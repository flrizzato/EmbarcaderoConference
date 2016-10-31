unit Exemplo6_1;

interface

uses Exemplo6_2, Exemplo6;

type
  TTipoFicha = (tfTexto, tfXml, tfJson);

  TExportaFichaUsuarioFactory = class
  public
    class function ObterExportador(pTipoFicha: TTipoFicha): TExportaFichaUsuario;
  end;


implementation

{ TExportaFichaUsuarioFactory }

class function TExportaFichaUsuarioFactory.ObterExportador(pTipoFicha: TTipoFicha): TExportaFichaUsuario;
begin
  case pTipoFicha of
    tfTexto: Result := TExportaFichaUsuarioTxt.Create;
    tfXml:   Result := TExportaFichaUsuarioXML.Create;
    tfJson:  Result := TExportaFichaUsuarioJson.Create;
  end;
end;

end.
