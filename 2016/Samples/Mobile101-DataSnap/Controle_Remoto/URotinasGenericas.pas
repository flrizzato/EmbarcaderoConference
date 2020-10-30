unit URotinasGenericas;

interface

uses Windows, SysUtils, Forms, StdCtrls, Graphics, Mask, DBCtrls, DB, DBTables, IWCompEdit;

function MostraData : string;
function Confirma (const strTexto : string) : integer;
function StrZero (const strValor : string; const intComprimento : integer) : string;
procedure Mensagem (const strMensagem, strTitulo : string);
procedure CorEntrada (Sender : TObject);
procedure CorSaida (Sender : TObject);
function VerificaCNPJ (strValor : string) : boolean;
function RemoveCaracteres (const Caracteres : string; const Palavra : string ) : string;
function RemoveAcentucao (Palavra : string) : string;
function GeraSenha (Tamanho : integer) : string;

implementation

function MostraData : string;
  var
    dtHoje : TDateTime;
    intDiaSemana : integer;
    strDiaSemana : string;
  begin
    dtHoje := Date;
    intDiaSemana := DayOfWeek(dtHoje);
    case intDiaSemana of
      1: strDiaSemana := 'Domingo - ';
      2: strDiaSemana := 'Segunda-feira - ';
      3: strDiaSemana := 'TerÁa-feira - ';
      4: strDiaSemana := 'Quarta-feira - ';
      5: strDiaSemana := 'Quinta-feira - ';
      6: strDiaSemana := 'Sexta-feira - ';
      7: strDiaSemana := 'S·bado - ';
    end;
    Result := strDiaSemana + DateToStr(dtHoje);
  end;

function Confirma (const strTexto : string) : Integer;
  begin
    Result := Application.MessageBox(PChar(strTexto), 'CONFIRMA«√O', MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION);
  end;

function StrZero (const strValor : string; const intComprimento : integer) : string;
var
    strZeros, strRetorno : string;
    intTamanho, intContador : integer;
  begin
    intTamanho := Length(Trim(strValor));
    strZeros := '';
    for intContador := 1 to intComprimento do
      strZeros := strZeros + '0';
    strRetorno := Copy(Trim(strZeros) + Trim(strValor), intTamanho + 1, intComprimento);
    Result := strRetorno;
  end;

procedure Mensagem (const strMensagem, strTitulo : string);
begin
  Application.MessageBox(PChar(strMensagem), Pchar(strTitulo) , MB_OK + MB_ICONEXCLAMATION);
end;

