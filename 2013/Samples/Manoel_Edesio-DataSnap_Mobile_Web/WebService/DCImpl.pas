{ Invokable implementation File for TDC which implements IDC }

unit DCImpl;

interface

uses InvokeRegistry, Types, XSBuiltIns, DCIntf, uClasses, Classes, SysUtils;

type

  { TDC }
  TDC = class(TInvokableClass, IDC)
  public
    	function Getcliente(Acliente:integer):TCliente;stdcall;
  end;

implementation

uses uDM;

function TDC.Getcliente(Acliente:integer): TCliente;
var
	FSql : string;
begin
  try
    DMdados := TDMdados.Create(nil);
    FSql    := Format('SELECT * FROM CLIENTE WHERE ID=%d',[ACliente]); 

    with DMdados do
    begin
       sqlDInamico.Close;
       sqlDInamico.CommandText := FSql;
       sqlDInamico.Open;

       if not sqlDInamico.IsEmpty then
       begin
          result           := TCliente.Create;
          result.Id        := sqlDInamico.FieldByName('ID').AsInteger;
          result.Nome      := sqlDInamico.FieldByName('NOME').AsString;
          result.Endereco  := sqlDInamico.FieldByName('ENDERECO').AsString;
          result.Cidade    := sqlDInamico.FieldByName('CIDADE').AsString;
          result.Estado    := sqlDInamico.FieldByName('ESTADO').AsString;
          result.Telefone  := sqlDInamico.FieldByName('TELEFONE').AsString;
       end;

    end;

  finally
   DMDados.sqlDInamico.Close;
   FreeAndNil(DMDados);
  end;
end;



initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TDC);
end.

