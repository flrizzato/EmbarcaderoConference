unit fMacros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFrmMacros = class(TForm)
    DSFirebird: TDataSource;
    memSQL: TMemo;
    btnExecuteFirebird: TButton;
    griFirebird: TDBGrid;
    panParams: TPanel;
    lblFields: TLabel;
    edtFields: TEdit;
    edtTable: TEdit;
    lblTable: TLabel;
    procedure btnExecuteFirebirdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMacros: TFrmMacros;

implementation

{$R *.dfm}

uses dMacros;

procedure TFrmMacros.btnExecuteFirebirdClick(Sender: TObject);
begin
  with DMMacros do
  begin
    Query.Close;
    Query.SQL.Clear;
    Query.SQL := memSQL.Lines;
    Query.MacroByName('Fields').AsRaw := edtFields.Text;
    Query.MacroByName('Table').AsRaw := edtTable.Text;
    Query.Open;
  end;
end;

end.
