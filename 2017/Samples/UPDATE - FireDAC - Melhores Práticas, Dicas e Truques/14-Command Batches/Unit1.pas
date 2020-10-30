unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Button1: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid4: TDBGrid;
    DBGrid5: TDBGrid;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := IntToStr(DataModule2.SQLNormal());
  Label1.Caption := Format('Total de Registros: %d',[DataSource1.DataSet.RecordCount]);
  Label2.Caption := Format('Total de Registros: %d',[DataSource2.DataSet.RecordCount]);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit2.Text := IntToStr(DataModule2.SQLBatches());
  Label4.Caption := Format('Total de Registros: %d',[DataSource1.DataSet.RecordCount]);
  Label5.Caption := Format('Total de Registros: %d',[DataSource2.DataSet.RecordCount]);
end;

end.
