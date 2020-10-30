unit MolHero.FormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Types3D, FMX.Objects3D,
  FMX.Edit, FMX.Materials, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Ani, FMX.MaterialSources, FMX.Controls3D,
  FMX.Viewport3D, FMX.StdCtrls, System.Math.Vectors, FMX.Controls.Presentation,
  FMX.Layouts, FMX.MultiView, FMX.Objects, FMX.ListView.Types, FMX.ListView,
  {IFDEF VER300} FMX.ListView.Appearances, {ENDIF}
  MolHero.Types, MolHero.Materials, MolHero.MoleculeModel;

const
  CAMERA_MAX_Z = -2;
  CAMERA_MIN_Z = -102;
  ZOOM_STEP = 2;

type
  TFormMain = class(TForm)
    ViewportMain: TViewport3D;
    CameraZ: TCamera;
    Light1: TLight;
    DummyMain: TDummy;
    DummyXY: TDummy;
    DummyModel: TDummy;
    LayoutHeader: TLayout;
    SpeedButtonMenu: TSpeedButton;
    LabelTitle: TLabel;
    LayoutClient: TLayout;
    MultiViewMain: TMultiView;
    RectangleMenu: TRectangle;
    LayoutMenuTop: TLayout;
    RectangleMenuTop: TRectangle;
    LabelMenuTitle: TLabel;
    ListViewMoleculeList: TListView;
    spdbtnMoleculeAdd: TSpeedButton;
    LayoutBottom: TLayout;
    SpeedButtonViewModeAB: TSpeedButton;
    SpeedButtonViewModeA: TSpeedButton;
    SpeedButtonViewModeB: TSpeedButton;
    SpeedButtonZoomOut: TSpeedButton;
    SpeedButtonZoomIn: TSpeedButton;
    SpeedButtonInfo: TSpeedButton;
    procedure ViewportMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ViewportMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure ViewportMainMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ListViewMoleculeListItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButtonViewModeABClick(Sender: TObject);
    procedure SpeedButtonViewModeAClick(Sender: TObject);
    procedure SpeedButtonViewModeBClick(Sender: TObject);
    procedure spdbtnMoleculeAddClick(Sender: TObject);
    procedure SpeedButtonZoomInClick(Sender: TObject);
    procedure SpeedButtonZoomOutClick(Sender: TObject);
    procedure SpeedButtonInfoClick(Sender: TObject);
  private
    FDefaultMoleculeIndex: integer;
    FDown: TPointF;
    FCurrViewMode: TMoleculeViewMode;
    procedure OnCtrlClick(Sender: TObject);
    procedure LoadDefaultMolecule;
    procedure LoadMoleculeList;
    procedure LoadMoleculeByIndex(index: integer);
    procedure DoZoom(aIn: boolean);
    procedure ShowAppAbout;
    procedure SetCurrViewMode(const Value: TMoleculeViewMode);
    property CurrViewMode: TMoleculeViewMode read FCurrViewMode write SetCurrViewMode;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses MolHero.DMMain, MolHero.FormAdd;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FDefaultMoleculeIndex := 3;

  MultiViewMain.Mode := TMultiViewMode.Drawer;

  CurrViewMode := TMoleculeViewMode.AB;
  SpeedButtonViewModeAB.IsPressed := True;

  LoadMoleculeList;
  LoadDefaultMolecule;
end;

procedure TFormMain.DoZoom(aIn: boolean);
var newZ: single;
begin
  if aIn then
    newZ := CameraZ.Position.Z + ZOOM_STEP
  else
    newZ := CameraZ.Position.Z - ZOOM_STEP;

  if (newZ < CAMERA_MAX_Z) and (newZ > CAMERA_MIN_Z) then
    CameraZ.Position.Z := newZ;
end;

procedure TFormMain.ListViewMoleculeListItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  LoadMoleculeByIndex(aItem.Tag);
  MultiViewMain.HideMaster;
end;

