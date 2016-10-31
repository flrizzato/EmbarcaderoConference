unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uPerson, Data.Bind.Components, Data.Bind.ObjectScope, System.Rtti,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Grid, FMX.Layouts, Fmx.Bind.Navigator, FMX.Grid,
  System.Generics.Collections;

type
  TForm1 = class(TForm)
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    NavigatorAdapterBindSource1: TBindNavigator;
    StringGrid1: TStringGrid;
    LinkGridToDataSourceAdapterBindSource12: TLinkGridToDataSource;
    Switch1: TSwitch;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
    //MyPerson : TPerson;
    MyPersonList: TObjectList<TPerson>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
//  MyPerson := TPerson.Create('Fred', 'Flintstone', 40);
//  ABindSourceAdapter := TObjectBindSourceAdapter<TPerson>.Create(self, MyPerson, True);

  MyPersonList := TObjectList<TPerson>.Create;

  MyPersonList.Add(TPerson.Create('Fred', 'Flintstone', 40));
  MyPersonList.Add(TPerson.Create('Wilma', 'Flintstone', 41));
  MyPersonList.Add(TPerson.Create('Barney', 'Rubble', 40));
  MyPersonList.Add(TPerson.Create('Betty', 'Rubble', 39));

  ABindSourceAdapter := TListBindSourceAdapter<TPerson>.Create(self, MyPersonList, True);
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  AdapterBindSource1.Active := Switch1.IsChecked;
end;

end.
