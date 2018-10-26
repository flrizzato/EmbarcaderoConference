unit U_Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Datasnap.DBClient, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;

type
  TDM = class(TDataModule)
    FDQMenu: TFDQuery;
    ConexaoBD: TFDConnection;
    FDQQuery: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDQQuery1: TFDQuery;
    FDQQuery2: TFDQuery;
    FDQQuery3: TFDQuery;
    FDQMenuIDMODULO: TIntegerField;
    FDQMenuITEM: TWideStringField;
    FDQMenuDESCRICAO: TWideStringField;
    FDQMenuNIVELMENU: TWideStringField;
    FDQMenuICONE: TWideStringField;
    FDQMenuNOMEFORM: TWideStringField;
    FDQConfiguracoes: TFDQuery;
    FDQConfiguracoesIDLICENCA: TIntegerField;
    FDQConfiguracoesNOMELICENCA: TWideStringField;
    FDQConfiguracoesCNPJ: TWideStringField;
    FDQConfiguracoesCEP: TWideStringField;
    FDQConfiguracoesENDERECO: TWideStringField;
    FDQConfiguracoesNUMERO: TWideStringField;
    FDQConfiguracoesBAIRRO: TWideStringField;
    FDQConfiguracoesCIDADE: TWideStringField;
    FDQConfiguracoesESTADO: TWideStringField;
    FDQConfiguracoesTELEFONES: TWideStringField;
    FDQConfiguracoesEMAILORIGEM: TWideStringField;
    FDQConfiguracoesNOMEORIGEM: TWideStringField;
    FDQConfiguracoesSMTP: TWideStringField;
    FDQConfiguracoesPORTA: TWideStringField;
    FDQConfiguracoesUSUARIO: TWideStringField;
    FDQConfiguracoesSENHA: TWideStringField;
    FDQConfiguracoesTLS: TWideStringField;
    FDQConfiguracoesSSL: TWideStringField;
    FDQClientesCad: TFDQuery;
    FDQClientesCadIDCLIENTE: TIntegerField;
    FDQClientesCadRAZAOSOCIAL: TWideStringField;
    FDQClientesCadCNPJ: TWideStringField;
    FDQClientesCadIE: TWideStringField;
    FDQClientesCadCEP: TWideStringField;
    FDQClientesCadENDERECO: TWideStringField;
    FDQClientesCadNUMERO: TWideStringField;
    FDQClientesCadCOMPLEMENTO: TWideStringField;
    FDQClientesCadBAIRRO: TWideStringField;
    FDQClientesCadCIDADE: TWideStringField;
    FDQClientesCadESTADO: TWideStringField;
    FDQClientesCadFONEFIXO: TWideStringField;
    FDQClientesCadFONECELULAR: TWideStringField;
    FDQClientesCadEMAIL: TWideStringField;
    FDQClientesCadSENHA: TWideStringField;
    FDQClientesCadDATAULTIMOACESSO: TSQLTimeStampField;
    FDQFuncionariosCad: TFDQuery;
    FDQFuncionariosCadIDFUNCIONARIO: TIntegerField;
    FDQFuncionariosCadNOMEFUNCIONARIO: TWideStringField;
    FDQFuncionariosCadCPF: TWideStringField;
    FDQFuncionariosCadRG: TWideStringField;
    FDQFuncionariosCadCEP: TWideStringField;
    FDQFuncionariosCadENDERECO: TWideStringField;
    FDQFuncionariosCadNUMERO: TWideStringField;
    FDQFuncionariosCadCOMPLEMENTO: TWideStringField;
    FDQFuncionariosCadBAIRRO: TWideStringField;
    FDQFuncionariosCadCIDADE: TWideStringField;
    FDQFuncionariosCadESTADO: TWideStringField;
    FDQFuncionariosCadFONEFIXO: TWideStringField;
    FDQFuncionariosCadFONECELULAR: TWideStringField;
    FDQFuncionariosCadEMAIL: TWideStringField;
    FDQFuncionariosCadUSUARIO: TWideStringField;
    FDQFuncionariosCadSENHA: TWideStringField;
    FDQFuncionariosCadDATAULTIMOACESSO: TSQLTimeStampField;
    FDQProdutosCad: TFDQuery;
    FDQProdutosCadIDPRODUTO: TIntegerField;
    FDQProdutosCadDESCRICAO: TWideStringField;
    FDQSolicitacoesCad: TFDQuery;
    FDQSolicitacoesCadIDSOLICITACAO: TIntegerField;
    FDQSolicitacoesCadDESCRICAO: TWideStringField;
    FDQChamadosCad: TFDQuery;
    FDQChamadosCadIDCHAMADO: TIntegerField;
    FDQChamadosCadIDCLIENTE: TIntegerField;
    FDQChamadosCadDATAHORAABERTURA: TSQLTimeStampField;
    FDQChamadosCadIDSOLICITACAO: TIntegerField;
    FDQChamadosCadIDPRODUTO: TIntegerField;
    FDQChamadosCadNOMESOLICITANTE: TWideStringField;
    FDQChamadosCadDEPTOSOLICITANTE: TWideStringField;
    FDQChamadosCadDESCRICAOSOLICITACAO: TBlobField;
    FDQChamadosCadPRIORIDADE: TWideStringField;
    FDQChamadosCadSITUACAO: TWideStringField;
    FDQChamadosCadSOLUCAOSOLICITACAO: TBlobField;
    FDQChamadosCadDATAHORASOLUCAO: TSQLTimeStampField;
    FDQChamadosCadIDFUNCIONARIOSOLUCAO: TIntegerField;
    FDQClientes: TFDQuery;
    FDQClientesIDCLIENTE: TIntegerField;
    FDQClientesRAZAOSOCIAL: TWideStringField;
    FDQClientesCNPJ: TWideStringField;
    FDQClientesIE: TWideStringField;
    FDQClientesCEP: TWideStringField;
    FDQClientesENDERECO: TWideStringField;
    FDQClientesNUMERO: TWideStringField;
    FDQClientesCOMPLEMENTO: TWideStringField;
    FDQClientesBAIRRO: TWideStringField;
    FDQClientesCIDADE: TWideStringField;
    FDQClientesESTADO: TWideStringField;
    FDQClientesFONEFIXO: TWideStringField;
    FDQClientesFONECELULAR: TWideStringField;
    FDQClientesEMAIL: TWideStringField;
    FDQClientesSENHA: TWideStringField;
    FDQClientesDATAULTIMOACESSO: TSQLTimeStampField;
    FDQSolicitacoes: TFDQuery;
    FDQSolicitacoesIDSOLICITACAO: TIntegerField;
    FDQSolicitacoesDESCRICAO: TWideStringField;
    FDQProdutos: TFDQuery;
    IntegerField1: TIntegerField;
    WideStringField1: TWideStringField;
    FDQEvento: TFDQuery;
    FDQEventoIDAGENDA: TIntegerField;
    FDQEventoIDFUNCIONARIO: TIntegerField;
    FDQEventoTITULO: TWideStringField;
    FDQEventoCOR: TWideStringField;
    FDQEventoINICIO: TSQLTimeStampField;
    FDQEventoFINAL: TSQLTimeStampField;
    FDQEventoDESCRICAO: TWideMemoField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ConexaoBDBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function FB_ReturnNextCOD_ByGenerator(NomeGenerator: string): Longint;
    function FB_ReturnMAXCOD_ByTabela(Tabela: string): Longint;
  end;

