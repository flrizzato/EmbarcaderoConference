unit U_Linhas;

interface

uses
   U_LinhaBase, U_Atributos;

type
   [TCodigoLinhaAtrib(0)]
   TLinha000 = class(TLinhaBase)
   private
      FDataGeracao : TDate;
   public
      [TOrdemImpressaoAtrib(1)]
      [TDataAtrib]
      property DataGeracao : TDate read FDataGeracao write FDataGeracao;
   end;

   [TCodigoLinhaAtrib(1)]
   TLinha001 = class(TLinhaBase)
   private
      FNomeContador : String;
      FCRCContador  : String;
   public
      [TOrdemImpressaoAtrib(1)]
      [TStringVariavelAtrib(50)]
      property NomeContador : String read FNomeContador write FNomeContador;
      [TOrdemImpressaoAtrib(2)]
      [TStringFixaAtrib(10)]
      property CRCContador : String read FCRCContador write FCRCContador;
   end;

   [TCodigoLinhaAtrib(2)]
   TLinha002 = class(TLinhaBase)
   private
      FNomeEmpresa : String;
      FCNPJ : String;
   public
      [TOrdemImpressaoAtrib(1)]
      [TStringVariavelAtrib(50)]
      property NomeEmpresa : String read FNomeEmpresa write FNomeEmpresa;
      [TOrdemImpressaoAtrib(2)]
      [TStringFixaAtrib(14)]
      property CNPJ : String read FCNPJ write FCNPJ;
   end;

   [TCodigoLinhaAtrib(3)]
   TLinha003 = class(TLinhaBase)
   private
      FDataVenda   : TDate;
      FNomeCliente : String;
      FValorVenda  : Currency;
   public
      [TOrdemImpressaoAtrib(1)]
      [TDataAtrib]
      property DataVenda : TDate read FDataVenda write FDataVenda;
      [TOrdemImpressaoAtrib(2)]
      [TStringVariavelAtrib()]
      property NomeCliente : String read FNomeCliente write FNomeCliente;
      [TOrdemImpressaoAtrib(3)]
      [TDinheiroAtrb]
      property ValorVenda : Currency read FValorVenda write FValorVenda;
   end;

   [TCodigoLinhaAtrib(9)]
   TLinha999 = class(TLinhaBase)
   end;


implementation

end.
