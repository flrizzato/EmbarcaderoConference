unit uAspectos;

interface

uses
  System.Generics.Collections, System.Rtti, System.SysUtils;

type
  TControlePermissao = class(TCustomAttribute)
  end;

  TControleTransacional = class(TCustomAttribute)
  end;

  TVerificadorAspector = class
  strict private
    class var FVMIs: TObjectDictionary<string, TVirtualMethodInterceptor>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegistrarClasse(const pClasse: TClass);
    class procedure RegistrarObjeto(const pObjeto: TObject);
    class procedure DesregistrarObjeto(const pObjeto: TObject);
  end;

implementation

{ TVerificadorAspector }

uses uUsuario, uConexao;

class constructor TVerificadorAspector.Create;
begin
  FVMIs := TObjectDictionary<string, TVirtualMethodInterceptor>.Create([doOwnsValues]);
end;

class procedure TVerificadorAspector.DesregistrarObjeto(const pObjeto: TObject);
var
  lVMI: TVirtualMethodInterceptor;
begin
  if FVMIs.TryGetValue(pObjeto.ClassName, lVMI) then
  begin
    lVMI.Unproxify(pObjeto);
  end;
end;

class destructor TVerificadorAspector.Destroy;
begin
  FVMIs.Free;
end;

class procedure TVerificadorAspector.RegistrarClasse(const pClasse: TClass);
var
  lVMI: TVirtualMethodInterceptor;
begin
  if not FVMIs.TryGetValue(pClasse.ClassName, lVMI) then
  begin
    lVMI := TVirtualMethodInterceptor.Create(pClasse);

    try
      lVMI.OnBefore :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>;
          out DoInvoke: Boolean; out Result: TValue)
        var
          lAtributo: TCustomAttribute;
        begin
          for lAtributo in Method.GetAttributes do
          begin
            if lAtributo is TControlePermissao then
            begin
              TUsuario.VerificarPermissao(Method.Name);
            end;

            if lAtributo is TControleTransacional then
            begin
              TConexao.BeginTransaction;
            end;
          end;
        end;

      lVMI.OnAfter :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; var Result: TValue)
        var
          lAtributo: TCustomAttribute;
        begin
          for lAtributo in Method.GetAttributes do
          begin
            if lAtributo is TControleTransacional then
            begin
              TConexao.Commit;
            end;
          end;
        end;

      lVMI.OnException :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>; out RaiseException: Boolean;
          TheException: Exception; out Result: TValue)
        var
          lAtributo: TCustomAttribute;
        begin
          for lAtributo in Method.GetAttributes do
          begin
            if lAtributo is TControleTransacional then
            begin
              TConexao.Rollback;
            end;
          end;
        end;

      FVMIs.Add(pClasse.ClassName, lVMI);
    except
      lVMI.Free;
      raise;
    end;
  end;
end;

class procedure TVerificadorAspector.RegistrarObjeto(const pObjeto: TObject);
begin
  RegistrarClasse(pObjeto.ClassType);

  FVMIs.Items[pObjeto.ClassName].Proxify(pObjeto);
end;

end.
