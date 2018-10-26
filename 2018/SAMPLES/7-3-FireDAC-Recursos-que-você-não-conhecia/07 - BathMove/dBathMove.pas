unit dBathMove;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.SQL, FireDAC.Comp.BatchMove.DataSet,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDMBathMove = class(TDataModule)
    ConnectionFirebird: TFDConnection;
    ConnectionPostgreSQL: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    SQLWriter: TFDBatchMoveSQLWriter;
    FDBatchMove: TFDBatchMove;
    DataSetReader: TFDBatchMoveDataSetReader;
    Query: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMBathMove: TDMBathMove;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
