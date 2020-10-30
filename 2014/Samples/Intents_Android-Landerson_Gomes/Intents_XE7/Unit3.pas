unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
uses
  FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
  Androidapi.Jni.Net, Androidapi.Jni.JavaTypes, idUri,
  Androidapi.JNIBridge, Androidapi.Helpers;


procedure TForm3.Button1Click(Sender: TObject);
var
  Destinatario : string;
  Intent : JIntent;
  Destinatarios: TJavaObjectArray<JString>;
begin
  if Edit1.Text <> EmptyStr then
    begin
      Destinatario := Edit1.Text;
      Destinatarios := TJavaObjectArray<JString>.Create(1);
      Destinatarios.Items[0] := StringToJString(Destinatario);

      Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
      Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, Destinatarios);
      Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString('E-mail de Teste'));
      Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString('corpo do email'));
      Intent.setType(StringToJString('plain/text'));

      SharedActivity.startActivity(TJIntent.JavaClass.createChooser(Intent,
        StrToJCharSequence('Qual aplicativo deseja usar?')));
    end;

end;
procedure TForm3.FormActivate(Sender: TObject);
begin
  Edit1.Text := 'insira@email.com';
end;

end.
