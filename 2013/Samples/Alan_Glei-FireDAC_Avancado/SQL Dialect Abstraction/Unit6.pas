unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TBanco = (Interbase, SqlServer);

  TForm6 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure Getdados(Banco: TBanco);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
  Getdados(TBanco.Interbase);
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Getdados(TBanco.SqlServer);
end;

procedure TForm6.Getdados(Banco: TBanco);
begin
  FDConnection1.Close();
  case Banco of
    Interbase:
      begin
        FDConnection1.Params.Values['Database'] :=
          'localhost:C:\Programacao\EC 2013\Exempos\DB\EC-2013.GDB';
        FDConnection1.Params.Values['User_Name'] := 'sysdba';
        FDConnection1.Params.Values['Password'] := 'masterkey';
        FDConnection1.Params.Values['DriverID'] := 'IB';
      end;
    SqlServer:
      begin
        FDConnection1.Params.Values['Database'] := 'EC-2013';
        FDConnection1.Params.Values['User_Name'] := 'sa';
        FDConnection1.Params.Values['Password'] := '732154al';
        FDConnection1.Params.Values['Server'] := 'localhost';
        FDConnection1.Params.Values['OSAuthent'] := 'No';
        FDConnection1.Params.Values['DriverID'] := 'MSSQL';
      end;
  end;
  FDQuery1.Close();
  FDQuery1.SQL.Assign(Memo1.Lines);
  FDQuery1.Open();
end;

end.
