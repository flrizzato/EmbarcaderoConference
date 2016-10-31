unit Exemplo1PAServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, FMX.Objects;

type
  TForm1 = class(TForm)
    Image1: TImage;
    edtName: TEdit;
    lblName: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  SName: string;
begin
 SName := edtName.Text;
 lblName.Text := Format ('Olá, %s', [sName]);
end;

end.
