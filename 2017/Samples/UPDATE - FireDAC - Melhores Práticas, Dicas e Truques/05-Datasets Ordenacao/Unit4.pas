unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    FDMemTable1EmpNo: TIntegerField;
    FDMemTable1LastName: TStringField;
    FDMemTable1FirstName: TStringField;
    FDMemTable1PhoneExt: TStringField;
    FDMemTable1HireDate: TDateTimeField;
    FDMemTable1Salary: TFloatField;
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.DBGrid1TitleClick(Column: TColumn);
//var
//  Opcaoes: TFDSortOptions;
//  NomeIndice: String;
//  Ix: TFDIndex;
begin
  if FDMemTable1.IndexFieldNames = Column.FieldName then
  begin
    FDMemTable1.IndexFieldNames := Column.FieldName + ':D';
  end
  else
  begin
    FDMemTable1.IndexFieldNames := Column.FieldName;;
  end;

//  if FDMemTable1.IndexName = 'a' + Column.FieldName then
//  begin
//    NomeIndice := 'd' + Column.FieldName;
//    Opcaoes := [soDescending];
//  end
//  else
//  begin
//    NomeIndice := 'a' + Column.FieldName;
//    Opcaoes := [];
//  end;
//  FDMemTable1.Indexes.Clear();
//  FDMemTable1.IndexName := EmptyStr;
//  if FDMemTable1.Indexes.FindIndex(NomeIndice) = nil then
//  begin
//    Ix := FDMemTable1.Indexes.Add();
//    Ix.Name := NomeIndice;
//    Ix.Fields := Column.FieldName;
//    Ix.Options := Opcaoes;
//    Ix.Selected := True;
//  end;
//  FDMemTable1.IndexName := NomeIndice;

end;

end.
