unit U_LinhaBase;

interface

uses
   System.Classes, System.SysUtils, System.Rtti, U_Atributos;

type
   TLinhaBase = class abstract(TObject)
   private const
      C_SEPARADOR = '|';
   public
      function GeraLinha() : String;
   end;

   TUtils = class
   public
      class function FormatarValor(AValor : String; AAtributo : TCustomAttribute) : String;
   end;


implementation

{ TLinhaBasae }

function TLinhaBase.GeraLinha: String;
const
   C_POS_INVALIDO = -1;
var
   rtCtx        : TRttiContext;
   rtType       : TRttiType;
   rtProperty   : TRttiProperty;
   rtValue      : TValue;
   rtAtrib      : TCustomAttribute;
   aCampos      : TArray<String>;
   nBufferPos   : Integer;
   cBufferCampo : String;
begin
   rtCtx := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(Self.ClassType);
      if Assigned(rtType) then
      begin
         for rtAtrib in rtType.GetAttributes do
         begin
            if rtAtrib is TCodigoLinhaAtrib then
            begin
               Result := FormatFloat('000', TCodigoLinhaAtrib(rtAtrib).CodigoLinha) + Self.C_SEPARADOR;
               Continue;
            end;
         end;

         SetLength(aCampos, Length(rtType.GetDeclaredProperties));

         for rtProperty in rtType.GetDeclaredProperties do
         begin
            nBufferPos   := C_POS_INVALIDO;
            cBufferCampo := EmptyStr;

            for rtAtrib in rtProperty.GetAttributes do
            begin
               if rtAtrib is TOrdemImpressaoAtrib then
               begin
                  nBufferPos := TOrdemImpressaoAtrib(rtAtrib).OrdemImpressao;
                  Continue;
               end;

               if rtAtrib is TFormatacaoAtrib then
               begin
                  rtValue := rtProperty.GetValue(Self);

                  if rtValue.IsType<String> then
                     cBufferCampo := rtValue.AsString
                  else if rtValue.IsType<Integer> then
                     cBufferCampo := IntToStr(rtValue.AsInteger)
                  else if rtValue.IsType<Currency> then
                     cBufferCampo := FloatToStr(rtValue.AsCurrency)
                  else if rtValue.IsType<TDate> then
                     cBufferCampo := DateTimeToStr(rtValue.AsType<TDate>);

                  cBufferCampo := TUtils.FormatarValor(cBufferCampo, rtAtrib);
               end;              

               if nBufferPos > C_POS_INVALIDO then
                  aCampos[nBufferPos - 1] := cBufferCampo;
            end;
         end;

         for cBufferCampo in aCampos do
            Result := Result + cBufferCampo + Self.C_SEPARADOR;
      end;
   finally
      rtCtx.Free;
      Finalize(aCampos);
   end;
end;

{ TUtils }

class function TUtils.FormatarValor(AValor: String;
  AAtributo: TCustomAttribute): String;
var
   nTamStr : Integer;
   nTamDesejado : Integer;
begin
   //String de Tamanho Variavel dentro do tamanho maximo
   if AAtributo is TStringVariavelAtrib then
   begin
      nTamStr      := Length(AValor);
      nTamDesejado := TStringVariavelAtrib(AAtributo).TamanhoMaximo;

      if nTamStr > nTamDesejado then
         Result := Copy(AValor, 1, nTamDesejado)
      else
         Result := AValor;

      Exit;
   end;

   //String de Tamanho Fixo, completando conforme necessario
   if AAtributo is TStringFixaAtrib then
   begin
      nTamStr      := Length(AValor);
      nTamDesejado := TStringFixaAtrib(AAtributo).Tamanho;

      if nTamStr > nTamDesejado then
         Result := Copy(AValor, 1, nTamDesejado)
      else if nTamStr < nTamDesejado then
         Result := StringOfChar(TStringFixaAtrib(AAtributo).Preenchimento, nTamDesejado - nTamStr) + AValor
      else
         Result := AValor;

      Exit;
   end;

   if AAtributo is TDataAtrib then
   begin
      Result := FormatDateTime('ddmmyyyy', StrToDateTimeDef(AValor, Now));
      Exit;
   end;

   if AAtributo is TDinheiroAtrb then
   begin
      Result := StringReplace(AValor, FormatSettings.DecimalSeparator, EmptyStr, [rfReplaceAll]);
      Exit;
   end;

   Result := AValor;
end;

end.
