unit FPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, System.Bluetooth,
  System.Bluetooth.Components, FMX.Controls.Presentation, FMX.StdCtrls, uThreadControle, uComum, FMX.Layouts,
  FMX.ListBox, Data.DB, Datasnap.DBClient, Cromis.Multitouch.Custom, Androidapi.JNI.JavaTypes, FMX.Effects,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.Ani, FMX.Filter.Effects;

type

  TForm3 = class(TForm)
    Bluetooth1: TBluetooth;
    BtnFrente: TImage;
    BtnRe: TImage;
    BtnEsquerda: TImage;
    BtnDireita: TImage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Image1: TImage;
    ActionList1: TActionList;
    NextTabAction1: TNextTabAction;
    Image2: TImage;
    Image3: TImage;
    Layout1: TLayout;
    Layout2: TLayout;
    Image4: TImage;
    ShadowEffect1: TShadowEffect;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    EfeitoBtnEsquerda: TFloatAnimation;
    EfeitoBtnDireita: TFloatAnimation;
    EfeitoBtnFrente: TFloatAnimation;
    EfeitoBtnRe: TFloatAnimation;
    ToolBar1: TToolBar;
    BtnVoltar: TButton;
    PreviousTabAction1: TPreviousTabAction;
    procedure FormTouch(Sender: TObject; const Touches: TTouches; const Action: TTouchAction);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
    ListaDevicesPariados: TBluetoothDeviceList;
    ListaServicos: TBluetoothServiceList;
    Socket: TBluetoothSocket;
    FThreadControle: ThreadControle;
    FComandos: TComandos;
    FUltimosComandos: TComandos;

    FOStream: JOutputStream;
    FIStream: JInputstream;

    procedure Ligar();
    procedure OnTouchEvent(const Event: TTouchEvent);
    procedure TouchToAction(const Points: TTouchPoints);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  Android.JNI.Toast;

const
  MAC = '00:13:EF:D6:8E:79';
//MAC = '00:13:EF:D6:85:58'; // Adriano Santos

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm3.FormCreate(Sender: TObject);
begin
   InitializeTouchListener;
   TouchEventListener.AddHandler(OnTouchEvent);
end;

procedure TForm3.FormTouch(Sender: TObject; const Touches: TTouches; const Action: TTouchAction);
var
  I: Integer;
begin
  if not Assigned(FThreadControle) then
  begin
    Exit
  end;

  FComandos := [];

  for I := Low(Touches) to High(Touches) do
  begin
    if BtnFrente.PointInObject(Touches[I].Location.X, Touches[I].Location.Y) then
    begin
      if Action = TTouchAction.Up then
      begin
        Include(FComandos, TComando.PararFrente);
        Exclude(FComandos, TComando.Frente);
      end
      else if (Action = TTouchAction.Down) or (Action = TTouchAction.Move) then
      begin
        Include(FComandos, TComando.Frente);
        Exclude(FComandos, TComando.PararFrente);
      end;
    end
    else if BtnRe.PointInObject(Touches[I].Location.X, Touches[I].Location.Y) then
    begin
      if Action = TTouchAction.Up then
      begin
        Include(FComandos, TComando.PararRe);
        Exclude(FComandos, TComando.Re);
      end
      else if (Action = TTouchAction.Down) or (Action = TTouchAction.Move) then
      begin
        Include(FComandos, TComando.Re);
        Exclude(FComandos, TComando.PararRe);
      end;
    end
    else if BtnDireita.PointInObject(Touches[I].Location.X, Touches[I].Location.Y) then
    begin
      if Action = TTouchAction.Up then
      begin
        Include(FComandos, TComando.AlinharDireita);
        Exclude(FComandos, TComando.Direita);
      end
      else if (Action = TTouchAction.Down) or (Action = TTouchAction.Move) then
      begin
        Include(FComandos, TComando.Direita);
        Exclude(FComandos, TComando.AlinharDireita);
      end;
    end
    else if BtnEsquerda.PointInObject(Touches[I].Location.X, Touches[I].Location.Y) then
    begin
      if Action = TTouchAction.Up then
      begin
        Include(FComandos, TComando.AlinharEsuqerda);
        Exclude(FComandos, TComando.Esquerda);
      end
      else if (Action = TTouchAction.Down) or (Action = TTouchAction.Move) then
      begin
        Include(FComandos, TComando.Esquerda);
        Exclude(FComandos, TComando.AlinharEsuqerda);
      end;
    end;
  end;

  FUltimosComandos := FThreadControle.Comandos;

  if (FComandos * [TComando.Frente] = []) and (FUltimosComandos * [TComando.Frente] <> []) then
  begin
    Include(FComandos, TComando.PararFrente);
  end;
  if (FComandos * [TComando.Re] = []) and (FUltimosComandos * [TComando.Re] <> []) then
  begin
    Include(FComandos, TComando.PararRe);
  end;
  if (FComandos * [TComando.Esquerda] = []) and (FUltimosComandos * [TComando.Esquerda] <> []) then
  begin
    Include(FComandos, TComando.AlinharEsuqerda);
  end;
  if (FComandos * [TComando.Direita] = []) and (FUltimosComandos * [TComando.Direita] <> []) then
  begin
    Include(FComandos, TComando.AlinharDireita);
  end;

   EfeitoBtnFrente.Enabled := TComando.Frente in FComandos;
   EfeitoBtnRe.Enabled := TComando.Re in FComandos;
   EfeitoBtnEsquerda.Enabled := TComando.Esquerda in FComandos;
   EfeitoBtnDireita.Enabled := TComando.Direita in FComandos;

  if FComandos <> [] then
  begin
    FThreadControle.Comandos := FComandos;
  end;
