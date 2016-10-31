unit uDM;

interface

uses
  SysUtils, Classes, WideStrings, FMTBcd, DB, SqlExpr, Data.DBXMSSQL;

type
  TDMdados = class(TDataModule)
    sqlDInamico: TSQLDataSet;
    sqlDinamico2: TSQLDataSet;
    sqlConexao: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMdados: TDMdados;

implementation

{$R *.dfm}

end.
