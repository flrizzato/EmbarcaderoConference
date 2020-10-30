unit ufrmAlterandoComponentes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Mask, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uMeuDataSet;

type
  TForm2 = class(TForm)
    FDMemTable1: TFDMemTable;
    FDMemTable1ID: TIntegerField;
    FDMemTable1Campo1: TStringField;
    FDMemTable1Campo2: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMeuDataSet: TMeuDataSet;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.FormCreate(Sender: TObject);
begin
  FDMemTable1.CreateDataSet;
  FMeuDataSet := TMeuDataSet.Create(nil);
  FMeuDataSet.Data := FDMemTable1.Data;
  DataSource1.DataSet := FMeuDataSet;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FMeuDataSet.Close;
  FreeAndNil(FMeuDataSet);
end;

end.
