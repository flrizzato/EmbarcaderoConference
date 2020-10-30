unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client;

type
  TForm4 = class(TForm)
    Con: TFDConnection;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  try
  Con.ExecSQL('insert into VendaProdutos (IdVenda, IdProduto, Qtd, Valor) values (:IdVenda, :IdProduto, :Qtd, :Valor)',
    [1,1,10,25]);
  except
    on E:Exception do
    begin
      Memo1.Lines.Text := E.Message;
    end;

//    on E:EFDDBEngineException do
//    begin
//      if E.Kind = ekUKViolated then
//      begin
//        Memo1.Lines.Text := 'Registro duplicado!' + #13#13 +
//          'SQL: ' + E.SQL + #13#13 +
//          'Mensagem Original:' + E.Message + #13#13 +
//          'Código: ' + E.ErrorCode.ToString() + #13#13 +
//          'Objeto:' + E.FDObjName;
//      end;
//    end;
  end;
end;

end.
