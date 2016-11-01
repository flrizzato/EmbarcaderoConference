unit U_GeraSQL;

interface

uses System.Rtti, System.Classes, System.SysUtils, U_Atributos;

type
   TGeraSQL = class(TObject)
   public
      class function GetSQL(AEntidade : TEntidade) : String;
   end;

implementation

{ TGeraSQL }

class function TGeraSQL.GetSQL(AEntidade: TEntidade): String;
var
   cSep    : String;
   cValor  : String;
   oDados  : TStringList;
   rtCtx   : TRttiContext;
   rtType  : TRttiType;
   rtProp  : TRttiProperty;
   rtAtrib : TCustomAttribute;
   rtValue : TValue;
begin
   rtCtx := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(AEntidade.ClassType);

      oDados := TStringList.Create;
      try
         //Nome da Tabela
         for rtAtrib in rtType.GetAttributes do
         begin
            if rtAtrib is TNomeTabela then
               oDados.Add('INSERT INTO ' + TNomeTabela(rtAtrib).Nome + ' (');
         end;

         //Campos
         cSep := EmptyStr;
         for rtProp in rtType.GetProperties do
         begin
            for rtAtrib in rtProp.GetAttributes do
            begin
               if rtAtrib is TNomeCampo then
               begin
                  oDados.Add(cSep + TNomeCampo(rtAtrib).Campo);
                  cSep := ',';
               end;
            end;
         end;

         oDados.Add(') VALUES (');

         //Parametros
         cSep := EmptyStr;
         for rtProp in rtType.GetProperties do
         begin
            for rtAtrib in rtProp.GetAttributes do
            begin
               if rtAtrib is TNomeCampo then
               begin
                  rtValue := rtProp.GetValue(AEntidade);

                  cValor := rtValue.ToString;
                  if rtValue.IsType<String> then
                     cValor := QuotedStr(cValor);

                  oDados.Add(cSep +  cValor);

                  cSep := ',';
               end;
            end;
         end;

         oDados.Add(')');
         Result := oDados.Text;
      finally
         oDados.Free;
      end;
   finally
      rtCtx.Free;
   end;
end;

end.
