unit Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI,
  FireDAC.Comp.BatchMove.Text, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet,
  Unit1, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TDtm = class(TDataModule)
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDConnMSSQL: TFDConnection;
    SqlClientes: TFDQuery;
    SqlClientesId: TIntegerField;
    SqlClientesNome: TStringField;
    SqlClientesDataNascimento: TDateField;
    FDBatchMoveTextWriter1: TFDBatchMoveTextWriter;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    SqlClientes1: TFDQuery;
    FDConnINTERBASE: TFDConnection;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    FDBatchMoveDataSetReader2: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter2: TFDBatchMoveDataSetWriter;
    procedure FDBatchMove1Progress(ASender: TObject; APhase: TFDBatchMovePhase);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetDados();
    procedure TableToTxt();
    procedure TxtToTable();
    procedure TableToTable();
  end;

var
  Dtm: TDtm;

implementation

uses
  Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDtm }

procedure TDtm.TableToTable;
begin
  FDBatchMove1.Reader := FDBatchMoveDataSetReader2;
  FDBatchMove1.Writer := FDBatchMoveDataSetWriter2;
  FDBatchMove1.GuessFormat();
  FDBatchMove1.Execute();
end;

procedure TDtm.TableToTxt;
begin
  FDBatchMove1.Reader := FDBatchMoveDataSetReader1;
  FDBatchMove1.Writer := FDBatchMoveTextWriter1;
  FDBatchMove1.Execute();
end;

procedure TDtm.TxtToTable;
begin
  FDBatchMove1.Reader := FDBatchMoveTextReader1;
  FDBatchMove1.Writer := FDBatchMoveDataSetWriter1;
  FDBatchMove1.GuessFormat();
  FDBatchMove1.Execute();
end;

procedure TDtm.FDBatchMove1Progress(ASender: TObject;
  APhase: TFDBatchMovePhase);
begin
  case APhase of
    psPreparing: ;
    psStarting: Form1.Progresso(True);
    psProgress: Application.ProcessMessages();
    psFinishing: Form1.Progresso(False);
    psUnpreparing: ;
  end;

end;

procedure TDtm.GetDados;
begin
  SqlClientes.Close();
  SqlClientes1.Close();
  SqlClientes.Open();
  SqlClientes1.Open();
end;

end.
