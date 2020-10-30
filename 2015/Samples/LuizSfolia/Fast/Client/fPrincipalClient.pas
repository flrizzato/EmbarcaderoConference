unit fPrincipalClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, frxServerClient,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, frxHTTPClient, FMX.Edit;

type
  TForm2 = class(TForm)
    frxHTTPClient1: TfrxHTTPClient;
    BitmapAnimation1: TBitmapAnimation;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
  frxHTTPClient1.ClientFields.FileName := Edit1.Text;
  frxHTTPClient1.Connect;

  frxHTTPClient1.Stream.SaveToFile('c:\tmp\teste.pdf');
end;

end.
