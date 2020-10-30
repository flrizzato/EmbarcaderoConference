unit ClienteUnit;

interface

type
  TCliente = class
  private
    FCodigo: Integer;
    FSalario: Double;
    FNome: string;
    FSituacao: string;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Salario: Double read FSalario write FSalario;
    property Situacao: string read FSituacao write FSituacao;
  end;

implementation

end.
