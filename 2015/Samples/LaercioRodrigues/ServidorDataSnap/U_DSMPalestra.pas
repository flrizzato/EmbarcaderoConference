unit U_DSMPalestra;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Datasnap.Provider, Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI;

type
  TDSMPalestra = class(TDSServerModule)
    FDConnection: TFDConnection;
    FDQueryTAG: TFDQuery;
    ClientDataSetTAG: TClientDataSet;
    DataSetProviderTAG: TDataSetProvider;
    ClientDataSetTAGID_TAG: TIntegerField;
    ClientDataSetTAGNUMERO: TStringField;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function ExisteTAG(numero : string) : boolean;
    procedure AbrirPorta(Tag : string);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses FormUnit1;

{$R *.dfm}

{ TDSServerModule1 }

procedure TDSMPalestra.AbrirPorta(Tag: string);
begin
   Form1.TimerLerSerial.Enabled:=False;
   Form1.EscreveDados(Tag);
   Form1.TimerLerSerial.Enabled:=True;
end;

function TDSMPalestra.ExisteTAG(numero: string): boolean;
begin
   ClientDataSetTAG.Close;
   ClientDataSetTAG.Params[0].AsString:=numero;
   ClientDataSetTAG.Open;
   if ClientDataSetTAG.RecordCount > 0 then
      Result:=True
   else
      Result:=False;
end;

end.

