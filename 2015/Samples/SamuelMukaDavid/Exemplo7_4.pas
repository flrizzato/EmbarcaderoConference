unit Exemplo7_4;

interface

type
  TAdministrador = class(TInterfacedObject)
  private
    FCodigo: integer;
    FNivel: integer;
    FNome: String;
    FSetor: string;
  public
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Setor: string read FSetor write FSetor;
    property Nivel: integer read FNivel write FNivel;
  end;


implementation

end.
