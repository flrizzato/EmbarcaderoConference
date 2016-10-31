{
Sobre o autor:
Guinther Pauli
Cursos Treinamentos Consultoria
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#,ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://guintherpauli.blogspot.com
http://www.gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
Emails: guintherpauli@gmail.com; guinther@gpauli.com
Suporte Skype: guinther.pauli
}
unit uFrmSQLDialectAbstraction;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, uDM,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmSQLDialectAbstraction = class(TForm)
    grid: TDBGrid;
    ds: TDataSource;
    qry: TFDQuery;
    radio: TRadioGroup;
    btnOpen: TButton;
    procedure btnOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSQLDialectAbstraction: TFrmSQLDialectAbstraction;

implementation

{$R *.dfm}

procedure TFrmSQLDialectAbstraction.btnOpenClick(Sender: TObject);
begin
  case radio.ItemIndex of
    0: qry.Connection := dm.sqlcon;
    1: qry.Connection := dm.con;
  end;
  qry.SQL.Clear();
  qry.SQL.Add('{IF FIREBIRD} SELECT RDB$RELATION_NAME FROM RDB$RELATIONS {fi}');
  qry.SQL.Add('{IF MSSQL} SELECT NAME FROM SYS.OBJECTS {fi}');
  qry.Open();
end;

end.
