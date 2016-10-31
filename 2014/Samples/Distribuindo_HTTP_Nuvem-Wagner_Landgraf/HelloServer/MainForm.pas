unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmHelloServer = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
  end;

var
  fmHelloServer: TfmHelloServer;

implementation

uses
  HelloServerUnit;

{$R *.dfm}

procedure TfmHelloServer.FormCreate(Sender: TObject);
begin
  StartHelloServer;
  Label1.Caption := 'Server running!';
end;

procedure TfmHelloServer.FormDestroy(Sender: TObject);
begin
  StopHelloServer;
end;

end.