end;

procedure TForm3.Image1Click(Sender: TObject);
begin
  // Utilizando Componente Bluetooth
  Ligar();

  // Utilizando Classe nativa do Android
//   if DoConnect(MAC,FIStream,FOStream) then
//   begin
//   FThreadControle := ThreadControle.Create(True);
//   FThreadControle.ControlStream := FOStream;
//   FThreadControle.FreeOnTerminate := False;
//   FThreadControle.Start();
//   NextTabAction1.ExecuteTarget(Self);
//   end;
end;

procedure TForm3.Ligar;
const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';
var
  Device: TBluetoothDevice;
  I: Integer;
begin
  FComandos := [];
  ListaDevicesPariados := Bluetooth1.PairedDevices();
  if ListaDevicesPariados.Count = 0 then
  begin
    Exit;
  end;
  for Device in ListaDevicesPariados do
  begin
    if Device.Address = MAC then
    begin
      Break
    end;
  end;
  Toast('Conectando com ' + MAC);
  ListaServicos := Device.LastServiceList;
  for I := 0 to ListaServicos.Count - 1 do
  begin
    //ListBox1.Items.Add(ListaServicos[I].UUID.ToString);
    if ListaServicos[I].UUID.ToString = UUID then
    begin
      Break;
    end;
  end;

  Socket := Device.CreateClientSocket(ListaServicos[I].UUID, False);
  if Socket <> nil then
  begin
    Socket.Connect();
    Toast('Conectado!');
    FThreadControle := ThreadControle.Create(True);
    FThreadControle.Socket := Socket;
    FThreadControle.FreeOnTerminate := False;
    FThreadControle.Start();
    NextTabAction1.ExecuteTarget(Self);
  end;
end;

procedure TForm3.OnTouchEvent(const Event: TTouchEvent);
begin
  if not Assigned(FThreadControle) then
  begin
    Exit;
  end;

  TouchToAction(TTouchPoints(Event.Points));

   EfeitoBtnFrente.Enabled := TComando.Frente in FComandos;
   EfeitoBtnRe.Enabled := TComando.Re in FComandos;
   EfeitoBtnEsquerda.Enabled := TComando.Esquerda in FComandos;
   EfeitoBtnDireita.Enabled := TComando.Direita in FComandos;

  if FComandos <> [] then
  begin
    FThreadControle.Comandos := FComandos;
  end;
end;

procedure TForm3.TouchToAction(const Points: TTouchPoints);
var
  I: Integer;
  mPosition: TPointF;
begin
  FComandos := [];
  for I := 0 to Length(Points) - 1 do
  begin
    mPosition := Points[I].Position;
    if BtnFrente.PointInObject(mPosition.X, mPosition.Y) then
    begin
      if pfTouchUp in Points[I].Flags then
        Include(FComandos, TComando.PararFrente)
      else
        Include(FComandos, TComando.Frente);
    end;
    if BtnRe.PointInObject(mPosition.X, mPosition.Y) then
    begin
      if pfTouchUp in Points[I].Flags then
        Include(FComandos, TComando.PararRe)
      else
        Include(FComandos, TComando.Re);
    end;
    if BtnEsquerda.PointInObject(mPosition.X, mPosition.Y) then
    begin
      if pfTouchUp in Points[I].Flags then
        Include(FComandos, TComando.AlinharEsuqerda)
      else
        Include(FComandos, TComando.Esquerda);
    end;
    if BtnDireita.PointInObject(mPosition.X, mPosition.Y) then
    begin
      if pfTouchUp in Points[I].Flags then
        Include(FComandos, TComando.AlinharDireita)
      else
        Include(FComandos, TComando.Direita);
    end;
  end;

  FUltimosComandos := FThreadControle.Comandos;

  if (FComandos * [TComando.Frente] = []) and (FUltimosComandos * [TComando.Frente] <> []) then
  begin
    Include(FComandos, TComando.PararFrente);
  end;
  if (FComandos * [TComando.Re] = []) and (FUltimosComandos * [TComando.Re] <> []) then
  begin
    Include(FComandos, TComando.PararRe);
  end;
  if (FComandos * [TComando.Esquerda] = []) and (FUltimosComandos * [TComando.Esquerda] <> []) then
  begin
    Include(FComandos, TComando.AlinharEsuqerda);
  end;
  if (FComandos * [TComando.Direita] = []) and (FUltimosComandos * [TComando.Direita] <> []) then
  begin
    Include(FComandos, TComando.AlinharDireita);
  end;
end;

end.
