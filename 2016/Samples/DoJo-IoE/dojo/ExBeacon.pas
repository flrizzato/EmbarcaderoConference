unit ExBeacon;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Beacon,
  System.Bluetooth, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Beacon.Components, FMX.ScrollBox, FMX.Memo;

type
  TForm3 = class(TForm)
    Beacon1: TBeacon;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Beacon1BeaconEnter(const Sender: TObject; const ABeacon: IBeacon;
      const CurrentBeaconList: TBeaconList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}

procedure TForm3.Beacon1BeaconEnter(const Sender: TObject;
  const ABeacon: IBeacon; const CurrentBeaconList: TBeaconList);
begin
//
  if ABeacon.Distance < 1 then
  begin
    label1.Text := ABeacon.Distance.ToString;
    label2.Text := abeacon.Minor.ToString;
    label3.Text := ABeacon.Major.ToString;

    Memo1.Lines.Add('Distancia:' + ABeacon.Distance.ToString);
    Memo1.Lines.Add('Minor:' + ABeacon.Minor.ToString);
    Memo1.Lines.Add('Major:' + ABeacon.Major.ToString);

    Memo1.Lines.Add('---------------------------------');
    Memo1.Lines.Add('');

  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
   Beacon1.Enabled := true;
   Beacon1.StartScan;

end;

end.
