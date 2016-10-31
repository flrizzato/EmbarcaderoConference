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
unit uFrmExecutingSQLScripts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.UI.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.VCLUI.Script, Data.DB, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Comp.Script;

type
  TFrmExecutingSQLScripts = class(TForm)
    Script: TFDScript;
    mmScript: TMemo;
    btnExecute: TButton;
    grid: TDBGrid;
    tbl: TFDTable;
    ds: TDataSource;
    scriptDlg: TFDGUIxScriptDialog;
    procedure btnExecuteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExecutingSQLScripts: TFrmExecutingSQLScripts;

implementation

{$R *.dfm}

procedure TFrmExecutingSQLScripts.btnExecuteClick(Sender: TObject);
var
  SQL: TFDSQLScript;
begin
  Script.SQLScripts.Clear();
  SQL := Script.SQLScripts.Add();
  SQL.SQL.Add('drop table CLIENTES;');
  SQL.SQL.Add('create table CLIENTES( ' +
    ' ID integer not null primary key,NOME varchar(100));');
  SQL.SQL.Add('insert into CLIENTES values(1,''GUINTHER'');');
  SQL.SQL.Add('insert into CLIENTES values(2,''RUDOLFO'');');
  SQL.SQL.Add('insert into CLIENTES values(3,''FERNANDO'');');
  SQL.SQL.Add('insert into CLIENTES values(4,''FABIO'');');
  Script.ValidateAll();
  Script.ExecuteAll();
  tbl.Open('CLIENTES');
end;

end.
