unit Entities;

{$SCOPEDENUMS ON}

interface

uses
  Generics.Collections,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy;

type
  TContact = class;

  [Entity, Automapping]
  TCountry = class
  private
    FName: string;
    FId: integer;
    FCountryCode: Nullable<integer>;
  public
    property Id: integer read FId write FId;
    property Name: string read FName write FName;
    property CountryCode: Nullable<integer> read FCountryCode write FCountryCode;
  end;

  TCustomerType = (Individual, Store);

  [Entity, Automapping]
  TCustomer = class
  private
    FName: string;
    FState: Nullable<string>;
    FId: integer;
    FCountry: TCountry;
    FCity: Nullable<string>;
    FCustomerType: TCustomerType;

    [ManyValuedAssociation([TAssociationProp.Lazy], CascadeTypeAll, 'FCustomer')]
    FContacts: Proxy<TList<TContact>>;
    function GetContacts: TList<TContact>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: integer read FId write FId;
    property Name: string read FName write FName;
    property City: Nullable<string> read FCity write FCity;
    property State: Nullable<string> read FState write FState;
    property Country: TCountry read FCountry write FCountry;
    property CustomerType: TCustomerType read FCustomerType write FCustomerType;
    property Contacts: TList<TContact> read GetContacts;
  end;

  [Entity, Automapping]
  TContact = class
  private
    FName: string;
    FPhone: Nullable<string>;
    FId: integer;
    FCustomer: TCustomer;
  public
    property Id: integer read FId write FId;
    property Name: string read FName write FName;
    property Phone: Nullable<string> read FPhone write FPhone;
    property Customer: TCustomer read FCustomer write FCustomer;
  end;

implementation

uses
  Aurelius.Global.Config;

{ TCustomer }

constructor TCustomer.Create;
begin
  FContacts.SetInitialValue(TList<TContact>.Create);
end;

destructor TCustomer.Destroy;
begin
  FContacts.DestroyValue;
  inherited;
end;

function TCustomer.GetContacts: TList<TContact>;
begin
  Result := FContacts.Value;
end;

initialization
  TGlobalConfigs.GetInstance.AutoMappingMode := TAutomappingMode.Full;
end.
