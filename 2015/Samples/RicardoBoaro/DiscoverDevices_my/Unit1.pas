unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation,
  FMX.StdCtrls, System.Bluetooth, System.Bluetooth.Components;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    BluetoothLE1: TBluetoothLE;
    procedure Button1Click(Sender: TObject);
    procedure BluetoothLE1EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.BluetoothLE1EndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
var
  I: Integer;
begin
  ListBox1.Clear;

  for I := 0 to ADeviceList.Count - 1 do
    if ADeviceList[i].DeviceName <> '' then
      ListBox1.Items.Add(ADeviceList[i].DeviceName)
    else
      ListBox1.Items.Add('Nao identificado');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  BluetoothLE1.DiscoverDevices(3000);
end;

end.
