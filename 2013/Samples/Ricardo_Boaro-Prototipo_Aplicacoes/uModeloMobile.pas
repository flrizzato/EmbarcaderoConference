unit uModeloMobile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Fmx.Bind.GenData, Data.Bind.GenData, FMX.ListView.Types, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, FMX.ListView, FMX.Layouts,
  Fmx.Bind.Navigator, Data.Bind.ObjectScope;

type
  TForm3 = class(TForm)
    PrototypeBindSource1: TPrototypeBindSource;
    NavigatorPrototypeBindSource1: TBindNavigator;
    ListView1: TListView;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

end.
