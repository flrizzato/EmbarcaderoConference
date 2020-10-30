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
unit uFrmLocalSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DBXFirebird, Data.FMTBcd,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Data.DB, Data.SqlExpr, FireDAC.Phys.SQLiteVDataSet,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmLocalSQL = class(TForm)
    qryDepartment: TSQLQuery;
    qryEmployee: TFDQuery;
    conLocal: TFDConnection;
    driver: TFDPhysSQLiteDriverLink;
    LocalSQL: TFDLocalSQL;
    qryLocal: TFDQuery;
    grid: TDBGrid;
    ds: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocalSQL: TFrmLocalSQL;

implementation

{$R *.dfm}

end.
