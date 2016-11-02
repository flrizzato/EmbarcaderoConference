unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Ani, ksTypes, ksVirtualListView,
  FMX.Layouts;

type
  TForm76 = class(TForm)
    Image1: TImage;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout1: TLayout;
    Image9: TImage;
    Image8: TImage;
    Image7: TImage;
    Image6: TImage;
    Image5: TImage;
    Image4: TImage;
    Image3: TImage;
    Image2: TImage;
    ksVirtualListView1: TksVirtualListView;
    Timer1: TTimer;
    procedure ksVirtualListView1ItemSwipe(Sender: TObject; ARow: TksVListItem;
      ASwipeDirection: TksVListSwipeDirection; AButtons: TksVListActionButtons);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure PopulateItems;
    { Private declarations }
  protected
    procedure DoShow; override;
  public
    { Public declarations }
  end;

var
  Form76: TForm76;

implementation

uses System.UIConsts;

{$R *.fmx}

procedure TForm76.PopulateItems;
var
  ICount: integer;
begin
  for ICount := 1 to 1 do
  begin
    ksVirtualListView1.Items.AddHeader('');
    ksVirtualListView1.Items.Add('Airplane Mode', '', '');
    ksVirtualListView1.Items.Add('Wi-Fi', '', 'BTHub5', atMore);
    ksVirtualListView1.Items.Add('Bluetooth', '', 'Off', atMore);
    ksVirtualListView1.Items.Add('Mobile Data', '', '', atMore);
    ksVirtualListView1.Items.Add('Personal Hotspot', '', 'Off', atMore);
    ksVirtualListView1.Items.Add('Carrier', '', 'EE', atMore);
    ksVirtualListView1.Items.AddHeader('');
    ksVirtualListView1.Items.Add('Notifications', '', '', atMore);
    ksVirtualListView1.Items.Add('Control Centre', '', '', atMore);

    ksVirtualListView1.Items[1].Image.Bitmap := Image2.Bitmap;
    ksVirtualListView1.Items[1].Image.SetOpaqueColor(claWhite);
    ksVirtualListView1.Items[1].Image.Background := claOrange;

    ksVirtualListView1.Items[2].Image.Bitmap := Image3.Bitmap;
    ksVirtualListView1.Items[2].Image.SetOpaqueColor(claWhite);
    ksVirtualListView1.Items[2].Image.Background := claDodgerblue;

    ksVirtualListView1.Items[3].Image.Bitmap := Image5.Bitmap;
    ksVirtualListView1.Items[3].Image.SetOpaqueColor(claWhite);
    ksVirtualListView1.Items[3].Image.Background := claDodgerblue;

   ksVirtualListView1.Items[4].Image.Bitmap := Image4.Bitmap;
   ksVirtualListView1.Items[4].Image.SetOpaqueColor(claWhite);
   ksVirtualListView1.Items[4].Image.Background := claLimegreen;

   ksVirtualListView1.Items[5].Image.Bitmap := Image6.Bitmap;
   ksVirtualListView1.Items[5].Image.SetOpaqueColor(claWhite);
   ksVirtualListView1.Items[5].Image.Background := claLimegreen;

   ksVirtualListView1.Items[6].Image.Bitmap := Image7.Bitmap;
   ksVirtualListView1.Items[6].Image.SetOpaqueColor(claWhite);
   ksVirtualListView1.Items[6].Image.Background := claLimegreen;

   ksVirtualListView1.Items[8].Image.Bitmap := Image8.Bitmap;
   ksVirtualListView1.Items[8].Image.SetOpaqueColor(claWhite);
   ksVirtualListView1.Items[8].Image.Background := claRed;

   ksVirtualListView1.Items[9].Image.Bitmap := Image9.Bitmap;
  end;
end;

procedure TForm76.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  PopulateItems;
end;

procedure TForm76.DoShow;
begin
  Timer1.Enabled := True;
end;

procedure TForm76.ksVirtualListView1ItemSwipe(Sender: TObject;
  ARow: TksVListItem; ASwipeDirection: TksVListSwipeDirection;
  AButtons: TksVListActionButtons);
begin
  if ASwipeDirection = ksSwipeFromLeft then
  begin
    AButtons.AddButton('Reply', claDodgerblue, claWhite, atCompose);
  end
  else
  begin
      AButtons.AddButton('More', claSilver, claWhite, atEllipses);
      AButtons.AddButton('Flag', claOrange, claWhite, atFlag);
  end;
end;

end.
