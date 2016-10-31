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
unit uFrmFetch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmFetch = class(TForm)
    qry: TFDQuery;
    qryDEPT_NO: TStringField;
    qryDEPARTMENT: TStringField;
    qryHEAD_DEPT: TStringField;
    qryMNGR_NO: TSmallintField;
    qryBUDGET: TBCDField;
    qryLOCATION: TStringField;
    qryPHONE_NO: TStringField;
    ds: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DBNavigator1: TDBNavigator;
    btnOpen: TButton;
    btnClose: TButton;
    boxMode: TComboBox;
    btnFetchNext: TButton;
    btnFetchAll: TButton;
    boxSize: TComboBox;
    Label8: TLabel;
    procedure btnOpenClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnFetchNextClick(Sender: TObject);
    procedure btnFetchAllClick(Sender: TObject);
  private

  end;

var
  FrmFetch: TFrmFetch;

implementation

{$R *.dfm}

procedure TFrmFetch.btnCloseClick(Sender: TObject);
begin
  qry.Close();
end;

procedure TFrmFetch.btnFetchAllClick(Sender: TObject);
begin
  qry.FetchAll();
end;

procedure TFrmFetch.btnFetchNextClick(Sender: TObject);
begin
  qry.FetchNext();
end;

procedure TFrmFetch.btnOpenClick(Sender: TObject);
begin
  qry.FetchOptions.RowsetSize := StrToInt(boxSize.Text);
  qry.FetchOptions.Mode := TFDFetchMode(boxMode.ItemIndex);
  qry.Open();
end;

end.
