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
unit uFrmSaveToFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.OleCtrls, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageXML, FireDAC.Stan.StorageBin, SHDocVw;

type
  TFrmSaveToFile = class(TForm)
    qry: TFDQuery;
    ds: TDataSource;
    bin: TFDStanStorageBinLink;
    xml: TFDStanStorageXMLLink;
    json: TFDStanStorageJSONLink;
    DBGrid1: TDBGrid;
    btnSaveXML: TButton;
    btnSaveJSON: TButton;
    btnLoadXML: TButton;
    btnLoadJSON: TButton;
    btnOpen: TButton;
    btnClose: TButton;
    procedure btnSaveXMLClick(Sender: TObject);
    procedure btnSaveJSONClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnLoadXMLClick(Sender: TObject);
    procedure btnLoadJSONClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSaveToFile: TFrmSaveToFile;

implementation

{$R *.dfm}

procedure TFrmSaveToFile.btnCloseClick(Sender: TObject);
begin
  qry.Close();
end;

procedure TFrmSaveToFile.btnLoadJSONClick(Sender: TObject);
begin
  qry.LoadFromFile('.\dados.json');
end;

procedure TFrmSaveToFile.btnLoadXMLClick(Sender: TObject);
begin
  qry.LoadFromFile('.\dados.xml');
end;

procedure TFrmSaveToFile.btnOpenClick(Sender: TObject);
begin
  qry.Open();
end;

procedure TFrmSaveToFile.btnSaveJSONClick(Sender: TObject);
begin
  qry.SaveToFile('.\dados.json',sfJSON);
end;

procedure TFrmSaveToFile.btnSaveXMLClick(Sender: TObject);
begin
  qry.SaveToFile('.\dados.xml',sfXML);
end;

end.
