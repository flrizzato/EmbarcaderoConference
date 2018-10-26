unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Actions,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.DateTimeCtrls,
  FMX.ListBox,
  FMX.Layouts,
  FMX.ListView,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.ActnList,
  FMX.Effects,
  FMX.ScrollBox,
  FMX.Memo;

const
  WEB_API_KEY = '';

type
  TForm1 = class(TForm)
    TabControl: TTabControl;
    TabLogin: TTabItem;
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Label1: TLabel;
    edt_email: TEdit;
    Label2: TLabel;
    edt_senha: TEdit;
    btn_acessar: TButton;
    lblNovo: TLabel;
    TabMain: TTabItem;
    TabRecuperarSenha: TTabItem;
    Image1: TImage;
    lblRecuperar: TLabel;
    ActionList1: TActionList;
    MudarTab1: TChangeTabAction;
    MudarTab2: TChangeTabAction;
    TabCriaConta: TTabItem;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    Label4: TLabel;
    Edit1Conta: TEdit;
    Label5: TLabel;
    Edit2ContaSenha: TEdit;
    Button1: TButton;
    MudarTab3: TChangeTabAction;
    Layout25: TLayout;
    VertScrollBox7: TVertScrollBox;
    Memo4: TMemo;
    RecuperarSenha: TEdit;
    Button14: TButton;
    GlowEffect7: TGlowEffect;
    Text1: TText;
    Layout18: TLayout;
    SpeedButton1: TSpeedButton;
    Layout3: TLayout;
    SpeedButton2: TSpeedButton;
    MudarTab4: TChangeTabAction;
    Text2: TText;
    TabItem1: TTabItem;
    MemToken: TMemo;
    MemResp: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_acessarClick(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure lblNovoClick(Sender: TObject);
    procedure lblRecuperarClick(Sender: TObject);
  private
    { Private declarations }
    FToken: string;
    procedure CriarContaFirebase;
    function DoLogin: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Firebase.Auth,
  Firebase.Interfaces,
  Firebase.Request,
  Firebase.Response,
  System.JSON,
  System.JSON.Writers;

{$R *.fmx}

procedure TForm1.btn_acessarClick(Sender: TObject);
begin
  if not DoLogin then
  begin
    ShowMessage('Não possui conta. E-mail ou senha inválida!');
    exit;
  end;
  MudarTab1.ExecuteTarget(Sender);
end;

procedure TForm1.Button14Click(Sender: TObject);
var
  Auth         : IFirebaseAuth;
  AResponse    : IFirebaseResponse;
  JSONResp     : TJSONValue;
  Obj          : TJSONObject;
begin
  Auth := TFirebaseAuth.Create;
  Auth.SetApiKey(WEB_API_KEY);
  AResponse := Auth.SendResetPassword(RecuperarSenha.Text);
  if (not Assigned(JSONResp)) or (not (JSONResp is TJSONObject)) then
  begin
    if Assigned(JSONResp) then
      JSONResp.Free;
    exit;
  end;

  if RecuperarSenha.Text.Equals(EmptyStr) then
  begin
    ShowMessage('Informe o email');
    exit;
  end;

  ShowMessage('Enviado com sucesso');
  RecuperarSenha.Text := EmptyStr;
  Obj := JSONResp as TJsonObject;
  MemResp.Lines.Add(Obj.ToString);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CriarContaFirebase;
  MudarTab1.ExecuteTarget(Sender);
  ShowMessage('Conta criada com sucesso!');
end;

procedure TForm1.CriarContaFirebase;
var
  Auth         : IFirebaseAuth;
  AResponse    : IFirebaseResponse;
  JSONResp     : TJSONValue;
  Obj          : TJSONObject;
  ObjError     : TJSONObject;
  LToken       : string;
  ErrorCode    : string;
  ErrorMessage : string;
begin
  Auth := TFirebaseAuth.Create;
  Auth.SetApiKey(WEB_API_KEY);
  AResponse := Auth.CreateUserWithEmailAndPassword(Edit1Conta.Text, Edit2ContaSenha.Text);
  JSONResp := TJSONObject.ParseJSONValue(AResponse.ContentAsString);
  if (not Assigned(JSONResp)) or (not (JSONResp is TJSONObject)) then
  begin
    if Assigned(JSONResp) then
      JSONResp.Free;
    exit;
  end;

  Obj := JSONResp as TJsonObject;

  if Obj.TryGetValue('idToken', LToken) then
    MemToken.Lines.Add(LToken);

  if Obj.TryGetValue('error', ObjError) then
  begin
    ObjError.TryGetValue('code', ErrorCode);
    ObjError.TryGetValue('message', ErrorMessage);
    if ErrorMessage.Equals('EMAIL_EXISTS') then
      raise Exception.Create('Esse email já existe');
  end;
end;

function TForm1.DoLogin: Boolean;
var
  Auth      : IFirebaseAuth;
  AResponse : IFirebaseResponse;
  JSONResp  : TJSONValue;
  Obj       : TJSONObject;
begin
  Result := False;
  Auth := TFirebaseAuth.Create;
  Auth.SetApiKey(WEB_API_KEY);
  AResponse := Auth.SignInWithEmailAndPassword(edt_email.Text, edt_senha.Text);
  JSONResp := TJsonObject.ParseJSONValue(AResponse.ContentAsString());
  try
    if (not Assigned(JSONResp)) or (not (JSONResp is TJSONObject)) then
      Exit(False);

    Obj := JSONResp as TJSONObject;
    Result := Obj.TryGetValue('idToken', FToken);
  finally
    JSONResp.DisposeOf;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl.ActiveTab   := TabLogin;
  //TabControl.TabPosition := TTabPosition.None;
end;

procedure TForm1.lblNovoClick(Sender: TObject);
begin
  MudarTab3.ExecuteTarget(Sender);
end;

procedure TForm1.lblRecuperarClick(Sender: TObject);
begin
  MudarTab2.ExecuteTarget(Sender);
end;

end.
