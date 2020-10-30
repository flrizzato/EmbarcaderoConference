
//---------------------------------------------------------------------------

// This software is Copyright (c) 2015 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of an Embarcadero developer tools product.
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MainFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.ImageList, FMX.ImgList, FMX.ListBox,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.StdCtrls, FMX.WebBrowser, FMX.ScrollBox, FMX.Memo,
  FMX.Objects;

type
  TDrawer = class(TForm)
    MultiView1: TMultiView;
    MasterButton: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    LayoutContent: TLayout;
    StyleBook1: TStyleBook;
    procedure CloseNavigationPane(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Drawer: TDrawer;

implementation

{$R *.fmx}

procedure TDrawer.CloseNavigationPane(Sender: TObject);
begin
  MultiView1.HideMaster;
end;

end.
