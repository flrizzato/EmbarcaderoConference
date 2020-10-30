unit ormbr.model.cliente;

interface

uses
  DB,
  Classes,
  /// orm
  ormbr.mapping.attributes,
  ormbr.types.mapping,
  ormbr.mapping.register;

type
  [Entity]
  [Table('Tab_Cliente','')]
  [PrimaryKey('Id', AutoInc, NoSort, True, 'Chave primária')]
  [Indexe('IDX_Nome', 'Nome')]
  [Sequence('SEQ_CLIENTE')]
  [OrderBy('Nome Desc')]
  TTab_Cliente = class
  private
    { Private declarations }
    FId: Integer;
    FNome: String;
//    FTelefone: String;
  public
    { Public declarations }
    [Restrictions([NoUpdate, NotNull])]
    [Column('Id', ftInteger)]
    [Dictionary('Cliente ID', 'Mensagem de validação', '', '', '', taCenter)]
    property ID: Integer read FId write FId;

    [Column('Nome', ftString, 40)]
    [Dictionary('Cliente Nome', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property Nome: string read FNome write FNome;

//    [Column('Telefone', ftString, 11)]
//    [Dictionary('Telefone', 'Mensagem de validação', '', '', '\(Oxx99\) 9 9999\-9999;0; ', taCenter)]
//    property Telefone: string read FTelefone write FTelefone;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TTab_Cliente);

end.
