unit MainForm;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Controls, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Controls, WEBLib.ExtCtrls,
  XData.Web.Client, XData.Web.Connection;

type
  TForm3 = class(TWebForm)
    cbNota: TWebComboBox;
    btRegistrar: TWebButton;
    XDataWebConnection1: TXDataWebConnection;
    XDataWebClient1: TXDataWebClient;
    WebTimer1: TWebTimer;
    procedure btRegistrarClick(Sender: TObject);
    procedure XDataWebClient1Load(Response: TXDataClientResponse);
    procedure WebFormCreate(Sender: TObject);
    procedure WebTimer1Timer(Sender: TObject);
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.btRegistrarClick(Sender: TObject);
var
  Nota: Integer;
begin
  Nota := cbNota.ItemIndex;
  XDataWebClient1.RawInvoke('INotaService.Registrar', [Nota]);
end;

procedure TForm3.WebFormCreate(Sender: TObject);
begin
  cbNota.ItemIndex := 10;

end;

procedure TForm3.WebTimer1Timer(Sender: TObject);
begin
  WebTimer1.Enabled := False;
  btRegistrar.Caption := 'Registrar';
  btRegistrar.Enabled := True;
end;

procedure TForm3.XDataWebClient1Load(Response: TXDataClientResponse);
var
  Media: double;
  Total: Integer;
begin
  Media := double(Response.ResultAsObject['Media']);
  Total := Integer(Response.ResultAsObject['Total']);
  btRegistrar.Caption := Format('Nota: %.2f (%d)', [Media, Total]);
  btRegistrar.Enabled := False;
end;

end.
