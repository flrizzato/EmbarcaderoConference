unit SOLID.SemSRP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TCalculoEstatisticas = class
  private
    procedure GerarEstatisticas;
    procedure EnviarRelatorioGerencia;
  public
    procedure Executar;
  end;

  TFormSemSRP = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSemSRP: TFormSemSRP;

implementation

{$R *.dfm}

{ TCalculoEstatisticas }

procedure TCalculoEstatisticas.Executar;
begin
  GerarEstatisticas;
  EnviarRelatorioGerencia;
end;

procedure TCalculoEstatisticas.EnviarRelatorioGerencia;
begin
  //
end;

procedure TCalculoEstatisticas.GerarEstatisticas;
begin
  //
end;

procedure TFormSemSRP.Button1Click(Sender: TObject);
var
  CalculoEstatisticas: TCalculoEstatisticas;
begin
  CalculoEstatisticas := TCalculoEstatisticas.Create;
  try
    CalculoEstatisticas.GerarEstatisticas;
  finally
    CalculoEstatisticas.Free;
  end;
end;

end.
