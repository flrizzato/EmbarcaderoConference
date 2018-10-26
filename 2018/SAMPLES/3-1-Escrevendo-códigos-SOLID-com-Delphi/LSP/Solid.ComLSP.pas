unit SOLID.ComLSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

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
  protected
    procedure SetDelimiter; override;
  end;

  TFormSemLSP = class(TForm)
  public
    procedure Exemplo;
  end;

var
  FormSemLSP: TFormSemLSP;

implementation

uses
  System.Generics.Collections;

{$R *.dfm}

{ TFormSemLSP }

procedure TFormSemLSP.Exemplo;
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

end.
