unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, IBODataset, IB_Components, IB_Access, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons, Vcl.ComCtrls, IB_Process, IB_Script;

type
  TForm1 = class(TForm)
    DB: TIBODatabase;
    Cadastros: TIBOQuery;
    dsCadastros: TDataSource;
    IncSearchTimer: TTimer;
    CadastrosCODIGO: TIntegerField;
    CadastrosNOME: TStringField;
    CadastrosENDERECO: TStringField;
    CadastrosNUMERO: TStringField;
    CadastrosCIDADE: TStringField;
    CadastrosBAIRRO: TStringField;
    CadastrosESTADO: TStringField;
    CadastrosCEP: TStringField;
    CadastrosCGC_CPF: TStringField;
    CadastrosLAT: TIBOFmtBCDField;
    CadastrosLNG: TIBOFmtBCDField;
    CadastrosLASTGEOTRY: TDateTimeField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    edIncSearch: TEdit;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Button1: TButton;
    tqConsulta: TIBOQuery;
    dsConsulta: TDataSource;
    DBGrid2: TDBGrid;
    TransQuery: TIB_Transaction;
    Button2: TButton;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    mePlan: TMemo;
    CriarDB: TIB_Script;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure IncSearchTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edIncSearchKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure CadastrosFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Ordenado: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uGeoCode;

const TriesLimit = 4;

procedure TForm1.edIncSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if IncSearchTimer.Enabled then
    IncSearchTimer.Enabled := false;
  IncSearchTimer.Enabled := true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Cadastros.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DB.Server := 'localhost';
  DB.Path := ExtractFilePath(Application.ExeName)+'GIS.FDB';
  if not FileExists (ExtractFilePath(Application.ExeName)+'GIS.FDB') then
  begin
    DB.CreateDatabase;
    DB.Connected := True;
    CriarDB.Execute;
  end;

  Ordenado := 'CODIGO';
  Cadastros.Open;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  Geo: TGeoCode;
  Resultado: Boolean;
  Conta, Tries: integer;
  ContaErros: integer;
begin
  Conta := 0;
  ContaErros := 0;
  Geo := TGeoCode.Create;
  try
    with Cadastros do
    begin
      Filtered := true;
      First;
      while not eof do
      begin
        Application.ProcessMessages;
        Resultado := Geo.DoGeocode(CadastrosENDERECO.AsString + ' ' + CadastrosNUMERO.AsString + ', ' +
          CadastrosBAIRRO.AsString + ', ' + CadastrosCIDADE.AsString + ', ' + CadastrosESTADO.AsString + ', ' +
          CadastrosCEP.AsString);
        if Resultado then
        begin
          Tries := 0;
          Edit;
          try
            CadastrosLAT.AsExtended := Geo.Latitude;
            CadastrosLNG.AsExtended := Geo.Longitude;
            CadastrosLASTGEOTRY.AsDateTime := Now;
            Post;
            Inc(Conta);
          Except
            Cancel;
            Inc(ContaErros);
            raise;
          end;
        end
        else
        begin
          Inc(ContaErros);
          if Geo.LastStatus = 'OVER_QUERY_LIMIT' then
          begin
            Inc (Tries);
            StatusBar1.SimpleText := 'Sleeping...';
            StatusBar1.Refresh;
            Sleep(1000 + (1000 * Tries));
            if (Tries > TriesLimit) then
            begin
              StatusBar1.SimpleText := 'Processo abortado devido a excesso no número de consultas.';
              Abort;
            end;
          end
          else
            Next;
        end;
        StatusBar1.SimpleText := Geo.LastStatus;
      end;
    end;
  finally
    Cadastros.Filtered := false;
    Geo.free;
    MessageDlg('Processamento executado!'#13 + 'Georreferenciados: ' + Conta.ToString + #13'Problemas: ' +
      ContaErros.ToString, mtInformation, [mbOk], 0);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with tqConsulta do
  begin
    Close;
    SQL.Text:=Memo1.Lines.text;
    Open;
    mePlan.Lines.Text := Plan;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  tqConsulta.Close;
end;

procedure TForm1.CadastrosFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := (CadastrosLAT.IsNull or CadastrosLNG.IsNull);
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  with Cadastros do
  begin
    Close;
    SQLOrder.Text := 'order by ' + Column.FieldName;
    Open;
    Ordenado := Column.FieldName;
  end;
end;

procedure TForm1.IncSearchTimerTimer(Sender: TObject);
begin
  IncSearchTimer.Enabled := false;
  Cadastros.locate(Ordenado, edIncSearch.Text, [loPartialKey]);
end;

end.
