unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  Datasnap.DBClient, frxDBSet, frxExportHTML, frxExportPDF, Vcl.ComCtrls,
  frxChart, IOUtils, IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client, Data.DBXDataSnap, Data.DBXCommon, Data.DbxHTTPLayer, Data.SqlExpr,
  uMetodosClient, frxBarcode, frxDCtrl;

type
  TfrmPrincipalExemplo1 = class(TForm)
    frxReport: TfrxReport;
    frxDBDatasetEmployee: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxChartObject1: TfrxChartObject;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    CheckBox1: TCheckBox;
    BitBtn3: TBitBtn;
    GroupBox3: TGroupBox;
    DtpInicial: TDateTimePicker;
    Label1: TLabel;
    dtpFinal: TDateTimePicker;
    Label2: TLabel;
    BitBtn4: TBitBtn;
    GroupBox4: TGroupBox;
    BitBtn5: TBitBtn;
    edtNomeRelatorio: TEdit;
    BitBtn6: TBitBtn;
    OpenDialog1: TOpenDialog;
    frxBarCodeObject1: TfrxBarCodeObject;
    GroupBox5: TGroupBox;
    BitBtn7: TBitBtn;
    frxDialogControls1: TfrxDialogControls;
    GroupBox6: TGroupBox;
    BitBtn8: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetarRelatorio(const ARelatorio : string);
  public
    { Public declarations }
  end;

var
  frmPrincipalExemplo1: TfrmPrincipalExemplo1;

implementation

{$R *.dfm}

uses uDMConexao, uDMConsultas;

procedure TfrmPrincipalExemplo1.BitBtn1Click(Sender: TObject);
begin
  SetarRelatorio('FastReportFilho.fr3');
  frxReport.ShowReport;
end;

procedure TfrmPrincipalExemplo1.BitBtn2Click(Sender: TObject);
begin
  SetarRelatorio('FastReportFilho.fr3');
  if not CheckBox1.Checked then
  begin
    frxPDFExport1.DefaultPath := TDirectory.GetCurrentDirectory;
    frxPDFExport1.FileName := 'TesteImpressao.pdf';
    frxPDFExport1.ShowDialog := False;
  end;
  frxReport.PrepareReport;
  frxReport.Export(frxPDFExport1);
end;

procedure TfrmPrincipalExemplo1.BitBtn3Click(Sender: TObject);
begin
  SetarRelatorio('FastReportFilho.fr3');
  if not CheckBox1.Checked then
  begin
    frxHTMLExport1.DefaultPath := TDirectory.GetCurrentDirectory;
    frxHTMLExport1.FileName := 'TesteImpressao.html';
    frxHTMLExport1.ShowDialog := False;
  end;
  frxReport.PrepareReport;
  frxReport.Export(frxHTMLExport1);
end;

procedure TfrmPrincipalExemplo1.BitBtn4Click(Sender: TObject);
var
  lRetorno: string;
begin
  SetarRelatorio('FastReportFilho.fr3');
  frxReport.Variables['DataInicial'] := QuotedStr(DateToStr(DtpInicial.Date));
  frxReport.Variables['DataFinal'] := QuotedStr(DateToStr(dtpFinal.Date));
  frxReport.ShowReport;
end;

procedure TfrmPrincipalExemplo1.BitBtn5Click(Sender: TObject);
begin
  frxReport.LoadFromFile(edtNomeRelatorio.Text);
  frxReport.ShowReport;
end;

procedure TfrmPrincipalExemplo1.BitBtn6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtNomeRelatorio.Text := OpenDialog1.FileName;
end;

procedure TfrmPrincipalExemplo1.BitBtn7Click(Sender: TObject);
begin
  SetarRelatorio('FastForm.fr3');
  frxReport.ShowReport;
end;

procedure TfrmPrincipalExemplo1.BitBtn8Click(Sender: TObject);
begin
  SetarRelatorio('FastBarCode.fr3');
  frxReport.ShowReport;
end;

procedure TfrmPrincipalExemplo1.SetarRelatorio(const ARelatorio: string);
var
  lCaminho: string;
begin
  lCaminho := TDirectory.GetCurrentDirectory;
  lCaminho := lCaminho + '\..\Relatorios\' + ARelatorio;
  frxReport.LoadFromFile(lCaminho);
end;

end.
