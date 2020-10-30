unit uLoadObjetos;

interface

uses Classes, System.Generics.Collections, uClientes, uCidades,
     FireDAC.Comp.Client, uDmDados;

type
 TLoadObjetos = class(TComponent)
   private

   public
    class function LoadClientes(aIDCliente: Integer): TList<TClientes>;
    class function LoadCidades(aIDCidade: Integer): TList<TCidades>;

 end;

implementation

uses
  System.SysUtils;

{ TLoadObjetos }

class function TLoadObjetos.LoadCidades(aIDCidade: Integer): TList<TCidades>;
var
 lQry: TFDQuery;
 sWhere: String;
begin
 sWhere := '';
 if aIDCidade > 0 then
  sWhere :=  'Where Cid_Codigo =' + IntToStr(aIDCidade);

 lQry := TFDQuery.Create(nil);
 lQry.Connection := DataModule1.TesteConnection;
 result := TObjectList<TCidades>.create;
 try
  lQry.SQL.Add('Select Cid_Codigo, Cid_Nome, Cid_UF  ' +
               'From Cidades                         ' +
               sWhere +
               'Order By Cid_Nome                    ');
  lQry.Open;
  lQry.First;
  while not lQry.Eof do
   begin
    result.Add(TCidades.Create(lQry.FieldByName('Cid_Codigo').AsInteger,
                               lQry.FieldByName('Cid_Nome').AsString,
                               lQry.FieldByName('Cid_UF').AsString));
    lQry.Next;
   end;
 finally
  lQry.Free;
 end;
end;

class function TLoadObjetos.LoadClientes(aIDCliente: Integer): TList<TClientes>;
var
 lQry: TFDQuery;
 sWhere: String;
begin
 sWhere := '';
 if aIDCliente > 0 then
  sWhere := 'Where Cli_Codigo =' + IntToStr(aIDCliente);

 lQry := TFDQuery.Create(nil);
 lQry.Connection := DataModule1.TesteConnection;
 result := TObjectList<TClientes>.create;

 try
  lQry.SQL.Add('Select Cli_Codigo, Cli_Nome, Cli_Endereco, Cli_Email  ' +
               'From Clientes                                         ' +
               sWhere +
               'Order By Cli_Nome                                     ' );
  lQry.Open;
  lQry.First;
  while not lQry.Eof do
   begin
    result.Add(TClientes.Create(lQry.FieldByName('Cli_Codigo').AsInteger,
                                lQry.FieldByName('Cli_Nome').AsString,
                                lQry.FieldByName('Cli_Endereco').AsString,
                                lQry.FieldByName('Cli_Email').AsString));
    lQry.Next;
   end;
 finally
  lQry.Free;
 end;
end;

end.
