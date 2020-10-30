unit Form_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ceffmx,
  FMX.Layouts, ceflib, Unit3;

type
  TFormPrincipal = class(TForm)
    Layout1: TLayout;
    ChromiumFMX1: TChromiumFMX;
    procedure FormCreate(Sender: TObject);
    procedure ChromiumFMX1AddressChange(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
  private
    { Private declarations }
    procedure ExibirNFe;
  public
    { Public declarations }
    MainForm : TMainForm;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  Form_NFe;

{$R *.fmx}

procedure TFormPrincipal.ChromiumFMX1AddressChange(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
begin
  if(Pos('NFE', url) > 0) then
    ExibirNFe;

  if(Pos('SPED', url) > 0) then
  begin
    ShowMessage('SPED');
    ChromiumFMX1.Browser.GoBack;
  end;

  if(Pos('PEDIDO', url) > 0) then
  begin
    ShowMessage('PEDIDO');
    ChromiumFMX1.Browser.GoBack;
  end;
end;

procedure TFormPrincipal.ExibirNFe;
var
  FormNfe : TfrmNotaFiscalEletronica;
begin
    FormNfe := TfrmNotaFiscalEletronica.Create(Self);
    MainForm.Layout3.RemoveObject(0);
    MainForm.Layout3.AddObject(FormNfe.Layout1);
    MainForm.ExitAction := false;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  ChromiumFMX1.Load(ExtractFilePath(ParamStr(0)) + 'index.html');
end;

end.
