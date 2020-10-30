unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Objects, FMX.Gestures;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.iPhone.fmx IOS}
{$R *.iPad.fmx IOS}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.GGlass.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

uses Androidapi.Helpers,
  IdURI, FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText, Androidapi.Jni.Net, Androidapi.Jni.JavaTypes,
  Androidapi.Jni.Telephony, //Usado neste exemplo no contexto do SMS
  Unit2, Unit3;


procedure TForm1.Button1Click(Sender: TObject);
var
  uri : string;
  idContato : Integer;
  Intent : JIntent;
  GerenciadorSMS : JSmsManager;

begin

  case ComboBox1.ItemIndex of
    -1:
      begin
        ShowMessage('Selecione uma Intent');
        ComboBox1.SetFocus;
      end;
    0: //Mapa
      begin
        //'geo://0,0?q=Espaço Apas';
        uri := Format('https://www.google.com.br/maps/dir/%s/%s',
                      ['Espaço APAS São Paulo', 'Itaocara RJ']);
        try

          Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
              TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));

          Intent.setClassName(StringToJString('com.google.android.apps.maps'),
                StringToJString('com.google.android.maps.MapsActivity'));

          SharedActivity.startActivity(Intent);

        except on E: Exception do
          ShowMessage(E.Message);
        end;
      end;

    1: // Telefone
      begin
        uri :='tel://08007290001';
        try
          Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_CALL,
            TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
          SharedActivity.startActivity(Intent);
        except on E: Exception do
          ShowMessage(E.Message);
        end;
      end;

    2:
      begin
        uri:= 'content://com.android.contacts/contacts/';
        try
          Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_PICK,
            TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
            SharedActivity.startActivity(Intent)
        except on E: Exception do
          ShowMessage(E.Message);
        end;
      end;

    3: // Navegador
      begin
        uri :='http://landersongomes.vivaitaocara.com.br';
        try
          Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
            TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
          SharedActivity.startActivity(Intent);
        except on E: Exception do
          ShowMessage(E.Message);
        end;
      end;
    4: // Email
      begin
        Form3 := TForm3.Create(Application);
        if Assigned(Form3) then
          Form3.Show;

      end;
    5: // Agenda
      begin
        Form2 := TForm2.Create(Application);
        if Assigned(Form2) then
          Form2.Show;

      end;
    6: // SMS  - Lembrando que deve ser alterada a Permissão SEND_SMS para TRUE
      begin
        GerenciadorSMS := TJSmsManager.JavaClass.getDefault;
        GerenciadorSMS.sendTextMessage(StringToJString('8000'), nil, StringToJString('DELPHI XE7 SMS '), nil, nil );
        ShowMessage('Envio concluído!');
      end;
  end;




end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    4,5 : Button1.Text := 'Abrir';
    6: Button1.Text := 'Enviar SMS';
  else
    Button1.Text := 'Executar'
  end;
end;

end.
