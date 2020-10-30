unit uLoginAspect;

interface

uses
  System.Classes, System.SysUtils, System.Rtti, Aspect4D, uContextoAspecto;

type
  ELoginException = class(EAspectException);

  TLoginAspect = class(TAspect, IAspect)
  private
    function DeveAplicarAspecto(const method: TRttiMethod): boolean;
  public
    procedure DoAfter(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; var result: TValue);
    procedure DoBefore(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
    procedure DoException(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
      theException: Exception; out result: TValue);
    function GetName: string;
  end;

implementation

uses
  Vcl.Dialogs, uAtributos;

function TLoginAspect.GetName: string;
begin
  result := QualifiedClassName;
end;

function TLoginAspect.DeveAplicarAspecto(const method: TRttiMethod): boolean;
begin
  result := method.Name.ToUpper.Equals('POST');
end;

procedure TLoginAspect.DoBefore(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
var
  _senha: string;
begin
  if not DeveAplicarAspecto(method) then
    Exit;
  _senha := EmptyStr;

  invoke := False;
  if not InputQuery('Autenticação Tabajara', 'Digite a senha', _senha) then
    Exit;

  invoke := _senha.Trim.ToUpper.Equals('123');
  if not invoke then
    ShowMessage('Senha errada. Não será possível salvar as alterações');
end;

procedure TLoginAspect.DoException(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
  theException: Exception; out result: TValue);
begin
  Exit;
end;

procedure TLoginAspect.DoAfter(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; var result: TValue);
begin
  Exit;
end;

initialization

ContextoAspecto.Register(TLoginAspect.Create);

end.
