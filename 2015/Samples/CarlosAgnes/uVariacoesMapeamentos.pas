unit uVariacoesMapeamentos;

interface

uses
  AqDrop.DB.ORM.Attributes;

type
  [AqTable('CIDADE', [])]
  TCidadeManual = class
  strict private
    [AqAutoIncrementColumn('ID')]
    FID: Integer;

    [AqColumn('NOME')]
    FNome: string;

    [AqColumn('ATIVA')]
    FAtiva: Boolean;
  public
    property ID: Integer read FID;
    property Nome: string read FNome write FNome;
    property Ativa: Boolean read FAtiva write FAtiva;
  end;

  [AqTable('CIDADE', [])]
  TCidadeManualPropriedades = class
  strict private
    FID: Integer;
    FNome: string;
    FAtiva: Boolean;
  public
    [AqAutoIncrementColumn('ID')]
    property ID: Integer read FID write FID;
    [AqColumn('NOME')]
    property Nome: string read FNome write FNome;
    [AqColumn('ATIVA')]
    property Ativa: Boolean read FAtiva write FAtiva;
  end;

  [AqTable]
  TCidade = class
  strict private
    [AqAutoIncrementColumn('ID')]
    FID: Integer;
    FNome: string;
    FAtiva: Boolean;
  public
    property ID: Integer read FID;
    property Nome: string read FNome write FNome;
    property Ativa: Boolean read FAtiva write FAtiva;
  end;

  [AqTable('MAIS_VARIACOES')]
  TMaisVariacoes = class
  strict private
    FFieldMapeadaAutomaticamente: Integer;
    [AqColumn('NOME_NO_BANCO')]
    FFieldComNomeDiferente: Integer;
    [AqColumn('COLUNA_NULL', [TAqDBColumnAttribute.caNullIfZero])]
    FfieldPassivelDeNullNoBD: Integer;
    [AqORMOff]
    FFieldNaoMapeado: Integer;

    FMaisUmFieldMapeadoAutomaticamente: Integer;

    function GetFieldProperty: Integer;
    procedure SetFieldProperty(const Value: Integer);
  public
    property FieldMapeadaAutomaticamente: Integer read FFieldMapeadaAutomaticamente write FFieldMapeadaAutomaticamente;
    property FieldComNomeDiferente: Integer read FFieldComNomeDiferente write FFieldComNomeDiferente;
    property fieldPassivelDeNullNoBD: Integer read FfieldPassivelDeNullNoBD write FFieldComNomeDiferente;
    property FieldNaoMapeado: Integer read FFieldNaoMapeado write FFieldNaoMapeado;
    property MaisUmFieldMapeadoAutomaticamente: Integer read FMaisUmFieldMapeadoAutomaticamente
      write FMaisUmFieldMapeadoAutomaticamente;

    [AqColumn('COLUNA_PROPERTY')]
    property FieldProperty: Integer read GetFieldProperty write SetFieldProperty;
  end;

  [AqTable]
  TPessoa = class
  strict private
    [AqAutoIncremetColumn('ID')]
    FID: Integer;
    FNome: string;
    [AqColumn('ID_CIDADE')]
    FIDCidade: Integer;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property IDCidade: Integer read FIDCidade write FIDCidade;
  end;

  [AqSpecialization('PESSOA_FISICA', 'ID', 'ID')]
  TPessoaFisica = class(TPessoa)
  private
    FNascimento: TDateTime;
    [AqColumn('CPF', [TAqDBColumnAttribute.caNullIfZero])]
    FCPF: Int64;
  public
    property Nascimento: TDateTime read FNascimento write FNascimento;
    property CPF: Int64 read FCPF write FCPF;
  end;

implementation

{ TMaisVariacoes }

function TMaisVariacoes.GetFieldProperty: Integer;
begin
  Result := 0;
end;

procedure TMaisVariacoes.SetFieldProperty(const Value: Integer);
begin

end;

end.
