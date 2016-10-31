unit uClientes;

interface

uses
  System.Classes, System.Generics.Collections, FireDAC.Comp.Client;

type
 TClientes = class(TObject)
  private
   FCodigo   : Integer;
   FNome     : String;
   FEndereco : String;
   FEmail    : String;
  public
   property Codigo   : Integer read FCodigo   write FCodigo;
   property Nome     : String  read FNome     write FNome;
   property Endereco : String  read FEndereco write FEndereco;
   property Email    : String  read FEmail    write FEmail;

   constructor Create(aCodigo: Integer; aNome: String;
                      aEndereco: String; aEmail: String);
 end;


implementation


{ TClientes }

constructor TClientes.Create(aCodigo: Integer; aNome, aEndereco,
  aEmail: String);
begin
 Codigo   := aCodigo;
 Nome     := aNome;
 Endereco := aEndereco;
 Email    := aEmail;
end;

end.
