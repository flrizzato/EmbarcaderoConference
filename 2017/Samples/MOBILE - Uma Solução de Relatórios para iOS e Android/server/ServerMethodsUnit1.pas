unit ServerMethodsUnit1;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  Datasnap.DSServer,
  Datasnap.DSAuth,
  DataSnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  FireDAC.Phys.IBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  frxClass,
  frxExportPDF,
  frxDBSet,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs;

type
  TServerMethods1 = class(TDSServerModule)
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    fdConn: TFDConnection;
    qryRelatorio: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryRelatorioCODIGO: TIntegerField;
    qryRelatorioapelido: TStringField;
    qryRelatoriorazaosocial: TStringField;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function DownloadFile(const AArquivo: String; out Size: Int64): TStream;
    function GerarPDF(out Size: Int64): TStream;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GerarPDF(out Size: Int64): TStream;
//var
//  CaminhoPDF : String;
//  Debug      : String;
begin
//  qryRelatorio.Active            := True;
//
//  CaminhoPDF                    := 'C:\Temp\PDF\'; //;ExtractFilePath('..\..\..\PDF\');
//
//  frxPDFExport1.FileName        := CaminhoPDF + 'Relatorio.pdf';
//  frxPDFExport1.DefaultPath     := CaminhoPDF + '\';
//  frxPDFExport1.ShowDialog      := False;
//  frxPDFExport1.ShowProgress    := False;
//  frxPDFExport1.OverwritePrompt := False;
//
//  frxReport1.PrepareReport();
//  frxReport1.Export(frxPDFExport1);
//  qryRelatorio.Active            := False;
//
//  Result := TFileStream.Create(CaminhoPDF + 'Relatorio.pdf', fmOpenRead or fmShareDenyNone);
//  Size   := Result.Size;
//
//  Result.Position := 0;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.DownloadFile(const AArquivo: String;
  out Size: Int64): TStream;
var
  CaminhoImagem: String;
  Debug: String;
begin
  CaminhoImagem := ExtractFilePath('..\..\..\img\');
  Debug := CaminhoImagem + AArquivo;
  Result := TFileStream.Create(CaminhoImagem + AArquivo, fmOpenRead or fmShareDenyNone);
  Size   := Result.Size;

  Result.Position := 0;
end;

end.

