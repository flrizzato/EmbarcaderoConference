unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    eEchoStr: TEdit;
    Label2: TLabel;
    eFilter: TEdit;
    bEchoString: TButton;
    Label3: TLabel;
    seRecordsPerPage: TSpinEdit;
    Label4: TLabel;
    bGetCustomers: TButton;
    lblPage: TLabel;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    bPrior: TButton;
    bNext: TButton;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure bEchoStringClick(Sender: TObject);
    procedure bGetCustomersClick(Sender: TObject);
    procedure bPriorClick(Sender: TObject);
    procedure bNextClick(Sender: TObject);
  private
    FCurrentPage: Integer;
    function GetPageFilter: String;
    procedure GetData;
    procedure SetCurrentPage(const Value: Integer);
  public
    property CurrentPage: Integer read FCurrentPage write SetCurrentPage;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ClientModuleUnit1, Datasnap.DSClientRest;

procedure TForm1.bNextClick(Sender: TObject);
begin
  CurrentPage := CurrentPage + 1;
  GetData;
end;

procedure TForm1.bPriorClick(Sender: TObject);
begin
  CurrentPage := CurrentPage-1;
  GetData;
end;

procedure TForm1.bEchoStringClick(Sender: TObject);
begin
  Label3.Caption := ClientModule1.ServerMethods1Client.EchoString(eEchoStr.Text,
                                                                  eFilter.Text);
end;

function TForm1.GetPageFilter: String;
var
  Skip, Count: Integer;
begin
  if seRecordsPerPage.Value = 0 then
  begin
    bPrior.Enabled := False;
    bNext.Enabled := False;
    exit(EmptyStr);
  end
  else
  begin
    Count := seRecordsPerPage.Value;
    Skip  := (CurrentPage-1)*Count;

    bPrior.Enabled := CurrentPage > 1;
    bNext.Enabled := True;
    result := Format('t.r=%d,%d', [Skip, Count]);
  end;
end;

procedure TForm1.SetCurrentPage(const Value: Integer);
begin
  FCurrentPage := Value;
  lblPage.Caption := 'Page: ' + CurrentPage.ToString
end;

procedure TForm1.GetData;
var
  LCachedDataSet: TDSRestCachedDataSet;
  LDataSet: TDataSet;
  Filter: String;
begin
  Filter := GetPageFilter;
  LDataSet := ClientModule1.ServerMethods1Client.Customers(Filter);
  if not LDataSet.IsEmpty then
  begin
    FDMemTable1.CopyDataSet(LDataSet, [coStructure, coRestart, coAppend]);
    LDataSet.Close;
  end
  else
  begin
    CurrentPage := CurrentPage-1;
    bNext.Enabled := False;
  end;
end;

procedure TForm1.bGetCustomersClick(Sender: TObject);
begin
  CurrentPage := 1;
  GetData;
end;

end.
