unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TForm4 = class(TForm)
    Conexao: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    Button1: TButton;
    FDQuery3: TFDQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    Button3: TButton;
    FDTransaction1: TFDTransaction;
    FDQuery3IdCliente: TFDAutoIncField;
    FDQuery3Nome: TStringField;
    FDQuery3Logradouro: TStringField;
    FDQuery3Numero: TStringField;
    FDQuery3IdBairro: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  Conexao.StartTransaction();
  try
    FDQuery1.ExecSQL();
    Conexao.StartTransaction();
    try
      FDQuery2.ExecSQL();
      Conexao.Commit();
    except
      Conexao.Rollback();
    end;
    Conexao.Commit();
  except
    Conexao.Rollback();
  end;

end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Conexao.StartTransaction();
  if FDQuery3.ApplyUpdates(0) = 0 then
  begin
    Conexao.Commit();
  end
  else
  begin
    Conexao.Rollback();
  end;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  FDQuery3.Close();
  FDQuery3.Open();
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  FDQuery3.Open();
end;

end.
