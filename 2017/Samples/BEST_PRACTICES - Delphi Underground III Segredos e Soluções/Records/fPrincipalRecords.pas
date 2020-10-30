unit fPrincipalRecords;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uCores, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.Button1Click(Sender: TObject);
var
  lCor: TCor;
  lCor2: TCor;
  lCor3: TCor;
begin
//  lCor.A := $FF;
//  lCor.R := $FF;
//  lCor.G := $0;
//  lCor.B := $0;
  lCor := 'vermelho';
  lCor2 := 1;
  lCor3 := lCor + lCor2;


  Self.Fill.Color := lCor.Cor;
end;

end.