var
  DM: TDM;

implementation

uses
  ServerController, System.IniFiles, IWInit;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDm }

procedure TDM.ConexaoBDBeforeConnect(Sender: TObject);
var
  ArqIni : TIniFile;
begin
  if FileExists('.\SisHelpDesk.ini') then
  begin
    ArqIni := TIniFile.Create('.\SisHelpDesk.ini');
    ConexaoBD.Params.Values['Server']   := ArqIni.ReadString('CONFIG', 'Server', 'localhost');
    ConexaoBD.Params.Values['Database'] := ExtractFilePath(WebApplication.ApplicationPath)+'BancoDados\' + ArqIni.ReadString('CONFIG', 'Database', 'HELPDESK.FDB');
    ArqIni.Free;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  ConexaoBD.Connected := false;
end;

function TDM.FB_ReturnMAXCOD_ByTabela(Tabela: string): Longint;
var
  SQL: TStringList;
  Qry: TFDQuery;
label
  FIM;
begin
{$I-}


  Result := 0;

  Qry:= TFDQuery.Create(nil);
  Qry.Connection := ConexaoBD;

  SQL := TstringList.Create;
  Result := 0;

  SQL.Add('Select Max(cod_'+Tabela+') as NEWID from '+Tabela);
  Qry.Open(SQL.Text);

  Result := StrToInt(Qry.FieldValues['NEWID']) +1 ;


  SQL.Free;

end;

function TDM.FB_ReturnNextCOD_ByGenerator(NomeGenerator: string): Longint;
var
  SQL: TStringList;
  Qry: TFDQuery;
label
  FIM;
begin
{$I-}

  Qry:= TFDQuery.Create(nil);
  Qry.Connection := ConexaoBD;

  SQL := TstringList.Create;
  Result := 0;

  SQL.Add('SELECT GEN_ID(' + NomeGenerator + ', 1) AS NEWID FROM RDB$DATABASE');
  Qry.Open(SQL.Text);

  Result := StrToInt(Qry.FieldValues['NEWID']);

  if Result <= 0 then
    Result := 0;

FIM:
  SQL.Free;

end;

end.
