unit uDmDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, Data.DB, FireDAC.Comp.Client, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, System.Generics.Collections, uClientes, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FMX.Types, FMX.Controls, FireDAC.Phys.ODBCBase;

type
  TDataModule1 = class(TDataModule)
    TesteConnection: TFDConnection;
  private
    { Private declarations }
  public
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}



end.
