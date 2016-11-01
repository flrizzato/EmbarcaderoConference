unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmServer = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
  end;

var
  fmServer: TfmServer;

implementation

uses
  Server;

{$R *.dfm}

procedure TfmServer.FormCreate(Sender: TObject);
begin
  StartServer;
  Label1.Caption := 'Server running!';
end;

procedure TfmServer.FormDestroy(Sender: TObject);
begin
  StopServer;
end;

end.
