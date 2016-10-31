unit Modules.FirebirdConnection;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Data.SqlExpr;

type
  TFirebirdConnectionModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
  private
  public
  end;

var
  FirebirdConnectionModule: TFirebirdConnectionModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
