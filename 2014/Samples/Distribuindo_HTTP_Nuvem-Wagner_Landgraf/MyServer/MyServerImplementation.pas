unit MyServerImplementation;

interface

uses
  Generics.Collections,
  XData.Service.Common,
  MyServerOperations,
  DBDemosEntities;

type
  [ServiceImplementation]
  TCustomerMethods = class(TInterfacedObject, ICustomerMethods)
  public
    function FindOldByCountry(const CountryName: string; Years: integer): TList<TCustomer>;
  end;

implementation

uses
  System.SysUtils, System.DateUtils,
  XData.Server.Module,
  Aurelius.Criteria.Base,
  Aurelius.Criteria.Linq;

{ TCustomerMethods }

function TCustomerMethods.FindOldByCountry(const CountryName: string;
  Years: integer): TList<TCustomer>;
begin
  Result := TXDataOperationContext.Current.GetManager
    .Find<TCustomer>
    .Where(
      TLinq.Like('Country', '%' + CountryName + '%')
      and TLinq.LessThan('LastInvoiceDate', IncYear(Now, -Years))
    )
    .AddOrder(TOrder.Desc('LastInvoiceDate'))
    .List;
  end;

initialization
  RegisterServiceType(TCustomerMethods);
end.
