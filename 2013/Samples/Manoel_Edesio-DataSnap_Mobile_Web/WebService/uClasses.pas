unit uClasses;

interface

uses
  InvokeRegistry, Classes;

  type



  	TCliente = class (TRemotable)
    private
      FId: integer;
      FNome: string;
      FCidade: string;
      FEndereco: string;
      FTelefone: string;
      FEstado: String;
      procedure SetCidade(const Value: string);
      procedure SetEndereco(const Value: string);
      procedure SetEstado(const Value: String);
      procedure SetId(const Value: integer);
      procedure SetNome(const Value: string);
      procedure SetTelefone(const Value: string);
    published
      property Id:integer read FId write SetId;
      property Nome:string read FNome write SetNome;
      property Cidade:string read FCidade write SetCidade;
      property Estado:String read FEstado write SetEstado;
      property Endereco:string read FEndereco write SetEndereco;
      property Telefone:string read FTelefone write SetTelefone;
    end;


implementation

uses uDM, SysUtils;

{ TCliente }

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TCliente.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TCliente.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

end.
