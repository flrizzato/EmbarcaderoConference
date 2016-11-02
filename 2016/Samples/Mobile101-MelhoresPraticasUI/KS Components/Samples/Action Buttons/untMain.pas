unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, ksTableView,
  FMX.Objects, ksTypes;

type
  TForm24 = class(TForm)
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ksTableView1ItemSwipe(Sender: TObject; ARow: TksTableViewItem; ASwipeDirection: TksSwipeDirection; AButtons: TksTableViewActionButtons);
    procedure ksTableView1ItemActionButtonClick(Sender: TObject; ARow: TksTableViewItem; AButton: TksTableViewActionButton);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24: TForm24;

implementation

uses System.UIConsts;

{$R *.fmx}

procedure TForm24.FormCreate(Sender: TObject);
var
  ICount: integer;
  AItem: tkstableviewitem;
begin
  Image2.Visible := False;
  Image3.Visible := False;

  AccessoryImages.Images[atUserDefined1].SetBitmap(Image2.Bitmap);
  AccessoryImages.Images[atUserDefined2].SetBitmap(Image3.Bitmap);

  Image1.Visible := False;
  ksTableView1.BeginUpdate;
  try

    for ICount := 1 to 3 do
    begin
      AItem := ksTableView1.Items.AddItem('Item: '+IntToStr(ICount), 'some subtitle text', 'some detail', atMore );
      AItem.Image.Bitmap := Image1.Bitmap;
      //AItem.AddSwitch(0, True);
    end;
    AItem := ksTableView1.Items.AddItem('User defined', 'with custom images', 'some detail', atMore );
    AItem.Image.Bitmap := Image1.Bitmap;
  finally
    ksTableView1.EndUpdate;
  end;
end;

procedure TForm24.ksTableView1ItemActionButtonClick(Sender: TObject; ARow: TksTableViewItem; AButton: TksTableViewActionButton);
begin
  // show a message for the button clicked...
  ShowMessage('You clicked on: '+AButton.Text);
end;

procedure TForm24.ksTableView1ItemSwipe(Sender: TObject; ARow: TksTableViewItem; ASwipeDirection: TksSwipeDirection; AButtons: TksTableViewActionButtons);
begin
  if ASwipeDirection = ksSwipeRightToLeft then
  begin
    if ARow.Index = 3 then
    begin
      // user defined action button image for the last row
      AButtons.AddButton('Like', claSilver, claWhite, atUserDefined1);
      AButtons.AddButton('Lock', claOrange, claWhite, atUserDefined2);
      //AButtons.AddButton('Flag', claOrange, claWhite, atUserDefined2);
    end
    else
    begin
      AButtons.AddButton('More', claSilver, claWhite, atEllipses);
      AButtons.AddButton('Flag', claOrange, claWhite, atFlag);
    end;
  end
  else
  begin
    AButtons.AddButton('Reply', claDodgerblue, claWhite, atCompose)
  end;
end;

end.
