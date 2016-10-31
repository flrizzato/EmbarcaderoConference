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
unit uFrmSubstitutionVariablesMacros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmSubstitutionVariablesMacros = class(TForm)
    boxTableName: TComboBox;
    Open: TButton;
    grid: TDBGrid;
    qry: TFDQuery;
    ds: TDataSource;
    procedure OpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSubstitutionVariablesMacros: TFrmSubstitutionVariablesMacros;

implementation

{$R *.dfm}

procedure TFrmSubstitutionVariablesMacros.OpenClick(
  Sender: TObject);
var
  tabela: string;
begin
  tabela := boxTableName.Text; // ex. EMPLOYEE
  qry.SQL.Text := 'SELECT * FROM &TABELA';
  qry.MacroByName('TABELA').AsRaw := tabela;
  qry.Open();
end;

end.
