unit AqDrop.DB.Base.Exceptions;

interface

uses
  AqDrop.Core.Exceptions;

type
  EAqFieldValidationError = class(EAqFriendly)
  strict private
    FClass: TClass;
    FFieldName: string;
  public
    constructor Create(const pMessage: string; const pClass: TClass; const pFieldName: string);

    property &Class: TClass read FClass;
    property FieldName: string read FFieldName;
  end;

  EAqEmptyStringField = class(EAqFieldValidationError)
  public
    constructor Create(const pClass: TClass; const pFieldName: string);
  end;

  EAqNotPositiveIntegerField = class(EAqFieldValidationError)
  public
    constructor Create(const pClass: TClass; const pFieldName: string);
  end;

implementation

{ EAqFieldValidationError }

constructor EAqFieldValidationError.Create(const pMessage: string; const pClass: TClass; const pFieldName: string);
begin
  inherited Create(pMessage);

  FClass := pClass;
  FFieldName := pFieldName;
end;

{ EAqEmptyStringField }

constructor EAqEmptyStringField.Create(const pClass: TClass; const pFieldName: string);
begin
  inherited Create('Field ' + pFieldName + ' must not be empty.', pClass, pFieldName);
end;

{ EAqNegativeOrZeroIntegerField }

constructor EAqNotPositiveIntegerField.Create(const pClass: TClass; const pFieldName: string);
begin
  inherited Create('Field ' + pFieldName + ' must be informed with a positive number.', pClass, pFieldName);
end;

end.
