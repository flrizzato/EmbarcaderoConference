unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, System.Actions, FMX.ActnList, FMX.Layouts,
  FMX.Memo;

type
  TFunctionCardinal = reference to function: Cardinal;

  TfrmPrincipal = class(TForm)
    btnProcessamentoSerial: TButton;
    spbEnesimo: TSpinBox;
    aclPrincipal: TActionList;
    actProcessamentoSerial: TAction;
    memLog: TMemo;
    btnProcessamentoThreadDedicada: TButton;
    actProcessamentoThreadDedicada: TAction;
    btnProcessamentoThreadAnonima: TButton;
    actProcessamentoThreadAnonima: TAction;
    btnSintaxe: TButton;
    procedure actProcessamentoSerialExecute(Sender: TObject);
    procedure actProcessamentoThreadDedicadaUpdate(Sender: TObject);
    procedure actProcessamentoThreadDedicadaExecute(Sender: TObject);
    procedure actProcessamentoThreadAnonimaUpdate(Sender: TObject);
    procedure actProcessamentoThreadAnonimaExecute(Sender: TObject);
    procedure btnSintaxeClick(Sender: TObject);
  private
    procedure ExecutarELogar(const pNomeMetodo: string; const pFuncao: TFunctionCardinal);
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses
  uFibonacci, System.Diagnostics, uThreadDedicada;

procedure TfrmPrincipal.actProcessamentoSerialExecute(Sender: TObject);
begin
  ExecutarELogar('Processamento serial',
    function: Cardinal
    begin
      Result := TFibonacci.GetEnesimoNumero(Trunc(spbEnesimo.Value));
    end);
end;

procedure TfrmPrincipal.actProcessamentoThreadAnonimaExecute(Sender: TObject);
begin
  ExecutarELogar('Processamento thread anônima',
    function: Cardinal
    var
      lValor1: Cardinal;
      lThreadAnonima1: TThread;
      lValor2: Cardinal;
      lThreadAnonima2: TThread;
    begin
      lValor1 := Trunc(spbEnesimo.Value - 1);
      lValor2 := Trunc(spbEnesimo.Value - 2);

      lThreadAnonima1 := TThread.CreateAnonymousThread(
        procedure
        begin
          lValor1 := TFibonacci.GetEnesimoNumero(lValor1 - 1) + TFibonacci.GetEnesimoNumero(lValor1 - 2);
        end);

      try
        lThreadAnonima1.FreeOnTerminate := False;
        lThreadAnonima1.Start;

        lThreadAnonima2 := TThread.CreateAnonymousThread(
          procedure
          begin
            lValor2 := TFibonacci.GetEnesimoNumero(lValor2 - 1) + TFibonacci.GetEnesimoNumero(lValor2 - 2);
          end);

        try
          lThreadAnonima2.FreeOnTerminate := False;
          lThreadAnonima2.Start;

          lThreadAnonima1.WaitFor;
          lThreadAnonima2.WaitFor;

          Result := lValor1 + lValor2;
        finally
          lThreadAnonima2.Free;
        end;
      finally
        lThreadAnonima1.Free;
      end;
    end);
end;

procedure TfrmPrincipal.actProcessamentoThreadAnonimaUpdate(Sender: TObject);
begin
  actProcessamentoThreadAnonima.Enabled := spbEnesimo.Value >= 4;
end;

procedure TfrmPrincipal.actProcessamentoThreadDedicadaExecute(Sender: TObject);
begin
  ExecutarELogar('Processamento thread dedicada',
    function: Cardinal
    var
      lTrehadDedicada1: TThreadFibonacciDedicada;
      lTrehadDedicada2: TThreadFibonacciDedicada;
    begin
      lTrehadDedicada1 := TThreadFibonacciDedicada.Create(Trunc(spbEnesimo.Value - 1));

      try
        lTrehadDedicada2 := TThreadFibonacciDedicada.Create(Trunc(spbEnesimo.Value - 2));

        try
          Result := lTrehadDedicada1.WaitFor + lTrehadDedicada2.WaitFor;
        finally
          lTrehadDedicada2.Free;
        end;
      finally
        lTrehadDedicada1.Free;
      end;
    end);
end;

procedure TfrmPrincipal.actProcessamentoThreadDedicadaUpdate(Sender: TObject);
begin
  actProcessamentoThreadDedicada.Enabled := spbEnesimo.Value >= 4;
end;

procedure TfrmPrincipal.btnSintaxeClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      // implemente aqui funções que devem ser executadas em paralelo.
    end);
end;

procedure TfrmPrincipal.ExecutarELogar(const pNomeMetodo: string; const pFuncao: TFunctionCardinal);
var
  lStopwatch: TStopwatch;
  lResultado: Cardinal;

  procedure AdLinha(const pMensagem: string);
  begin
    memLog.Lines.Add(pMensagem);
    memLog.GoToTextEnd;
  end;

  procedure Log(const pMensagem: string);
  begin
    AdLinha(FormatDateTime('yyyy.mm.dd hh:mm:ss', Now) + ' - ' + pMensagem);
  end;
begin
  lStopwatch := TStopwatch.StartNew;

  Log('iniciado ' + pNomeMetodo);

  lResultado := pFuncao;

  lStopwatch.Stop;

  Log('finalizado ' + pNomeMetodo);
  Log('Resultado: ' + IntToStr(lResultado) + ' (' + IntToStr(lStopwatch.ElapsedMilliseconds) + ')');
  AdLinha(StringOfChar('-', 80));
end;

end.
