unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Datasnap.DBClient, Datasnap.DSConnect, Data.SqlExpr,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm2 = class(TForm)
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    ClientDataSet1EMP_NO: TSmallintField;
    ClientDataSet1FIRST_NAME: TStringField;
    ClientDataSet1LAST_NAME: TStringField;
    ClientDataSet1PHONE_EXT: TStringField;
    ClientDataSet1HIRE_DATE: TSQLTimeStampField;
    ClientDataSet1DEPT_NO: TStringField;
    ClientDataSet1JOB_CODE: TStringField;
    ClientDataSet1JOB_GRADE: TSmallintField;
    ClientDataSet1JOB_COUNTRY: TStringField;
    ClientDataSet1SALARY: TBCDField;
    ClientDataSet1FULL_NAME: TStringField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  ClientDataSet1.Close;
  ClientDataSet1.Open;
end;

end.
