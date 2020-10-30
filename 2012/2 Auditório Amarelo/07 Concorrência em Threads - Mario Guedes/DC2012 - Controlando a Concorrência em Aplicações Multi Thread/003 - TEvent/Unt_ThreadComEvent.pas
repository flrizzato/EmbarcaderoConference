unit Unt_ThreadComEvent;

interface

uses
  System.Classes,
  System.SyncObjs,
  Vcl.StdCtrls;

type

  /// <summary>
  /// Exemplo de utilização do TEvent
  /// </summary>
  TExemploThread = class(TThread)
  private
    FSinalizador: TEvent;
    FMemo       : TMemo;
    FMensagem   : string;
    procedure EscreverNoMemo;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Execute; override;
    procedure SinalizarThread;
    property Memo: TMemo read FMemo write FMemo;
  end;

implementation

uses
  System.SysUtils;

{ TExemploThread }

procedure TExemploThread.AfterConstruction;
begin
  inherited;
  Self.FSinalizador := TEvent.Create(nil, False, True, '_delphiconference');
end;

procedure TExemploThread.BeforeDestruction;
begin
  inherited;
  Self.FSinalizador.Free;
end;

procedure TExemploThread.EscreverNoMemo;
begin
  Self.FMemo.Lines.Insert(0, TimeToStr(Time) + ' - ' + Self.FMensagem);
end;

procedure TExemploThread.Execute;
var
  eEvent: TWaitResult;
begin
  inherited;
  while not(Self.Terminated) do
  begin
    eEvent := Self.FSinalizador.WaitFor(5000); //Pode-se usar a constante INFINITE
    case eEvent of
      wrSignaled:
        begin
          Self.FMensagem := 'Thread sinalizada!';
        end;
      wrTimeout:
        begin
          Self.FMensagem := 'Time-out na espera da sinalização!';
        end;
      wrAbandoned:
        begin
          Self.FMensagem := 'Sinalizador encerrado!';
        end;
      wrError:
        begin
          Self.FMensagem := 'Erro! ' + IntToStr(Self.FSinalizador.LastError);
        end;
      wrIOCompletion:
        begin
          Self.FMensagem := 'wrIOCompletion';
        end;
    end;
    Self.Synchronize(Self.EscreverNoMemo);
  end;
end;

procedure TExemploThread.SinalizarThread;
begin
  Self.FSinalizador.SetEvent;
end;

end.
