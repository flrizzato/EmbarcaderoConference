unit SOLID.SemLSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

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

  TFormSemLSP = class(TForm)
  public
    procedure Exemplo1;
    procedure Exemplo2;
  end;

var
  FormSemLSP: TFormSemLSP;

implementation

uses
  System.Generics.Collections;

{$R *.dfm}

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

{ TFormSemLSP }

procedure TFormSemLSP.Exemplo1;
var
  FileList: TObjectList<TArquivo>;
  ItemFile: TArquivo;
begin
  FileList := TObjectList<TArquivo>.Create;

  FileList.Add(TArquivoTXT.Create);
  FileList.Add(TArquivoTXT.Create);
  FileList.Add(TArquivoCSV.Create);
  FileList.Add(TArquivoCSV.Create);

  for ItemFile in FileList do
  begin
    // processa o arquivo
  end;
end;

procedure TFormSemLSP.Exemplo2;
var
  FileList: TObjectList<TArquivo>;
  ItemFile: TArquivo;
begin
  FileList := TObjectList<TArquivo>.Create;

  FileList.Add(TArquivoTXT.Create);
  FileList.Add(TArquivoTXT.Create);
  FileList.Add(TArquivoCSV.Create);
  FileList.Add(TArquivoCSV.Create);

  {FileList.Add(TArquivoJSON.Create('C:\Importacao\Arquivo5.json'));
  FileList.Add(TArquivoJSON.Create('C:\Importacao\Arquivo6.json'));

  for ItemFile in FileList do
  begin
    if ItemFile.ClassType = TArquivoJSON then
      (ItemFile as TJSONFile).LerArquivoJSON
    else
      // processa arquivos delimitados
  end;}
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

end.
