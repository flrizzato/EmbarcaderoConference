unit ExemploSemLSP;

interface

type
  TArquivo = class
  protected
    FDelimiter: string;
    procedure SetDelimiter; virtual; abstract;
  public
    procedure LerArquivo;
  end;

  TArquivoCSV = class(TArquivo)
  protected
    procedure SetDelimiter; override;
  end;

  TArquivoTXT = class(TArquivo)
  protected
    procedure SetDelimiter; override;
  end;

  {TArquivoJSON = class(TArquivo)
  protected
    procedure SetDelimiter; override;
  public
    procedure LerArquivoJSON;
  end;}

  TCliente = class
  public
    procedure Exemplo1;
    procedure Exemplo2;
  end;

implementation

uses
  System.Generics.Collections;

{ TArquivo }

procedure TArquivo.LerArquivo;
begin
  //
end;

{ TArquivoCSV }

procedure TArquivoCSV.SetDelimiter;
begin
  FDelimiter := ';';
end;

{ TArquivoTXT }

procedure TArquivoTXT.SetDelimiter;
begin
  FDelimiter := '|';
end;

{ TCliente }

procedure TCliente.Exemplo1;
var
  ListaArquivos: TObjectList<TArquivo>;
  Arquivo: TArquivo;
begin
  ListaArquivos := TObjectList<TArquivo>.Create;

  ListaArquivos.Add(TArquivoTXT.Create);
  ListaArquivos.Add(TArquivoTXT.Create);
  ListaArquivos.Add(TArquivoCSV.Create);
  ListaArquivos.Add(TArquivoCSV.Create);

  for Arquivo in ListaArquivos do
  begin
    Arquivo.LerArquivo;
  end;
end;

{ TArquivoJSON }

{procedure TArquivoJSON.LerArquivoJSON;
begin
  //
end;

procedure TArquivoJSON.SetDelimiter;
begin
  // ?
end;}

procedure TCliente.Exemplo2;
var
  ListaArquivos: TObjectList<TArquivo>;
  Arquivo: TArquivo;
begin
  ListaArquivos := TObjectList<TArquivo>.Create;

  ListaArquivos.Add(TArquivoTXT.Create);
  ListaArquivos.Add(TArquivoTXT.Create);
  ListaArquivos.Add(TArquivoCSV.Create);
  ListaArquivos.Add(TArquivoCSV.Create);

  {ListaArquivos.Add(TArquivoJSON.Create);
  ListaArquivos.Add(TArquivoJSON.Create);

  for Arquivo in ListaArquivos do
  begin
    if Arquivo.ClassType = TArquivoJSON then
      (Arquivo as TJSONFile).LerArquivoJSON
    else
      Arquivo.LerArquivo;
  end;}
end;

end.
