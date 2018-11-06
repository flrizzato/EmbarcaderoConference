unit Classe.ExecutorTh;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TMetodo = class
  private
    FExecutar: TProc;
    FRetornoOk: TProc;
    FRetornoErro: TProc;
  public
    constructor Create(const pExecutar, pRetornoOk, pRetornoErro: TProc);
    property Executar: TProc read FExecutar write FExecutar;
    property RetornoOk: TProc read FRetornoOk write FRetornoOk;
    property RetornoErro: TProc read FRetornoErro write FRetornoErro;
  end;

  TListaMetodos = class(TList<TMetodo>);

  TThreadExecutor = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

  TExecutor = class
  private
    class var
      FListaMetodos: TListaMetodos;
      FTh: TThreadExecutor;

  public
    class destructor Destroy;

    class function GetListaMetodos: TListaMetodos;
    class procedure AddMetodo(pMetodo: TMetodo);
  end;

implementation

{ TMetodo }

constructor TMetodo.Create(const pExecutar, pRetornoOk, pRetornoErro: TProc);
begin
  FExecutar := pExecutar;
  FRetornoOk := pRetornoOk;
  FRetornoErro := pRetornoErro;
end;

{ TExcutor }

class procedure TExecutor.AddMetodo(pMetodo: TMetodo);
begin
  if not Assigned(FTh) then
  begin
    FTh := TThreadExecutor.Create;
  end;

  GetListaMetodos.Add(pMetodo);
end;

class destructor TExecutor.Destroy;
begin
  FListaMetodos.Free;
end;

class function TExecutor.GetListaMetodos: TListaMetodos;
begin
  if not Assigned(FListaMetodos) then
  begin
    FListaMetodos := TListaMetodos.Create;
  end;

  Result := FListaMetodos;
end;

{ TThreadExecutor }

constructor TThreadExecutor.Create;
begin
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TThreadExecutor.Execute;
var
  lMetodo: TMetodo;
begin
  while not Terminated do
  begin
    lMetodo := nil;

    if TExecutor.GetListaMetodos.Count > 0 then
    begin
      lMetodo := TExecutor.GetListaMetodos.First;
      TExecutor.GetListaMetodos.Remove(lMetodo);
    end;

    if Assigned(lMetodo) then
    begin
      try
        if Assigned(lMetodo.FExecutar) then
        begin
          lMetodo.FExecutar();
        end;

        if Assigned(lMetodo.FRetornoOk) then
        begin
          lMetodo.FRetornoOk();
        end;

      except
        on E: Exception do
        begin
          if Assigned(lMetodo.FRetornoErro) then
          begin
            lMetodo.FRetornoErro();
          end;
        end;
      end;

      lMetodo.Free;
    end;

    Sleep(100);
  end;
end;

end.
