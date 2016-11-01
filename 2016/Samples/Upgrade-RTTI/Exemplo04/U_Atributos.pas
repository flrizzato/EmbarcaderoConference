unit U_Atributos;

interface

uses
   System.Rtti;

type
   //Informa o CODIGO DA LINHA
   TCodigoLinhaAtrib = class(TCustomAttribute)
   private
      FCodigoLinha : Integer;
   public
      constructor Create(ACodigoLinha : Integer);
      property CodigoLinha : Integer read FCodigoLinha;
   end;

   //Determina a ORDEM DE IMPRESSAO
   TOrdemImpressaoAtrib = class(TCustomAttribute)
   private
      FOrdemImpressao : Integer;
   public
      constructor Create(AOrdemImpressao : Integer);
      property OrdemImpressao : Integer read FOrdemImpressao;
   end;

   //Classe base de Formatacao
   TFormatacaoAtrib = class abstract(TCustomAttribute)
   end;

   //Formato Variavel, respeitando o tamanho maximo
   TStringVariavelAtrib = class(TFormatacaoAtrib)
   private
      FTamanhoMaximo : Byte;
   public
      constructor Create(ATamanhoMaximo : Byte = 255);
      property TamanhoMaximo : Byte read FTamanhoMaximo write FTamanhoMaximo;
   end;

   //Tamanho Fixo, preenchendo o espaço restante
   TStringFixaAtrib = class(TFormatacaoAtrib)
   private
      FTamanho       : Byte;
      FPreenchimento : Char;
   public
      constructor Create(ATamanho : Byte; APreenchimento : Char = ' ');
      property Tamanho : Byte read FTamanho;
      property Preenchimento : Char read FPreenchimento;
   end;

   //Formata a Data
   TDataAtrib = class(TFormatacaoAtrib)
   end;

   //Retira as Casas decimais
   TDinheiroAtrb = class(TFormatacaoAtrib)
   end;

implementation

{ TStringFixaAtrib }

constructor TStringFixaAtrib.Create(ATamanho: Byte; APreenchimento: Char);
begin
   FTamanho       := ATamanho;
   FPreenchimento := APreenchimento;
end;

{ TCodigoLinhaAtrib }

constructor TCodigoLinhaAtrib.Create(ACodigoLinha: Integer);
begin
   FCodigoLinha := ACodigoLinha;
end;

{ TOrdemImpressaoAtrib }

constructor TOrdemImpressaoAtrib.Create(AOrdemImpressao: Integer);
begin
   FOrdemImpressao := AOrdemImpressao;
end;

{ TStringVariavelAtrib }

constructor TStringVariavelAtrib.Create(ATamanhoMaximo: Byte);
begin
   FTamanhoMaximo := ATamanhoMaximo;
end;

end.
