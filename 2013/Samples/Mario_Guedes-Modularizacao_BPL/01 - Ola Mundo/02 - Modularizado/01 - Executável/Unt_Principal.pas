unit Unt_Principal;

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
  Vcl.StdCtrls;

type

  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  DC2013.OlaMundo.OlaMundo;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  sMensagem: string;
begin

  // .                     /---------------------> Namespace em ação (nome totalmente qualificado)
  // .                     |
  // .                     |                  /--> Regra de negócio isolada! \o/
  // .                     |                  |
  // .         /----------------------\ /-----------\
  sMensagem := DC2013.OlaMundo.OlaMundo.GerarOlaMundo;

  ShowMessage(sMensagem); // --> Regra de visualização!
end;

end.
