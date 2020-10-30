unit fArrayDML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Param;

const
  Registros = 10000;

type
  TFrmArrayDML = class(TForm)
    btnExecuteFirebird: TButton;
    btnArrayDML: TButton;
    procedure btnExecuteFirebirdClick(Sender: TObject);
    procedure btnArrayDMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmArrayDML: TFrmArrayDML;

implementation

{$R *.dfm}

uses dArrayDML;

procedure TFrmArrayDML.btnArrayDMLClick(Sender: TObject);
var
  I: Integer;
  lStart, lEnd: TDateTime;
begin
  lStart := Now;

  DMArrayDML.Query.Params.ArraySize := Registros;

  for I := 0 to Registros -1 do
    DMArrayDML.Query.ParamByName('item').AsStrings[I] :=  I.ToString + ' - ' + DateTimeToStr(Now);

  DMArrayDML.Query.Execute(Registros, 0);

  lEnd := Now;

  ShowMessage('Time elapsed: ' + FormatDateTime('hh:nn:ss:zzz', lEnd - lStart));
end;

procedure TFrmArrayDML.btnExecuteFirebirdClick(Sender: TObject);
var
  I: Integer;
  lStart, lEnd: TDateTime;
begin
  lStart := Now;

  for I := 1 to Registros do
  begin
    DMArrayDML.Query.ParamByName('item').AsString := I.ToString + ' - ' + DateTimeToStr(Now);
    DMArrayDML.Query.ExecSQL;
  end;

  lEnd := Now;

  ShowMessage('Time elapsed: ' + FormatDateTime('hh:nn:ss:zzz', lEnd - lStart));
end;

end.
