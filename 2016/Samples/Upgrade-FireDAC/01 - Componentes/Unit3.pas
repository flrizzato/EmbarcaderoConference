unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TForm3 = class(TForm)
    ExtremedelphiConnection: TFDConnection;
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    FDStoredProc1: TFDStoredProc;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetDados(Value: TFDDataSet);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  GetDados(FDTable1);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  GetDados(FDQuery1);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  GetDados(FDStoredProc1);
end;

procedure TForm3.GetDados(Value: TFDDataSet);
begin
  DataSource1.DataSet := Value;
  Value.Open();
  Label1.Caption := Format('%d Registro(s)',[Value.RecordCount])
end;

end.
