unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Layouts, FMX.ListBox,
  FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, System.Tether.TCPProtocol,
  FMX.Edit, System.Tether.NetworkAdapter, System.Tether.BluetoothAdapter;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    btnEnviar: TButton;
    btnConectar: TButton;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    Label1: TLabel;
    edtNumero: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const ARemoteManagers: TTetheringManagerInfoList);
    procedure TetheringManager1EndAutoConnect(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
  private
    { Private declarations }
    FIsConnected : Boolean;
    procedure CheckRemoteProfiles;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

uses
  REST.JSON,  uNotaFiscal, uDM_ModuloEnvio;

procedure TForm1.Button1Click(Sender: TObject);
var
  Nota : TNFCe;
  ArrayProd : ArrayProdutos;
begin
  SetLength(ArrayProd,1);

  Nota := TNFCe.Create;
  Nota.Empresa.RazaoSocial  := 'NASAJON SISTEMAS LTDA';
  Nota.Empresa.NomeFantasia := 'NASAJON SISTEMAS LTDA';
  Nota.Empresa.CNPJ         := '27915735000100';
  Nota.Empresa.IE           := 'ISENTO';
  Nota.Empresa.Endereco     := 'Avenida Rio Branco';
  Nota.Empresa.Numero       := '45';
  Nota.Empresa.Bairro       := 'CENTRO';
  Nota.Empresa.CEP          := '20003090';
  Nota.Empresa.UF           := 'RJ';
  Nota.Empresa.CodigoUF     := 33;
  Nota.Empresa.Municipio    := 'Rio de Janeiro';
  Nota.Empresa.CodigoMunicipio := 3304557;

  Nota.natOp      := 'Venda de Mercadoria';
  Nota.Serie      := '331';
  Nota.Numero     := edtNumero.Text;
  Nota.dEmi       := now;
  Nota.CFOP       := 5102;

  Nota.Produtos   := ArrayProd;
  Nota.Produtos[0] := TProdutoNFCe.Create;
  Nota.Produtos[0].cProd := '123';
  Nota.Produtos[0].xProd := 'TESTE';
  Nota.Produtos[0].NCM   := '48185000';
  Nota.Produtos[0].CFOP  := 5102;
  Nota.Produtos[0].uCom  := 'UN';
  Nota.Produtos[0].qCom  := 1;
  Nota.Produtos[0].vUnCom:= 100;
  Nota.Produtos[0].vProd := 100;
  Nota.Produtos[0].vBC   := 100;
  Nota.Produtos[0].Aliquota := 19;
  Nota.Produtos[0].ValorICMS := 19;

  Nota.ValorBase  := 100.00;
  Nota.ValorICMS  := 19.00;
  Nota.ValorProd  := 100.00;
  Nota.ValorDesc  := 0.00;
  Nota.ValorNota  := 100.00;

  memo1.Lines.Text :=  TJson.ObjectToJsonString( NOta );

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  nfce : TNFCe;
begin
   nfce := TJson.JsonToObject<TNFCe>(memo1.Lines.Text);
   showmessage(nfce.natOp);

end;

procedure TForm1.btnEnviarClick(Sender: TObject);
var
   LStream: TMemoryStream;
   NFCe : TStringList;
begin
  Try
    Button1Click(nil);
    LStream := TMemoryStream.Create;
    NFCe := TStringList.Create;
    NFCe.Text := memo1.Lines.Text;
    NFCe.SaveToStream(LStream);

    TetheringAppProfile1.SendStream(TetheringManager1.RemoteProfiles[0],
      'NFCe', LStream);
  Finally
    ShowMessage('enviado');
  End;
end;

procedure TForm1.btnConectarClick(Sender: TObject);
begin
  Timer1.Enabled := true;
  TetheringManager1.AutoConnect();
end;

procedure TForm1.TetheringManager1EndAutoConnect(Sender: TObject);
begin
  btnEnviar.Enabled := true;
end;

procedure TForm1.TetheringManager1EndManagersDiscovery(const Sender: TObject;
  const ARemoteManagers: TTetheringManagerInfoList);
begin
  btnEnviar.Enabled := true;
end;

procedure TForm1.TetheringManager1RequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CheckRemoteProfiles;
end;

procedure TForm1.CheckRemoteProfiles;
var
  I: Integer;
  ConnectedProfiles : String;
begin
  if TetheringManager1.RemoteProfiles.Count > 0 then
  begin
    for I := 0 to TetheringManager1.RemoteProfiles.Count - 1 do
    begin
      ConnectedProfiles := ConnectedProfiles + ' - ' + TetheringManager1.RemoteProfiles.Items[I].ProfileText;
    end;
    Label1.Text := 'Conectado ao :' + ConnectedProfiles;
    FIsConnected := true;
  end
  else
  begin
    Label1.Text := 'Não está conectado';
    FIsConnected := false;
  end;
end;

end.
