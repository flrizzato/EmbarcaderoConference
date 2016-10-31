unit Unt_Thread;

interface

uses
  System.Classes,
  Vcl.Samples.Gauges;

type

  /// <summary>
  /// Exemplo didático sobre o uso do Synchronize
  /// </summary>
  TThreadExemplo = class(TThread)
  private const
    C_MAX = 9999;
  private
    FProgresso      : Integer;
    FProgressBar    : TGauge;
    FNucleo         : Byte;
    FUsarSynchronize: Boolean;
    procedure AlimentarProgressBar;
  public
    /// <summary>
    /// Thread propriamente dita
    /// </summary>
    procedure Execute; override;
    /// <summary>
    /// Manipulação da ProgressBar
    /// </summary>
    property ProgressBar: TGauge read FProgressBar write FProgressBar;
    /// <summary>
    /// Indica a máscara de afinidade que será usada
    /// </summary>
    property Nucleo: Byte read FNucleo write FNucleo;
    /// <summary>
    /// Indica se a função se sincronização será usada ou não
    /// </summary>
    property UsarSynchronize: Boolean read FUsarSynchronize write FUsarSynchronize;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

{ TThreadExemplo }

procedure TThreadExemplo.AlimentarProgressBar;
begin
  if (Assigned(FProgressBar)) then
  begin
    Self.ProgressBar.MinValue := 0;
    Self.FProgressBar.MaxValue := Self.C_MAX;
    Self.FProgressBar.Progress := Self.FProgresso;
  end;
end;

procedure TThreadExemplo.Execute;
var
  i    : Integer;
  cRet : Cardinal;
  sErro: string;
begin
  inherited;
  cRet := SetThreadAffinityMask(GetCurrentThread, Self.FNucleo);
  if (cRet = 0) then
  begin
    cRet := GetLastError;
    sErro := SysErrorMessage(cRet);
  end;

  for i := 0 to Self.C_MAX do
  begin
    Self.FProgresso := i;
    if (Self.FUsarSynchronize) then
    begin
      Self.Synchronize(Self.AlimentarProgressBar);
    end else begin
      Self.AlimentarProgressBar;
    end;
  end;
end;

end.
