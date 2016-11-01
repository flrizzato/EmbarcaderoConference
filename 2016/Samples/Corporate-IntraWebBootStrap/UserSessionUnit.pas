unit UserSessionUnit;

interface

uses
  IWUserSessionBase, SysUtils, Classes, U_DM;

type
  TIWUserSession = class(TIWUserSessionBase)
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DM : TDM;
  end;

implementation

{$R *.dfm}

procedure TIWUserSession.IWUserSessionBaseCreate(Sender: TObject);
begin
   DM:=TDM.Create(Self);
end;

end.