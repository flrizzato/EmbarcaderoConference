unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids;

type
  TForm4 = class(TForm)
    Conexao: TFDConnection;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button4: TButton;
    FDMemTable1: TFDMemTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  Conexao.ExecSQL('drop table teste', True);
  Conexao.ExecSQL('create table teste (id integer primary key, nome varchar(50))');
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Conexao.ExecSQL('insert into teste (id, nome) values (1,''ALAN'')');
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Conexao.ExecSQL('insert into teste (id, nome) values (:id, :nome)', [StrToInt(Edit1.Text), Edit2.Text],
    [ftInteger, ftString]);
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  Conexao.ExecSQL('select * from teste',TDataSet(FDMemTable1));
  DataSource1.DataSet := FDMemTable1;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  Edit2.Text := Conexao.ExecSQLScalar('select nome from teste where id = :id',[StrToInt(Edit1.Text)]);
end;

end.
