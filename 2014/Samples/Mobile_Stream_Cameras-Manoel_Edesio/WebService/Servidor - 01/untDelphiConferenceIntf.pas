{ Invokable interface IDelphiConference }

unit untDelphiConferenceIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type
  TCliente = class(TRemotable)
  private
    FDataNascimento: string;
    FSexo: string;
    FNome: string;
    FCidade: string;
    procedure SetCidade(const Value: string);
    procedure SetDataNascimento(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetSexo(const Value: string);
  published
    property Nome:string read FNome write SetNome;
    property DataNascimento:string read FDataNascimento write SetDataNascimento;
    property Sexo:string read FSexo write SetSexo;
    property Cidade:string read FCidade write SetCidade;
  end;

  { Invokable interfaces must derive from IInvokable }
  IDelphiConference = interface(IInvokable)
  ['{3BDF0269-B9A1-4A59-9B85-D214B5521780}']
    function GetNomeCliente(AIdCliente:integer):string;stdcall;
    function GetCliente(AIdCliente:integer):TCliente;stdcall;
    function GetIntervaloClientes(AIdInicial,AIdFinal:integer):string;stdcall;
    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
  end;

implementation

{ TCliente }

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCliente.SetDataNascimento(const Value: string);
begin
  FDataNascimento := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetSexo(const Value: string);
begin
  FSexo := Value;
end;

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IDelphiConference));

end.
