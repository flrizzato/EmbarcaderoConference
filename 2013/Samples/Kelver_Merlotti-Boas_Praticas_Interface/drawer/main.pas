unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.Layouts;

type
  TForm3 = class(TForm)
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    ListBoxItem14: TListBoxItem;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    AnimateDrawer: TFloatAnimation;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

procedure TForm3.SpeedButton1Click(Sender: TObject);
var
  targetX: single;
begin
  targetX:=Self.ClientWidth - 60;

  if (panel1.Position.X=targetX) then begin
    AnimateDrawer.StartValue:= targetX;
    AnimateDrawer.StopValue:= 0;
  end
  else begin
    AnimateDrawer.StartValue:= 0;
    AnimateDrawer.StopValue:= targetX;
  end;

  AnimateDrawer.Start;


end;

end.
