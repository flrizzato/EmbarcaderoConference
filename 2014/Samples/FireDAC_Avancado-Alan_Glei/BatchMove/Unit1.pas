unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.StdCtrls, FireDAC.Comp.BatchMove.Text, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.VCLUI.Wait, FireDAC.Phys.ODBCBase,
  FireDAC.Comp.UI, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Vcl.Grids, Data.Bind.DBScope, Vcl.DBGrids, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    ProgressBar1: TProgressBar;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Progresso(Ativar: Boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Dm;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Dtm.GetDados();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Dtm.TableToTxt();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Dtm.TxtToTable;
  Dtm.GetDados();
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Dtm.TableToTable();
end;

procedure TForm1.Progresso(Ativar: Boolean);
begin
  case Ativar of
    True: ProgressBar1.Style := pbstMarquee;
    False: ProgressBar1.Style := pbstNormal;
  end;

end;

end.
