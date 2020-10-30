unit uCadClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, System.Rtti, FMX.Layouts, FMX.Grid,
  Data.Bind.Components, Data.Bind.ObjectScope, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Grid, uDmDados, System.Actions, FMX.ActnList, Data.Bind.Controls,
  Fmx.Bind.Navigator, uLoadObjetos, uClientes, System.Generics.Collections;

type
  TFrmCadClientes = class(TForm)
    edtCod: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    edtEndereco: TEdit;
    Label4: TLabel;
    edtEmail: TEdit;
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    Button4: TButton;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    StringGrid1: TStringGrid;
    ActionList1: TActionList;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    BindNavigator1: TBindNavigator;
    Button1: TButton;
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FLocCli: Integer;
    FListaClientes : TList<TClientes>;
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrmCadClientes.Button1Click(Sender: TObject);
begin
 FLocCli := 0;
 FListaClientes.Clear;
 AdapterBindSource1.Refresh;
 FListaClientes := TLoadObjetos.LoadClientes(FLocCli);
 AdapterBindSource1.Adapter := TListBindSourceAdapter<TClientes>.Create(Self, FListaClientes, False);
 AdapterBindSource1.Active := True;
end;

procedure TFrmCadClientes.Button4Click(Sender: TObject);
begin
 FLocCli := StrToInt(InputBox('Localizar Clientes','Informe o código do cliente que deseja localizar: ','0'));
 FListaClientes.Clear;
 AdapterBindSource1.Refresh;
 FListaClientes := TLoadObjetos.LoadClientes(FLocCli);
 AdapterBindSource1.Adapter := TListBindSourceAdapter<TClientes>.Create(Self, FListaClientes, False);
 AdapterBindSource1.Active := True;
end;

procedure TFrmCadClientes.FormCreate(Sender: TObject);
begin
 FListaClientes := TLoadObjetos.LoadClientes(FLocCli);
 AdapterBindSource1.Adapter        := TListBindSourceAdapter<TClientes>.Create(Self, FListaClientes, False);
 AdapterBindSource1.Adapter.Active := True;
end;

end.
