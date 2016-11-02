unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, ksTableView,
  FMX.Objects, ksTypes, FMX.TabControl, ksSlideMenu;

type
  TForm24 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    TabControl1: TTabControl;
    ksSlideMenu1: TksSlideMenu;
    SpeedButton1: TSpeedButton;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Image1: TImage;
    Label2: TLabel;
    Image2: TImage;
    Label3: TLabel;
    Image3: TImage;
    Label4: TLabel;
    ToolBar2: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure ksSlideMenu1SelectMenuItemEvent(Sender: TObject; AId: string);
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
begin
  TabControl1.TabPosition := TTabPosition.None;
  ksSlideMenu1.AddMenuItem('PAGE_1','First Screen');
  ksSlideMenu1.AddMenuItem('PAGE_2','Second Screen');
  ksSlideMenu1.AddMenuItem('PAGE_3','Last Screen');

end;

procedure TForm24.ksSlideMenu1SelectMenuItemEvent(Sender: TObject; AId: string);
begin
  if AId = 'PAGE_1' then TabControl1.TabIndex := 0;
  if AId = 'PAGE_2' then TabControl1.TabIndex := 1;
  if AId = 'PAGE_3' then TabControl1.TabIndex := 2;

end;

end.
