unit fMyRotation;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Effects, FMX_Objects, FMX_Types3D, FMX_Layers3D;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Viewport3D1: TViewport3D;
    Image3D1: TImage3D;
    TrackBar1: TTrackBar;
    lblAnglo: TLabel;
    TrackBar2: TTrackBar;
    StyleBook1: TStyleBook;
    StyleBook3: TStyleBook;
    StyleBook2: TStyleBook;
    ReflectionEffect1: TReflectionEffect;
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 Image3D1.RotationAngle.Y := TrackBar1.Value;
 lblAnglo.Text := Format('Rotação de Y: %f', [TrackBar1.Value]);
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
 Image3D1.RotationAngle.X := TrackBar2.Value;
end;

end.
