unit MyServerOperations;

interface

uses
  Generics.Collections,
  XData.Service.Common,
  DBDemosEntities;

type
  [ServiceContract]
  ICustomerMethods = interface(IInvokable)
  ['{8A441D74-668F-4AE5-8946-4F93A8AD7821}']
    function FindOldByCountry(const CountryName: string; Years: integer): TList<TCustomer>;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(ICustomerMethods));
end.
