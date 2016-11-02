unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  ksFormTransition, ksSlideMenu, FMX.StdCtrls, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, ksTypes, ksTableView;

type
  TForm3 = class(TForm)
    ToolBar1: TToolBar;
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    Label1: TLabel;
    Image1: TImage;
    ksSlideMenu1: TksSlideMenu;
    procedure FormCreate(Sender: TObject);
    procedure ksTableView1ItemClick(Sender: TObject; x, y: Single;
      AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses untOtherForm, ksChatView;

{$R *.fmx}

procedure TForm3.FormCreate(Sender: TObject);
var
  AIcon: TBitmap;
begin
  TransitionFading := False;
  {$IFDEF MSWINDOWS}
  Width := FormFactor.Width;
  Height := FormFactor.Height;
  Left := 360;
  Top := 150;
  {$ENDIF}
  AIcon := Image1.Bitmap;
  Image1.Visible := False;
  ksTableView1.Items.AddItem('Slide in right', '', 'background scroll', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in right', '', 'fixed background', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in bottom', '', 'background scroll', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in bottom', '', 'fixed background', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in top', '', 'background scroll', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in top', '', 'fixed background', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in left', '', 'background scroll', atMore).Image.Bitmap := AIcon;
  ksTableView1.Items.AddItem('Slide in left', '', 'fixed background', atMore).Image.Bitmap := AIcon;
  //SetPassCodeRequireType(TksPassCodeRequireType.ksRequireOnActivate);
end;

procedure TForm3.ksTableView1ItemClick(Sender: TObject; x, y: Single;
  AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  case AItem.Index of
    0: PushForm(Self, Form5, ksFtSlideInFromRight, True);
    1: PushForm(Self, Form5, ksFtSlideInFromRight, False);
    2: PushForm(Self, Form5, ksFtSlideInFromBottom, True);
    3: PushForm(Self, Form5, ksFtSlideInFromBottom, False);
    4: PushForm(Self, Form5, ksFtSlideInFromTop, True);
    5: PushForm(Self, Form5, ksFtSlideInFromTop, False);
    6: PushForm(Self, Form5, ksFtSlideInFromLeft, True);
    7: PushForm(Self, Form5, ksFtSlideInFromLeft, False);
  end;

end;

end.
