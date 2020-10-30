unit uPOS;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSServer,
  Datasnap.DSAuth,
  uDMPOS,
  dbxJson,
  data.db,
  data.FireDACJSONReflect,
  System.json;

type
{$METHODINFO ON}
  TPOS = class(TComponent)
  private
    function DataToJSONObject(const AValue: TDataSet): TJSONObject;
    { Private declarations }
  public
    { Public declarations }
    function StatusMesa(NumeroMesa: integer): string;
    function ListaProdutos: string;
    function PagamentoMesa(NumeroMesa: integer): string;
    function ConsumoMesa(NumeroMesa: integer): string;
    function EmiteNFCe(NumeroMesa: integer): string;

  end;
{$METHODINFO OFF}

implementation

{ TPOS }

function TPOS.StatusMesa(NumeroMesa: integer): string;
begin
  dmPOS.mtblMesas.Filtered := false;
  dmPOS.mtblMesas.Filter := 'mesa=' + NumeroMesa.ToString;
  dmPOS.mtblMesas.Filtered := true;

  result := DataToJSONObject(dmPOS.mtblMesas).ToString;

  dmPOS.mtblMesas.Filtered := false;
  dmPOS.mtblMesas.Filter := EmptyStr;
end;

function TPOS.ListaProdutos: string;
begin
  dmPOS.mtblMesas.First;
  result := DataToJSONObject(dmPOS.mtblProdutos).ToString;
end;

function TPOS.PagamentoMesa(NumeroMesa: integer): string;
begin
  dmPOS.mtblMesas.Filtered := false;
  dmPOS.mtblMesas.Filter := 'mesa=' + NumeroMesa.ToString;
  dmPOS.mtblMesas.Filtered := true;
  dmPOS.mtblMesas.Edit;
  dmPOS.mtblMesasstatus.AsBoolean := false;
  dmPOS.mtblMesasvalor.AsFloat := 0;
  dmPOS.mtblMesas.Post;
  dmPOS.mtblMesas.Filtered := false;
  dmPOS.mtblMesas.Filter := EmptyStr;
end;

function TPOS.EmiteNFCe(NumeroMesa: integer): string;
begin
  // seleciona a mesa
  dmPOS.mtblMesas.Filtered := false;
  dmPOS.mtblMesas.Filter := 'mesa=' + NumeroMesa.ToString;
  dmPOS.mtblMesas.Filtered := true;

  // seleciona os produtos
  dmPOS.mtblVendas.Filtered := false;
  dmPOS.mtblVendas.Filter := 'mesa=' + NumeroMesa.ToString;
  dmPOS.mtblVendas.Filtered := true;

  try
    dmPOS.GeraNFCe();
  finally
    dmPOS.mtblMesas.Filtered := false;
    dmPOS.mtblVendas.Filtered := false;
  end;

end;

function TPOS.ConsumoMesa(NumeroMesa: integer): string;
begin
  dmPOS.mtblVendas.Filtered := false;
  dmPOS.mtblVendas.Filter := 'mesa=' + NumeroMesa.ToString;
  dmPOS.mtblVendas.Filtered := true;

  result := DataToJSONObject(dmPOS.mtblVendas).ToString;

  dmPOS.mtblVendas.Filtered := false;
  dmPOS.mtblVendas.Filter := EmptyStr;
end;

function TPOS.DataToJSONObject(const AValue: TDataSet): TJSONObject;
var
  I: integer;
begin
  result := TJSONObject.create();
  while not AValue.Eof do
  begin
    for I := 0 to AValue.FieldDefs.Count - 1 do
    begin
      case AValue.FieldDefs[I].DataType of
        ftString, ftWideString, ftMemo:
          begin
            if AValue.FieldByName(AValue.FieldDefs[I].Name).AsString <> '' then
              result.AddPair(AValue.FieldDefs[I].Name, AValue.FieldByName(AValue.FieldDefs[I].Name).AsString)
            else
              result.AddPair(AValue.FieldDefs[I].Name, ' ');
          end;
        ftSmallint, ftInteger, ftWord, ftLongWord, ftShortint:
          begin
            result.AddPair(AValue.FieldDefs[I].Name, TJSONNumber.create(AValue.FieldByName(AValue.FieldDefs[I].Name).AsInteger));
          end;
        ftFloat, ftCurrency:
          begin
            result.AddPair(AValue.FieldDefs[I].Name, TJSONNumber.create(AValue.FieldByName(AValue.FieldDefs[I].Name).AsFloat));
          end;
        ftBoolean:
          begin
            result.AddPair(AValue.FieldDefs[I].Name, AValue.FieldByName(AValue.FieldDefs[I].Name).AsString)
          end;
      end;
    end;
    AValue.Next;
  end;
end;

end.
