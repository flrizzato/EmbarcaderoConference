unit uCadCidades;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  Fmx.Bind.Navigator, FMX.StdCtrls, System.Rtti, FMX.Grid, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid, uCidades,
  uLoadObjetos, uDmDados;

type
  TFrmCadCidades = class(TForm)
    Label1: TLabel;
    BindNavigator1: TBindNavigator;
    Label2: TLabel;
    edtCod: TEdit;
    edtNome: TEdit;
    Label3: TLabel;
    edtUF: TEdit;
    StringGrid1: TStringGrid;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

procedure TFrmCadCidades.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
 ABindSourceAdapter := TListBindSourceAdapter<TCidades>.Create(Self,TLoadObjetos.LoadCidades(0));
end;

end.
