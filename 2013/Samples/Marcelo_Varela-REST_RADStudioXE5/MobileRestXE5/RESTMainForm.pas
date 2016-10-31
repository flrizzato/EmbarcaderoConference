unit RESTMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, IPPeerClient, FMX.ListView.Types, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FMX.Layouts, FMX.Memo, Data.Bind.Components, FMX.Edit,
  FMX.ListView, Data.Bind.DBScope, Data.DB, Datasnap.DBClient,
  REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope, FMX.ListBox;

type
  TTabbedForm = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    RESTResponse: TRESTResponse;
    RESTRequest: TRESTRequest;
    RESTClient: TRESTClient;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    ListView1: TListView;
    BindingsList1: TBindingsList;
    Memo1: TMemo;
    Button1: TButton;
    LinkListControlToField1: TLinkListControlToField;
    ClientDataSet: TClientDataSet;
    BindSourceDB2: TBindSourceDB;
    DetailsListView: TListView;
    ClientDataSetLastName: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure RESTRequestAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure RESTResponseDataSetAdapterBeforeOpenDataSet(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TabbedForm: TTabbedForm;

implementation

{$R *.fmx}

uses
  REST.Json;

procedure TTabbedForm.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;
end;

procedure TTabbedForm.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  i: Integer;
  Field: TField;
  item: TListViewItem;
  lName, lValue: TLabel;
begin
  DetailsListView.ClearItems;
  for Field in ClientDataSet.Fields do
  begin
    item := DetailsListView.Items.Add;
    item.Text := Field.FieldName + ': ' + ClientDataSet.FieldByName(Field.FieldName).AsString;
  end;
  TabControl1.ActiveTab := TabItem4;
end;

procedure TTabbedForm.Button1Click(Sender: TObject);
begin
  RESTResponseDataSetAdapter.FieldDefs.Clear;
  RESTRequest.Execute;
end;

procedure TTabbedForm.RESTRequestAfterExecute(Sender: TCustomRESTRequest);
begin
  if assigned(RESTResponse.JSONValue) then
  begin
    memo1.Lines.Text := TJson.Format(RESTResponse.JSONValue)
  end
  else
  begin
    memo1.Lines.Text := RESTResponse.Content;
  end;
  TabControl1.ActiveTab := TabItem2;
  ClientDataSet.Open;
end;

procedure TTabbedForm.RESTResponseDataSetAdapterBeforeOpenDataSet(
  Sender: TObject);
begin
  ClientDataSet.CreateDataSet;
end;

end.
