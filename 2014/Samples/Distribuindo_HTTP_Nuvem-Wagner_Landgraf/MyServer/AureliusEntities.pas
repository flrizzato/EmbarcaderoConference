unit AureliusEntities;

interface

uses
  Generics.Collections,
  Aurelius.Types.Blob,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Mapping.Attributes;

type
  [Entity, Automapping]
  TGenre = class
  strict private
    FId: integer;
    FName: string;
  public
    constructor Create(const AName: string);
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  [Entity, Automapping]
  TArtist = class
  strict private
    FId: integer;
    FName: string;
  public
    constructor Create(const AName: string);
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  [Entity, Automapping]
  TTrack = class
  strict private
    FId: integer;
    FName: string;
    FGenre: TGenre;
    FComposer: Nullable<string>;
    FMilliseconds: Nullable<integer>;
  public
    constructor Create(const AName: string); overload;
    constructor Create(const AName: string; AGenre: TGenre); overload;
    constructor Create(const AName: string; AGenre: TGenre; const AComposer: string); overload;
    constructor Create(const AName: string; AGenre: TGenre; const AComposer: string; AMilliSeconds: integer); overload;
    property Id: integer read FId write FId;
    property Name: string read FName write FName;
    property Genre: TGenre read FGenre write FGenre;
    property Composer: Nullable<string> read FComposer write FComposer;
    property Milliseconds: Nullable<integer> read FMilliseconds write FMilliseconds;
  end;

  [Entity, Automapping]
  TAlbum = class
  strict private
    FId: integer;
    FName: string;
    FArtist: TArtist;
    [ManyValuedAssociation([TAssociationProp.Lazy], CascadeTypeAllRemoveOrphan)]
    FTracks: Proxy<TList<TTrack>>;
    function GetTracks: TList<TTrack>;
  public
    constructor Create; overload;
    constructor Create(const AName: string; AArtist: TArtist); overload;
    destructor Destroy; override;
    property Id: integer read FId write FId;
    property Name: string read FName write FName;
    property Artist: TArtist read FArtist write FArtist;
    property Tracks: TList<TTrack> read GetTracks;
  end;

implementation

{ TGenre }

constructor TGenre.Create(const AName: string);
begin
  FName := AName;
end;

{ TArtist }

constructor TArtist.Create(const AName: string);
begin
  FName := AName;
end;

{ TTrack }

constructor TTrack.Create(const AName: string; AGenre: TGenre);
begin
  FName := AName;
  FGenre := AGenre;
end;

constructor TTrack.Create(const AName: string);
begin
  FName := AName;
end;

constructor TTrack.Create(const AName: string; AGenre: TGenre; const AComposer: string;
  AMilliSeconds: integer);
begin
  FName := AName;
  FGenre := AGenre;
  FComposer := AComposer;
  FMilliSeconds := AMilliSeconds;
end;

constructor TTrack.Create(const AName: string; AGenre: TGenre; const AComposer: string);
begin
  FName := AName;
  FGenre := AGenre;
  FComposer := AComposer;
end;

{ TAlbum }

constructor TAlbum.Create;
begin
  FTracks.SetInitialValue(TList<TTrack>.Create);
end;

constructor TAlbum.Create(const AName: string; AArtist: TArtist);
begin
  Create;
  FName := AName;
  FArtist := AArtist;
end;

destructor TAlbum.Destroy;
begin
  FTracks.DestroyValue;
  inherited;
end;

function TAlbum.GetTracks: TList<TTrack>;
begin
  Result := FTracks.Value;
end;

end.
