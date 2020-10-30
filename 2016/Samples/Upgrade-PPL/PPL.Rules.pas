unit PPL.Rules;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, System.Threading, Winapi.Windows,
  System.Types;

type
  TLog = reference to procedure(const ALog: string);

  TFemMasc = record
  public
    class operator Add(a, b: TFemMasc): TFemMasc;
    procedure Zerar();
  public
    Feminino: Integer;
    Masculino: Integer;
    Desconhecido: Integer;
    Arquivos: Integer;
    Linhas: Integer;
  end;

  TdmRules = class(TDataModule)
  private
    { Private declarations }
    procedure _(const AMensagem: string);
    function AnalisarArquivos(const APath: string): IFuture<TFemMasc>;
  public
    GeraLog: TLog;
    procedure LimparDiretorio();
    procedure DownloadArquivos(const AArquivos: TArray<string>);
    procedure DescompactarArquivos();
    function CalcularFemMasc(): ITask;
  end;

var
  dmRules: TdmRules;

implementation

uses
  idURI, System.IOUtils, System.Zip, System.Generics.Collections, Vcl.Dialogs, System.Diagnostics;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

function TdmRules.AnalisarArquivos(const APath: string): IFuture<TFemMasc>;
begin
  Result := TTask.Future<TFemMasc>(
    function: TFemMasc
    var
      tfArquivo: TextFile;
      sLinha: string;
      slLinha: TStringList;
    begin
      dmRules._(Format('Analisando: [%s]', [APath]));
      slLinha := TStringList.Create();
      slLinha.Delimiter := ';';
      Result.Zerar;

      Inc(Result.Arquivos);
      AssignFile(tfArquivo, APath);
      try
        try
          Reset(tfArquivo);
          while not Eof(tfArquivo) do
          begin
            TTask.CurrentTask.CheckCanceled();
            Inc(Result.Linhas);

            ReadLn(tfArquivo, sLinha);
            slLinha.DelimitedText := sLinha;

            if (slLinha[30] = 'FEMININO') then
            begin
              Inc(Result.Feminino);
              Continue;
            end;

            if (slLinha[30] = 'MASCULINO') then
            begin
              Inc(Result.Masculino);
              Continue;
            end;

            Inc(Result.Desconhecido);
          end;
        except
          on E: Exception do
          begin
            dmRules._(E.ClassName);
          end;
        end;
      finally
        CloseFile(tfArquivo);
        slLinha.Free;
        dmRules._('Pronto!');
      end;
    end);
end;

function TdmRules.CalcularFemMasc: ITask;
begin
  Result := TTask.Create(
    procedure
    const
      C_RESULT = #13#10'Arquivos: [%d]'#13#10'Linhas: [%d]'#13#10'Feminino: [%d]'#13#10'Masculino: [%d]'#13#10'Desconhecido: [%d]';
    var
      oFuture: IFuture<TFemMasc>;
      oLista: TQueue<IFuture<TFemMasc>>;
      sDiretorio: string;
      sArquivo: string;
      rSoma: TFemMasc;
      oItem: IFuture<TFemMasc>;
      oCrono : TStopWatch;
    begin
      oCrono := TStopwatch.StartNew;
      dmRules._('Iniciando processo de análise!');
      oLista := TQueue < IFuture < TFemMasc >>.Create();
      try
        for sDiretorio in TDirectory.GetDirectories(TDirectory.GetCurrentDirectory()) do
        begin
          for sArquivo in TDirectory.GetFiles(sDiretorio, '*.txt') do
          begin
            if TTask.CurrentTask.Status = TTaskStatus.Canceled then
            begin
              dmRules._('INTERROMPENDO O LANÇAMENTO DE TASKS');
              Break;
            end;

            oFuture := Self.AnalisarArquivos(sArquivo);
            oLista.Enqueue(oFuture);
          end;
        end;

        rSoma.Zerar;
        while oLista.Count > 0 do
        begin
          oItem := oLista.Dequeue();
          if TTask.CurrentTask.Status = TTaskStatus.Canceled then
          begin
            dmRules._('CANCELANDO ...');
            oItem.Cancel;
            Continue;
          end;

          rSoma := rSoma + oFuture.Value;
        end;

        if TTask.CurrentTask.Status = TTaskStatus.Canceled then
        begin
          dmRules._('A TAREFA FOI CANCELADA!');
        end
        else
        begin
          dmRules._(Format(C_RESULT, [rSoma.Arquivos, rSoma.Linhas, rSoma.Feminino, rSoma.Masculino, rSoma.Desconhecido]));
        end;

      finally
        oLista.Free;
        dmRules._('Pronto!');
        oCrono.Stop;
        dmRules._(Format('*** Tempo de execução: [%d] segundos',[oCrono.Elapsed.Seconds]));
      end

    end);
