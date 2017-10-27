unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TForm4 = class(TForm)
    ExtremedelphiConnection: TFDConnection;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    VendaprodutosTable: TFDQuery;
    VendaprodutosTableIdVenda: TIntegerField;
    VendaprodutosTableIdProduto: TIntegerField;
    VendaprodutosTableQtd: TBCDField;
    VendaprodutosTableValor: TBCDField;
    VendaprodutosTableSelecionado: TIntegerField;
    VendaprodutosTableValorTotal: TFloatField;
    VendaprodutosTableValorTotal1: TFloatField;
    VendaprodutosTableTotalVenda: TAggregateField;
    DBText1: TDBText;
    VendaprodutosTableQtdMarcado: TAggregateField;
    DBText2: TDBText;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure VendaprodutosTableSelecionadoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure VendaprodutosTableCalcFields(DataSet: TDataSet);
    procedure VendaprodutosTableTotalVendaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation


{$R *.dfm}

procedure TForm4.DBGrid1DblClick(Sender: TObject);
var
  Flag: Boolean;
begin
  if not (VendaprodutosTable.State in dsEditModes) then
  begin
    VendaprodutosTable.Edit();
  end;
  Flag := not Boolean(VendaprodutosTableSelecionado.Value);
  VendaprodutosTableSelecionado.Value := Integer(Flag);
  VendaprodutosTable.Post();
end;

procedure TForm4.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
  I: Byte;
begin
  inherited;
  if (not DataSource1.DataSet.IsEmpty) and (Column.FieldName = 'Selecionado') then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    Check := 0;
    if Column.Field.AsInteger = 1 then
    begin
      Check := DFCS_CHECKED;
    end
    else
    begin
      Check := 0;
    end;
    R := Rect;
    InflateRect(R, -2, -2);
    DrawFrameControl(DBGrid1.Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check);
  end;
end;

procedure TForm4.VendaprodutosTableCalcFields(DataSet: TDataSet);
begin
//  if VendaprodutosTable.State = dsInternalCalc then
//  begin
//    VendaprodutosTableValorTotal1.AsFloat := VendaprodutosTableQtd.AsFloat * VendaprodutosTableValor.AsFloat;
//  end;
end;

procedure TForm4.VendaprodutosTableSelecionadoGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
  begin
    Text := EmptyStr;
  end;
end;

procedure TForm4.VendaprodutosTableTotalVendaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if gbLast in VendaprodutosTable.GetGroupState(1) then
  begin
    Text := Sender.Value;
  end
  else
  begin
    Text := EmptyStr;
  end;
end;

end.
