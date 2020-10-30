unit Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Menus,
  Vcl.ComCtrls,
  IPPeerClient,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Authenticator.OAuth;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Financeiro1: TMenuItem;
    Estoque1: TMenuItem;
    Vendas1: TMenuItem;
    N1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Panel3: TPanel;
    Button1: TButton;
    Panel4: TPanel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FSession: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.JSON;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oData: TJSONObject;
  oResult: TJSONObject;
  oSpeech: TJSONString;
begin
  oData := TJSONObject.Create;
  try
    Self.Memo1.Lines.Add('Eu: ' + Self.Memo2.Text);
    Self.Memo1.Lines.Add('------------------------------------');

    oData.AddPair('query', Self.Memo2.Text);
    oData.AddPair('lang', 'pt-br');
    oData.AddPair('timezone', 'America/Sao_Paulo');
    oData.AddPair('sessionId', Self.FSession);

    Self.RESTRequest1.AddBody(oData);

    Self.RESTRequest1.Execute;

    if Self.RESTResponse1.StatusCode <> 200 then
    begin
      ShowMessage(Self.RESTResponse1.JSONValue.ToJSON);
      Exit;
    end;

    oResult := TJSONObject(
              TJSONObject(
                 Self.RESTResponse1.JSONValue
                 ).GetValue('result'));
    oSpeech := TJSONString(oResult.GetValue('speech'));

    Self.Memo1.Lines.Add('Severiiinu!: ' + oSpeech.Value);
    Self.Memo1.Lines.Add('------------------------------------');
   finally
    Self.Memo2.Clear;
    oData.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.FSession := 'EC2017_XXXXX-XXXXX-YYYY';
end;

end.
