unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.EMSProvider, REST.Backend.ServiceTypes, System.JSON,
  REST.Backend.EMSServices, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client, REST.Backend.EndPoint, FMX.ScrollBox, FMX.Memo,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, FMX.Edit,
  REST.Backend.MetaTypes, REST.Backend.BindSource,
  REST.Backend.ServiceComponents, FMX.Grid.Style, FMX.Grid,
  REST.Backend.EMSFireDAC, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.Stan.Error, Data.DB, FireDAC.Comp.DataSet,
  Fmx.Bind.Grid, Data.Bind.Grid, Data.Bind.DBScope, FireDAC.Stan.StorageJSON,
  FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
  TForm1 = class(TForm)
    EMSProvider1: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    btnExecute: TButton;
    Memo1: TMemo;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    btnLogin: TButton;
    BackendAuth1: TBackendAuth;
    Label1: TLabel;
    Label2: TLabel;
    StringGrid1: TStringGrid;
    EMSFireDACClient1: TEMSFireDACClient;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDTableAdapter1: TFDTableAdapter;
    FDMemTable1: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    btnCustomer: TButton;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure btnExecuteClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnCustomerClick(Sender: TObject);
begin
  EMSFireDACClient1.GetData;
end;

procedure TForm1.btnExecuteClick(Sender: TObject);
begin
  BackendEndpoint1.Execute;
end;

procedure TForm1.btnLoginClick(Sender: TObject);
begin
  BackendAuth1.UserName := edtUsuario.Text;
  BackendAuth1.Password := edtSenha.Text;
  BackendAuth1.Login;
end;

end.
