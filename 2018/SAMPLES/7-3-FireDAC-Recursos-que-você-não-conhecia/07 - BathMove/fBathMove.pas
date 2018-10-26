unit fBathMove;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmBathMove = class(TForm)
    btnExecuteFirebird: TButton;
    procedure btnExecuteFirebirdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBathMove: TFrmBathMove;

implementation

{$R *.dfm}

uses dBathMove;

procedure TFrmBathMove.btnExecuteFirebirdClick(Sender: TObject);
var
  lStart, lEnd: TDateTime;
begin
  lStart := Now;

  with DMBathMove do
  begin
    ConnectionFirebird.Connected := True;
    ConnectionPostgreSQL.Connected := True;
    FDBatchMove.Execute;
  end;

  lEnd := Now;

  ShowMessage('Time elapsed: ' + FormatDateTime('hh:nn:ss:zzz', lEnd - lStart));
end;

end.
