unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.TabControl,
  FMX.Gestures, FMX.StdCtrls, System.Actions, FMX.ActnList;

type
  TTabSlidingForm = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Image1: TImage;
    Image2: TImage;
    GestureManager1: TGestureManager;
    ToolBar1: TToolBar;
    Label1: TLabel;
    TabActionList: TActionList;
    ChangeTabActionPrev: TChangeTabAction;
    ChangeTabActionNext: TChangeTabAction;
    procedure ChangeTabActionPrevUpdate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TabSlidingForm: TTabSlidingForm;

implementation

{$R *.fmx}

procedure TTabSlidingForm.ChangeTabActionPrevUpdate(Sender: TObject);
begin
  if TabControl1.TabIndex < TabControl1.TabCount -1 then
    ChangeTabActionNext.Tab := TabControl1.Tabs[TabControl1.TabIndex + 1]
  else
    ChangeTabActionNext.Tab := nil;

  if TabControl1.TabIndex > 0 then
    ChangeTabActionPrev.Tab := TabControl1.Tabs[TabControl1.TabIndex - 1]
  else
    ChangeTabActionPrev.Tab := nil;
end;


end.
