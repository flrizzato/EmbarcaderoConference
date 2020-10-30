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
unit uFrmOffliningConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls;

type
  TFrmOffliningConnection = class(TForm)
    qry: TFDQuery;
    ds: TDataSource;
    grid: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOffliningConnection: TFrmOffliningConnection;

implementation

{$R *.dfm}

procedure TFrmOffliningConnection.FormShow(Sender: TObject);
begin
 qry.SQL.Text := 'select * from EMPLOYEE';
  qry.Open();
  qry.FetchAll();
  DM.con.Offline();
  DM.con.Close();
  // Dados ainda podem ser visualizados e alterados
end;

end.
