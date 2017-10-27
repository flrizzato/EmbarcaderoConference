unit CustomerClass;

interface

uses
  MVCFramework.Serializer.Commons;

type
  [MVCNameCase(ncLowerCase)]
  TCustomer = class
  private
    FCompanyName: string;
    FCity: string;
    FCustomerID: string;
    FContactName: string;
  public
    property customerid: string read FCustomerID write FCustomerID;
    property companyname: string read FCompanyName write FCompanyName;
    property contactname: string read FContactName write FContactName;
    property city: string read FCity write FCity;
  end;

implementation

end.
