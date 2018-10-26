unit ExemploComLSP;

interface

type
  IArquivo = interface
    procedure LerArquivo;
  end;

  TArquivoDelimitado = class(TInterfacedObject, IArquivo)
  protected
    procedure SetDelimiter; virtual; abstract;
  public
    procedure LerArquivo;
  end;

  TArquivoCSV = class(TArquivoDelimitado)
  protected
    procedure SetDelimiter; override;
  end;

  TArquivoTXT = class(TArquivoDelimitado)
  protected
    procedure SetDelimiter; override;
  end;

  TArquivoEstruturado = class(TInterfacedObject, IArquivo)
  public
    procedure LerArquivo;
  end;

  TArquivoJSON = class(TArquivoEstruturado)
  end;

  TCliente = class
  public
    procedure Exemplo;
  end;

implementation

uses
  System.Generics.Collections;

{ TCliente }

procedure TCliente.Exemplo;
var
  Lista: TList<IArquivo>;
  Arquivo: IArquivo;
begin
  Lista := TList<IArquivo>.Create;

  Lista.Add(TArquivoTXT.Create);
  Lista.Add(TArquivoTXT.Create);
  Lista.Add(TArquivoCSV.Create);
  Lista.Add(TArquivoCSV.Create);
  Lista.Add(TArquivoJSON.Create);
  Lista.Add(TArquivoJSON.Create);

  for Arquivo in Lista do
      Arquivo.LerArquivo;
end;

{$REGION 'Classes de Arquivos'}

{ TArquivoDelimitado }

procedure TArquivoDelimitado.LerArquivo;
begin

end;

{ TArquivoCSV }

procedure TArquivoCSV.SetDelimiter;
begin

end;

{ TArquivoTXT }

procedure TArquivoTXT.SetDelimiter;
begin

end;

{ TArquivoEstruturado }

procedure TArquivoEstruturado.LerArquivo;
begin

end;

{$ENDREGION}

end.
