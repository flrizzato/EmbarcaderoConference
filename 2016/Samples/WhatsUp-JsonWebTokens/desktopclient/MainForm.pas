unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Generics.Collections, Vcl.StdCtrls, Data.DB,
  Aurelius.Bind.Dataset, Vcl.Grids, Vcl.DBGrids,
  MusicEntities, XData.Client;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    AureliusDataset1: TAureliusDataset;
    edUser: TComboBox;
    edPassword: TEdit;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edUserChange(Sender: TObject);
    procedure AureliusDataset1ObjectUpdate(Dataset: TDataSet; AObject: TObject);
    procedure AureliusDataset1ObjectInsert(Dataset: TDataSet; AObject: TObject);
    procedure AureliusDataset1ObjectRemove(Dataset: TDataSet; AObject: TObject);
  private
    XClient: TXDataClient;
    Artists: TList<TArtist>;
    XClientAuth: TXDataClient;
    Token: string;
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Sparkle.Http.Client,
  LoginService;

{$R *.dfm}

procedure TForm1.AureliusDataset1ObjectInsert(Dataset: TDataSet;
  AObject: TObject);
begin
  XClient.Post(AObject);
end;

procedure TForm1.AureliusDataset1ObjectRemove(Dataset: TDataSet;
  AObject: TObject);
begin
  XClient.Delete(AObject);
end;

procedure TForm1.AureliusDataset1ObjectUpdate(Dataset: TDataSet;
  AObject: TObject);
begin
  XClient.Put(AObject);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  AureliusDataset1.Close;
  Artists := XClient.List<TArtist>;
  AureliusDataset1.SetSourceList(Artists);
  AureliusDataset1.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Token := XClientAuth.Service<ILoginService>.Login(edUser.Text, edPassword.Text);
  ShowMessage('Login successful');
end;

procedure TForm1.edUserChange(Sender: TObject);
begin
  if (edUser.Text = 'admin') or (edUser.Text = 'user') then
    edPassword.Text := edUser.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  XClient := TXDataClient.Create;
  XClient.Uri := 'http://localhost:2001/tms/api';
  XClient.HttpClient.OnSendingRequest :=
    procedure(Req: THttpRequest)
    begin
      if Token <> '' then
        Req.Headers.SetValue('authorization', 'Bearer ' + Token);
    end;

  XClientAuth := TXDataClient.Create;
  XClientAuth.Uri := 'http://localhost:2001/tms/auth';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  XClient.Free;
  XClientAuth.Free;
end;

end.
