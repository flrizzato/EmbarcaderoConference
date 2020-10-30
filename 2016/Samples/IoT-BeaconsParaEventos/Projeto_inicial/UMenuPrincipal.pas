unit UMenuPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FMX.Layouts, FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, System.IOUtils, FMX.Edit, System.Actions, FMX.ActnList,
  FMX.Bind.Navigator, Data.DBXDataSnap, IPPeerClient, Data.DBXCommon,
  Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, System.Beacon,
  System.Beacon.Components;

type
  TfrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    FDConnection1: TFDConnection;
    FDQueryConsulta: TFDQuery;
    FDQueryConsultaCodigoCel: TWideMemoField;
    FDQueryConsultaNome: TWideMemoField;
    FDQueryConsultaEmail: TWideMemoField;
    FDQueryConsultaDadosServidor: TWideMemoField;
    FDQueryConsultaFoiEvento: TWideMemoField;
    FDQueryConsultaEstaNaPalestra: TWideMemoField;
    ListBox1: TListBox; // 8000005 falta espaço iphpone
    BindSourceDB1: TBindSourceDB;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldItemDataText: TLinkPropertyToField;
    FDQueryInsert: TFDQuery;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    LinkPropertyToFieldItemDataText2: TLinkPropertyToField;
    FDQueryAlterar: TFDQuery;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1codcel: TWideStringField;
    ClientDataSet1nome: TWideStringField;
    ClientDataSet1email: TWideStringField;
    ClientDataSet1evento: TWideStringField;
    IdTCPClient1: TIdTCPClient;
    Timer1: TTimer;
    FDQueryAlteraStatusServidor: TFDQuery;
    Timer2: TTimer;
    Beacon1: TBeacon;
    ClientDataSet1foievento: TWideStringField;
    ClientDataSet1estanapalestra: TWideStringField;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    Label3: TLabel;
    LabelEstaServidor: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    Label4: TLabel;
    LabelFoiEvento: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    Label5: TLabel;
    LabelEstaNaPalestra: TLabel;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    FDQueryStatusiBeacon: TFDQuery;
    Button1: TButton;
    FDQueryExcluir: TFDQuery;
    FDQueryConsultaiBeaconNoServidor: TWideMemoField;
    ListBoxItem14: TListBoxItem;
    LinkPropertyToFieldItemDataText3: TLinkPropertyToField;
    FDQueryStatusiBeaconServidor: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Beacon1EnterRegion(const Sender: TObject; const [Ref] UUID: TGUID;
      AMajor, AMinor: Integer);
    procedure Beacon1ExitRegion(const Sender: TObject; const [Ref] UUID: TGUID;
      AMajor, AMinor: Integer);
    procedure Button1Click(Sender: TObject);
  private
    tentativas: Integer;
    NovoAlteracao: string;
    descricaoNome: string;
    email: string;
    descricaoEmail: array [0 .. 0] of string;
    DadosServidor: string;
    iBeaconNoServidor: string;
    FoiEvento: string;
    EstaNaPalestra: string;
    procedure GravarDadosSqlite(nome: String; email: String);
    procedure EntradaNome(const md: TModalResult; const nome: array of string);
    procedure EntradaEmail(const md: TModalResult;
      const email: array of string);
    { Private declarations }
    procedure ExecutaInputQueryNome(nome: String);
    function CodigoUnicoCelular(): String;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$IFDEF ANDROID}

uses
  Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers,
  Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.Os, Androidapi.JNI.App;
{$ENDIF}
{$IFDEF IOS}

uses
  iOSApi.UIKit,
  iOSApi.Foundation,
  Macapi.Helpers;
{$ENDIF}
{$R *.fmx}
{$R *.iPhone.fmx IOS}

procedure TfrmPrincipal.Beacon1EnterRegion(const Sender: TObject;
  const [Ref] UUID: TGUID; AMajor, AMinor: Integer);
begin
  FoiEvento := 'S';
  EstaNaPalestra := 'S';
  ListBoxItem12.Text := 'Ibeacon: Foi/Esta no evento';
  FDQueryStatusiBeacon.ParamByName('FoiEvento').AsString := 'S';
  FDQueryStatusiBeacon.ParamByName('EstaNaPalestra').AsString := 'S';
  FDQueryStatusiBeacon.ExecSQL();
  FDQueryConsulta.Close;
  FDQueryConsulta.Open();
  if (FDQueryConsultaiBeaconNoServidor.Value = 'N') and (timer1.Enabled = false) then
      timer1.Enabled := true;
end;

procedure TfrmPrincipal.Beacon1ExitRegion(const Sender: TObject;
  const [Ref] UUID: TGUID; AMajor, AMinor: Integer);
begin
  // FoiEvento := 'N'; //por mais que ele tenha saido do evento, ele foi no evento
  EstaNaPalestra := 'N';
  ListBoxItem12.Text := 'Ibeacon: Foi/Mas Não Esta mais';

end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  FDQueryExcluir.ExecSQL();
  FDQueryConsulta.Close();
  FDQueryConsulta.Open();
end;

