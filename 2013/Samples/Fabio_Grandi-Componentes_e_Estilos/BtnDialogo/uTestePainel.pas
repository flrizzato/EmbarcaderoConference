unit uTestePainel;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type
  TTestePainel = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestePainel: TTestePainel;

implementation

{$R *.fmx}

uses uTesteDialogo;

procedure TTestePainel.Button1Click(Sender: TObject);
var
  ModalResult: Integer;
begin
  ModalResult := TesteDialogo.ShowModal;
  Label1.Text := IntToStr(ModalResult);
end;

end.
