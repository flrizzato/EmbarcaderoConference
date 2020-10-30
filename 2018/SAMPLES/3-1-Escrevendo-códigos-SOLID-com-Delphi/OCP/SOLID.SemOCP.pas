unit SOLID.SemOCP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormSemOCP = class(TForm)
  private
    procedure SelecionarPrimeirosClientes(const ABancoDados: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSemOCP: TFormSemOCP;

implementation

{$R *.dfm}

{ TForm2 }

procedure TFormSemOCP.SelecionarPrimeirosClientes(const ABancoDados: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    if ABancoDados = 'Oracle' then
      Query.Open('SELECT * FROM Clientes WHERE rownum <= 100')
    else if ABancoDados = 'Firebird' then
      Query.Open('SELECT FIRST 100 * FROM CLIENTES')
    else if ABancoDados = 'SQL Server' then
      Query.Open('SELECT TOP 100 * FROM CLIENTES')
    else if ABancoDados = 'PostgreSQL' then
      Query.Open('SELECT * FROM CLIENTES LIMIT 100');

    { ... }
  finally
    Query.Free;
  end;
end;

end.
