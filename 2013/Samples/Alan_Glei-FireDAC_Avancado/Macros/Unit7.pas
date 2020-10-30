unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.ValEdit, Vcl.DBGrids,
  FireDAC.VCLUI.Wait, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Comp.UI;

type
  TForm7 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Button1: TButton;
    ValueListEditor1: TValueListEditor;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  FDQuery1.Close();
  for I := 1 to ValueListEditor1.RowCount -1 do
    begin
      FDQuery1.Macros[i-1].Value := ValueListEditor1.Values[ValueListEditor1.Keys[i]];
    end;
  FDQuery1.Open();
end;

procedure TForm7.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  ValueListEditor1.Strings.Clear();
  for I := 0 to FDQuery1.MacroCount -1 do
  begin
    ValueListEditor1.InsertRow(FDQuery1.Macros[i].Name, FDQuery1.Macros[i].Value,True);
  end;
end;

end.
