unit uCadPedidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, Data.Bind.Controls, FMX.Layouts, Fmx.Bind.Navigator, FMX.Grid,
  FMX.Controls.Presentation, FMX.Edit, uDmDados, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Fmx.Bind.Grid, Data.Bind.Grid;

type
  TFrmItens = class(TForm)
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    lblreg: TLabel;
    edtDescProd: TEdit;
    edtCodProd: TEdit;
    edtNF: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StringGrid1: TStringGrid;
    BindNavigator1: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    chkActive: TCheckBox;
    LinkControlToPropertyActive: TLinkControlToProperty;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

end.