end;

procedure TdmRules.DescompactarArquivos;

  function Descompactar(const AArquivo: string): TProc;
  begin
    Result := procedure
      var
        oDescompressor: TZipFile;
        sDir: string;
      begin
        dmRules._(Format('Descompactando o arquivo: [%s]', [AArquivo]));
        oDescompressor := TZipFile.Create;
        try
          sDir := TPath.GetFileNameWithoutExtension(AArquivo);

          oDescompressor.Open(AArquivo, zmRead);
          oDescompressor.ExtractAll(TPath.Combine(TDirectory.GetCurrentDirectory(), sDir));
        finally
          oDescompressor.Close;
          oDescompressor.Free;
          dmRules._('Pronto!')
        end;
      end;
  end;

var
  sArquivo: string;
  oTask : ITask;
  oLista: TList<ITask>;
begin
  oLista := TList<ITask>.Create();

  for sArquivo in TDirectory.GetFiles(TDirectory.GetCurrentDirectory(), '*.zip') do
  begin
    oTask := TTask.Run(Descompactar(sArquivo));
    oLista.Add(oTask);
  end;

  TThread.CreateAnonymousThread(
    procedure
    begin
      TTask.WaitForAll(oLista.ToArray());
      oLista.Free;
      ShowMessage('Arquivos descompactados com sucesso!');
    end
  ).Start;
end;

procedure TdmRules.DownloadArquivos(const AArquivos: TArray<string>);

  function Download(const AURL: string): TProc;
  begin
    Result := procedure
      var
        sNomeArquivo: string;
        oHTTP: TIdHTTP;
        oFile: TStringStream;
      begin
        sNomeArquivo := TPath.GetFileName(AURL);

        dmRules._('Baixando o arquivo: ' + sNomeArquivo);

        oHTTP := TIdHTTP.Create();
        oFile := TStringStream.Create();
        try
          oHTTP.Get(AURL, oFile);
          oFile.SaveToFile('.\' + sNomeArquivo);
        finally
          dmRules._('Pronto!');
          oHTTP.Free;
          oFile.Free;
        end;
      end;
  end;

var
  aTrabalhadores: array of TProc;
  aEmpreitada: ITask;
  i: Integer;
begin
  SetLength(aTrabalhadores, Length(AArquivos));

  for i := 0 to High(AArquivos) do
  begin
    aTrabalhadores[i] := Download(AArquivos[i]);
  end;

  aEmpreitada := TParallel.Join(aTrabalhadores);

  TThread.CreateAnonymousThread(
    procedure
    begin
      aEmpreitada.Wait();
      ShowMessage('Arquivos recuperados com sucesso!');
    end
  ).Start;
end;

procedure TdmRules.LimparDiretorio;

  function ExcluirItem(const AArquivo: string; const IsDirectory: Boolean): TProc;
  begin
    Result := procedure
      begin
        dmRules._(Format('Deletando o item: [%s]', [AArquivo]));

        if IsDirectory then
        begin
          TDirectory.Delete(AArquivo, True);
        end
        else
        begin
          TFile.Delete(AArquivo);
        end;

        dmRules._('Pronto!');
      end;
  end;

var
  sItem: string;
  oLista : TList<ITask>;
begin
  oLista := TList<ITask>.Create();
  for sItem in TDirectory.GetFiles(TDirectory.GetCurrentDirectory(), '*.zip') do
  begin
    TThreadPool.Default.QueueWorkItem(ExcluirItem(sItem, False));
  end;

  for sItem in TDirectory.GetDirectories(TDirectory.GetCurrentDirectory()) do
  begin
    TThreadPool.Default.QueueWorkItem(ExcluirItem(sItem, True));
  end;
end;

procedure TdmRules._(const AMensagem: string);
var
  iThreadID: Cardinal;
begin
  if Assigned(Self.GeraLog) then
  begin
    iThreadID := TThread.CurrentThread.ThreadID;
    Self.GeraLog(Format('[%d] - %s', [iThreadID, AMensagem]));
  end;
end;

{ TFemMasc }

class operator TFemMasc.Add(a, b: TFemMasc): TFemMasc;
begin
  Result.Feminino := a.Feminino + b.Feminino;
  Result.Masculino := a.Masculino + b.Masculino;
  Result.Desconhecido := a.Desconhecido + b.Desconhecido;
  Result.Arquivos := a.Arquivos + b.Arquivos;
  Result.Linhas := a.Linhas + b.Linhas;
end;

procedure TFemMasc.Zerar;
begin
  Self.Desconhecido := 0;
  Self.Feminino := 0;
  Self.Masculino := 0;
  Self.Arquivos := 0;
  Self.Linhas := 0;
end;

end.
