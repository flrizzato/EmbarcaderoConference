unit uFrmProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.ListBox, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmProdutos = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    ListBox1: TListBox;
    SearchBox1: TSearchBox;
    DSProProdutos: TDSProviderConnection;
    cdsProdutos: TClientDataSet;
    cdsProdutosID: TIntegerField;
    cdsProdutosDESCRICAO: TStringField;
    cdsProdutosESTOQUE: TFloatField;
    cdsProdutosPRECO: TFloatField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.fmx}

uses uDMDados, uFrmPrincipal;

procedure TfrmProdutos.SpeedButton1Click(Sender: TObject);
begin
  try
    cursor := crHourGlass;
    cdsProdutos.Close;
    cdsProdutos.Open;
  finally
    Cursor := crDefault;
  end;
end;

procedure TfrmProdutos.SpeedButton2Click(Sender: TObject);
begin
   Self.Hide;
   FrmHome.Show;
end;

end.
