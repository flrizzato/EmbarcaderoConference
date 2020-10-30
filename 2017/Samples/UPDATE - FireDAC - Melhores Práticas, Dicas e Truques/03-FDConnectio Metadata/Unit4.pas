unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet;

type
  TForm4 = class(TForm)
    Conexao: TFDConnection;
    Button1: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    FDMetaInfoQuery1: TFDMetaInfoQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
    FDMetaInfoQuery1RECNO: TIntegerField;
    FDMetaInfoQuery1CATALOG_NAME: TWideStringField;
    FDMetaInfoQuery1SCHEMA_NAME: TWideStringField;
    FDMetaInfoQuery1TABLE_NAME: TWideStringField;
    FDMetaInfoQuery1TABLE_TYPE: TIntegerField;
    FDMetaInfoQuery1TABLE_SCOPE: TIntegerField;
    FDMetaInfoQuery2: TFDMetaInfoQuery;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    FDMetaInfoQuery2RECNO: TIntegerField;
    FDMetaInfoQuery2CATALOG_NAME: TWideStringField;
    FDMetaInfoQuery2SCHEMA_NAME: TWideStringField;
    FDMetaInfoQuery2TABLE_NAME: TWideStringField;
    FDMetaInfoQuery2COLUMN_NAME: TWideStringField;
    FDMetaInfoQuery2COLUMN_POSITION: TIntegerField;
    FDMetaInfoQuery2COLUMN_DATATYPE: TIntegerField;
    FDMetaInfoQuery2COLUMN_TYPENAME: TWideStringField;
    FDMetaInfoQuery2COLUMN_ATTRIBUTES: TLongWordField;
    FDMetaInfoQuery2COLUMN_PRECISION: TIntegerField;
    FDMetaInfoQuery2COLUMN_SCALE: TIntegerField;
    FDMetaInfoQuery2COLUMN_LENGTH: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDMetaInfoQuery1AfterScroll(DataSet: TDataSet);
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
  Conexao.GetTableNames('','','',Listbox1.Items);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  FDMetaInfoQuery1.Open();
end;

procedure TForm4.FDMetaInfoQuery1AfterScroll(DataSet: TDataSet);
begin
  FDMetaInfoQuery2.Close();
  FDMetaInfoQuery2.ObjectName := FDMetaInfoQuery1TABLE_NAME.AsString;
  FDMetaInfoQuery2.Open();
end;

procedure TForm4.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > -1 then
  begin
    Conexao.GetFieldNames('','',ListBox1.Items[ListBox1.ItemIndex],'',ListBox2.Items);
  end;
end;

end.
