unit fImportador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  frxClass,
  frxDesgn,
  ConverterRR2FR,
  StdCtrls, Buttons;

type
  TForm5 = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    edtOrigem: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    edtDestino: TEdit;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.BitBtn1Click(Sender: TObject);
var
  lReport: TfrxReport;
begin
  lReport := TfrxReport.Create(nil);
  try
    lReport.DesignReport;
  finally
    FreeAndNil(lReport);
  end;
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
var
  lReport: TfrxReport;
begin
  lReport := TfrxReport.Create(nil);
  try
    lReport.LoadFromFile(edtOrigem.Text);
    lReport.SaveToFile(edtDestino.Text);
  finally
    FreeAndNil(lReport);
  end;
end;

procedure TForm5.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtOrigem.Text := OpenDialog1.FileName;
end;

procedure TForm5.SpeedButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    edtDestino.Text := SaveDialog1.FileName;
end;

end.
