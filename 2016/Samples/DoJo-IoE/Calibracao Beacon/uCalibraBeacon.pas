{
  Exemplo ditatico, ou seja, para colocar eu sua aplicação adapte conforme seu padrao de desenvolvimento
  duvidas: email: newton.oliveira@brtag.com.br
  skype: newton.michel
  telefone/whatsapp: +55(51)9235-8577
}
unit uCalibraBeacon;

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
  System.Beacon,
  System.Bluetooth,
  System.Beacon.Components,
  System.Math,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Edit,
  FMX.ScrollBox,
  FMX.Memo,
  uCCalibraBeacon;

type
  TfrmCalibrar = class(TForm)
    btnCalibrar: TButton;
    edtUUID: TEdit;
    lblUUID: TLabel;
    lytCalibrar: TLayout;
    lblMinor: TLabel;
    edtMinor: TEdit;
    lblMajor: TLabel;
    edtMajor: TEdit;
    Memo1: TMemo;
    lblLog: TLabel;
    btnPesquisarBeacon: TButton;
    Beacon2: TBeacon;
    lblMediaRSSI: TLabel;
    edtMediaRSSI: TEdit;
    procedure btnCalibrarClick(Sender: TObject);
    procedure btnPesquisarBeaconClick(Sender: TObject);
    procedure Beacon2BeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
  private
    dRSSI: Double;
    iRSSI: integer;
    bCalibrar: boolean;
    procedure Calibrando(const Sender: TObject; ACalibrado: boolean);
    function Calibra(txCalibratedPower, rssi: Double): Double;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalibrar: TfrmCalibrar;

  {
    Segue procedimento de calibração e medição de distância:

    Primeiramente o usuário deverá efetuar a calibração para 1 metro de distância, ou seja,
    - Coloque o chip a 1 metro de distância do smartphone e
    - Calcule a média de 10 amostras  dos valores de potência recebida (RSSI)
    Essa média será chamada de potencia_1_metro.

    Após a calibração, para calcular a distância faça as seguintes etapas:
    1. ratio_db = potencia_1_metro – potencia_recebida
    2. ratio_linear= 10 ^ (ratio_db/10)
    3. distancia = raiz_quadrada(ratio_linear)
  }

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

{ Esta função, será chamada sempre que um beacon for encontrado.
}
procedure TfrmCalibrar.Beacon2BeaconEnter(const Sender: TObject; const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
var
  log: string;
  lProximity: string;
begin

  if bCalibrar then
  begin
    if iRSSI > 9 then
    begin
      edtMediaRSSI.Text := FloatToStr(dRSSI / 10);
      Beacon2.Enabled := false;
      Memo1.Lines.Add('d:' + FloatToStr(Calibra(dRSSI / 10, ABeacon.rssi)));
    end
    else
    begin
      dRSSI := dRSSI + ABeacon.rssi;
      Memo1.Lines.Add(IntToStr(ABeacon.rssi));
      iNC(iRSSI);
      Beacon2.StartScan;
    end
  end
  else
  begin

    case ABeacon.Proximity of
      Immediate:
        lProximity := 'Ao Lado';
      Near:
        lProximity := 'Perto';
      Far:
        lProximity := 'Longe';
      Away:
        lProximity := 'Muito Longe';
    end;

    log := 'UUID:' + ABeacon.GUID.ToString() + #13 + #10 + ' Major:' + IntToStr(ABeacon.Major) + #13 + #10 + ' Minor:' + IntToStr(ABeacon.Minor) + #13 + #10 + ' Distancia:' +
      FloatToStr(ABeacon.Distance) + #13 + #10 + ' Onde esta?:' + lProximity + #13 + #10 + '-----------------------------------' + #13 + #10;
    Memo1.Lines.Add(log);
  end;
end;

procedure TfrmCalibrar.btnCalibrarClick(Sender: TObject);
var
  lCalibraBeacon: TCalibraBeacon;
begin
  lCalibraBeacon := TCalibraBeacon.create(edtUUID.Text, StrToIntDef(edtMinor.Text, -1), StrToIntDef(edtMajor.Text, -1));
  lCalibraBeacon.onCalibra := Calibrando;
  lCalibraBeacon.Calibra;
end;

procedure TfrmCalibrar.btnPesquisarBeaconClick(Sender: TObject);
var
  lBeaconRegionItem: TBeaconRegionItem;
begin
  bCalibrar := false;

  if Beacon2.Enabled then
    Beacon2.Enabled := false;

  Memo1.Lines.Clear;
  lBeaconRegionItem := TBeaconRegionItem.create(nil);
  lBeaconRegionItem.UUID := edtUUID.Text;

  Beacon2.MonitorizedRegions.Add;
  Beacon2.MonitorizedRegions.Items[0] := lBeaconRegionItem;

  Beacon2.Enabled := true;
  Beacon2.StartScan;

end;

{ Função que executa a calibração }
function TfrmCalibrar.Calibra(txCalibratedPower, rssi: Double): Double;
var
  ratio_db: Double;
  ratio_linear: Double;
  r: Double;
begin
  ratio_db := txCalibratedPower - rssi;
  ratio_linear := Power(10, ratio_db / 10);
  r := sqrt(ratio_linear);
  result := r;
end;

procedure TfrmCalibrar.Calibrando(const Sender: TObject; ACalibrado: boolean);
begin
  Memo1.Lines.Add('Coletando amostra de RSSI:' + IntToStr(TCalibraBeacon(Sender).count));
end;

end.
