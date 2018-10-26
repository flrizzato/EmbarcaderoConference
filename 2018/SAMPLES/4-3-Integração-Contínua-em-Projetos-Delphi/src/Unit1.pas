unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCalculadora;

type
  TForm1 = class(TForm)
    edValor1: TEdit;
    edValor2: TEdit;
    pbSomar: TButton;
    pbSubtrair: TButton;
    lbResultado: TLabel;
    pbMultiplicar: TButton;
    pbDividir: TButton;
    procedure pbSomarClick(Sender: TObject);
    procedure pbSubtrairClick(Sender: TObject);
    procedure pbMultiplicarClick(Sender: TObject);
    procedure pbDividirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCalculadora: TCalculadora;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCalculadora := TCalculadora.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FCalculadora.Free;
end;

procedure TForm1.pbDividirClick(Sender: TObject);
begin
  lbResultado.Caption := FloatToStr(FCalculadora.Dividir(StrToInt(edValor1.Text), StrToInt(edValor2.Text)));
end;

procedure TForm1.pbMultiplicarClick(Sender: TObject);
begin
  lbResultado.Caption := IntToStr(FCalculadora.Multiplicar(StrToInt(edValor1.Text), StrToInt(edValor2.Text)));
end;

procedure TForm1.pbSomarClick(Sender: TObject);
begin
  lbResultado.Caption := IntToStr(FCalculadora.Somar(StrToInt(edValor1.Text), StrToInt(edValor2.Text)));
end;

procedure TForm1.pbSubtrairClick(Sender: TObject);
begin
  lbResultado.Caption := IntToStr(FCalculadora.Subtrair(StrToInt(edValor1.Text), StrToInt(edValor2.Text)));
end;

end.

