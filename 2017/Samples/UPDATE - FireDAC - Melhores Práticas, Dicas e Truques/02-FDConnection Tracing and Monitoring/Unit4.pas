unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Moni.RemoteClient, Vcl.StdCtrls, FireDAC.Moni.Custom;

type
  TForm4 = class(TForm)
    CursofiredacConnection: TFDConnection;
    FDQBairros: TFDQuery;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    Memo1: TMemo;
    procedure FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase; const AClassName, AObjName,
      AMessage: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase; const AClassName, AObjName,
  AMessage: string);
begin
  if AObjName = 'FDQBairros' then
  begin
    Memo1.Lines.Add(AMessage);
  end;
end;

end.
