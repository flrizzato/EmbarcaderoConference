program ConhecendoVMI;

{$APPTYPE CONSOLE}
{$R *.res}
{$M+}

uses
  System.SysUtils,
  System.Rtti;

type
  TClasseTeste = class
  private
    procedure MetodoVirtualPrivado; virtual;
  protected
    procedure MetodoVirtualProtegido; virtual;
  published
    procedure MetodoVirtualPublico; virtual;
    procedure MetodoNaoVirtual;
  end;

  TClasseTesteFilha = class(TClasseTeste)
  public
    procedure MetodoVirtualProtegido; override;
  end;

  { TClasseTeste }

procedure TClasseTeste.MetodoNaoVirtual;
begin
  Writeln('Metodo não virtual');
  MetodoVirtualPrivado;
  MetodoVirtualProtegido;
  MetodoVirtualPublico;
end;

procedure TClasseTeste.MetodoVirtualPrivado;
begin
  Writeln('Código do método virtual privado');
end;

procedure TClasseTeste.MetodoVirtualProtegido;
begin
  Writeln('Código do método virtual protegido');
end;

procedure TClasseTeste.MetodoVirtualPublico;
begin
  Writeln('Método virtual público');
end;

{ TClasseTesteFilha }

procedure TClasseTesteFilha.MetodoVirtualProtegido;
begin
  inherited;
  Writeln('Método protegido na classe filha, que virou publico');
end;

var
  _classeTeste: TClasseTeste;
  _vmt: TVirtualMethodInterceptor;
begin
  try
    Writeln('Teste');

    _classeTeste := TClasseTeste.Create;

    _vmt := TVirtualMethodInterceptor.Create(_classeTeste.ClassType);

    _vmt.OnBefore :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>;
        out DoInvoke: Boolean; out Result: TValue)
      begin
        Writeln(Format('>>>>>>Antes de %s.%s', [Instance.ClassName, Method.Name]));
      end;

    _vmt.OnAfter :=
        procedure(Instance: TObject; Method: TRttiMethod; const Args: TArray<TValue>;
        var Result: TValue)
      begin
        Writeln(Format('<<<<<<Depois de %s.%s', [Instance.ClassName, Method.Name]));
      end;

    _vmt.Proxify(_classeTeste);
    _classeTeste.MetodoNaoVirtual;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
