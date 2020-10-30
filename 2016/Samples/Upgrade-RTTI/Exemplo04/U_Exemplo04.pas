unit U_Exemplo04;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TF_Exemplo04 = class(TForm)
    Panel1: TPanel;
    MDocumento: TMemo;
    btnGerarDocto: TButton;
    procedure btnGerarDoctoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Exemplo04: TF_Exemplo04;

implementation

uses
  U_GeradorDocto, U_Linhas;

{$R *.dfm}

procedure TF_Exemplo04.btnGerarDoctoClick(Sender: TObject);
var
   oGeradorDocto : TGeradorDocto;
   oLinha000     : TLinha000;
   oLinha001     : TLinha001;
   oLinha002     : TLinha002;
   oLinha003     : TLinha003;
   oLinha999     : TLinha999;
   nCont         : Integer;
begin
   MDocumento.Lines.Clear;

   //Cria o Documento
   oGeradorDocto := TGeradorDocto.Create();
   try
      //Cria e Alimenta as Linhas do Documento
      oLinha000 := TLinha000.Create;
      oLinha000.DataGeracao := Now;
      oGeradorDocto.Add(oLinha000);

      oLinha001 := TLinha001.Create;
      oLinha001.NomeContador := 'Contador da Conference';
      oLinha001.CRCContador  := '1234567890';
      oGeradorDocto.Add(oLinha001);

      oLinha002 := TLinha002.Create;
      oLinha002.NomeEmpresa := 'Minha Empresa de Testes';
      oLinha002.CNPJ := '99999999999999';
      oGeradorDocto.Add(oLinha002);

      for nCont := 1 to 5 do
      begin
         oLinha003 := TLinha003.Create;
         oLinha003.DataVenda := Now;
         oLinha003.NomeCliente := Format('Cliente %d', [nCont]);
         oLinha003.ValorVenda := nCont * 1.2;
         oGeradorDocto.Add(oLinha003);
      end;

      oLinha999 := TLinha999.Create;
      oGeradorDocto.Add(oLinha999);

      //Gera o Documento no Memo
      MDocumento.Lines.Text := oGeradorDocto.GerarDocumento;
   finally
      oGeradorDocto.Free;
   end;
end;

end.
