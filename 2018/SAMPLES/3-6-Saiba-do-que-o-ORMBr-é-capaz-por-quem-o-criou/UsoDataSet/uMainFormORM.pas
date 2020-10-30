unit uMainFormORM;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DB,
  Grids,
  DBGrids,
  StdCtrls,
  Mask,
  DBClient,
  DBCtrls,
  ExtCtrls,

  Vcl.Imaging.pnglang,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Vcl.Imaging.GIFImg,

  /// dataset
  ormbr.manager.dataset,

  /// connection
  ormbr.factory.interfaces,
  ormbr.factory.firedac,
  ormbr.types.database,

  /// driver do banco
  ormbr.dml.generator.firebird,
//  ormbr.dml.generator.sqlite,

  /// orm model
  ormbr.model.mestre,
  ormbr.model.detalhe,
  ormbr.model.Status,
  ormbr.model.cliente,

  /// orm metadata
  ormbr.ddl.commands,
  ormbr.ddl.generator.firebird,
  ormbr.metadata.firebird,
  ormbr.modeldb.compare,
  ormbr.database.interfaces,

  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.ExprFuncs, FireDAC.Comp.UI, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TForm3 = class(TForm)
    dtsMestre: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    DBGrid2: TDBGrid;
    dtsDetalhe: TDataSource;
    dtsCliente: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMestre: TFDMemTable;
    FDDetalhe: TFDMemTable;
    FDCliente: TFDMemTable;
    FDStatus: TFDMemTable;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Button1: TButton;
    Button3: TButton;
    Memo1: TMemo;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    OpenDialog1: TOpenDialog;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FDDetalheCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    oConn: IDBConnection;
    oManager: TManagerDataSet;

    procedure UpdateMetadata;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  StrUtils,
  ormbr.form.monitor;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  LMaster: TTab_Mestre;
begin
  LMaster := oManager.Current<TTab_Mestre>;
  LMaster.Descricao := 'Mudando Registro via Object';
  oManager.Save<TTab_Mestre>(LMaster);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  oManager.ApplyUpdates<TTab_Mestre>(0);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  TCommandMonitor.GetInstance.Show;
end;

procedure TForm3.FDDetalheCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('CALPRECOS').AsCurrency := DataSet.FieldByName('PRECO').AsCurrency * 2;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  /// <summary>
  /// Conexão
  /// </summary>
  oConn := TFactoryFireDAC.Create(FDConnection1, dnFirebird);

  /// <summary>
  /// Monitor
  /// </summary>
  oConn.SetCommandMonitor(TCommandMonitor.GetInstance);

  /// <summary>
  /// Metadata
  /// </summary>
//  UpdateMetadata;

  /// <summary>
  /// Manager
  /// </summary>
  oManager := TManagerDataSet.Create(oConn);
  oManager.AddAdapter<TTab_Mestre>(FDMestre, 10)
          .AddAdapter<TTab_Detalhe, TTab_Mestre>(FDDetalhe)
          .AddAdapter<TTab_Cliente, TTab_Mestre>(FDCliente)
  .Open<TTab_Mestre>;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
  oManager.Free;
  inherited;
end;

procedure TForm3.UpdateMetadata;
var
oManager: IDatabaseCompare;
cDDL: TDDLCommand;
begin
  oManager := TModelDbCompare.Create(oConn);
//  oManager.CommandsAutoExecute := False;
  oManager.BuildDatabase;
  for cDDL in oManager.GetCommandList do
      Memo1.Lines.Add(cDDL.Command);
end;

end.
