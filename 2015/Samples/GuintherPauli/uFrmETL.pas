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
unit uFrmETL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Datasnap.DBClient, FireDAC.Comp.BatchMove.Text, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Comp.BatchMove.SQL;

type
  TFrmETL = class(TForm)
    PageControl: TPageControl;
    tabTxt: TTabSheet;
    qry: TFDQuery;
    BatchMove: TFDBatchMove;
    Reader: TFDBatchMoveDataSetReader;
    datasetWriter: TFDBatchMoveDataSetWriter;
    Button1: TButton;
    ds: TDataSource;
    txtWriter: TFDBatchMoveTextWriter;
    tabDataSet: TTabSheet;
    tabSource: TTabSheet;
    mmDados: TMemo;
    gridSource: TDBGrid;
    tabSQL: TTabSheet;
    sqlWriter: TFDBatchMoveSQLWriter;
    btnMoveDataSet: TButton;
    gridSQL: TDBGrid;
    tbl: TFDTable;
    dsSQL: TDataSource;
    memTable: TFDMemTable;
    dsDataSet: TDataSource;
    gridDataSet: TDBGrid;
    procedure btnMoveDataSetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmETL: TFrmETL;

implementation

{$R *.dfm}

uses
  System.IOUtils;

procedure TFrmETL.btnMoveDataSetClick(Sender: TObject);
begin
  BatchMove.Writer := datasetWriter;
  BatchMove.Execute();
  BatchMove.Writer := txtWriter;
  BatchMove.Execute();
  BatchMove.Writer := sqlWriter;
  BatchMove.Execute();
  mmDados.Lines.LoadFromFile('.\dados.txt');
  tbl.Open('TARGET');
end;

procedure TFrmETL.FormShow(Sender: TObject);
begin
  try
    DM.con.ExecSQL('drop table TARGET');
    DeleteFile('.\dados.txt');
  except
    //
  end;
  qry.Open();
end;

end.
