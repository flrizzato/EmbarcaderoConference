unit uDM;

interface

uses
  SysUtils, Classes, DBXFirebird, DB, SqlExpr, WideStrings, Data.DBXMySQL;

type
  TDM = class(TDataModule)
    DBConn: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
