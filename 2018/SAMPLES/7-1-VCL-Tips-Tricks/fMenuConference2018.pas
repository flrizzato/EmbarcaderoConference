unit fMenuConference2018;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCtrls,
  fWebLogin, fWebMaps, uGoogleTranslateClass, fExtrairImagemDfm, uHandleUtils, mmSystem,
  Vcl.OleCtrls, SHDocVw, fTranslate;


const
  HOOK_MSG = WM_USER+100;

type
  TfrmMenuConference2018 = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnAdicionarTextoCombo: TButton;
    edtHandleComboBox: TEdit;
    ComboBox1: TComboBox;
    edtTextoCombo: TEdit;
    Label1: TLabel;
    btnAbreCombo: TButton;
    Label2: TLabel;
    edtHandleEnvioMsg: TEdit;
    tmrHandle: TTimer;
    edtHandlePos: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    lbX: TLabel;
    lbY: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtClasse: TEdit;
    edtTexto: TEdit;
    Label7: TLabel;
    chxCapturarHandle: TCheckBox;
    TabSheet3: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    chxAtivarHandleParent: TCheckBox;
    dscHandle: TDataSource;
    cdsHandle: TClientDataSet;
    cdsHandleHandle: TIntegerField;
    cdsHandleClasse: TStringField;
    cdsHandleName: TStringField;
    tmrHandleParent: TTimer;
    cdsHandleText: TStringField;
    cdsHandleNivel: TIntegerField;
    cdsHandleNodo: TStringField;
    Label8: TLabel;
    edtHandleParent: TEdit;
    chxDestacarHandle: TCheckBox;
    tmrDestacarHandle: TTimer;
    TabSheet4: TTabSheet;
    btnInstallHook: TButton;
    btnUninstallHook: TButton;
    lblInstalled: TLabel;
    lblKey: TLabel;
    TabSheet5: TTabSheet;
    btnWebLogin: TButton;
    btnWebMaps: TButton;
    edtNome: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Translate: TButton;
    TabSheet6: TTabSheet;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarTextoComboClick(Sender: TObject);
    procedure btnAbreComboClick(Sender: TObject);
    procedure tmrHandleTimer(Sender: TObject);
    procedure chxCapturarHandleClick(Sender: TObject);
    procedure tmrHandleParentTimer(Sender: TObject);
    procedure chxAtivarHandleParentClick(Sender: TObject);
    procedure tmrDestacarHandleTimer(Sender: TObject);
    procedure chxDestacarHandleClick(Sender: TObject);
    procedure btnInstallHookClick(Sender: TObject);
    procedure btnUninstallHookClick(Sender: TObject);
    procedure btnWebLoginClick(Sender: TObject);
    procedure btnWebMapsClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TranslateClick(Sender: TObject);
  private
    FHandleAtual: THandle;
    FHook: HHOOK;
    procedure HookMsg(var Msg: TMessage); message HOOK_MSG;
    procedure MontarCdsHandle(lHandle: Cardinal);
    procedure InicilaizarCdsHandle;
  public
  end;

const
  HOOK_DLL = 'HookDll.dll';

  {Importing functions from DLL}
  function InstallHook(pHandle: Integer): integer; external HOOK_DLL delayed;
  function UninstallHook: Integer; external HOOK_DLL delayed;

const
  InstalledStrings: array[0..2] of string[50]=('Falha na instalação do Hook','Hook instalado','Hook já instalado');
  UnInstalledStrings: array[0..2] of string[50]=('Falha na desinstalação do Hook','Hook desinstalado','Não há Hook para desinstalação');


var
  frmMenuConference2018: TfrmMenuConference2018;




implementation

{$R *.dfm}

procedure TfrmMenuConference2018.btnAbreComboClick(Sender: TObject);
begin
  SendMessage(StrToInt(edtHandleEnvioMsg.Text),CB_SHOWDROPDOWN,1,0);
  //https://docs.microsoft.com/en-us/windows/desktop/controls/cb-showdropdown
end;

procedure TfrmMenuConference2018.btnAdicionarTextoComboClick(Sender: TObject);
var
  lHandle: THandle;
  lMensage, lTexto: Integer;

begin
  lHandle := StrToInt(edtHandleEnvioMsg.Text);
  lMensage := CB_ADDSTRING;
  lTexto   := integer(PChar(edtTextoCombo.Text));

  SendMessage(lHandle,lMensage,0,lTexto);
  //https://docs.microsoft.com/en-us/windows/desktop/controls/cb-addstring
end;

procedure TfrmMenuConference2018.btnInstallHookClick(Sender: TObject);
var
  lRetorno: Integer;
begin
  lRetorno:=InstallHook(Handle);

  lblInstalled.Caption:=InstalledStrings[lRetorno];
end;

procedure TfrmMenuConference2018.btnUninstallHookClick(Sender: TObject);
var
  lRetorno: Integer;
begin
  lRetorno:=UninstallHook;
  lblInstalled.Caption:=UnInstalledStrings[lRetorno];
end;

procedure TfrmMenuConference2018.btnWebLoginClick(Sender: TObject);
begin
  TfrmWebLogin.Create(Self).Show;
end;

