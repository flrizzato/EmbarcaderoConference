unit UntDM;

interface

uses
  SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    fdConn: TFDConnection;
    qryClientes: TFDQuery;
    DataSource1: TDataSource;
    qryClientesCODIGO: TIntegerField;
    qryClientesapelido: TStringField;
    qryClientesrazaosocial: TStringField;
    qryClientesIMPRIMIR: TStringField;
    procedure qryClientesIMPRIMIRGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DM: TDM;

implementation

{$R *.dfm}

uses
  UniGUIVars, uniGUIMainModule, MainModule;

function DM: TDM;
begin
  Result := TDM(UniMainModule.GetModuleInstance(TDM));
end;

procedure TDM.qryClientesIMPRIMIRGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
 if DisplayText then
    Text := '<span style="cursor:pointer"><button type="button" class="btn btn-success btn-xs btn-block">Email</button></span>';

end;

initialization
  RegisterModuleClass(TDM);

end.
