unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MetropolisUI.Tile,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    LiveTile1: TLiveTile;
    Edit1: TEdit;
    Memo1: TMemo;
    Edit2: TEdit;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  png: TPngImage;
begin
  png := TPngImage.Create;
  png.Assign(Image1.Picture.Bitmap);
  png.SaveToFile(LiveTile1.ImagesFolder + 'wide.png');
  LiveTile1.UpdateTile;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  png: TPngImage;
begin
  png := TPngImage.Create;
  png.Assign(Image2.Picture.Bitmap);
  png.SaveToFile(LiveTile1.ImagesFolder + 'narrow.png');
  LiveTile1.UpdateTile;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  LiveTile1.WideValue['Text Header 1'] := Edit1.Text;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  LiveTile1.NarrowValue['Text Header 1'] := Edit2.Text;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Canvas.Ellipse(X-5, y-5, x+5, y+5);
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Canvas.Ellipse(X-5, y-5, x+5, y+5);
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  LiveTile1.WideValue['Text Field 2'] := Edit1.Text;
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin
  LiveTile1.NarrowValue['Text Header 2'] := Edit2.Text;
end;

end.
