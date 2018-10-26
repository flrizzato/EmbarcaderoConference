program LimitesAttributes;

{$APPTYPE CONSOLE}
{$R *.res}
{$M+}

uses
  System.SysUtils,
  System.Rtti,
  uClasseTeste in 'uClasseTeste.pas';


var
  _classeTeste: TClasseTesteFilha;
  _vmt: TVirtualMethodInterceptor;

begin
  try
    _classeTeste := TClasseTesteFilha.Create;

    _vmt := TVirtualMethodInterceptor.Create(_classeTeste.ClassType);
    _vmt.OnBefore :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>;
        out DoInvoke: Boolean; out Result: TValue)
      var
        _attr: TCustomAttribute;
      begin
        Writeln('     '+ Method.Parent.QualifiedName);
        for _attr in Method.GetAttributes do
        begin
          if _attr is TTesteAttribute then
            Writeln(Format('>>>>>>Antes de %s.%s', [Instance.ClassName, Method.Name]));
        end;
      end;

    _vmt.OnAfter :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>;
        var Result: TValue)

      var
        _attr: TCustomAttribute;
      begin
        for _attr in Method.GetAttributes do
        begin
          if _attr is TTesteAttribute then
            Writeln(Format('<<<<<<Depois de %s.%s', [Instance.ClassName, Method.Name]));
        end;
      end;

    _vmt.Proxify(_classeTeste);
    _classeTeste.MetodoNaoVirtual;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
