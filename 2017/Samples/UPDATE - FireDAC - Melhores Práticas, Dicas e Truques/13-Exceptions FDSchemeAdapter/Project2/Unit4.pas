unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    FDConnection1: TFDConnection;
    FDQueryClientes: TFDQuery;
    FDQueryTelefones: TFDQuery;
    DtsClientes: TDataSource;
    FDQueryClientesIdCliente: TIntegerField;
    FDQueryClientesNome: TStringField;
    FDQueryTelefonesIdCliente: TIntegerField;
    FDQueryTelefonesFone: TStringField;
    DtsFone: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    FDSchemaAdapter1: TFDSchemaAdapter;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDSchemaAdapter1ReconcileRow(ASender: TObject; ARow: TFDDatSRow;
      var Action: TFDDAptReconcileAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  FDSchemaAdapter1.Close();
  FDSchemaAdapter1.Open();
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  FDConnection1.StartTransaction();
  try
    FDSchemaAdapter1.ApplyUpdates(0);
    FDConnection1.Commit();
  except
    on E:Exception do
    begin
      FDConnection1.Rollback();
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TForm4.FDSchemaAdapter1ReconcileRow(ASender: TObject; ARow: TFDDatSRow;
  var Action: TFDDAptReconcileAction);
//var
//  MensagemOriginal: String;
//  Objeto: String;
//  Sql: String;
//  Codigo: string;
begin
//  MensagemOriginal := EFDDBEngineException(ARow.RowError).Message;
//  Objeto := EFDDBEngineException(ARow.RowError).FDObjName;
//  Sql := EFDDBEngineException(ARow.RowError).SQL;
//  Codigo := EFDDBEngineException(ARow.RowError).ErrorCode.ToString();
//  raise Exception.Create('Minha menagem de erro.' + #13#13 +
//    'Mensagem Original: ' + MensagemOriginal + #13#13 +
//    'Comando SQL: ' + Sql + #13#13 +
//    'Objeto: ' + Objeto + #13#13 +
//    'Código do Erro ' + Codigo);
end;

end.
