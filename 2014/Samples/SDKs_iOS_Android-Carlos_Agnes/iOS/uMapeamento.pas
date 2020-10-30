unit uMapeamento;

interface

uses
  Macapi.ObjectiveC, iosapi.Foundation;

// classe          metodo estatico  metodo do objeto
// UITextInputMode.currentInputMode.primaryLanguage

type
  UITextInputMode = interface(NSObject)
    ['{9AEB5757-73EA-45F1-B24C-38A72144E5C3}']
    function primaryLanguage: NSString; cdecl;
  end;

  UITextInputModeClass = interface(NSObjectClass)
    ['{B0BC8691-2AF5-4C1B-BF77-9EDCC43984CB}']
    function currentInputMode: Pointer; cdecl;
  end;

  TUITextInputMode = class(
    TOCGenericImport<UITextInputModeClass, UITextInputMode>);

implementation

end.
