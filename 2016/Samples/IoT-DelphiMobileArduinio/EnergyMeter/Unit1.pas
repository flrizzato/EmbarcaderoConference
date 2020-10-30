unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Chart,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.TabControl,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Notification;

type
  TForm2 = class(TForm)
    Chart1: TChart;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Panel4: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image7: TImage;
    Image8: TImage;
    Desenvolvimento: TGroupBox;
    RH: TGroupBox;
    Image5: TImage;
    Image6: TImage;
    TabControl1: TTabControl;
    Config: TTabItem;
    Main: TTabItem;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    UDPClient: TIdUDPClient;
    ReqsTimer: TTimer;
    Label7: TLabel;
    NotificationCenter1: TNotificationCenter;
    Edit5: TEdit;
    Label8: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ReqsTimerTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    procedure conexao;
    function consumo(potencia: double;  minutos: integer): integer;
    procedure notifica;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormActivate(Sender: TObject);
begin
  Chart1.Title.Caption := 'Consumo de Energia Elétrica';
  Series1.Clear;
  Series1.Legend.Text := 'Lâmpada';
  Series2.Clear;
  Series2.Legend.Text := 'Mq. Café';
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
 UDPClient.Send('DW03-');
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
 UDPClient.Send('DW03+');
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
 UDPClient.Send('DW03L');
 image3.Visible := false;
 image4.Visible := true;
end;

procedure TForm2.Image4Click(Sender: TObject);
begin
 UDPClient.Send('DW03H');
 image4.Visible := false;
 image3.Visible := true;
end;

procedure TForm2.Image7Click(Sender: TObject);
begin
 UDPClient.Send('DW03L');
 image7.Visible := false;
 image8.Visible := true;
end;

procedure TForm2.Image8Click(Sender: TObject);
begin
 UDPClient.Send('DW03H');
 image8.Visible := false;
 image7.Visible := true;
end;

procedure TForm2.ReqsTimerTimer(Sender: TObject);
var potencia: double; result: string; min: integer;
begin
  UDPClient.Send('AR01');
  result := UDPClient.ReceiveString(700);
  if result <> 'TCOK' then
  begin
    potencia := (StrToFloat(StringReplace(result, ',', '.', []))/100)*strToInt(Edit4.Text);
    Series1.AddY((potencia));
    min := min + 1;
    if (potencia > strToInt(Edit5.Text)) then
    begin
      notifica;
    end;
  end;

end;

function TForm2.consumo(potencia: double; minutos: integer): integer;
var min, hor: integer;
begin
  hor:=0;
  while minutos > 60 do
  begin
    minutos := minutos -60;
    hor := hor + 1;
  end;
  min := minutos;
end;

procedure TForm2.notifica;
var MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  MyNotification.AlertBody := 'Alerta do consumo de energia!!';
  NotificationCenter1.PresentNotification(MyNotification);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  conexao;
  ReqsTimer.Enabled := true;
  TabControl1.TabIndex := 0;
end;

procedure TForm2.conexao;
var retorno: String;
begin
  UDPClient.Host := edit1.Text;
  UDPClient.Port := strToInt(edit2.Text);
  UDPClient.Connect;
  if UDPClient.Connected then
  begin
    UDPClient.Send('TC', nil);
    retorno := UDPClient.ReceiveString(80);
    ReqsTimer.Enabled := true;
    if retorno = 'TCOK' then
      label4.Text := 'Conectado'
    else
      label4.Text := 'Desconectado';
  end
  else
  begin
    label4.Text := 'Desconectado';
  end;

end;

end.
