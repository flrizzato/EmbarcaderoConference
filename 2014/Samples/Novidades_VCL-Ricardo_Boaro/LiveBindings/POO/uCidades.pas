unit uCidades;

interface

uses Classes;

Type
 TCidades = class
   private
    FCodigo: Integer;
    FNome: String;
    FUF: String;
   public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome  : String  read FNome   write FNome;
    property UF    : String  read FUF     write FUF;

    constructor Create(const aCodigo: Integer; const aNome, aUF:String);
 end;

implementation

{ TCidades }

constructor TCidades.Create(const aCodigo: Integer; const aNome, aUF: String);
begin
 Codigo := aCodigo;
 Nome   := aNome;
 UF     := aUF;
end;

end.
