unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm6 = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Panel2: TPanel;
    Button4: TButton;
    Button6: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses Dm;

procedure TForm6.Button1Click(Sender: TObject);
begin
  Dtm.Gravar();
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Dtm.Cancelar();
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  DataSource1.DataSet.Close();
  DataSource1.DataSet.Open();
  DataSource2.DataSet.Close();
  DataSource2.DataSet.Open();
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  Dtm.GravarJSON(Memo1.Lines.Text);
end;

procedure TForm6.Button6Click(Sender: TObject);
begin
  Memo1.Lines.Text := Dtm.GetClientes();
end;

end.
