unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, Vcl.Samples.Spin,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, FireDAC.Phys.MSSQLDef, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.Phys.IBBase;

type
  TForm3 = class(TForm)
    FDConnection1: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Button3: TButton;
    Image1: TImage;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDConnection2: TFDConnection;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    procedure LimparTabela;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  System.Threading;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  I: Integer;
  TempoOld: Cardinal;
begin
  LimparTabela();
  Button3.Caption := 'Diferença: ';
  FDQuery1.SQL.Text := 'insert into TabelaInsert (Id, Descricao) values(:Id, :Descricao)';
  TempoOld := GetTickCount();
  for I := 1 to SpinEdit1.Value do
  begin
    FDQuery1.Params[0].Value := I;
    FDQuery1.Params[1].Value := 'Nome - ' + i.ToString;
    FDQuery1.ExecSQL();
  end;
  Edit1.Text := IntToStr(GetTickCount() - TempoOld);
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  I: Integer;
  TempoOld: Cardinal;
  Tasks: array of ITask;
begin
  LimparTabela();
  Button3.Caption := 'Diferença: ';
  FDQuery1.SQL.Text := 'insert into TabelaInsert (Id, Descricao) values(:Id, :Descricao)';
  FDQuery1.Params.ArraySize := SpinEdit1.Value;
  TempoOld := GetTickCount();
  for I := 0 to FDQuery1.Params.ArraySize do
  begin
    FDQuery1.Params[0].AsIntegers[I - 1] := I;
    FDQuery1.Params[1].AsStrings[I - 1] := 'Nome - ' + IntToStr(I);
  end;
  FDQuery1.Execute(FDQuery1.Params.ArraySize);
  Edit2.Text := IntToStr(GetTickCount() - TempoOld);
end;

procedure TForm3.Button3Click(Sender: TObject);
var
  Tempo1: Integer;
  Tempo2: Integer;
begin
  Tempo1 := StrToInt(Edit1.Text);
  Tempo2 := StrToInt(Edit2.Text);
  Button3.Caption := 'Diferença: ' + FormatFloat('#0.00%',
    (Tempo1 - Tempo2) * 100 / Tempo1);
end;

procedure TForm3.LimparTabela;
begin
  FDQuery1.SQL.Text := 'delete from TabelaInsert';
  FDQuery1.ExecSQL;
end;

procedure TForm3.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0: FDQuery1.Connection := FDConnection2;
    1: FDQuery1.Connection := FDConnection1;
  end;
end;

end.