procedure TfrmMenuConference2018.btnWebMapsClick(Sender: TObject);
begin
  TfrmWebMaps.Create(Self).Show;
end;

procedure TfrmMenuConference2018.TranslateClick(Sender: TObject);
begin
  TfrmTranslate.Create(Self).Show;
end;

procedure TfrmMenuConference2018.Button3Click(Sender: TObject);
begin
  TfrmExtrairImagemDfm.Create(Self).Show;
end;


procedure TfrmMenuConference2018.chxAtivarHandleParentClick(Sender: TObject);
begin
  tmrHandleParent.Enabled := chxAtivarHandleParent.Checked;
end;

procedure TfrmMenuConference2018.MontarCdsHandle(lHandle: Cardinal);
var
  lNivel: Integer;
  lText: array [0..255] of char;
  lClasse: array [0..255] of char;
  lName: string;
  sNodo: string;
begin
  lNivel := 0;
  repeat
    GetWindowText(lHandle, lText, SizeOf(lText));
    GetClassName(lHandle, lClasse, SizeOf(lClasse));
    cdsHandle.Append;
    cdsHandle.FieldByName('Handle').AsInteger := lHandle;
    cdsHandle.FieldByName('Text').AsString := trim(lText);
    cdsHandle.FieldByName('Classe').AsString := trim(lClasse);
    cdsHandle.FieldByName('Name').AsString := THandleUtils.GetNameWinControl(lHandle);
    cdsHandle.FieldByName('Nivel').AsInteger := lNivel;
    cdsHandle.Post;
    lHandle := GetParent(lHandle);
    Inc(lNivel);
  until (lHandle = 0);
  sNodo := '|';
  cdsHandle.First;
  while not cdsHandle.Eof do
  begin
    lNivel := cdsHandle.FieldByName('Nivel').AsInteger;
    cdsHandle.Edit;
    cdsHandle.FieldByName('Nodo').AsString := '|' + StringOfChar('_', (abs(lNivel) * 2)+1)+'|';
    cdsHandle.Post;
    cdsHandle.Next;
  end;
end;

procedure TfrmMenuConference2018.InicilaizarCdsHandle;
begin
  if not cdsHandle.Active then
  begin
    cdsHandle.CreateDataSet;
    cdsHandle.IndexFieldNames := 'Nivel';
  end
  else
  begin
    cdsHandle.EmptyDataSet;
  end;
end;

procedure TfrmMenuConference2018.chxCapturarHandleClick(Sender: TObject);
begin
  tmrHandle.Enabled := chxCapturarHandle.Checked;
end;

procedure TfrmMenuConference2018.chxDestacarHandleClick(Sender: TObject);
begin
  tmrDestacarHandle.Enabled := chxDestacarHandle.Checked;
end;

procedure TfrmMenuConference2018.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  edtHandleComboBox.Text := IntToStr(ComboBox1.Handle);
  edtHandleEnvioMsg.Text := IntToStr(ComboBox1.Handle);
end;

procedure TfrmMenuConference2018.tmrDestacarHandleTimer(Sender: TObject);
begin
  if chxAtivarHandleParent.Checked and (FHandleAtual > 0) then
  begin
    THandleUtils.DestacarHandle(FHandleAtual);
  end;
end;

procedure TfrmMenuConference2018.tmrHandleParentTimer(Sender: TObject);
var
  lPosicao: TPoint;
  lHandle : THandle;
begin
  GetCursorPos(lPosicao);
  lHandle := WindowFromPoint(lPosicao);

  if lHandle <> FHandleAtual then
  begin
    RedrawWindow(FHandleAtual, nil, 0, RDW_INVALIDATE or RDW_ERASE);
    FHandleAtual := lHandle;

    cdsHandle.DisableControls;
    try
      InicilaizarCdsHandle;
      MontarCdsHandle(lHandle);
    finally
      cdsHandle.EnableControls
    end;

  end;
end;

procedure TfrmMenuConference2018.tmrHandleTimer(Sender: TObject);
var
  lPosicao: TPoint;
  lHandle : THandle;
  lTexto, lClasse: array [0..255] of char;
begin
  GetCursorPos(lPosicao);
  lHandle := WindowFromPoint(lPosicao);

  lbX.Caption := lPosicao.X.ToString;
  lbY.Caption := lPosicao.Y.ToString;

  edtHandlePos.Text := IntToStr(lHandle);

  GetClassName(lHandle,lClasse,SizeOf(lClasse));
  GetWindowText(lHandle,lTexto,SizeOf(lTexto));

  edtClasse.Text := lClasse;
  edtTexto.Text := lTexto;
  edtHandleParent.Text := IntToStr(GetParent(lHandle));
end;


procedure TfrmMenuConference2018.HookMsg(var Msg: TMessage);
begin

  lblKey.Caption := IntToStr(Msg.WParam)+':'+Chr(Msg.WParam);

  if ((HiWord(Msg.lParam) and KF_ALTDOWN) <> 0) then
  begin
    lblKey.Caption := lblKey.Caption + ' ' + 'Alt';
    case Msg.WParam of
      VK_F5 : chxAtivarHandleParent.Checked := True;
      VK_F6 : chxAtivarHandleParent.Checked := False;
    end;
  end;


end;




end.