procedure TfrmPrincipal.ClientDataSet1AfterPost(DataSet: TDataSet);
begin
  ClientDataSet1.ApplyUpdates(0);
end;

function TfrmPrincipal.CodigoUnicoCelular: String;
var
  IMEI: String;
{$IFDEF ANDROID}
  obj: JObject;
  tm: JTelephonyManager;
{$ENDIF}
{$IFDEF IOS}
  device: UIDevice;
{$ENDIF}
begin
{$IFDEF ANDROID}
  IMEI := '';
  obj := TAndroidHelper.Activity.getSystemService
    (TJContext.JavaClass.TELEPHONY_SERVICE);
  if obj <> nil then
  begin
    tm := TJTelephonyManager.Wrap((obj as ILocalObject).GetObjectID);
    if tm <> nil then
      IMEI := JStringToString(tm.getDeviceId);
  end;
  if IMEI = '' then
    IMEI := JStringToString(TJSettings_Secure.JavaClass.getString
      (TAndroidHelper.Activity.getContentResolver,
      TJSettings_Secure.JavaClass.ANDROID_ID));
{$ENDIF}
{$IFDEF IOS}
  IMEI := '';
  device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  IMEI := device.uniqueIdentifier.UTF8String;
{$ENDIF}
  result := IMEI;
end;

procedure TfrmPrincipal.EntradaEmail(const md: TModalResult;
  const email: array of string);
var
  descricaoEmail: string;
begin
  DadosServidor := 'N';
  descricaoEmail := string.Empty;
  if md <> mrOK then
    exit;
  descricaoEmail := email[0];
  try
    if (descricaoEmail.Trim <> '') then
    begin
      if NovoAlteracao = 'Novo' then
      begin
        // inserir no sqlite
        FDQueryInsert.ParamByName('codigoCel').AsString := CodigoUnicoCelular;
        FDQueryInsert.ParamByName('nome').AsString := descricaoNome;
        FDQueryInsert.ParamByName('email').AsString := descricaoEmail;
        FDQueryInsert.ParamByName('DadosServidor').AsString := DadosServidor;
        FDQueryInsert.ParamByName('Foievento').AsString := FoiEvento;
        FDQueryInsert.ParamByName('EstaNaPalestra').AsString := EstaNaPalestra;
        FDQueryInsert.ParamByName('iBeaconNoServidor').AsString := iBeaconNoServidor;
        FDQueryInsert.ExecSQL();
        FDQueryConsulta.Close;
        FDQueryConsulta.Open();
      end
      else if NovoAlteracao = 'Alteracao' then
      begin
        FDQueryAlterar.ParamByName('Nome').AsString := descricaoNome;
        FDQueryAlterar.ParamByName('Email').AsString := descricaoEmail;
        FDQueryAlterar.ExecSQL();
        FDQueryAlteraStatusServidor.ParamByName('DadosServidor')
          .AsString := 'N';
        FDQueryAlteraStatusServidor.ExecSQL();
        FDQueryConsulta.Close;
        FDQueryConsulta.Open();
      end;
      Timer1.Enabled := true;
    end;
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;

end;

procedure TfrmPrincipal.EntradaNome(const md: TModalResult;
  const nome: array of string);
begin
  // descricaoNome := string.Empty;
  if md <> mrOK then
    exit;
  descricaoNome := nome[0];
  if (descricaoNome.Trim <> '') then
  begin
    if NovoAlteracao = 'Novo' then
      descricaoEmail[0] := string.Empty
    else
      descricaoEmail[0] := email;
    InputQuery('Digite seu email', ['Email'], descricaoEmail,
      Self.EntradaEmail);
  end;

end;

procedure TfrmPrincipal.ExecutaInputQueryNome(nome: String);
begin
  if (ListBoxItem2.Text = '') or
    (ListBoxItem2.Text = 'Clique aqui p/ novo usuário') then
    nome := '';
  InputQuery('Digite seu nome', ['Nome'], nome, Self.EntradaNome);
end;

procedure TfrmPrincipal.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IF DEFINED(iOS) or DEFINED(android)}
  FDConnection1.ParamS.values['database'] :=
    tPath.combine(tPath.getDocumentsPath, 'eventos.s3db');
{$ENDIF}
  // adicionar no uses System.IOUtils

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  nome, email: string;
begin
  FoiEvento := 'N';
  EstaNaPalestra := 'N';
  iBeaconNoServidor :='N';
  try
    Beacon1.Enabled := true;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
  tentativas := 0;
  if (ListBoxItem2.Text = '') then
  begin
    // showMessage('Não cadastrado');
    ListBoxItem2.Text := 'Clique aqui p/ novo usuário';
    NovoAlteracao := 'Novo';
    descricaoNome := string.Empty;
    ExecutaInputQueryNome(descricaoNome);
    // InputQuery('Digite seu nome', ['Nome'], descricaoNome, Self.EntradaNome);
    // InputQuery('Informe seu nome', 'Nome', nome);
    // InputQuery('Informe seu enail', 'Email', email);
    // if (nome.Trim <> '') and (email.Trim <> '') then
    // GravarDadosSqlite(nome, email);
  end
  else
  begin
    // showMessage('Cadastrado');
    NovoAlteracao := 'Alteracao';
    // ListBoxItem1.Text := 'Click no campo abaixo para alterar usuário';
    if (FDQueryConsultaDadosServidor.Value = 'N') or (FDQueryConsultaiBeaconNoServidor.Value = 'N') then
      Timer1.Enabled := true;
  end;