procedure TFormMain.LoadMoleculeByIndex(index: integer);
var i: integer;
begin
  DMMain.LoadMoleculeByIndex(DummyModel, index);

  for i := 0 to DummyModel.ChildrenCount-1 do
  begin
    if DummyModel.Children[i] is TControl3D then
      TControl3D(DummyModel.Children[i]).OnClick := OnCtrlClick;
  end;

  if DMMain.CurrentMolecule <> nil then
    LabelTitle.Text := DMMain.CurrentMolecule.DisplayName
  else
    LabelTitle.Text := '';

  Invalidate;
end;

procedure TFormMain.LoadDefaultMolecule;
begin
  LoadMoleculeByIndex(FDefaultMoleculeIndex);
end;

procedure TFormMain.LoadMoleculeList;
var i, aCount: integer; s: string; lvi: TListViewItem;
begin
  aCount := DMMain.GetMoleculeCount;
  for i := 0 to aCount-1 do
  begin
    s := DMMain.GetMoleculeDisplayName(i);
    lvi := ListViewMoleculeList.Items.Add;
    lvi.Text := s;
    lvi.Tag := i;
  end;
end;

procedure TFormMain.OnCtrlClick(Sender: TObject);
begin
//
end;

procedure TFormMain.SetCurrViewMode(const Value: TMoleculeViewMode);
var i: integer; sph: TSphere; cyl: TCylinder;
begin
  if FCurrViewMode <> Value then
  begin
    FCurrViewMode := Value;

    for i := 0 to DummyModel.ChildrenCount-1 do
    begin
      if DummyModel.Children[i] is TSphere then
      begin
        sph := TSphere(DummyModel.Children[i]);
        sph.Visible := CurrViewMode in [TMoleculeViewMode.AB, TMoleculeViewMode.A];
      end

      else if DummyModel.Children[i] is TCylinder then
      begin
        cyl := TCylinder(DummyModel.Children[i]);
        cyl.Visible := CurrViewMode in [TMoleculeViewMode.AB, TMoleculeViewMode.B];
      end
    end;

  end;
end;

procedure TFormMain.ShowAppAbout;
begin
  ShowMessage(
    'MOLECULE HERO'
    + #10
    + #10 + 'Version 1.0'
    + #10
    + #10 + 'Chemical molecule interactive 3D viewer'
    + #10
    + #10 + 'proudly built with Embarcadero DELPHI'
  );
end;

procedure TFormMain.SpeedButtonInfoClick(Sender: TObject);
begin
  ShowAppAbout;
end;

procedure TFormMain.spdbtnMoleculeAddClick(Sender: TObject);
begin
  if FormAdd = nil then
    FormAdd := TFormAdd.Create(Application);

  FormAdd.ShowModal;
end;

procedure TFormMain.SpeedButtonViewModeABClick(Sender: TObject);
begin
  CurrViewMode := TMoleculeViewMode.AB;
end;

procedure TFormMain.SpeedButtonViewModeAClick(Sender: TObject);
begin
  CurrViewMode := TMoleculeViewMode.A;
end;

procedure TFormMain.SpeedButtonViewModeBClick(Sender: TObject);
begin
  CurrViewMode := TMoleculeViewMode.B;
end;

procedure TFormMain.SpeedButtonZoomInClick(Sender: TObject);
begin
  DoZoom(True);
end;

procedure TFormMain.SpeedButtonZoomOutClick(Sender: TObject);
begin
  DoZoom(False);
end;

procedure TFormMain.ViewportMainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FDown := PointF(X, Y);
end;

procedure TFormMain.ViewportMainMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  if (ssLeft in Shift) then
  begin
    DummyXY.RotationAngle.X := DummyXY.RotationAngle.X - ((Y - FDown.Y) * 0.3);
    DummyXY.RotationAngle.Y := DummyXY.RotationAngle.Y + ((X - FDown.X) * 0.3);
    FDown := PointF(X, Y);
  end;
end;

procedure TFormMain.ViewportMainMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  DoZoom(WheelDelta > 0);
end;

end.
