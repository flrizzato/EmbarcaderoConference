unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls, FireDAC.Comp.DataSet, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.Client, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    CursofiredacConnection: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDQuery1IdCliente: TFDAutoIncField;
    FDQuery1Nome: TStringField;
    FDQuery1Logradouro: TStringField;
    FDQuery1Numero: TStringField;
    FDQuery1IdBairro: TIntegerField;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    FDMemTable1: TFDMemTable;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FDQuery1AfterScroll(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  if FDQuery1.ApplyUpdates(0) = 0 then
  begin
    FDQuery1.CommitUpdates();
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  FDQuery1.CancelUpdates();
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  FDMemTable1.FilterChanges := [];
  if CheckBox1.Checked then
  begin
    FDMemTable1.FilterChanges := FDMemTable1.FilterChanges + [rtInserted];
  end;
  if CheckBox2.Checked then
  begin
    FDMemTable1.FilterChanges := FDMemTable1.FilterChanges + [rtModified];
  end;
  if CheckBox3.Checked then
  begin
    FDMemTable1.FilterChanges := FDMemTable1.FilterChanges + [rtDeleted];
  end;
  FDMemTable1.Close();
  FDMemTable1.Data := FDQuery1.Delta;
  FDMemTable1.Open();
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  FDQuery1.UndoLastChange(True);
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  FDQuery1.RevertRecord();
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  ListBox1.Items.Add(IntToStr(FDQuery1.SavePoint));
end;

procedure TForm3.FDQuery1AfterScroll(DataSet: TDataSet);
begin
  case FDQuery1.UpdatesPending of
   True: Label1.Caption := 'Sim';
   False: Label1.Caption := 'Não';
  end;
  Label2.Caption := IntToStr(FDQuery1.ChangeCount);
end;

procedure TForm3.ListBox1DblClick(Sender: TObject);
begin
  FDQuery1.SavePoint := StrToInt(ListBox1.Items[ListBox1.ItemIndex]);
  ListBox1.DeleteSelected;
end;

end.
