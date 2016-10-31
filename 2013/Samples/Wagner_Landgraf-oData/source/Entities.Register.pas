unit Entities.Register;

interface

implementation

uses
  Aurelius.Mapping.Explorer,
  Aurelius.Mapping.Setup,
  Entities;

procedure RegisterEntityClasses;
var
  Setup: TMappingSetup;
begin
  Setup := TMappingSetup.Create;
  try
    Setup.MappedClasses.RegisterClass(TCustomer);
    Setup.MappedClasses.RegisterClass(TCountry);
    Setup.MappedClasses.RegisterClass(TContact);
    TMappingExplorer.ReplaceDefaultInstance(TMappingExplorer.Create(Setup));
  finally
    Setup.Free;
  end;
end;

initialization
  RegisterEntityClasses;
end.
