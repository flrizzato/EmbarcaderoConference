unit Unt_ThreadProcessamento;

interface

uses
  System.Classes,
  System.SyncObjs,
  System.Generics.Collections;

type

  /// <summary>
  /// Objeto de exemplo
  /// </summary>
  TItemExemplo = class
  private
    FDataInclusao: TDateTime;
    FMensagem    : string;
  public
    property DataInclusao: TDateTime read FDataInclusao write FDataInclusao;
    property Mensagem    : string read FMensagem write FMensagem;
  end;

  /// <summary>
  /// Executa o processamento da pilha de objetos
  /// </summary>
  TThreadProcessamento = class(TThread)
  private
    FSecaoCritica    : TCriticalSection;
    FPilha           : TObjectQueue<TItemExemplo>;
    FItensProcessados: UInt64;
    function GetItensNaoProcessados: UInt64;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure Execute; override;
    procedure ColocarNaPilha(AItem: TItemExemplo);
    property ItensProcessados: UInt64 read FItensProcessados;
    property ItensNaoProcessados: UInt64 read GetItensNaoProcessados;
  end;

implementation

{ TThreadProcessamento }

procedure TThreadProcessamento.AfterConstruction;
begin
  Self.FPilha := TObjectQueue<TItemExemplo>.Create;
  Self.FSecaoCritica := TCriticalSection.Create;
end;

procedure TThreadProcessamento.BeforeDestruction;
begin
  Self.FPilha.Free;
  Self.FSecaoCritica.Free;
end;

procedure TThreadProcessamento.ColocarNaPilha(AItem: TItemExemplo);
begin
  Self.FSecaoCritica.Enter;
  try
    Self.FPilha.Enqueue(AItem);
  finally
    Self.FSecaoCritica.Release;
  end;
end;

procedure TThreadProcessamento.Execute;
var
  oItemPilha: TItemExemplo;
begin
  inherited;
  while not(Self.Terminated) do
  begin
    Sleep(10);
    while Self.FPilha.Count > 0 do
    begin
      Self.FSecaoCritica.Enter;
      try
        oItemPilha := Self.FPilha.Extract;
      finally
        Self.FSecaoCritica.Release;
      end;

      Self.FItensProcessados := Self.FItensProcessados + 1;

      oItemPilha.Free;
    end;
  end;
end;

function TThreadProcessamento.GetItensNaoProcessados: UInt64;
begin
  Result := Self.FPilha.Count;
end;

end.
