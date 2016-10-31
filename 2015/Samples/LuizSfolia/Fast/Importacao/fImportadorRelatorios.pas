unit fImportadorRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  frxClass,
  frxDesgn;

type
  TForm1 = class(TForm)
    edtOrigem: TButtonedEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    edtDestino: TButtonedEdit;
    Label2: TLabel;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  frxReport: TfrxReport;
begin
  TfrxReport.Create(nil).DesignReport;
//
//  frxReport := TFrxReport.Create(Self);
//  try
//    frxReport.LoadFromFile(edtOrigem.Text);
//    frxReport.SaveToFile(edtDestino.Text);
//  finally
//    FreeAndNil(frxReport);
//  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtOrigem.Text := OpenDialog1.FileName;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    edtDestino.Text := SaveDialog1.FileName;
end;

end.
