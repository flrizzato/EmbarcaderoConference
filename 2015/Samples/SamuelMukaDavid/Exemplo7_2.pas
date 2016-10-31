unit Exemplo7_2;

interface

uses Exemplo7_1, Exemplo7;

type
  TTipoFicha = (tfNone, tfTexto, tfXml, tfJson);

  TExportaFichaUsuarioFactory = class
  public
    class function ObterExportador(pTipoFicha: TTipoFicha): IExportadorFichaUsuario;
  end;


implementation

{ TExportaFichaUsuarioFactory }

class function TExportaFichaUsuarioFactory.ObterExportador(pTipoFicha: TTipoFicha): IExportadorFichaUsuario;
begin
  case pTipoFicha of
    tfTexto: Result := TExportadorFichaUsuarioTxt.Create;
    tfXml:   Result := TExportadorFichaUsuarioXML.Create;
    tfJson:  Result := TExportadorFichaUsuarioJson.Create;
  end;
end;


end.
