unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.VCLUI.Login, FireDAC.Moni.Base, FireDAC.Moni.FlatFile, FireDAC.Phys.IB;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    Button2: TButton;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDMemTable1: TFDMemTable;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FDQuery1.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FDConnection1.Open;

 with FDConnection1.FormatOptions do
  begin
    OwnMapRules := True;
    MapRules.Clear;
    with MapRules.Add do
    begin
      SourceDataType := dtFmtBCD;
      PrecMin:= 10;
      PrecMax:= 10;
      TargetDataType := dtInt32;
    end;
  end;
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  FDQuery1.IndexFieldNames := Column.FieldName;
end;

end.
