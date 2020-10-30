unit U_Atributos;

interface

uses
   System.Rtti;

type
   TEntidade = class(TObject)
   end;

   TNomeTabela = class(TCustomAttribute)
   private
      FNome : String;
   public
      constructor Create(ANome : String);
      property Nome : String read FNome;
   end;

   TNomeCampo = class(TCustomAttribute)
   private
      FCampo :  String;
   public
      constructor Create(ACampo : String);
      property Campo : String read FCampo;
   end;

implementation

{ TNomeTabela }

constructor TNomeTabela.Create(ANome: String);
begin
   Self.FNome := ANome;
end;

{ TNomeCampo }

constructor TNomeCampo.Create(ACampo: String);
begin
   Self.FCampo := ACampo;
end;

end.
