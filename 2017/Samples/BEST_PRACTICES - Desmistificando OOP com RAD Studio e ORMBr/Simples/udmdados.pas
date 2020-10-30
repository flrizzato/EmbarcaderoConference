unit udmdados;

interface

uses
  System.SysUtils, System.Classes,

  ormbr.factory.interfaces,
  ormbr.types.database,
  ormbr.database.abstract,
  ormbr.database.interfaces,
  ormbr.modeldb.compare,
  ormbr.ddl.generator.firebird,
  ormbr.metadata.firebird,
  ormbr.ddl.commands,


  ormbr.factory.firedac,


  FireDAC.Stan.Intf, FireDAC.Stan.Option, Dialogs,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  Tdmdados = class(TDataModule)
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    oConnection: IDBConnection;
    oManager: IDatabaseCompare;

  end;

var
  dmdados: Tdmdados;

implementation

uses
  SQLMonitor;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdmdados.DataModuleCreate(Sender: TObject);
//var
//  cDDL: TDDLCommand;
//  comandos : TStringList;
begin
//  comandos := TStringList.Create;

  FDConnection1.Connected := true;
  oConnection := TFactoryFireDAC.Create(FDConnection1, dnFirebird);
  oConnection.SetCommandMonitor(TFSQLMonitor.GetInstance);

  oManager := TModelDbCompare.Create(oConnection);
//  oManager.CommandsAutoExecute:= false;
  oManager.BuildDatabase;

//  for cDDL in oManager.GetCommandList do
//      comandos.Add(cDDL.Command) ;
//
//      ShowMessage(comandos.Text);
end;

procedure Tdmdados.FDConnection1BeforeConnect(Sender: TObject);
begin
  FDConnection1.Params.Values[ 'Database'] := ExtractFilePath(ParamStr(0))+ 'database.fdb';
end;

end.
