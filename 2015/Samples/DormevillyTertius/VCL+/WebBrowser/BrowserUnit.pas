unit BrowserUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, Vcl.Themes,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    ImageList1: TImageList;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure WebBrowser1ShowScriptError(ASender: TObject; const AErrorLine,
      AErrorCharacter, AErrorMessage, AErrorCode, AErrorUrl: OleVariant;
      var AOut: OleVariant; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  WebBrowser1.Navigate(Edit1.Text);
end;

type
  TWinControlClass = class(TWInControl);

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    WebBrowser1.Navigate(Edit1.Text);
end;

procedure TForm1.WebBrowser1ShowScriptError(ASender: TObject; const AErrorLine,
  AErrorCharacter, AErrorMessage, AErrorCode, AErrorUrl: OleVariant;
  var AOut: OleVariant; var AHandled: Boolean);
begin
  AHandled := True;
end;

end.
