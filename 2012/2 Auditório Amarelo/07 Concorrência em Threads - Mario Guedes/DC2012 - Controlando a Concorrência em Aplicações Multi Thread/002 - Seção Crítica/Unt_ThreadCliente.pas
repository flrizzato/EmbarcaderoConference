unit Unt_ThreadCliente;

interface

uses
  System.Classes,
  Unt_ThreadProcessamento;

type

  /// <summary>
  /// Representa uma thread cliente que colocará elementos na pilha.
  /// Poderia ser, por exemplo, uma conexão TCP/IP
  /// </summary>
  TThreadCliente = class(TThread)
  private
    FPilha: TThreadProcessamento;
  public
    constructor Create(APilha: TThreadProcessamento); reintroduce;
    procedure Execute; override;
  end;

implementation

uses
  System.SysUtils;

{ TThreadCliente }

constructor TThreadCliente.Create(APilha: TThreadProcessamento);
begin
  inherited Create(True);
  Self.FPilha := APilha;
end;

procedure TThreadCliente.Execute;
var
  oItem: TItemExemplo;
begin
  inherited;
  while not(Self.Terminated) do
  begin
    Sleep(10);
    oItem := TItemExemplo.Create;
    oItem.DataInclusao := Now;
    oItem.Mensagem := ':: DELPHI XE3 ::';

    Self.FPilha.ColocarNaPilha(oItem);
  end;
end;

end.
