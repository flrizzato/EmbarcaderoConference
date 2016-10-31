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
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
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
  { Exemplo de um cenário a ser evitado }

  // .     /........> Regra de Visualização
  // .     |
  // . /--------\
  { } ShowMessage(' - Delphi Conference 2013 - ');
  // .             \---------------------------/
  // .                            |
  // .                            \..........> Regra de negócio
end;

end.
