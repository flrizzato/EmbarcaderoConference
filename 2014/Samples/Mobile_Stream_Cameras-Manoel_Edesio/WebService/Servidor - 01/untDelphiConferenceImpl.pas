{ Invokable implementation File for TDelphiConference which implements IDelphiConference }

unit untDelphiConferenceImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, untDelphiConferenceIntf;

type

  { TDelphiConference }
  TDelphiConference = class(TInvokableClass, IDelphiConference)
  public
      function GetNomeCliente(AIdCliente:integer):string;stdcall;
      function GetCliente(AIdCliente:integer):TCliente;stdcall;
      function GetIntervaloClientes(AIdInicial,AIdFinal:integer):string;stdcall;
  end;

implementation


{ TDelphiConference }

uses untDMDados, SysUtils, System.Classes, Datasnap.DBClient;

function TDelphiConference.GetCliente(AIdCliente: integer): TCliente;
var
  FSql : string;
begin
   try
      result := TCliente.Create;
      FSql := Format('SELECT DS_NOME,DT_NASCIMENTO,DS_SEXO,DS_CIDADE FROM TB_SMS_PESSOA WHERE ID_SMS_PESSOA=%d',[AIdCliente]);

      DMDados := TDMDados.Create(nil);
      DMDados.fQryClassePessoa.Close;
      DMDados.fQryClassePessoa.SQL.Clear;
      DMDados.fQryClassePessoa.SQL.Add(FSql);
      DMDados.fQryClassePessoa.Open;

      if DMDados.fQryClassePessoa.IsEmpty then
        result.Nome := 'Registro não encontrado'
      else
      begin
        result.Nome           := DMDados.fQryClassePessoa.FieldByName('DS_NOME').AsString;
        result.DataNascimento := FormatDateTime('dd/mm/yyyy',DMDados.fQryClassePessoa.FieldByName('DT_NASCIMENTO').AsDateTime);
        result.Sexo           := DMDados.fQryClassePessoa.FieldByName('DS_SEXO').AsString;
        result.Cidade         := DMDados.fQryClassePessoa.FieldByName('DS_CIDADE').AsString;
      end;

      DMDados.fQryClassePessoa.Close;
   finally
      FreeAndNil(DMDados);
   end;
end;

function TDelphiConference.GetIntervaloClientes(AIdInicial,
  AIdFinal: integer): string;
var
  FSql    : string;
  FStream : TStringStream;
begin
  FStream := TStringStream.Create('');

   try
      FSql := Format('SELECT ID_SMS_PESSOA,DS_NOME FROM TB_SMS_PESSOA WHERE ID_SMS_PESSOA BETWEEN %d AND %d',[AIdInicial,AIdFinal]);

      DMDados := TDMDados.Create(nil);
      DMDados.cdsPessoas.Close;
      DMDados.cdsPessoas.CommandText := FSql;
      DMDados.cdsPessoas.Open;

      DMDados.cdsPessoas.SaveToStream(FStream, dfXML);
      Result := FStream.DataString;

      DMDados.cdsPessoas.Close;
   finally
      FreeAndNil(FStream);
      FreeAndNil(DMDados);
   end;

end;

function TDelphiConference.GetNomeCliente(AIdCliente: integer): string;
var
  FSql : string;
begin
   try
      FSql := Format('SELECT DS_NOME FROM TB_SMS_PESSOA WHERE ID_SMS_PESSOA=%d',[AIdCliente]);

      DMDados := TDMDados.Create(nil);
      DMDados.fQryPessoa.Close;
      DMDados.fQryPessoa.SQL.Clear;
      DMDados.fQryPessoa.SQL.Add(FSql);
      DMDados.fQryPessoa.Open;

      if DMDados.fQryPessoa.IsEmpty then
        result := 'Registro não encontrado'
      else
        result := DMDados.fQryPessoa.FieldByName('DS_NOME').AsString;

      DMDados.fQryPessoa.Close;
   finally
      FreeAndNil(DMDados);
   end;
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TDelphiConference);
end.

