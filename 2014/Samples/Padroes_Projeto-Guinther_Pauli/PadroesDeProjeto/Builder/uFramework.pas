unit uFramework;

interface

uses
  Generics.Collections;

type
  TRelatorio = class
     public Cabecalho: string;
     public Detalhes: TList<string>;
     public Rodape: string;
     constructor Create();
     destructor Destroy(); override;
  end;

  // Builder (Abstrato)
  TRelatorioBuilder = class abstract
    protected _relatorio: TRelatorio;
    function getRelatorio: TRelatorio;
    // processo de construção (abstrato)
    public procedure buildCabecalho(); virtual; abstract;
    public procedure buildDetalhes(); virtual; abstract;
    public procedure buildRodape(); virtual; abstract;
    public procedure createNewRelatorioProduct();
  end;

  // Builder (Concreto)
  TRelatorioClientesBuilder = class(TRelatorioBuilder)
    public procedure buildCabecalho(); override;
    public procedure buildDetalhes(); override;
    public procedure buildRodape(); override;
  end;

  // Builder (Concreto)
  TRelatorioProdutosBuilder = class(TRelatorioBuilder)
    public procedure buildCabecalho(); override;
    public procedure buildDetalhes(); override;
    public procedure buildRodape(); override;
  end;

  { Director - responsável pelo gerenciamento
    da sequência correta de criação do objeto
    Recebe um um Concret Builder como parâmetro e
    executa as operações necessárias sobre ele  }
  TGerador = class
    private _relatorioBuilder: TRelatorioBuilder;
    public procedure setRelatorioBuilder(relatorioBuilder: TRelatorioBuilder);
    public function getRelatorio(): TRelatorio;
    public procedure constructRelatorio();
  end;

implementation

{ RelatorioClientesBuilder }

procedure TRelatorioClientesBuilder.buildCabecalho();
begin
  _relatorio.Cabecalho := 'Relatório de Clientes';
end;

procedure TRelatorioClientesBuilder.buildDetalhes();
begin
  _relatorio.Detalhes.Add('Jose');
  _relatorio.Detalhes.Add('Pedro');
  _relatorio.Detalhes.Add('Joao');
end;

procedure TRelatorioClientesBuilder.buildRodape();
begin
  _relatorio.Rodape := 'GPauli Cursos e Treinamentos';
end;

{ RelatorioProdutosBuilder }

procedure TRelatorioProdutosBuilder.buildCabecalho();
begin
  _relatorio.Cabecalho := 'Relatório de Produtos';
end;

procedure TRelatorioProdutosBuilder.buildDetalhes();
begin
  _relatorio.Detalhes.Add('iPhone');
  _relatorio.Detalhes.Add('iPad');
  _relatorio.Detalhes.Add('iPod');
end;

procedure TRelatorioProdutosBuilder.buildRodape();
begin
 _relatorio.Rodape := 'GPauli Cursos e Treinamentos';
end;

{ RelatorioBuilder }

procedure TRelatorioBuilder.createNewRelatorioProduct();
begin
  _relatorio := TRelatorio.Create();
end;

function TRelatorioBuilder.getRelatorio(): TRelatorio;
begin
  result := _relatorio;
end;

{ Director }

procedure TGerador.constructRelatorio();
begin
  _relatorioBuilder.createNewRelatorioProduct();
  _relatorioBuilder.buildCabecalho();
  _relatorioBuilder.buildDetalhes();
  _relatorioBuilder.buildRodape();
end;

function TGerador.getRelatorio(): TRelatorio;
begin
  result := _relatorioBuilder.getRelatorio();
end;

procedure TGerador.setRelatorioBuilder(
  relatorioBuilder: TRelatorioBuilder);
begin
  self._relatorioBuilder := relatorioBuilder;
end;

{ Relatorio }

constructor TRelatorio.Create();
begin
  Detalhes := TList<string>.Create();
end;

destructor TRelatorio.Destroy();
begin
  Detalhes.Free();
  inherited;
end;

end.