end;

procedure TfrmPrincipal.GravarDadosSqlite(nome, email: String);
begin
  try
    // :codigoCel,:nome,:email,:DadosServidor, :Foievento,:EstaNaPalestra
    FDQueryInsert.ParamByName('codigoCel').AsString := 'pegarcodigoautomatico';
    FDQueryInsert.ParamByName('nome').AsString := nome;
    FDQueryInsert.ParamByName('email').AsString := email;
    FDQueryInsert.ParamByName('DadosServidor').AsString := 'N';
    FDQueryInsert.ParamByName('Foievento').AsString := 'N';
    FDQueryInsert.ParamByName('EstaNaPalestra').AsString := 'N';
    FDQueryInsert.ExecSQL();
    FDQueryConsulta.Close;
    FDQueryConsulta.Open();
  except
    on e: Exception do
    begin
      ShowMessage('Erro ao gravar');
    end;
  end;
end;

procedure TfrmPrincipal.ListBoxItem2Click(Sender: TObject);
begin
  if (ListBoxItem2.Text = '') or
    (ListBoxItem2.Text = 'Clique aqui p/ novo usuário') then
    NovoAlteracao := 'Novo'
  else
    NovoAlteracao := 'Alteracao';
  email := ListBoxItem4.Text;
  ExecutaInputQueryNome(ListBoxItem2.Text);
end;

procedure TfrmPrincipal.ListBoxItem4Click(Sender: TObject);
begin
  if (ListBoxItem2.Text = '') or
    (ListBoxItem2.Text = 'Clique aqui p/ novo usuário') then
    NovoAlteracao := 'Novo'
  else
    NovoAlteracao := 'Alteracao';
  email := ListBoxItem4.Text;
  ExecutaInputQueryNome(ListBoxItem2.Text);
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  tentativas := tentativas + 1;
  ListBoxItem11.Text := inttostr(tentativas);
  try
    if IdTCPClient1.Connected = false then
    begin
      IdTCPClient1.ReadTimeout := 2000;
      IdTCPClient1.ConnectTimeout := 2000;
      IdTCPClient1.Port := 80;
      IdTCPClient1.Host := 'google.com';
      IdTCPClient1.Connect;
      // IdTCPClient1.Connect;  gera erro, não pode ter 2  IdTCPClient1.Connect;
      if IdTCPClient1.Connected then
      begin
        ListBoxItem7.Text := 'IdTCPCliente Conectado Internet';
        Timer2.Enabled := true;
      end;
    end;
  except
    on e: Exception do
      // IdTCPClient1.Disconnect;
      ListBoxItem8.Text := 'E.classname=' + e.classname + ',Erro=' + e.Message +
        ',tentativa=' + inttostr(tentativas);
  end;
end;

procedure TfrmPrincipal.Timer2Timer(Sender: TObject);
begin
  try
    SQLConnection1.Open;
    if SQLConnection1.Connected then
    begin
      DSProviderConnection1.Open;
      ClientDataSet1.Open;
      ListBoxItem8.Text := 'SQLConnection Banco conectado';

      if (ClientDataSet1.Locate('codcel', CodigoUnicoCelular,
        [lopartialkey, locaseinsensitive]) = false) then
      begin
        ClientDataSet1.Insert;
        ClientDataSet1.FieldByName('codcel').Value := CodigoUnicoCelular;
        ListBoxItem9.Text := 'Novo';
      end
      else
      begin
        ListBoxItem9.Text := 'Alteracao';
        ClientDataSet1.Edit;
      end;
      ClientDataSet1.FieldByName('nome').Value := FDQueryConsultaNome.Value;
      ClientDataSet1.FieldByName('email').Value := FDQueryConsultaEmail.Value;
      ClientDataSet1.FieldByName('evento').Value := 'Palestra Neri MG';
      ClientDataSet1.FieldByName('FoiEvento').Value := FoiEvento;
      ClientDataSet1.FieldByName('EstaNaPalestra').Value := EstaNaPalestra;
      ClientDataSet1.Post;
      DadosServidor := 'S';
      FDQueryAlteraStatusServidor.ParamByName('DadosServidor').AsString :=
        DadosServidor;
      FDQueryAlteraStatusServidor.ExecSQL();
      FDQueryStatusiBeaconServidor.ParamByName('iBeaconNoServidor').AsString :=
      ClientDataSet1foievento.Value;
      FDQueryStatusiBeaconServidor.ExecSQL();

      FDQueryConsulta.Close;
      FDQueryConsulta.Open();
      SQLConnection1.Close;
      Timer1.Enabled := false;
      Timer2.Enabled := false;
      IdTCPClient1.Disconnect;
    end;
  except
    on e: Exception do
      // IdTCPClient1.Disconnect;
      ListBoxItem8.Text := e.Message;

  end;
end;

end.
