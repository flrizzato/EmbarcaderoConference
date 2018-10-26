unit ormbr.model.mestre;

interface

uses
  Classes, 
  DB, 
  Generics.Collections,
  /// orm
  ormbr.mapping.attributes,
  ormbr.types.mapping,
  ormbr.mapping.register,
  /// Modelos
  ormbr.model.detalhe,
  ormbr.model.cliente,
  ormbr.types.blob;

type
  [Entity]
  [Table('Tab_Mestre', '')]
  [PrimaryKey('Id', AutoInc, NoSort, True, 'Chave primária')]
  [Sequence('SEQ_MESTRE')]
  [OrderBy('Descricao DESC')]
  TTab_Mestre = class
  private
    { Private declarations }
    FId: Integer;
    FDescricao: String;
    FDataCadastro: TDateTime;
    FDataAlteracao: TDateTime;
    FCliente_Id: Integer;
    FDetalhe: TObjectList<TTab_Detalhe>;
    FCliente: TTab_Cliente;
    function GetTotal: Double;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    [Restrictions([NoUpdate, NotNull])]
    [Column('Id', ftInteger)]
    [Dictionary('Mestre Id', 'Mensagem de validação', '', '', '', taCenter)]
    property Id: Integer read FId write FId;

    [Column('Descricao', ftString, 60)]
    [Dictionary('Descrição', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property Descricao: string read FDescricao write FDescricao;

    [Restrictions([NotNull])]
    [Column('DataCadastro', ftDate)]
    [Dictionary('Dt Cadastro', 'Favor informar a data de cadastro', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;

    [Restrictions([NotNull])]
    [Column('DataAlteracao', ftDate)]
    [Dictionary('Dt Alteração', 'Favor informar a data de alteração', 'Date', '', '!##/##/####;1;_',taCenter)]
    property DataAlteracao: TDateTime read FDataAlteracao write FDataAlteracao;

    [ForeignKey('FK_ClienteId', 'Cliente_Id', 'Tab_Cliente', 'Id')]
    [Restrictions([NotNull])]
    [Column('Cliente_Id', ftInteger)]
    [Dictionary('Cliente Id', 'Favor informar o Id do cliente', '', '', '', taCenter)]
    property Cliente_Id: Integer read FCliente_Id write FCliente_Id;

    [Association(OneToOne, 'Cliente_Id', 'Tab_Cliente', 'Id')]
    property Cliente: TTab_Cliente read FCliente write FCliente;

    [Association(OneToMany, 'Id', 'Tab_Detalhe', 'Mestre_Id')]
    [CascadeActions([CascadeAutoInc, CascadeInsert, CascadeUpdate, CascadeDelete])]
    property Detalhe: TObjectList<TTab_Detalhe> read FDetalhe;

    [Restrictions([NoInsert, NoUpdate])]
    property PrecoTotal: Double read GetTotal;
  end;

implementation

{ TTab_Mestre }

constructor TTab_Mestre.Create;
begin
   FDetalhe := TObjectList<TTab_Detalhe>.Create;
   FCliente := TTab_Cliente.Create;
end;

destructor TTab_Mestre.Destroy;
begin
  FDetalhe.Free;
  FCliente.Free;
  inherited;
end;

function TTab_Mestre.GetTotal: Double;
var
  iFor: Integer;
begin
  Result := 0;
  for iFor := 0 to FDetalhe.Count -1 do
    Result := Result + FDetalhe.Items[iFor].Preco;
end;

initialization
  TRegisterClass.RegisterEntity(TTab_Mestre);

end.
