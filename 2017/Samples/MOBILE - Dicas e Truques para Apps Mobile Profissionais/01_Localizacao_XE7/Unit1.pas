unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Filter.Effects, FMX.StdCtrls, System.Sensors, System.Sensors.Components,
  FMX.WebBrowser, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Switch1: TSwitch;
    SwirlEffect1: TSwirlEffect;
    LocationSensor1: TLocationSensor;
    Label1: TLabel;
    WebBrowser1: TWebBrowser;
    ToolBar1: TToolBar;
    procedure Switch1Switch(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
const
  Navegar : string = 'https://maps.google.com/?q=%s,%s&&t=h&&z=13&&hl=pt-' +
  'BR'; //&&output=embed
begin
  FormatSettings.DecimalSeparator := '.';
  Label1.Text := Format(navegar, [ Format('%2.6f', [NewLocation.Latitude]), Format('%2.6f', [NewLocation.Longitude])]);
  WebBrowser1.Navigate(Format(navegar, [Format('%2.6f', [NewLocation.Latitude]),
      Format('%2.6f', [NewLocation.Longitude])]));
end;


procedure TForm1.Switch1Switch(Sender: TObject);
begin
  LocationSensor1.Active := Switch1.IsChecked;
  if LocationSensor1.Active = False then
      begin
        Label1.Text := 'landersongomes.vivaitaocara.com.br';
        WebBrowser1.Navigate(Label1.Text);
      end;

end;

end.
