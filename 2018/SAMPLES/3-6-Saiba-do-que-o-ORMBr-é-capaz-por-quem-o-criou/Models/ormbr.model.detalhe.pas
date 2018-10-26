unit ormbr.model.detalhe;

interface

uses
  Classes, 
  DB,
  /// orm
  ormbr.mapping.attributes,
  ormbr.types.mapping,
  ormbr.model.status,
  ormbr.mapping.register;

type
  [Entity]
  [Table('Tab_Detalhe','')]
  [PrimaryKey('Id; Mestre_Id', 'Chave primária')]
  [AggregateField('AggPRECO','SUM(PRECO * 2)', taRightJustify, '#,###,##0.00')]
  TTab_Detalhe = class
  private
    { Private declarations }
    FId: Integer;
    FMestre_Id: Integer;
    FStatus_Id: Integer;
    FObservacao: String;
    FStatus_Descricao: string;
    FPreco: Double;
    FPrecos: Double;
    procedure SetPrecos(const Value: Double);
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('Id', ftInteger)]
    [Dictionary('Detalhe Id','Mensagem de validação','','','',taCenter)]
    property Id: Integer read FId write FId;

    [Restrictions([NotNull])]
    [Column('Mestre_Id', ftInteger)]
    [ForeignKey('FK_MestreID', 'Mestre_Id', 'Tab_Mestre', 'Id', Cascade, Cascade)]
    [Dictionary('Mestre Id','Id da tabela mestre é obrigatório','','','',taCenter)]
    property Mestre_Id: Integer read FMestre_Id write FMestre_Id;

    [Restrictions([NotNull])]
    [Column('Status_Id', ftInteger)]
    [ForeignKey('FK_StatusID', 'Status_Id', 'Tab_Status', 'Id', None, None)]
    [Dictionary('ID Status','Mensagem de validação','0','','',taCenter)]
    property Status_Id: Integer read FStatus_Id write FStatus_Id;

    [Column('Observacao', ftString, 30)]
    [Dictionary('Observaçao','Mensagem de validação','','','',taLeftJustify)]
    property Observacao: string read FObservacao write FObservacao;

    [Restrictions([NotNull])]
    [Column('Preco', ftBCD, 18, 3)]
    [Dictionary('Preço Unitário','O valor do preço deve ser mairo ou igual a ZERO','0','#,###,##0.00','',taRightJustify)]
    property Preco: Double read FPreco write FPreco;

    [CalcField('CALPRECOS', ftBCD, 0)]
    [Dictionary('Campo Calculado','','','#,###,##0.00','',taRightJustify)]
    property Precos: Double read FPrecos write SetPrecos;
  end;

implementation

{ TTab_Detalhe }

procedure TTab_Detalhe.SetPrecos(const Value: Double);
begin
  FPrecos := Value * 2;
end;

initialization
  TRegisterClass.RegisterEntity(TTab_Detalhe);

end.
