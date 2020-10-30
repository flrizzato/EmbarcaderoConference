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
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.ListBox,
  FMX.Layouts,
  System.Bluetooth,
  System.Bluetooth.Components,
  FMX.Objects,
  FGX.ProgressDialog;

//Passo 1 - Constante relacionada ao GUID para impressoras Bluetooth
const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

type
  TfrmPrincipal = class(TForm)
    bthDispositivos: TBluetooth;
    cbxDevices: TComboBox;
    Button1: TButton;
    Button2: TButton;
    lblConectado: TLabel;
    Button3: TButton;
    ListBox1: TListBox;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ToolBar1: TToolBar;
    Label2: TLabel;
    Label3: TLabel;
    fgActivityDialog1: TfgActivityDialog;
    crlConectado: TCircle;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    //Passo 3 - Listar os dispositivos JÁ pareados
    procedure CarregarDispositivos;
    function  CarregarImpressoraPorNome(ANomeImpressora: String): TBluetoothDevice;
    function  ConectarImpressora(ANomeImpressora: String): boolean;
    { Private declarations }
  public
    { Public declarations }

    //Passo 2 - Criar variável. Esta será usada para enviar comandos para a impressora
    FSocket : TBluetoothSocket;

    procedure ShowAguarde(const AMessage: String);
    procedure HideAguarde;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  CarregarDispositivos;
end;

procedure TfrmPrincipal.CarregarDispositivos;
var
  Dispositivo: TBluetoothDevice;
begin
  ShowAguarde('Listando...');

  cbxDevices.Clear;
  for Dispositivo in bthDispositivos.PairedDevices do
    cbxDevices.Items.Add(Dispositivo.DeviceName);

  (*
  if cbxDevices.Items.Count > 0 then
    cbxDevices.ItemIndex := 0;
  *)

  HideAguarde;
end;

function TfrmPrincipal.CarregarImpressoraPorNome(ANomeImpressora: String): TBluetoothDevice;
var
  Dispositivo: TBluetoothDevice;
begin
  Result := nil;
  for Dispositivo in bthDispositivos.PairedDevices do
    if Dispositivo.DeviceName = ANomeImpressora then
      Result := Dispositivo;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  ShowAguarde('Conectando...');

  if (cbxDevices.Selected <> nil) and (cbxDevices.Selected.Text <> '') then
  begin
    //Testa se conegue conectar à impressora
    if ConectarImpressora(cbxDevices.Selected.Text) then
    begin
      lblConectado.Text := '  Conectado a Impressora';
      crlConectado.Fill.Color := TAlphaColorRec.Lime;
    end
    else
    begin
      lblConectado.Text := '  Não conectado';
      crlConectado.Fill.Color := TAlphaColorRec.Red;
    end;
  end
  else
    ShowMessage('Selecione um dispositivo');

  HideAguarde;
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
  procedure Centralizar;
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(97) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(8)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(16)));
  end;

  procedure Titulo;
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(32)));
  end;

  procedure Normal;
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(0)));
  end;
begin
  if (FSocket <> nil) and (FSocket.Connected) then
  begin
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(64)));
    Centralizar;
    Titulo;

    FSocket.SendData(TEncoding.UTF8.GetBytes('EC 2016' + chr(13)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));

    FSocket.SendData(TEncoding.UTF8.GetBytes('----------------' + chr(13)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(33) + chr(0)));

    Centralizar;
    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('MASTERCARD'));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));

    Centralizar;
    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('DEBITO A VISTA'));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));

    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('Via Cliente> CPF: 266.452.608-15'));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(0)));

    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('SAO PAULO - SP'));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(0)));

    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('DOC-705890  - ' + FormatDateTime('DD/MM/YY',Date) + ' - '  + FormatDateTime('HH:MM',Time)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(0)));

    Normal;
    FSocket.SendData(TEncoding.UTF8.GetBytes('Valor:     12,50'));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(1)));

    Centralizar;
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(97) + chr(0)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(5)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(29) + chr(107) + chr(2) + '8920183749284' + chr(0)));
    FSocket.SendData(TEncoding.UTF8.GetBytes(chr(27) + chr(100) + chr(5)));
  end;
end;

function TfrmPrincipal.ConectarImpressora(ANomeImpressora: String): Boolean;
var
  Dispositivo: TBluetoothDevice;
begin
  Result := False;
  Dispositivo := CarregarImpressoraPorNome(ANomeImpressora);
  if Dispositivo <> nil then
  begin
    FSocket := Dispositivo.CreateClientSocket(StringToGUID(UUID), False);
    if FSocket <> nil then
    begin
      FSocket.Connect;
      Result := FSocket.Connected;
    end;
  end;
end;

procedure TfrmPrincipal.HideAguarde;
begin
  fgActivityDialog1.Hide;
end;

procedure TfrmPrincipal.ShowAguarde(const AMessage: String);
begin
  fgActivityDialog1.Title       := 'Aguarde';
  fgActivityDialog1.Message     := AMessage;
  fgActivityDialog1.Cancellable := False;
  fgActivityDialog1.Show;
end;

end.
