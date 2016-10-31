unit uMapeamentos;

interface

uses AqDrop.DB.Base, AqDrop.DB.ORM.Attributes, AqDrop.Core.Collections.Intf;

type
  [AqTable]
  TCidade = class(TAqDBObjectAutoID)
  strict private
    FAtiva: Boolean;
    FNome: string;

    procedure SetAtiva(const Value: Boolean);
    procedure SetNome(const Value: string);
  public
    constructor Create;

    property Nome: string read FNome write SetNome;
    property Ativa: Boolean read FAtiva write SetAtiva;
  end;

  TCidades = class(TAqDBObjectManager<TCidade>);

  [AqTable]
  TPessoa = class(TAqDBObjectAutoID)
  strict private
    FNome: string;
    [AqColumn('ID_CIDADE')]
    FIDCidade: Integer;

    function GetCidade: TCidade;
    procedure SetIDCidade(const Value: Integer);
    procedure SetNome(const Value: string);
  public
    property Nome: string read FNome write SetNome;
    property IDCidade: Integer read FIDCidade write SetIDCidade;
    property Cidade: TCidade read GetCidade;
  end;

  TPessoas = class(TAqDBObjectManager<TPessoa>);

  [AqTable]
  TProjeto = class(TAqDBObjectAutoID)
  strict private
    FNome: string;
    procedure SetNome(const Value: string);
  public
    property Nome: string read FNome write SetNome;
  end;

  TProjetos = class(TAqDBObjectManager<TProjeto>)
  public
    function GetProjetosDoRecurso(const pIDPessoa: Integer): IAqResultList<TProjeto>;
  end;

implementation

{ TCidade }

uses AqDrop.DB.SQL.Intf;

constructor TCidade.Create;
begin
  FAtiva := True;
end;

procedure TCidade.SetAtiva(const Value: Boolean);
begin
  FAtiva := Value;
end;

procedure TCidade.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TPessoa }

function TPessoa.GetCidade: TCidade;
begin
  Result := GetForeignManager<TCidades>.Get(FIDCidade);
end;

procedure TPessoa.SetIDCidade(const Value: Integer);
begin
  FIDCidade := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TProjeto }

procedure TProjeto.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TProjetos }

function TProjetos.GetProjetosDoRecurso(const pIDPessoa: Integer): IAqResultList<TProjeto>;
begin
  Result := Get(
    procedure(pSelect: IAqDBSQLSelect)
    begin
      pSelect.InnerJoin('PROJETO_PESSOA').&On('ID_PROJETO').EqualsTo('ID');
      pSelect.CustomizeCondition().AddColumnEqual('ID_PESSOA', pIDPessoa);
    end);
end;

end.
