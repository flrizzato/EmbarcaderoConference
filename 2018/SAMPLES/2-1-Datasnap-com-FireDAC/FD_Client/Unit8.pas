unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls;

type
  TForm8 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DBNavigator1: TDBNavigator;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses Dm;

{ TForm8 }


procedure TForm8.Button1Click(Sender: TObject);
begin
  Dtm.Gravar();
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  Dtm.Cancelar();
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
  Dtm.GetClientes();
end;

procedure TForm8.Button4Click(Sender: TObject);
begin
  Dtm.GetTelefones();
end;

procedure TForm8.Button5Click(Sender: TObject);
begin
  Dtm.GetClientesTelefones();
end;

end.
