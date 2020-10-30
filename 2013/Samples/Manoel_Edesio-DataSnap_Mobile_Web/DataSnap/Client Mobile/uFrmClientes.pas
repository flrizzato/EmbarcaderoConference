unit uFrmClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.ListBox,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, FMX.ListView.Types, FMX.ListView;

type
  TfrmClientes = class(TForm)
    DSProClientes: TDSProviderConnection;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    cdsClientes: TClientDataSet;
    cdsClientesID: TIntegerField;
    cdsClientesNOME: TStringField;
    cdsClientesENDERECO: TStringField;
    cdsClientesCIDADE: TStringField;
    cdsClientesESTADO: TStringField;
    cdsClientesTELEFONE: TStringField;
    dsClientes: TDataSource;
    BindSourceDB1: TBindSourceDB;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.fmx}

uses uDMDados, uFrmPrincipal, uFrmPedidos, uFrmIncClientes;

procedure TfrmClientes.ListView1Click(Sender: TObject);
begin
  try
    cursor := crHourGlass;
    FrmPedidos.cdsPedidos.Close;
    FrmPedidos.cdsPedidos.Filtered := False;
    FrmPedidos.cdsPedidos.Filter   := 'CLIENTE=' +  cdsClientesID.AsString;
    FrmPedidos.cdsPedidos.Filtered := True;
    FrmPedidos.cdsPedidos.Open;
    FrmPedidos.Show;
    FrmPedidos.FormBack := Self;
  finally
    Cursor := crDefault;
  end;
end;

procedure TfrmClientes.SpeedButton1Click(Sender: TObject);
begin
  try
    cursor := crHourGlass;
    cdsClientes.Close;
    cdsClientes.Open;
  finally
    Cursor := crDefault;
  end;
end;

procedure TfrmClientes.SpeedButton2Click(Sender: TObject);
begin
   Self.Hide;
   FrmHome.Show;
end;

procedure TfrmClientes.SpeedButton3Click(Sender: TObject);
begin
  frmincClientes.Show;
end;

end.
