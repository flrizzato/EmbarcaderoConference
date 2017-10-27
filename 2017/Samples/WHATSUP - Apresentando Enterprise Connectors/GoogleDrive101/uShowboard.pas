unit uShowboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfmShowboard = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowBoard(Title: string);
  end;

var
  fmShowboard: TfmShowboard;

implementation

{$R *.dfm}

{ TfmShowboard }

procedure TfmShowboard.ShowBoard(Title: string);
begin
  Caption:=Title;
  ShowModal;
end;

end.
