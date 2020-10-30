unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.Controls, Data.FMTBcd,
  DataSnap.DBClient, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.ObjectScope,
  Data.Bind.Components, Data.Bind.DBXScope, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Bind.Navigator, Data.Bind.DBScope;

type
  TForm1 = class(TForm)
    BindSourceDB1: TBindSourceDB;
    PrototypeBindSource1: TPrototypeBindSource;
    BindNavigator1: TBindNavigator;
    BindSourceDBX1: TBindSourceDBX;
    BindingsList1: TBindingsList;
    AdapterBindSource1: TAdapterBindSource;
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
