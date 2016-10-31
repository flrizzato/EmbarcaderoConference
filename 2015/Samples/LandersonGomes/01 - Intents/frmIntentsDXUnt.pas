unit frmIntentsDXUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TfrmIntentsDX = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    ToolBar1: TToolBar;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    btnTwitter: TCornerButton;
    btnLocalizacaoGeo: TCornerButton;
    btnEnviarTextoIntent: TCornerButton;
    btnSchemeDelphiIntent: TCornerButton;
    btnBundleIntent: TCornerButton;
    procedure Image1Click(Sender: TObject);
    procedure btnTwitterClick(Sender: TObject);
    procedure btnLocalizacaoGeoClick(Sender: TObject);
    procedure btnEnviarTextoIntentClick(Sender: TObject);
    procedure btnSchemeDelphiIntentClick(Sender: TObject);
    procedure btnBundleIntentClick(Sender: TObject);
  private
    { Private declarations }
   procedure EnviarTextoViaIntent(const MeuTexto : string);
   procedure EnviarLocalizacaoIntent;
   procedure EnviarSchemaIntent;
   procedure IntentExplicitaTwitter;

  public
    { Public declarations }
  end;

var
  frmIntentsDX: TfrmIntentsDX;

implementation

{$R *.fmx}
uses
  Androidapi.Jni.JavaTypes,
  IdURI, Androidapi.Jni.Net, // Usadas para o Exemplo IntentLocalizacao
  Androidapi.Jni.GraphicsContentViewText,
  FMX.Platform.Android,
  Androidapi.Helpers;



{ TfrmIntentsDX }

procedure TfrmIntentsDX.btnLocalizacaoGeoClick(Sender: TObject);
begin
  EnviarLocalizacaoIntent;
end;

procedure TfrmIntentsDX.btnTwitterClick(Sender: TObject);
begin
  IntentExplicitaTwitter;
end;

procedure TfrmIntentsDX.btnSchemeDelphiIntentClick(Sender: TObject);
begin
  EnviarSchemaIntent;
end;

procedure TfrmIntentsDX.btnBundleIntentClick(Sender: TObject);
var
  IntentBundle : JIntent;

begin
  IntentBundle := TJIntent.Create;
  // Selecionei ACTION_ANSWER pois não há aplicativos associados a ela no meu aparelho
  IntentBundle.setAction(TJIntent.JavaClass.ACTION_ANSWER);
  IntentBundle.putExtra(StringToJString('Evento'), StringToJString('Embarcadero Conference 2015'));
  IntentBundle.putExtra(StringToJString('Mensagem'), StringToJString('Isso aqui é Delphi meu filho!'));
  IntentBundle.putExtra(StringToJString('Hashtag'), StringToJString('#dephi20anos'));
  if MainActivity.getPackageManager.queryIntentActivities(IntentBundle,
          TJPackageManager.JavaClass.MATCH_DEFAULT_ONLY).size > 0 then
    MainActivity.startActivity(IntentBundle)

  else
    ShowMessage('Não existe APK para receber IntentBundle');
end;

procedure TfrmIntentsDX.btnEnviarTextoIntentClick(Sender: TObject);
begin
  EnviarTextoViaIntent('program ECon2015;' + sLineBreak +
    sLineBreak +
    'begin' + sLineBreak +
    '  Writeln(' + QuotedStr('Bem vindo ao Delphi 10 Seattle!') +');' + sLineBreak +
    'end.' + sLineBreak);
end;

procedure TfrmIntentsDX.EnviarTextoViaIntent(const MeuTexto: string);
var
  IntentTexto : JIntent;
begin
  IntentTexto := TJIntent.Create;
  IntentTexto.setType(StringToJString('text/pas'));
  IntentTexto.setAction(TJIntent.JavaClass.ACTION_VIEW);
  IntentTexto.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString(MeuTexto));
  if MainActivity.getPackageManager.queryIntentActivities(IntentTexto,
          TJPackageManager.JavaClass.MATCH_DEFAULT_ONLY).size > 0 then
    MainActivity.startActivity(IntentTexto)

  else
    ShowMessage('Não existe APK para receber esta Intent');

end;

procedure TfrmIntentsDX.Image1Click(Sender: TObject);
var
  uri : string;
  Intent : JIntent;
begin
  uri :='http://landersongomes.vivaitaocara.com.br';
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
        TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
  SharedActivity.startActivity(Intent);

end;

procedure TfrmIntentsDX.IntentExplicitaTwitter;
var
  IntentTweet : JIntent;
begin
  //Enviar tweet
  IntentTweet := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
  IntentTweet.setClassName(StringToJString('com.twitter.android'),
        StringToJString('com.twitter.android.composer.ComposerActivity') );
  IntentTweet.putExtra(TJIntent.JavaClass.EXTRA_TEXT,
        StringToJString('Intents em Android: Novos Recursos. Exemplo Intent Explícita. '+
                          '#10Seattle #delphi20anos #Econ2015') )  ;
  SharedActivity.startActivity(IntentTweet);
end;

procedure TfrmIntentsDX.EnviarLocalizacaoIntent;
var
  IntentLocalizacao : JIntent;
  uri : string;
begin
  uri :='geo://0,0?q=Maracana, Rio de Janeiro';
  try
    IntentLocalizacao := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
    SharedActivity.startActivity(IntentLocalizacao);
  except on E: Exception do
    ShowMessage(E.Message);
  end;
  end;

procedure TfrmIntentsDX.EnviarSchemaIntent;
var
  scheme, uri: string;
  IntentScheme : JIntent;
begin
  scheme := 'delphi://';
  uri := scheme + 'Embarcadero Conference Brasil 2015!';
  IntentScheme := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
      TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));

  if MainActivity.getPackageManager.queryIntentActivities(IntentScheme,
          TJPackageManager.JavaClass.MATCH_DEFAULT_ONLY).size > 0 then
    MainActivity.startActivity(IntentScheme)

  else
    ShowMessage('Não existe APK para receber esta Intent');
end;

end.
