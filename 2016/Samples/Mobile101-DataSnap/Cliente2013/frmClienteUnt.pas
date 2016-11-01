unit frmClienteUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Datasnap.DBClient,
  Datasnap.DSConnect, Data.DB, Data.SqlExpr, Data.DbxHTTPLayer, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Edit;

type
  TfrmCliente = class(TForm)
    DSPConn: TDSProviderConnection;
    cdsIDCliente: TClientDataSet;
    ToolBar1: TToolBar;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    dsConDistrimed: TSQLConnection;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.fmx}

procedure TfrmCliente.Button1Click(Sender: TObject);
begin

//DriverName=DataSnap
//DriverUnit=Data.DBXDataSnap
//Port=2013
//CommunicationProtocol=http
//DatasnapContext=datasnap/
//DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b
//HostName=localhost
  dsConDistrimed.Close;
  dsConDistrimed.Params.Values['HostName'] := '177.39.141.50';
  dsConDistrimed.Params.Values['Port'] := '3064';
  cdsIDCliente.Params[0].asString := Edit1.Text;
  cdsIDCliente.Open;


end;

end.
