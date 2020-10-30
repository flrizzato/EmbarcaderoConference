unit PPL.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, System.Threading, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    LinkLabel1: TLinkLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tsLog: TTabSheet;
    mLog: TMemo;
    mLinks: TMemo;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button7: TButton;
    Button8: TButton;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    FDMemTable1THREADID: TIntegerField;
    FDMemTable1QUANTIDADE: TIntegerField;
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    FTaskAnalise: ITask;
    procedure GetInfoAmbiente();
    procedure Log(const AMensagem: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ShellAPI, PPL.Rules, System.Math;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.PageControl1.ActivePage := Self.tsLog;
  dmRules.DownloadArquivos(Self.mLinks.Lines.ToStringArray());
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Self.PageControl1.ActivePage := Self.tsLog;
  dmRules.DescompactarArquivos();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Self.PageControl1.ActivePage := Self.tsLog;
  Self.FTaskAnalise := dmRules.CalcularFemMasc();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Self.PageControl1.ActivePage := Self.tsLog;
  dmRules.LimparDiretorio();
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  iNovoValor: Integer;
  sBuffer: string;
  bRes: Boolean;
begin
  sBuffer := InputBox('Novo valor', 'Valor', '0');
  iNovoValor := StrToInt(sBuffer);
  bRes := TThreadPool.Default.SetMinWorkerThreads(iNovoValor);
  if not bRes then
  begin
    raise Exception.Create('Valor inválido!');
  end;

  Self.GetInfoAmbiente;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  iNovoValor: Integer;
  sBuffer: string;
  bRes: Boolean;
begin
  sBuffer := InputBox('Novo valor', 'Valor', '0');
  iNovoValor := StrToInt(sBuffer);
  bRes := TThreadPool.Default.SetMaxWorkerThreads(iNovoValor);
  if not bRes then
  begin
    raise Exception.Create('Valor inválido!');
  end;

  Self.GetInfoAmbiente;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Self.FTaskAnalise.Start;

  TThread.CreateAnonymousThread(
    procedure
    var
    bRes : Boolean;
    begin
      try
        bRes := Self.FTaskAnalise.Wait();
        if bRes then
        begin
            ShowMessage('Análise efetuada com sucesso!');
        end else
        begin
          ShowMessage('Ocorreu algum problema na análise!');
        end;
      except
        ShowMessage('A análise foi cancelada!');
      end;
    end
  ).Start;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Self.FTaskAnalise.Cancel;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  dmRules.GeraLog := Self.Log;
  Self.PageControl1.ActivePageIndex := 0;
  Self.GetInfoAmbiente();
  Self.FDMemTable1.Open;
end;

procedure TForm1.GetInfoAmbiente;
begin
  Self.Label1.Caption := Format('Quantidade de processadores: [%d]', [TThread.ProcessorCount]);
  Self.Label2.Caption := Format('Quantidade mínima de trabalhadores: [%d]', [TThreadPool.Default.MinWorkerThreads]);
  Self.Label3.Caption := Format('Quantidade máxima de trabalhadores: [%d]', [TThreadPool.Default.MaxWorkerThreads]);
  Self.Label4.Caption := Format('Thread principal: [%d]', [GetCurrentThreadId()]);
  Application.ProcessMessages;
end;

procedure TForm1.LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  ShellExecute(0, 'Open', PChar(Link), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Log(const AMensagem: string);
begin
  TThread.Queue(nil,
    procedure
    var
    sThreadID: string;
    iThreadID: Integer;
    begin
      Form1.mLog.Lines.Insert(0, AMensagem);
      if Pos('Pronto!', AMensagem) > 0 then
      begin
        sThreadID := Copy(AMensagem, 2, Pos(']', AMensagem) - 2);
        iThreadID := StrToInt(sThreadID);

        if Form1.FDMemTable1.FindKey([iThreadID]) then
        begin
          Form1.FDMemTable1.Edit;
          Form1.FDMemTable1QUANTIDADE.Value := Form1.FDMemTable1QUANTIDADE.Value + 1;
          Form1.FDMemTable1.Post;
        end else
        begin
          Form1.FDMemTable1.InsertRecord([iThreadID, 1]);
        end;
      end;
    end);
end;

end.
