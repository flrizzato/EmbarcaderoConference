unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Objects, FMX.DateTimeCtrls, FMX.Edit, FMX.ListBox,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.ListView.Types, FMX.ListView,
  Data.Bind.ObjectScope, Data.Bind.Components, System.Generics.Collections,
  Layer.Business, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, IPPeerClient, REST.OpenSSL,
  REST.Backend.ServiceTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, REST.Backend.Providers,
  REST.Backend.ServiceComponents, REST.Backend.BindSource,
  REST.Backend.KinveyProvider, Data.Bind.Controls, Fmx.Bind.Navigator,
  FMX.Controls.Presentation, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    tbListar: TTabItem;
    tbDetalhes: TTabItem;
    tbNovo: TTabItem;
    ToolBar1: TToolBar;
    Text1: TText;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    GoTbNovo: TChangeTabAction;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Edit1: TEdit;
    Edit2: TEdit;
    DateEdit1: TDateEdit;
    ToolBar2: TToolBar;
    Text2: TText;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GoTbListar: TChangeTabAction;
    ToolBar3: TToolBar;
    Text3: TText;
    SpeedButton5: TSpeedButton;
    ListView1: TListView;
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    BindingsList1: TBindingsList;
    BackendQuery1: TBackendQuery;
    BackendStorage1: TBackendStorage;
    SpeedButton4: TSpeedButton;
    GoDetalhes: TChangeTabAction;
    LinkListControlToField1: TLinkListControlToField;
    Text4: TText;
    Text5: TText;
    txtTelefone: TText;
    txtDataNascimento: TText;
    txtNome: TText;
    Text9: TText;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    SpeedButton6: TSpeedButton;
    KinveyProvider1: TKinveyProvider;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    myValoresLista: TObjectList<TCliente>;
    procedure ListarDados;
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
  myValoresLista := TObjectList<TCliente>.Create;
  ABindSourceAdapter := TListBindSourceAdapter<TCliente>.Create(self, myValoresLista, True);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := tbListar;
  TabControl1.TabPosition := TTabPosition.None;
end;

procedure TForm1.ListarDados;
var
  clientes: TBackendObjectList<TCliente>;
  QueryStr: TArray<string>;
  cliente: TCliente;
  oid: string;
begin
  //BackendQuery1.Execute;
  clientes := TBackendObjectList<TCliente>.Create;
  try
    QueryStr := TArray<string>.Create('');
    BackendStorage1.Storage.QueryObjects<TCliente>('Cliente', QueryStr, clientes);
    myValoresLista.Clear;
    for cliente in clientes do
    begin
      oid := clientes.EntityValues[cliente].ObjectID;
      myValoresLista.Add(TCliente.Create(cliente.Nome, cliente.Telefone, cliente.DataNascimento, oid));
    end;
  finally
    AdapterBindSource1.Refresh;
    clientes.Free;
  end;
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  GoDetalhes.ExecuteTarget(Self);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
Var
  LValue : TBackendEntityValue;
  cliente : TCliente;
begin
  cliente := TCliente.Create(Edit1.Text, Edit2.Text, DateEdit1.DateTime);
  try
    BackendStorage1.Storage.CreateObject<TCliente>('Cliente', cliente, LValue);
    Edit1.Text := '';
    Edit2.Text := '';
    DateEdit1.DateTime := Now;
    ListarDados;
  finally
    cliente.Free;
    GoTbListar.ExecuteTarget(Self);
  end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  ListarDados;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
var
  oid: string;
begin
  oid := myValoresLista[AdapterBindSource1.ItemIndex].GetOID;
  BackendStorage1.Storage.DeleteObject('Cliente', oid);
  ListarDados;
  GoTbListar.ExecuteTarget(Self);
end;

end.
