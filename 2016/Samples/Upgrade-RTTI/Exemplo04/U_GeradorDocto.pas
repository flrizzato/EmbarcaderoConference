unit U_GeradorDocto;

interface

uses
   System.Generics.Collections, U_LinhaBase;

type
   TGeradorDocto = class(TObjectList<TLinhaBase>)
   public
      function GerarDocumento() : String;
   end;

implementation

uses
   System.Classes, System.SysUtils;

{ TGeradorDocto }

function TGeradorDocto.GerarDocumento: String;
var
   oItemLista : TLinhaBase;
   Dados : TStringList;
begin
   Result := EmptyStr;

   Dados := TStringList.Create;
   try
      for oItemLista in Self.ToArray do
         Dados.Add( oItemLista.GeraLinha() );

      Result := Dados.Text;
   finally
      Dados.Free;
   end;
end;

end.
