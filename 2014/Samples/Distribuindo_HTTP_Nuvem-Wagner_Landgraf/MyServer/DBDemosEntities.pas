unit DBDemosEntities;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob;

type
  [Entity, Automapping]
  [Id('FCustNo', TIdGenerator.None)]
  TCustomer = class
  private
    FCustno: double;
    FCompany: string;
    [Column('Addr1', [])]
    FAddr1: string;
    [Column('Addr2', [])]
    FAddr2: string;
    FCity: string;
    FState: string;
    FZip: string;
    FCountry: string;
    FPhone: string;
    FFax: string;
    FTaxrate: double;
    FContact: string;
    FLastinvoicedate: TDateTime;
  public
    property Custno: double read FCustno write FCustno;
    property Company: string read FCompany write FCompany;
    property Addr1: string read FAddr1 write FAddr1;
    property Addr2: string read FAddr2 write FAddr2;
    property City: string read FCity write FCity;
    property State: string read FState write FState;
    property Zip: string read FZip write FZip;
    property Country: string read FCountry write FCountry;
    property Phone: string read FPhone write FPhone;
    property Fax: string read FFax write FFax;
    property Taxrate: double read FTaxrate write FTaxrate;
    property Contact: string read FContact write FContact;
    property Lastinvoicedate: TDateTime read FLastinvoicedate write FLastinvoicedate;
  end;

  [Entity, Automapping]
  [Id('FSpeciesNo', TIdGenerator.None)]
  TBiolife = class
  private
    FSpeciesNo: double;
    FCategory: string;
    FCommonName: string;
    FSpeciesName: string;
    [Column('LENGTH__CM_', [])]
    FLengthCm: double;
    FLengthIn: double;
    FNotes: TBlob;
    FGraphic: TBlob;
  public
    property SpeciesNo: double read FSpeciesNo write FSpeciesNo;
    property Category: string read FCategory write FCategory;
    property CommonName: string read FCommonName write FCommonName;
    property SpeciesName: string read FSpeciesName write FSpeciesName;
    property LengthCm: double read FLengthCm write FLengthCm;
    property LengthIn: double read FLengthIn write FLengthIn;
    property Notes: TBlob read FNotes write FNotes;
    property Graphic: TBlob read FGraphic write FGraphic;
  end;

implementation

initialization
  RegisterEntity(TCustomer);
  RegisterEntity(TBiolife);
end.