procedure CorEntrada (Sender : TObject);
  begin
    if (Sender is TEdit) then
      begin
        if ((Sender as TEdit).Tag = 0) then
          (Sender as TEdit).Color := clYellow
          else
            (Sender as TEdit).Color := clAqua;
      end
    else if (Sender is TMaskEdit) then
      begin
          if ((Sender as TMaskEdit).Tag = 0) then
            (Sender as TMaskEdit).Color := clYellow
            else
              (Sender as TMaskEdit).Color := clAqua;
      end
    else if (Sender is TMemo) then
            (Sender as TMemo).Color := clYellow
    else if (Sender is TDBEdit) then
      begin
        if (Sender as TDBEdit).Tag = 0 then
          (Sender as TDBEdit).Color := clYellow
          else
            (Sender as TDBEdit).Color := clAqua;
      end
    else if (Sender is TDBMemo) then
         (Sender as TDBMemo).Color := clYellow;

   // Componentes Intraweb
    if (Sender is TIWEdit) then
      begin
        if ((Sender as TIWEdit).Tag = 0) then
          (Sender as TIWEdit).BGColor := clYellow
          else
            (Sender as TIWEdit).BGColor := clAqua;
      end ;
    {else if (Sender is TIWMaskEdit) then
      begin
          if ((Sender as TIWMaskEdit).Tag = 0) then
            (Sender as TIWMaskEdit).Color := clYellow
            else
              (Sender as TIWMaskEdit).Color := clAqua;
      end
    else if (Sender is TIWMemo) then
            (Sender as TIWMemo).Color := clYellow;
   { else if (Sender is TDBEdit) then
      begin
        if (Sender as TDBEdit).Tag = 0 then
          (Sender as TDBEdit).Color := clYellow
          else
            (Sender as TDBEdit).Color := clAqua;
      end
    else if (Sender is TDBMemo) then
         (Sender as TDBMemo).Color := clYellow; }

end;

procedure CorSaida (Sender : TObject);
begin
  if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow
    else if (Sender is TMaskEdit) then
         (Sender as TMaskEdit).Color := clWindow
    else if (Sender is TMemo) then
         (Sender as TMemo).Color := clWindow
    else if (Sender is TDBEdit) then
         (Sender as TDBEdit).Color := clWindow
    else if (Sender is TDBMemo) then
         (Sender as TDBMemo).Color := clWindow
       // Componentes Intraweb
    else if (Sender is TIWEdit) then
        (Sender as TIWEdit).BGColor := clWindow;

end;

function VerificaCNPJ (strValor : string) : boolean;
var
  strCNPJ : string;
  blnResultado : boolean;
  intDigito1, intDigito2, intContador, intSoma : integer;
begin
    strCNPJ := '';
    blnResultado := False;
//    Analisa CNPJ no formato 99.999.999/999-99
    if Length (strValor) = 18 then
      begin
       if Copy(strValor, 3, 1) + Copy(strValor, 7, 1) + Copy(strValor, 11, 1) + Copy(strValor, 16, 1) = '../-' then
        begin
          strCNPJ := Copy(strValor, 1, 2) + Copy(strValor, 4, 3) + Copy(strValor, 8, 3) + Copy(strValor, 12, 4) + Copy(strValor, 17,2);
          blnResultado := True;
        end;
      end
//      Analisa CNPJ no formato 99999999999999
      else if Length (strValor) = 14 then
        begin
          strCNPJ := strValor;
          blnResultado := True;
        end;
//      ComeÁa a verificaÁ„o do dÌgito
      if blnResultado then
        begin
          try
//            1∫ digito
            intSoma := 0;
            for intContador := 1 to 12 do
              begin
                if intContador < 5 then
                  Inc(intSoma, StrToInt(Copy(strCNPJ, intContador, 1)) * (6 - intContador))
                else
                  Inc(intSoma, StrToInt(Copy(strCNPJ, intContador, 1)) * (14 - intContador));
              end;
            intDigito1 := 11 - (intSoma mod 11);
            if intDigito1 > 9 then
              intDigito1 := 0;

//            2∫ digito
            intSoma := 0;
            for intContador := 1 to 13 do
              begin
                if intContador < 6 then
                  Inc(intSoma, StrToInt(Copy(strCNPJ, intContador, 1)) * (7 - intContador))
                else
                  Inc(intSoma, StrToInt(Copy(strCNPJ, intContador, 1))* (15 - intContador));
              end;
            intDigito2 := 11 - (intSoma mod 11);
            if intDigito2 > 9 then
              intDigito2 := 0;
//            checa os dois dÌgitos
            blnResultado := (intDigito1 = StrToInt(Copy(strCNPJ, 13, 1))) and (intDigito2 = StrToInt(Copy(strCNPJ, 14,1)));
          except
            blnResultado := False;
          end;
        end;
        Result := blnResultado;
end;

function RemoveCaracteres (const Caracteres : string; const Palavra : string ) : string;
var
  Posicao : integer;
begin
  Result := Palavra;
  Posicao := Pos(Caracteres[1], Result);
  while Posicao > 0 do
    begin
      Delete(Result, Posicao, 1);
      Posicao := Pos(Caracteres[1], Result);
    end;
end;

function RemoveAcentucao (Palavra : string) : string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  i : integer;
begin
   for i := 0 to Length(Palavra) do
     begin
       if Pos(Palavra[i], ComAcento) <> 0 then
          Palavra[i] := SemAcento[Pos(Palavra[i], ComAcento)];
     end;
   Result := Palavra;
end;

function GeraSenha (Tamanho : integer) : string;
var
  i : integer;
const
  str = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
begin
  Result := '';
  for i := 1 to Tamanho do
    begin
      Randomize;
      Result := Result + str[Random(Length(str))+1];
    end;
end;

end.
