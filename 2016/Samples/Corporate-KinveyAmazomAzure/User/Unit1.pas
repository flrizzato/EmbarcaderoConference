unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, REST.Backend.MetaTypes, System.JSON,
  System.PushNotification, REST.Backend.BindSource, REST.Backend.PushDevice,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Backend.ServiceComponents,
  REST.OpenSSL, REST.Backend.ServiceTypes, REST.Backend.KinveyServices,
  FMX.StdCtrls, REST.Backend.Providers, REST.Backend.KinveyProvider,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, FMX.Memo, FMX.ListBox;

type
  TForm1 = class(TForm)
    BackendUsers1: TBackendUsers;
    Button1: TButton;
    edUser: TEdit;
    edPassword: TEdit;
    User: TLabel;
    Password: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    KinveyProvider1: TKinveyProvider;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    ACO: TArray<TBackendEntityValue>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Unit2;

procedure TForm1.Button1Click(Sender: TObject);
var
  ACreatedObject: TBackendEntityValue;
begin
  BackendUsers1.Users.SignupUser(edUser.Text, edPassword.Text, nil, ACreatedObject);
  ShowMessage('Conta criada');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ACreatedObject, o2: TBackendEntityValue;
  ACO: TArray<TBackendEntityValue>;
  QueryStr: TArray<string>;
  arr: TJSONArray;
  v: TJSONValue;
  o: TJSONObject;
begin
  try
    BackendUsers1.Users.LoginUser(edUser.Text, edPassword.Text, ACreatedObject);
    ShowMessage('Ok');
  except
    ShowMessage('Erro de login');
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  user: TBackendEntityValue;
begin
  if ListBox1.ItemIndex > -1 then
  begin
    user :=   ACO[ListBox1.ItemIndex];
    BackendUsers1.Users.DeleteUser(user);
    Button4Click(Sender);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  arr: TJSONArray;
  ACreatedObject: TBackendEntityValue;
  QueryStr: TArray<string>;
  o: TJSONObject;
  user: TUsuario;
begin
  ListBox1.Clear;
  arr := TJSONArray.Create;
  QueryStr := TArray<string>.Create('');
  BackendUsers1.Users.QueryUsers(QueryStr, arr, ACO);
  for ACreatedObject in ACO do
  begin
    ListBox1.Items.Add(ACreatedObject.UserName);
  end;
end;

end.
