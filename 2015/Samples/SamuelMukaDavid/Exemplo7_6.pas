unit Exemplo7_6;

interface

uses
  Exemplo7, Exemplo7_2, Exemplo7_3;

type
  TGerenciadorFichaHelper = class helper for TGerenciadorFicha
    procedure ExportarParaArquivo(pTipoFicha: TTipoFicha; pNomeArquivo: string);
    class procedure CriarExportarDestruir(lFicha: TFichaUsuario; pTipoFicha: TTipoFicha;
  pNomeArquivo: string);
  end;


implementation

{ TGerenciadorFichaHelper }

class procedure TGerenciadorFichaHelper.CriarExportarDestruir(lFicha: TFichaUsuario; pTipoFicha: TTipoFicha;
  pNomeArquivo: string);
var
  lGerenciadorFicha : TGerenciadorFicha;
begin
  lGerenciadorFicha := TGerenciadorFicha.Create(lFicha);
  try
    lGerenciadorFicha.Exportar(TExportaFichaUsuarioFactory.ObterExportador(pTipoFicha),pNomeArquivo);
  finally
    lGerenciadorFicha.Free;
  end;
end;

procedure TGerenciadorFichaHelper.ExportarParaArquivo(pTipoFicha: TTipoFicha;
  pNomeArquivo: string);
begin
  Exportar(TExportaFichaUsuarioFactory.ObterExportador(pTipoFicha),pNomeArquivo);
end;

end.
