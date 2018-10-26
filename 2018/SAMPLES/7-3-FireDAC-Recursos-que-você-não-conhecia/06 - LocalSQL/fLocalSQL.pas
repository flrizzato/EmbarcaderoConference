unit fLocalSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TFrmLocalSQL = class(TForm)
    btnExecuteFirebird: TButton;
    griFirebird: TDBGrid;
    DataSource: TDataSource;
    procedure btnExecuteFirebirdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocalSQL: TFrmLocalSQL;

implementation

{$R *.dfm}

uses dLocalSQL;

procedure TFrmLocalSQL.btnExecuteFirebirdClick(Sender: TObject);
begin
  DMLocalSQL.ConnectionFirebird.Connected := True;
  DMLocalSQL.ConnectionPostgreSQL.Connected := True;
  DMLocalSQL.ConnectionLocal.Connected := True;

  DMLocalSQL.VendasFull.Close;
  DMLocalSQL.VendasFull.Open;
end;

end.
