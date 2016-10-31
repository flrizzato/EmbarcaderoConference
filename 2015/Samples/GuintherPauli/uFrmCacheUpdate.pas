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
unit uFrmCacheUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmCacheUpdate = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
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
    upd: TFDUpdateSQL;
    btnApply: TButton;
    mmStatus: TMemo;
    btnUndoLastChange: TButton;
    btnSavePoint: TButton;
    TabSheet3: TTabSheet;
    memDelta: TFDMemTable;
    memData: TFDMemTable;
    dsData: TDataSource;
    dsDelta: TDataSource;
    gridData: TDBGrid;
    gridDelta: TDBGrid;
    btnGetData: TButton;
    btnGetDelta: TButton;
    procedure btnApplyClick(Sender: TObject);
    procedure btnUndoLastChangeClick(Sender: TObject);
    procedure btnSavePointClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure btnGetDataClick(Sender: TObject);
    procedure btnGetDeltaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCacheUpdate: TFrmCacheUpdate;

implementation

{$R *.dfm}

procedure TFrmCacheUpdate.btnApplyClick(Sender: TObject);
begin
   qry.ApplyUpdates();
end;

procedure TFrmCacheUpdate.btnGetDataClick(Sender: TObject);
begin
  memData.FilterChanges := [rtModified, rtInserted, rtDeleted];
  memData.Data := qry.Data;
end;

procedure TFrmCacheUpdate.btnGetDeltaClick(Sender: TObject);
begin
  memDelta.FilterChanges := [rtModified, rtInserted, rtDeleted];
  memDelta.Data := qry.Delta;
end;

procedure TFrmCacheUpdate.btnSavePointClick(Sender: TObject);
begin
  qry.SavePoint;
end;

procedure TFrmCacheUpdate.btnUndoLastChangeClick(Sender: TObject);
begin
  qry.UndoLastChange(true);
end;

procedure TFrmCacheUpdate.dsStateChange(Sender: TObject);
begin
  mmStatus.Clear();
  if qry.UpdatesPending then
    mmStatus.Lines.Add('UpdatesPending=true')
  else
    mmStatus.Lines.Add('UpdatesPending=false');
  mmStatus.Lines.Add('ChangeCount=' + qry.ChangeCount.ToString());
end;

procedure TFrmCacheUpdate.FormShow(Sender: TObject);
begin
  qry.Open();
end;

end.
