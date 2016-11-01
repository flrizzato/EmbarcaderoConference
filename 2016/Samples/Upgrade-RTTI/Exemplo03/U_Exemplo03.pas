unit U_Exemplo03;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_Cliente, Vcl.StdCtrls, U_GeraSQL;

type
  TF_Exemplo03 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Exemplo03: TF_Exemplo03;

implementation

{$R *.dfm}

procedure TF_Exemplo03.Button1Click(Sender: TObject);
var
   Cliente : TCliente;
begin
   Cliente := TCliente.Create;
   try
      Cliente.Codigo := 1;
      Cliente.RazaoSocial := 'Embarcadero Conference 2016';
      Cliente.CNPJ := '99999999999999';
      Cliente.Telefone := '1198765432';
      Cliente.ValorUltimaVenda := 10.200;
      ShowMessage( TGeraSQL.GetSQL(Cliente) );
   finally
      Cliente.Free;
   end;
end;

end.
