unit ufrmormbr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  ormbr.dml.generator.firebird,
  ormbr.container.dataset.interfaces,
  ormbr.container.fdmemtable,
  uORMBr.Clientes, Vcl.DBCtrls, Vcl.StdCtrls;

type
  Tfrmormbr = class(TForm)
    dbgrd1: TDBGrid;
    pnl1: TPanel;
    img1: TImage;
    img2: TImage;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    oContainerMaster: IContainerDataSet<TClientes>;
  public
    { Public declarations }
  end;

var
  frmormbr: Tfrmormbr;

implementation

uses
  udmdados, SQLMonitor;

{$R *.dfm}

procedure Tfrmormbr.Button1Click(Sender: TObject);
begin
  TFSQLMonitor.GetInstance.Show;
end;

procedure Tfrmormbr.FormCreate(Sender: TObject);
begin
  oContainerMaster := TContainerFDMemTable<TClientes>.Create(dmdados.oConnection, FDMemTable1);
  oContainerMaster.Open;
end;

end.
