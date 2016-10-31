unit PhoneTools;

interface

uses
  Entities,
  Aurelius.Engine.ObjectManager;

type
  TPhoneTools = class
  public
    class procedure UpdateCountryCodes(Include: boolean);
    class procedure IncludeCountryCode(Contact: TContact);
    class procedure ExcludeCountryCode(Contact: TContact);

    class procedure UpdateCountryCodesSQL(Include: boolean);
  end;

implementation

uses
  SqlExpr,
  SysUtils,
  Aurelius.Criteria.Base,
  Aurelius.Criteria.Linq,
  Modules.Connections;

{ TPhoneTools }

class procedure TPhoneTools.ExcludeCountryCode(Contact: TContact);
var
  Prefix: string;
begin
  if Contact.Phone.IsNull or Contact.Customer.Country.CountryCode.IsNull then Exit;

  Prefix := '+' + IntToStr(Contact.Customer.Country.CountryCode) + ' ';
  if Copy(Contact.Phone, 1, Length(Prefix)) = Prefix then
    Contact.Phone := Copy(Contact.Phone, Length(Prefix) + 1, MaxInt);
end;

class procedure TPhoneTools.IncludeCountryCode(Contact: TContact);
begin
  if Contact.Phone.IsNull or Contact.Customer.Country.CountryCode.IsNull then Exit;

  if Copy(Contact.Phone, 1, 1) <> '+' then
    Contact.Phone := '+' + IntToStr(Contact.Customer.Country.CountryCode) + ' ' + Contact.Phone;
end;

class procedure TPhoneTools.UpdateCountryCodes(Include: boolean);
var
  Manager: TObjectManager;
  Contacts: ICriteriaCursor;
begin
  Manager := TObjectManager.Create(Connections.DefaultConnection);
  try
    Contacts := Manager.Find<TContact>.Open;
    while Contacts.Next do
      if Include then
        IncludeCountryCode(TContact(Contacts.Fetch))
      else
        ExcludeCountryCode(TContact(Contacts.Fetch));
    Manager.Flush;
  finally
    Manager.Free;
  end;
end;

class procedure TPhoneTools.UpdateCountryCodesSQL(Include: boolean);
var
  Contacts: TSQLQuery;
  Exec: TSQLQuery;
  Prefix: string;
  NewPhone: string;
begin
  Contacts := TSQLQuery.Create(nil);
  Exec := TSQLQuery.Create(nil);
  try
    Contacts.SQLConnection := nil; // set some connection here
    Exec.SQLConnection := nil; // set some connection here

    Contacts.SQL.Text := 'Select Con.Id, Con.Phone, Ct.Country_Code '+
      'from Contact Con Left Join Customer Cust On (Cust.Id = Con.Customer_id) '+
      '     Left Join Country Ct On (Ct.Id = Cust.Country_ID) ';
    Contacts.Open;
    while not Contacts.EOF do
    begin
      if not Contacts.FieldByName('Country_Code').IsNull and not Contacts.FieldByName('Phone').IsNull then
      begin
        if Include then
        begin
          // include country code
          if Copy(Contacts.FieldByName('Phone').AsString, 1, 1) <> '+' then
          begin
            NewPhone := '+' + Contacts.FieldByName('Country_Code').AsString + ' ' +
              Contacts.FieldByName('Phone').AsString;

            Exec.SQL.Text := 'Update Contact Set Phone = :newphone Where Id = :id';
            Exec.ParamByName('newphone').AsString := NewPhone;
            Exec.ParamByName('id').AsInteger := Contacts.FieldByName('Id').AsInteger;
            Exec.ExecSQL;
          end;
        end else
        begin
          // exclude country code
          Prefix := '+' + Contacts.FieldByName('Country_Code').AsString + ' ';
          if Copy(Contacts.FieldByName('Phone').AsString, 1, Length(Prefix)) = Prefix then
          begin
            NewPhone := Copy(Contacts.FieldByName('Phone').AsString, Length(Prefix) + 1, MaxInt);

            Exec.SQL.Text := 'Update Contact Set Phone = :newphone Where Id = :id';
            Exec.ParamByName('newphone').AsString := NewPhone;
            Exec.ParamByName('id').AsInteger := Contacts.FieldByName('Id').AsInteger;
            Exec.ExecSQL;
          end;
        end;
      end;
      Contacts.Next;
    end;
  finally
    Contacts.Free;
    Exec.Free;
  end;
end;

end.
