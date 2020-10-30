unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Data.DB,
  Data.SqlExpr, Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, Datasnap.DBClient, Datasnap.DSConnect, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Edit;

type
  TFrmHome = class(TForm)
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    Label1: TLabel;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxGroupFooter1: TListBoxGroupFooter;
    ListBoxItem5: TListBoxItem;
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHome: TFrmHome;

implementation

{$R *.fmx}

uses uDMDados, uFrmClientes, uFrmProdutos, uFrmPedidos, uFrmconfig,
  uFrmBuscaCliente;

procedure TFrmHome.ListBoxItem1Click(Sender: TObject);
begin
     frmClientes.Show;
end;

procedure TFrmHome.ListBoxItem2Click(Sender: TObject);
begin
  frmProdutos.Show;
end;

procedure TFrmHome.ListBoxItem3Click(Sender: TObject);
begin
  FrmPedidos.Show;
  FrmPedidos.FormBack := Self;
end;

procedure TFrmHome.ListBoxItem4Click(Sender: TObject);
begin
  frmConfig.Show;
end;

procedure TFrmHome.ListBoxItem5Click(Sender: TObject);
begin
   FrmBuscaCliente.Show;
end;

end.
