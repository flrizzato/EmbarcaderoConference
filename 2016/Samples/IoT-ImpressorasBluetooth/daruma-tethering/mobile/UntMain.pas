unit UntMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  System.Bluetooth,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.ListBox,
  System.Bluetooth.Components,
  FMX.Layouts,
  IPPeerClient,
  IPPeerServer,
  System.Tether.Manager,
  System.Tether.AppProfile,
  FMX.Objects,
  System.Actions,
  FMX.ActnList,
  FMX.StdActns,
  FMX.MediaLibrary.Actions,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.TabControl, FGX.ProgressDialog;


type
  TfrmPrincipal = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    lsboxServidores: TListBox;
    ImCaptured: TImage;
    btnEnviar: TButton;
    memTexto: TMemo;
    ToolBar2: TToolBar;
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    fgActivityDialog1: TfgActivityDialog;
    ListBox2: TListBox;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const ARemoteManagers: TTetheringManagerInfoList);
    procedure TetheringManager1EndProfilesDiscovery(const Sender: TObject;
      const ARemoteProfiles: TTetheringProfileInfoList);
    procedure TetheringManager1RemoteManagerShutdown(const Sender: TObject;
      const AManagerIdentifier: string);
    procedure FormShow(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FConectado : Boolean;
    procedure  ProcurarPrinterServer;
    function   EnviarParaImpressao: Boolean;
    procedure  AtualizarLista;
    procedure  ShowAguarde(AMensagem: String);
    procedure  HideAguarde;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

function TfrmPrincipal.EnviarParaImpressao: Boolean;
var
  LStream: TMemoryStream;
begin
  if not memTexto.Lines.Text.IsEmpty then
  begin
    if not FConectado then
      FConectado := TetheringAppProfile1.Connect(TetheringManager1.RemoteProfiles[lsboxServidores.ItemIndex]);

    LStream := TMemoryStream.Create;
    try
      memTexto.Lines.SaveToStream(LStream);
      Result := TetheringAppProfile1.SendStream(TetheringManager1.RemoteProfiles[lsboxServidores.ItemIndex], 'Texto do Mobile', LStream);
    finally
      LStream.Free;
    end;
  end
  else
  begin
    ShowMessage('Por favor, digite um texto para envio.');
  end;
end;

procedure TfrmPrincipal.TetheringManager1EndManagersDiscovery(
  const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
var
  I: Integer;
begin
  {Faz o pareamento com o servidor descoberto}
  for I := 0 to ARemoteManagers.Count - 1 do
    if (ARemoteManagers[I].ManagerText = 'PrinterServer') {or
      (ARemoteManagers[I].ManagerText = 'OutroServidor')} then
    begin
      TetheringManager1.PairManager(ARemoteManagers[I]);
      //ShowMessage('Manager Descoberto');
    end;
end;

procedure TfrmPrincipal.TetheringManager1EndProfilesDiscovery(
  const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList);
begin
  {Atualiza ListBox com os servidores descobertos}
  AtualizarLista;
end;

procedure TfrmPrincipal.TetheringManager1RemoteManagerShutdown(
  const Sender: TObject; const AManagerIdentifier: string);
begin
  {Atualiza novamente ListBox ao desconectar do servidor}
  AtualizarLista;
end;

procedure TfrmPrincipal.TetheringManager1RequestManagerPassword(
  const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  ShowAguarde('Localizando Servidores...');
  ProcurarPrinterServer;
  HideAguarde;
end;

procedure TfrmPrincipal.btnEnviarClick(Sender: TObject);
begin
  if lsboxServidores.ItemIndex >= 0
  then EnviarParaImpressao
  else ShowMessage('Por favor, selecione um servidor válido!');
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  ProcurarPrinterServer;
end;

procedure TfrmPrincipal.HideAguarde;
begin
  fgActivityDialog1.Hide;
end;

procedure TfrmPrincipal.ProcurarPrinterServer;
var
  I: Integer;
begin
  ShowAguarde('Localizando Servidores...');
  {Limpa ListBox}
  lsboxServidores.Items.Clear;
  {Limpa a lista de dispositivos encontrados}
  for I := TetheringManager1.PairedManagers.Count - 1 downto 0 do
    TetheringManager1.UnPairManager(TetheringManager1.PairedManagers[I]);
  {Procura por servidores na rede}
  TetheringManager1.DiscoverManagers;
  HideAguarde;
end;

procedure TfrmPrincipal.ShowAguarde(AMensagem: String);
begin
  fgActivityDialog1.Title       := 'Aguarde';
  fgActivityDialog1.Message     := AMensagem;
  fgActivityDialog1.Cancellable := False;
  fgActivityDialog1.Show;
end;

procedure TfrmPrincipal.AtualizarLista;
var
  I: Integer;
begin
  lsboxServidores.Items.Clear;
  for I := 0 to Pred(TetheringManager1.RemoteProfiles.Count) do
    if (TetheringManager1.RemoteProfiles[I].ProfileText = 'PrinterServer') {or
       (TetheringManager1.RemoteProfiles[I].ProfileText = 'OutroServidor')} then
    begin
      lsboxServidores.Items.Add(TetheringManager1.RemoteProfiles[I].ProfileText);
      //ShowMessage('Adicionado 1');
    end;

  if lsboxServidores.Count > 0 then
  begin
    lsboxServidores.ItemIndex := 0;
    FConectado := TetheringAppProfile1.Connect(TetheringManager1.RemoteProfiles[0]);
  end;
end;

end.
