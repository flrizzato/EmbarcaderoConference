unit uFrmPedidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.StdCtrls, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Grid, FMX.Layouts, Fmx.Bind.Grid, FMX.ListView.Types,
  FMX.ListView;

type
  TFrmPedidos = class(TForm)
    lblPedidos: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    DSProPedidos: TDSProviderConnection;
    cdsPedidos: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    cdsPedidosID: TIntegerField;
    cdsPedidosNUMERO: TStringField;
    cdsPedidosINCLUSAO: TSQLTimeStampField;
    cdsPedidosPREV_ENTREGA: TSQLTimeStampField;
    cdsPedidosENTREGA: TSQLTimeStampField;
    cdsPedidosSTATUS: TStringField;
    cdsPedidosVALOR_TOTAL: TFloatField;
    cdsPedidosCLIENTE: TIntegerField;
    cdsPedidossqlItensPedido: TDataSetField;
    lstPedidos: TListView;
    LinkListControlToField1: TLinkListControlToField;
    btnEdit: TSpeedButton;
    btnApply: TSpeedButton;
    GroupBox1: TGroupBox;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure lstPedidosClick(Sender: TObject);
  private
    FNomeForm: TForm;
    procedure SetNomeForm(const Value: TForm);
    { Private declarations }
  public
    property FormBack:TForm read FNomeForm write SetNomeForm;
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

{$R *.fmx}

uses uFrmPrincipal, uDMDados;

procedure TFrmPedidos.SetNomeForm(const Value: TForm);
begin
  FNomeForm := Value;
end;

procedure TFrmPedidos.SpeedButton1Click(Sender: TObject);
begin
  try
    cursor := crHourGlass;
    cdsPedidos.Close;
    cdsPedidos.Open;
  finally
    Cursor := crDefault;
  end;
end;

procedure TFrmPedidos.SpeedButton2Click(Sender: TObject);
begin
   Self.Hide;
   cdsPedidos.Close;
   cdsPedidos.Filter := '';
   cdsPedidos.Filtered := False;
   FormBack.Show;
end;

procedure TFrmPedidos.btnEditClick(Sender: TObject);
begin
   lstpedidos.EditMode := True;
   btnEdit.Enabled := False;
   btnApply.Enabled:= True;
end;

procedure TFrmPedidos.lstPedidosClick(Sender: TObject);
begin
//  lblPedidos.Text := cdsPedidosNUMERO.AsString;
end;

procedure TFrmPedidos.btnApplyClick(Sender: TObject);
begin
   lstpedidos.EditMode := False;
   btnEdit.Enabled := True;
   btnApply.Enabled:= False;
end;

end.
