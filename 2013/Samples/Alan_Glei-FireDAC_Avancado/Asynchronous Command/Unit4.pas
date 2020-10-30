unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Vcl.StdCtrls, Data.Bind.Components,
  Data.Bind.Grid, Vcl.Grids, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, Vcl.ExtCtrls, FireDAC.VCLUI.Async, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.Samples.Spin, FireDAC.VCLUI.Error;

type
  TForm4 = class(TForm)
    FDConnection1: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    Open: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    procedure OpenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FDQuery1AfterGetRecords(DataSet: TFDDataSet);
    procedure FDQuery1BeforeOpen(DataSet: TDataSet);
    procedure FDQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FDQuery1AfterGetRecords(DataSet: TFDDataSet);
begin
  if RadioGroup1.ItemIndex = 1 then
  begin
    ProgressBar1.Style := pbstNormal;
  end;
end;

procedure TForm4.FDQuery1AfterOpen(DataSet: TDataSet);
begin
  if RadioGroup1.ItemIndex = 1 then
  begin
    DataSource1.DataSet := FDQuery1;
    FDQuery1.ResourceOptions.CmdExecMode := amBlocking;
  end;
end;

procedure TForm4.FDQuery1BeforeOpen(DataSet: TDataSet);
begin
  if RadioGroup1.ItemIndex = 1 then
  begin
    DataSource1.DataSet := nil;
  end;
end;

procedure TForm4.OpenClick(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0:
      begin
        FDQuery1.ResourceOptions.CmdExecMode := amBlocking;
        FDQuery1.ResourceOptions.CmdExecTimeout := 4294967295;
      end;
    1:
      begin
        FDQuery1.ResourceOptions.CmdExecMode := amAsync;
      end;
    2:
      begin
        FDQuery1.ResourceOptions.CmdExecMode := amCancelDialog;
      end;
    3:
      begin
        FDQuery1.ResourceOptions.CmdExecMode := amBlocking;
        FDQuery1.ResourceOptions.CmdExecTimeout := SpinEdit1.Value;
      end;
  end;
  if FDQuery1.Active then
  begin
    FDQuery1.Close();
  end;
  if RadioGroup1.ItemIndex = 1 then
  begin
    ProgressBar1.Style := pbstMarquee;
  end;
  try
    FDQuery1.Open();
  except
    on E: EFDException do
      if E.FDCode = 700 then
      begin
        Application.MessageBox('TimeOut!!!','Erro', MB_ICONERROR)
      end;
  end;

end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := TimeToStr(Now());
end;

end.
