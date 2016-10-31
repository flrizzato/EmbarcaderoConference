unit frmRecebeSchemeUnt;

interface

uses
  FMX.Platform, // Adicionado para suportar TApplicationEvent
  System.Messaging, // Adicionado para suportar TMessage
  Androidapi.Jni.GraphicsContentViewText, // Suportar JIntent
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.WebBrowser,
  FMX.Objects;

type
  TfrmRecebeScheme = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Image1: TImage;
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
  frmRecebeScheme: TfrmRecebeScheme;

implementation

{$R *.fmx}
uses
  FMX.Platform.Android,
  Androidapi.Jni.JavaTypes,
  Androidapi.Jni.Net,
  Androidapi.Jni.Os,
  Androidapi.Helpers;

function TfrmRecebeScheme.ControlaAcaoIntent(const Intent: JIntent): boolean;
var
  Valor : Jnet_Uri;

begin
  Result := False;
  if Intent <> nil then
    begin
      Memo1.ClearContent;
      Valor := Intent.getData;
      if Valor <> nil then
       begin
        Memo1.Lines.Add(JStringToString(Valor.getHost));
       end;

      Invalidate;
    end;

end;

function TfrmRecebeScheme.ControlaEventosAplic(EventoAplic: TApplicationEvent;
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

procedure TfrmRecebeScheme.ControlaMensagensActivity(const Sender: TObject;
  const Mensagem: TMessage);
begin
  if Mensagem is TMessageReceivedNotification then
    ControlaAcaoIntent(TMessageReceivedNotification(Mensagem).Value);
end;

procedure TfrmRecebeScheme.FormCreate(Sender: TObject);
var
  ServicoEventoAplic : IFMXApplicationEventService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, ServicoEventoAplic) then
    ServicoEventoAplic.SetApplicationEventHandler(ControlaEventosAplic);

  //Registramos nossa aplicação para receber ACTION
  //Conforme estabelecida no Intent-Filter do AndroidManifest.template.xml
  MainActivity.registerIntentAction(TJIntent.JavaClass.ACTION_VIEW);


  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, ControlaMensagensActivity);

end;

end.
