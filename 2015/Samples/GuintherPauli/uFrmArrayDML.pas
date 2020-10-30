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
unit uFrmArrayDML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmArrayDML = class(TForm)
    btnExecuteArrayDML: TButton;
    ds: TDataSource;
    tbl: TFDTable;
    grid: TDBGrid;
    qry: TFDQuery;
    procedure btnExecuteArrayDMLClick(Sender: TObject);
  private
    procedure CriarTabelaTeste();
    procedure DestruirTabelaTeste();
  end;

var
  FrmArrayDML: TFrmArrayDML;

implementation

{$R *.dfm}

procedure TFrmArrayDML.btnExecuteArrayDMLClick(Sender: TObject);
var
  i: integer;
begin
  // DestruirTabelaTeste();
  CriarTabelaTeste();
  qry.Params.ArraySize := 100;
  // qry.SQL.Text := 'insert into TESTE_ARRAY values (:ID,:TEXTO)';
  // se fizer o SQL em runtime, configurar parâmetros aqui ou no DFM / wizard
  for i := 0 to 99 do
  begin
    qry.ParamByName('ID').AsIntegers[i] := i;
    qry.ParamByName('TEXTO').AsStrings[i] := 'TEXTO' + i.ToString();
  end;
  qry.Execute(100);
  tbl.Open('TESTE_DML2');
  DestruirTabelaTeste();
end;

procedure TFrmArrayDML.CriarTabelaTeste();
begin
  DM.con.ExecSQL('create table TESTE_DML2'+
  '(ID INTEGER NOT NULL PRIMARY KEY,'+
  'TEXTO VARCHAR(200))');
end;

procedure TFrmArrayDML.DestruirTabelaTeste();
begin
 try
    DM.con.ExecSQL('drop table TESTE_ARRAY');
  except
    //
  end;
end;


end.
