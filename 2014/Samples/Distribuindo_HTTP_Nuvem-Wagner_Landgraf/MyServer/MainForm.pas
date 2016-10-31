unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

uses
  MyServerUnit;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  StartMyServer;
  Label1.Caption := 'Server running!';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 StopMyServer;
end;

end.
