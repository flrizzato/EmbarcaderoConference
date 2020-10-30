unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Advertising, FMX.Objects;

type
  TForm1 = class(TForm)
    BannerAd1: TBannerAd;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  BannerAd1.AdUnitID := 'ca-app-pub-3388914534529041/9480984698';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  BannerAd1.LoadAd;
end;

end.
