unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, ksTypes, ksTableView, FMX.Layouts;

type
  TForm58 = class(TForm)
    ksTableView1: TksTableView;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Button1: TButton;
    Button2: TButton;
    layoutImages: TLayout;
    Image5: TImage;
    Image4: TImage;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure PopulateList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form58: TForm58;

implementation

{$R *.fmx}

procedure TForm58.Button1Click(Sender: TObject);
var
  AItem: TksTableViewItem;
begin
  AItem := ksTableView1.Items.ItemByID['USER_4'];
  // update user image..
  AItem.Image.Bitmap := Image4.Bitmap;

  // update side bar images...
  AItem.ImageByID['LEFT_BAR'].Bitmap := Image2.Bitmap;
  AItem.ImageByID['RIGHT_BAR'].Bitmap := Image2.Bitmap;


  AItem := ksTableView1.Items.ItemByID['USER_6'];
  // update side bar images...
  AItem.ImageByID['LEFT_BAR'].Bitmap := Image3.Bitmap;
  AItem.ImageByID['RIGHT_BAR'].Bitmap := Image3.Bitmap;
end;

procedure TForm58.Button2Click(Sender: TObject);
begin
  PopulateList;
end;

procedure TForm58.FormCreate(Sender: TObject);
begin
  layoutImages.Visible := False;
  PopulateList;
end;

procedure TForm58.PopulateList;
var
  AItem: TksTableViewItem;
  ICount: integer;
  ABar: TksTableViewItemImage;
begin
  ksTableView1.BeginUpdate;
  try
    ksTableView1.ClearItems;
    for ICount := 0 to 10 do
    begin
      AItem := ksTableView1.Items.AddItem('Item '+IntToStr(ICount), 'some text', '');
      AItem.ID := 'USER_'+IntToStr(ICount);

      AItem.Image.Bitmap := Image5.Bitmap;
      AItem.Image.OffsetX := 4;
      ABar := AItem.DrawBitmap(Image1.Bitmap, 6, 0, 6, 28);
      ABar.ID := 'LEFT_BAR';

      ABar := AItem.DrawBitmap(Image1.Bitmap, 0, 0, 6, 28);
      ABar.ID := 'RIGHT_BAR';
      ABar.Align := TksTableItemAlign.Trailing;
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

end.
