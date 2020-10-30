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
unit uFrmMetaData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmMetaData = class(TForm)
    metaInfo: TFDMetaInfoQuery;
    ds: TDataSource;
    boxTabelas: TComboBox;
    grid: TDBGrid;
    Label1: TLabel;
    boxInfoKind: TComboBox;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure boxInfoKindChange(Sender: TObject);
  private
    function Database(): string;
    procedure FillMetaInfoKindBox();
  end;

var
  FrmMetaData: TFrmMetaData;

implementation

{$R *.dfm}

uses
  TypInfo;

procedure TFrmMetaData.boxInfoKindChange(Sender: TObject);
var
  tabela: string;
begin
  metaInfo.MetaInfoKind := TFDPhysMetaInfoKind(boxInfoKind.ItemIndex);
  if boxTabelas.Text <> '' then
    metaInfo.ObjectName := boxTabelas.Text;
  metaInfo.Close();
  metaInfo.Open();
  // para firebird não precisa estas duas colunas
  grid.Columns[1].Visible := false;
  grid.Columns[2].Visible := false;

end;

procedure TFrmMetaData.FillMetaInfoKindBox();
var
  i: integer;
begin
  for i := Ord(Low(TFDPhysMetaInfoKind)) to ord(High(TFDPhysMetaInfoKind)) do
    boxInfoKind.Items.Add(GetEnumName(TypeInfo(TFDPhysMetaInfoKind),i));
end;

procedure TFrmMetaData.FormShow(Sender: TObject);
begin
  DM.con.GetTableNames(Database,'','',boxTabelas.Items);
  FillMetaInfoKindBox();
end;

function TFrmMetaData.Database(): string;
begin
  exit(DM.con.Params.Database);
end;

end.
