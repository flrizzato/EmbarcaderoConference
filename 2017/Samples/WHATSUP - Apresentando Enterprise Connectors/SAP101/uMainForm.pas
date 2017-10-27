unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataSalesforce, FireDAC.Phys.CDataSalesforceDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.CDataSAP, FireDAC.Phys.CDataSAPDef;

type
  TMainForm = class(TForm)
    DBGrid1: TDBGrid;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DataSource1: TDataSource;
    Panel1: TPanel;
    SpeedButton3: TSpeedButton;
    DBNavigator1: TDBNavigator;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CdatasapConnection: TFDConnection;
    MaktView: TFDQuery;
    FDPhysCDataSAPDriverLink1: TFDPhysCDataSAPDriverLink;
    MaktViewMANDT: TWideStringField;
    MaktViewMATNR: TWideStringField;
    MaktViewSPRAS: TWideStringField;
    MaktViewMAKTX: TWideStringField;
    MaktViewMAKTG: TWideStringField;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Call_BAPI_MATERIAL_SAVEDATA;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Call_BAPI_MATERIAL_SAVEDATA;
var
  sHEAD, sMATR, sEXEC: string;
begin
  sHEAD := 'INSERT INTO HEADDATA#TEMP (';
  sHEAD := sHEAD + 'MATERIAL, ';
  sHEAD := sHEAD + 'BASIC_VIEW ';
  sHEAD := sHEAD + ') VALUES (';
  sHEAD := sHEAD + QuotedSTR(MaktViewMATNR.AsString) + ', ';
  sHEAD := sHEAD + QuotedSTR('X') + ')';
  CdatasapConnection.ExecSQL(sHEAD);

  sMATR := 'INSERT INTO MATDESC#TEMP ( ';
  sMATR := sMATR + 'LANGU, ';
  sMATR := sMATR + 'LANGU_ISO, ';
  sMATR := sMATR + 'MATL_DESC ';
  sMATR := sMATR + ') VALUES ( ';
  sMATR := sMATR + QuotedSTR(MaktViewSPRAS.AsString) + ', ';
  sMATR := sMATR + QuotedSTR(MaktViewSPRAS.AsString) + ', ';
  sMATR := sMATR + QuotedSTR(MaktViewMAKTX.AsString) + ')';
  CdatasapConnection.ExecSQL(sMATR);

  sEXEC := 'EXEC BAPI_MATERIAL_SAVEDATA ';
  sEXEC := sEXEC + '@HEADDATA=' + QuotedSTR('HEADDATA#TEMP') + ', ';
  sEXEC := sEXEC + '@MATERIALDESCRIPTION=' + QuotedSTR('MATDESC#TEMP');
  CdatasapConnection.ExecSQL(sEXEC);

  CdatasapConnection.ExecSQL('EXEC BAPI_TRANSACTION_COMMIT');
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  //MaktView.ApplyUpdates(-1);
  Call_BAPI_MATERIAL_SAVEDATA;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  MaktView.CancelUpdates;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
  MaktView.Close;
  MaktView.Open;
end;

end.
