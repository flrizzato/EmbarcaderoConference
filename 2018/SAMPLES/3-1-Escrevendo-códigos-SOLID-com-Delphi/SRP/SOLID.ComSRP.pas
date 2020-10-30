unit SOLID.ComSRP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TCalculoEstatisticas = class
  public
    procedure GerarEstatisticas;
  end;

  TEnvioRelatorio = class
  public
    procedure EnviarRelatorioGerencia;
  end;

  TFormComSRP = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormComSRP: TFormComSRP;

implementation

{$R *.dfm}

{ TEnvioRelatorio }

procedure TEnvioRelatorio.EnviarRelatorioGerencia;
begin
  //
end;

{ TCalculoEstatisticas }

procedure TCalculoEstatisticas.GerarEstatisticas;
begin
  //
end;

procedure TFormComSRP.Button1Click(Sender: TObject);
var
  CalculoEstatisticas: TCalculoEstatisticas;
  EnvioRelatorio: TEnvioRelatorio;
begin
  CalculoEstatisticas := TCalculoEstatisticas.Create;
  EnvioRelatorio := TEnvioRelatorio.Create;
  try
    CalculoEstatisticas.GerarEstatisticas;
    EnvioRelatorio.EnviarRelatorioGerencia;
  finally
    EnvioRelatorio.Free;
    CalculoEstatisticas.Free;
  end;
end;

end.
