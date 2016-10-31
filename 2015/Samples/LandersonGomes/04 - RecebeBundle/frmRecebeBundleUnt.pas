unit frmRecebeBundleUnt;

interface

uses
  FMX.Platform, // Adicionado para suportar TApplicationEvent
  System.Messaging, // Adicionado para suportar TMessage
  Androidapi.Jni.GraphicsContentViewText, // Suportar JIntent
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.WebBrowser,
  FMX.Objects, FMX.Edit, FMX.Layouts;

type
  TfrmRecebeBundle = class(TForm)
    Image1: TImage;
    edtEvento: TEdit;
    edtHashtag: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    memMensagem: TMemo;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function ControlaEventosAplic (EventoAplic: TApplicationEvent; Contexto : TObject) : Boolean;
    procedure ControlaMensagensActivity(const Sender : TObject; const Mensagem : TMessage);
    function ControlaAcaoIntent (const Intent : JIntent) : boolean;
  public
    { Public declarations }
  end;

var
  frmRecebeBundle: TfrmRecebeBundle;

implementation

{$R *.fmx}
uses
  FMX.Platform.Android,
  Androidapi.Jni.JavaTypes,
  Androidapi.Jni.Net,
  Androidapi.Jni.Os,
  Androidapi.Helpers;

function TfrmRecebeBundle.ControlaAcaoIntent(const Intent: JIntent): boolean;
var
  MeuBundle : JBundle;

begin
  Result := False;
  if Intent <> nil then
    begin
      memMensagem.ClearContent;
      MeuBundle := Intent.getExtras;
      if MeuBundle <> nil then
       begin
        edtEvento.Text := JStringToString(MeuBundle.getString(StringToJString('Evento')));
        memMensagem.Lines.Add(JStringToString(MeuBundle.getString(StringToJString('Mensagem'))));
        edtHashtag.Text := JStringToString(MeuBundle.getString(StringToJString('Hashtag')));
       end;

      Invalidate;
    end;

end;

function TfrmRecebeBundle.ControlaEventosAplic(EventoAplic: TApplicationEvent;
  Contexto: TObject): Boolean;
var
  IniciaIntent : JIntent;
begin
  Result := False;
  if EventoAplic = TApplicationEvent.BecameActive then
    begin
      IniciaIntent := MainActivity.getIntent;
      if IniciaIntent <> nil then
        ControlaAcaoIntent(IniciaIntent);

    end;

end;

procedure TfrmRecebeBundle.ControlaMensagensActivity(const Sender: TObject;
  const Mensagem: TMessage);
begin
  if Mensagem is TMessageReceivedNotification then
    ControlaAcaoIntent(TMessageReceivedNotification(Mensagem).Value);
end;

procedure TfrmRecebeBundle.FormCreate(Sender: TObject);
var
  ServicoEventoAplic : IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, ServicoEventoAplic) then
    ServicoEventoAplic.SetApplicationEventHandler(ControlaEventosAplic);

  //Registramos nossa aplicação para receber ACTION
  //Conforme estabelecida no Intent-Filter do AndroidManifest.template.xml
  MainActivity.registerIntentAction(TJIntent.JavaClass.ACTION_ANSWER);


  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, ControlaMensagensActivity);

end;

end.
