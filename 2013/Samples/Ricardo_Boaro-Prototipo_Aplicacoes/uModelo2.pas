unit uModelo2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.GenData, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, Vcl.ExtCtrls, Data.Bind.Components, Vcl.Buttons,
  Vcl.Bind.Navigator, Vcl.StdCtrls, Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    EditDateField1: TEdit;
    LinkControlToFieldDateField1: TLinkControlToField;
    NavigatorPrototypeBindSource1: TBindNavigator;
    BindingsList1: TBindingsList;
    EditCurrencyField1: TEdit;
    LinkControlToFieldCurrencyField1: TLinkControlToField;
    ImageContactBitmapL1: TImage;
    LinkControlToFieldContactBitmapL1: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
