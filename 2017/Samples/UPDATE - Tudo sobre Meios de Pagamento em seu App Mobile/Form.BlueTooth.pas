unit Form.BlueTooth;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Bluetooth, System.Bluetooth.Components, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TfrmBlueTooth = class(TForm)
    BluetoothLE1: TBluetoothLE;
    Bluetooth1: TBluetooth;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBlueTooth: TfrmBlueTooth;

implementation

{$R *.fmx}

end.
