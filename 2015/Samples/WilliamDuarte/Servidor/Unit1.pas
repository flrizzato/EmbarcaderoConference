unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, Vcl.StdCtrls, ACBrMail,
  ACBrNFeDANFEClass, ACBrBase, ACBrDFe,
  ACBrNFe,pcnConversao, ACBrNFeDANFeRLClass, ACBrDANFCeFortesFr;

type
  TForm1 = class(TForm)
    TetheringManager1: TTetheringManager;
    Memo1: TMemo;
    TetheringAppProfile1: TTetheringAppProfile;
    ACBrNFe1: TACBrNFe;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    ACBrNFeDANFeRL1: TACBrNFeDANFeRL;
    ACBrNFeDANFCeFortes1: TACBrNFeDANFCeFortes;
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TetheringAppProfile1Resources0ResourceReceived(
      const Sender: TObject; const AResource: TRemoteResource);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uNotaFiscal, REST.JSON, pcnConversaoNFe,
  System.Tether.NetworkAdapter, System.Bluetooth, System.Bluetooth.Components,
  System.Tether.BluetoothAdapter;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := ACBrNFe1.SSL.SelecionarCertificado;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  nfce : TNFCe;
  i,j : integer;
begin

  nfce := TJson.JsonToObject<TNFCe>(memo1.Lines.Text);

  ACBrNFe1.Configuracoes.Geral.ModeloDF := moNFCe;

  with ACBrNFe1.NotasFiscais.Add.NFe do
   begin
     Ide.cNF       := StrToInt(nfce.Numero);
     Ide.natOp     := nfce.natOp;
     Ide.indPag    := ipVista;
     Ide.modelo    := 65;

     Ide.serie     := StrToInt(nfce.Serie);
     Ide.nNF       := StrToInt(nfce.Numero);
     Ide.dEmi      := now;
     Ide.dSaiEnt   := now;
     Ide.hSaiEnt   := now;
     Ide.tpNF      := tnSaida;
     Ide.tpEmis    := TpcnTipoEmissao(0); ;
     Ide.tpAmb     := taHomologacao;
     Ide.cUF       := UFtoCUF(nfce.Empresa.UF);
     Ide.cMunFG    := nfce.Empresa.CodigoMunicipio;
     Ide.finNFe    := fnNormal;
     Ide.tpImp     := tiNFCe;
     Ide.indFinal  := cfConsumidorFinal;
     Ide.indPres   := pcPresencial;

     Emit.CNPJCPF           := nfce.Empresa.CNPJ;
     Emit.IE                := '82448209';
     Emit.xNome             := nfce.Empresa.RazaoSocial;
     Emit.xFant             := nfce.Empresa.NomeFantasia;

     Emit.EnderEmit.fone    := nfce.Empresa.Telefone;
     Emit.EnderEmit.CEP     := StrToInt(nfce.Empresa.CEP);
     Emit.EnderEmit.xLgr    := nfce.Empresa.Endereco;
     Emit.EnderEmit.nro     := nfce.Empresa.Numero;
     Emit.EnderEmit.xCpl    := nfce.Empresa.Complemento;
     Emit.EnderEmit.xBairro := nfce.Empresa.Bairro;
     Emit.EnderEmit.cMun    := nfce.Empresa.CodigoMunicipio;
     Emit.EnderEmit.xMun    := nfce.Empresa.Municipio;
     Emit.EnderEmit.UF      := nfce.Empresa.UF;
     Emit.enderEmit.cPais   := 1058;
     Emit.enderEmit.xPais   := 'BRASIL';

     Emit.IEST              := '';

     Emit.CRT               := crtRegimeNormal;// (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)

    for I := Low(nfce.Produtos) to High(nfce.Produtos) do
    begin
      with Det.Add do
       begin
         Prod.nItem    := i+1; // Número sequencial, para cada item deve ser incrementado
         Prod.cProd    := nfce.Produtos[i].cProd;
         Prod.cEAN     := nfce.Produtos[i].cEANTrib;
         Prod.xProd    := nfce.Produtos[i].xProd;
         Prod.NCM      := nfce.Produtos[i].NCM;
         Prod.EXTIPI   := '';
         Prod.CFOP     := IntToStr(nfce.Produtos[i].CFOP);
         Prod.uCom     := nfce.Produtos[i].uCom;
         Prod.qCom     := nfce.Produtos[i].qCom;
         Prod.vUnCom   := nfce.Produtos[i].vUnCom;
         Prod.vProd    := nfce.Produtos[i].vProd;

         Prod.cEANTrib  := nfce.Produtos[i].cEANTrib;
         Prod.uTrib     := nfce.Produtos[i].ucom;
         Prod.qTrib     := nfce.Produtos[i].qCom;
         Prod.vUnTrib   := nfce.Produtos[i].vUnCom;

         Prod.vOutro    := nfce.Produtos[i].vOutro;
         Prod.vDesc     := nfce.Produtos[i].vDesc;

         with Imposto do
          begin
            // lei da transparencia nos impostos
            vTotTrib := 0;

            with ICMS do
             begin
               CST          := cst00;
               ICMS.orig    := oeNacional;
               ICMS.modBC   := dbiValorOperacao;
               ICMS.vBC     := nfce.Produtos[i].vBC;
               ICMS.pICMS   := nfce.Produtos[i].Aliquota;
               ICMS.vICMS   := nfce.Produtos[i].ValorICMS;
               ICMS.modBCST := dbisMargemValorAgregado;
               ICMS.pMVAST  := 0;
               ICMS.pRedBCST:= 0;
               ICMS.vBCST   := 0;
               ICMS.pICMSST := 0;
               ICMS.vICMSST := 0;
               ICMS.pRedBC  := 0;
             end;
          end;
       end ;
    end;

      Total.ICMSTot.vBC     := nfce.ValorBase;
      Total.ICMSTot.vICMS   := nfce.ValorICMS;
      Total.ICMSTot.vBCST   := 0;
      Total.ICMSTot.vST     := 0;
      Total.ICMSTot.vProd   := nfce.ValorProd;
      Total.ICMSTot.vFrete  := 0;
      Total.ICMSTot.vSeg    := 0;
      Total.ICMSTot.vDesc   := nfce.ValorDesc;
      Total.ICMSTot.vII     := 0;
      Total.ICMSTot.vIPI    := 0;
      Total.ICMSTot.vPIS    := 0;
      Total.ICMSTot.vCOFINS := 0;
      Total.ICMSTot.vOutro  := 0;
      Total.ICMSTot.vNF     := nfce.ValorNota;

      Transp.modFrete := mfSemFrete; // NFC-e não pode ter FRETE

      for J := Low(NFCe.Pagamentos) to High(NFCe.Pagamentos) do
        begin
          with pag.Add do //PAGAMENTOS apenas para NFC-e
            begin
              tPag := TpcnFormaPagamento( nfce.Pagamentos[j].codigo );
              vPag := nfce.Pagamentos[j].valor;
            end;
        end;

      InfAdic.infCpl     :=  '';
      InfAdic.infAdFisco :=  '';

   end;

   ACBrNFe1.Configuracoes.Certificados.NumeroSerie := Edit1.Text;

    ACBrNFe1.Configuracoes.Arquivos.PathSchemas :=
      'C:\HomePC\Palestras\EConf2015\ACBrNFCeTether\NFCe\Servidor\Win32\Debug\Schemas';

    ACBrNFe1.NotasFiscais[0].Assinar;

    ACBrNFe1.Enviar(1,True)
end;

procedure TForm1.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
Memo1.Lines.LoadFromStream(AResource.Value.AsStream);

if Memo1.Lines.Text <> '' then
  begin
    Button2Click(Button2);
  end;
end;

procedure TForm1.TetheringAppProfile1Resources0ResourceReceived(
  const Sender: TObject; const AResource: TRemoteResource);
begin
  Memo1.Lines.LoadFromStream(AResource.Value.AsStream);
end;

procedure TForm1.TetheringManager1RequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

end.
