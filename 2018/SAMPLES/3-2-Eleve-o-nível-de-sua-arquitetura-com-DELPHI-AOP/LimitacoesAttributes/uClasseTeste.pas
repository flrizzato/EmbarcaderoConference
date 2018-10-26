unit uClasseTeste;

interface

{$M+}

type
  TTesteAttribute = class(TCustomAttribute);

  TClasseTeste = class
  public
    [TTesteAttribute]
    procedure MetodoVirtualPublico; virtual;
  published
    procedure MetodoNaoVirtual;
  end;

  TClasseTesteFilha = class(TClasseTeste)
  public
    procedure MetodoVirtualPublico; override;
  end;

  { TClasseTeste }

implementation

procedure TClasseTeste.MetodoNaoVirtual;
begin
  Writeln('Metodo não virtual');
  MetodoVirtualPublico;
end;

procedure TClasseTeste.MetodoVirtualPublico;
begin
  Writeln('Método virtual público');
end;

{ TClasseTesteFilha }

procedure TClasseTesteFilha.MetodoVirtualPublico;
begin
  inherited;
  Writeln('Método virtual público filho');
end;

end.
