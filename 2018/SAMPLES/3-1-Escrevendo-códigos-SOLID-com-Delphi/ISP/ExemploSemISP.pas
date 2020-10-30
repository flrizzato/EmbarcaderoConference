unit ExemploSemISP;

interface

type
  IRelatorio = interface
    procedure Imprimir;
    procedure EnviarParaCliente;
  end;

  TComprovantePedido = class(TInterfacedObject, IRelatorio)
  public
    procedure Imprimir;
    procedure EnviarParaCliente;
  end;

  TNotaFiscal = class(TInterfacedObject, IRelatorio)
  public
    procedure Imprimir;
    procedure EnviarParaCliente;
  end;

  TRelatorioClientes = class(TInterfacedObject, IRelatorio)
  public
    procedure Imprimir;
    procedure EnviarParaCliente;
  end;

implementation

uses
  Utils;

{ TComprovantePedido }

procedure TComprovantePedido.Imprimir;
begin
  TImpressao.Imprimir(Self, impTimbrado);
end;

procedure TComprovantePedido.EnviarParaCliente;
begin
  TServicoEmail.EnviarEmail(Self, 'pedidos@empresa.com.br');
end;

{ TNotaFiscal }

procedure TNotaFiscal.Imprimir;
begin
  TImpressao.Imprimir(Self, impArquivo);
end;

procedure TNotaFiscal.EnviarParaCliente;
begin
  TServicoEmail.EnviarEmail(Self, 'nfe@empresa.com.br');
end;

{ TRelatorioClientes }

procedure TRelatorioClientes.Imprimir;
begin
  TImpressao.Imprimir(Self, impImpressora);
end;

procedure TRelatorioClientes.EnviarParaCliente;
begin
  // ?
end;

end.
