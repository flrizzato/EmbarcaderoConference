unit uCliente;

interface

type
  TCliente = class
  private
    FNome: string;
    FEndereco: string;
    procedure SetEndereco(const Value: string);
    procedure SetNome(const Value: string);
  public
    procedure Salvar;

    property Nome: string read FNome write SetNome;
    property Endereco: string read FEndereco write SetEndereco;
  end;

  TClientePF = class(TCliente)
  private
    FCPF: Int64;
    procedure SetCPF(const Value: Int64);
  public
    property CPF: Int64 read FCPF write SetCPF;
  end;

implementation

uses uConexao, System.SysUtils;

{ TCliente }

procedure TCliente.Salvar;
begin
  try
    TConexao.ExecutarSQL('insert into CLIENTE ( /* CAMPOS */ ) values ( /* VALORES */ )');
  except
    raise Exception.Create('Aconteceu um erro ao salvar o cliente.');
  end;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TClientePF }

procedure TClientePF.SetCPF(const Value: Int64);
begin
  FCPF := Value;
end;

end.
