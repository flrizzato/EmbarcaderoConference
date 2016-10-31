unit FrameRatio;
//=== File Prolog ============================================================
//    This code was developed by RiverSoftAVG.
//
//--- Notes ------------------------------------------------------------------
//
//--- Development History  ---------------------------------------------------
//
//      02/2015 T. Grubb
//              - Added code to persist the selection rectangles
//      02/2015 Thanks to Graham Murt for his updates:
//              - Added loading/saving of settings so filenames are saved and reloaded on next run.
//      02/2014 T. Grubb
//              Initial version.
//
//      File Contents:
//
//
//=== End File Prolog ========================================================

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit;

type
  TMode = (mNone, mDraw, mDrag);
  TRatioFrame = class(TFrame)
    GroupBox1: TGroupBox;
    Button1: TButton;
    imPreview: TImage;
    pbPreview: TPaintBox;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    sbSelectAll: TSpeedButton;
    ceFilename: TComboEdit;
    procedure Button1Click(Sender: TObject);
    procedure pbPreviewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure pbPreviewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure pbPreviewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure pbPreviewPaint(Sender: TObject; Canvas: TCanvas);
    procedure ceFilenameChange(Sender: TObject);
    procedure sbSelectAllClick(Sender: TObject);
  private
    { Private declarations }
    FRatioWidth: Integer;
    FRatioHeight: Integer;
    FOnChange: TNotifyEvent;
    FMode: TMode;
    FSelectRect: TRectF;
    FStartPoint: TPointF;
    FEndPoint: TPointF;
    class var Num: Integer;
    function GetCaption: String;
    procedure SetCaption(const Value: String);
    procedure SetRatioHeight(const Value: Integer);
    procedure SetRatioWidth(const Value: Integer);
    procedure RatioChanged;
    procedure FilenameChanged;
    function GetRatio: Single;
    function GetFilename: String;
    procedure SetFilename(const Value: String);
    procedure SetMode(const Value: TMode);
    procedure SetSelectRect(const Value: TRectF);
    procedure SetStartPoint(const Value: TPointF);
    procedure SetEndPoint(const Value: TPointF);
    procedure SelectRectChange;
    function GetSetting(AName: string): string;
    procedure SetSetting(AName: string; const Value: string);
    function GetSizeStr: string;
    function GetSettingRect(AName: string): TRectF;
    procedure SetSettingRect(AName: string; const Value: TRectF);
    property Mode: TMode read FMode write SetMode;
    property EndPoint: TPointF read FEndPoint write SetEndPoint;
    property StartPoint: TPointF read FStartPoint write SetStartPoint;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; aWidth, aHeight: Integer); reintroduce; overload;
    function ImageRect: TRectF;
    function ZoomRect: TRectF;
    property Caption: String read GetCaption write SetCaption;
    property Filename: String read GetFilename write SetFilename;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Ratio: Single read GetRatio;
    property RatioHeight: Integer read FRatioHeight write SetRatioHeight;
    property RatioWidth: Integer read FRatioWidth write SetRatioWidth;
    property SelectRect: TRectF read FSelectRect write SetSelectRect;
    property Setting[AName: string]: string read GetSetting write SetSetting;
    property SettingRect[AName: string]: TRectF read GetSettingRect write SetSettingRect;
    property SizeStr: string read GetSizeStr;
  end;

implementation

uses Inifiles;

{$R *.fmx}

{ TRatioFrame }

procedure TRatioFrame.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Filename := OpenDialog1.FileName;
end;

procedure TRatioFrame.ceFilenameChange(Sender: TObject);
begin
  Filename := (Sender as TComboEdit).Text;
  Setting[SizeStr] := Filename;
end;

constructor TRatioFrame.Create(AOwner: TComponent; aWidth, aHeight: Integer);
begin
  Create(AOwner);
  Name := Name + Num.ToString;
  Inc(Num);
  FRatioWidth := aWidth;
  FRatioHeight := aHeight;
  RatioChanged;
  Filename := Setting[SizeStr];
  SelectRect := SettingRect[SizeStr];
//  SelectRect := RectF(0, 0, pbPreview.Height*Ratio, pbPreview.Height);
end;

function TRatioFrame.ImageRect: TRectF;
begin
  result := RectF(0, 0, imPreview.Bitmap.Width / imPreview.Bitmap.BitmapScale, imPreview.Bitmap.Height / imPreview.Bitmap.BitmapScale);
  result.Fit(RectF(0, 0, imPreview.Width, imPreview.Height));
  result.Left := Round(result.Left);
  result.Top := Round(result.Top);
  result.Right := Round(result.Right);
  result.Bottom := Round(result.Bottom);
end;

procedure TRatioFrame.FilenameChanged;
begin
  ceFilename.Text := FileName;
  if Filename <> '' then
    imPreview.Bitmap.LoadFromFile(FileName)
  else
    imPreview.Bitmap.Clear(TAlphaColorRec.Null);
  if Filename = '' then Exit;
  sbSelectAll.OnClick(sbSelectAll);
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TRatioFrame.GetCaption: String;
begin
  result := GroupBox1.Text;
end;

function TRatioFrame.GetFilename: String;
begin
  result := OpenDialog1.FileName;
end;

function TRatioFrame.GetRatio: Single;
begin
  result := RatioWidth/RatioHeight;
end;

function TRatioFrame.GetSetting(AName: string): string;
var
  AIni: TMemIniFile;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    Result := AIni.ReadString('images', AName, '');
  finally
    AIni.Free;
  end;
end;

function TRatioFrame.GetSettingRect(AName: string): TRectF;
var
  AIni: TMemIniFile;
  aSize: TStringList;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  aSize := TStringList.Create;
  try
    aSize.Delimiter := ',';
    aSize.DelimitedText := AIni.ReadString('selections', AName, '');
    if aSize.Count = 4 then
    begin
      result.Left := StrToFloat(aSize[0]);
      result.Top := StrToFloat(aSize[1]);
      result.Right := StrToFloat(aSize[2]);
      result.Bottom := StrToFloat(aSize[3]);
    end
    else
    begin
      if (ImageRect.Left+ImageRect.Height*Ratio) > ImageRect.Right then
        result := RectF( ImageRect.Left,
                              ImageRect.Top,
                              ImageRect.Left+ImageRect.Width,
                              ImageRect.Top+ImageRect.Width/Ratio)
      else
        result := RectF( ImageRect.Left,
                              ImageRect.Top,
                              ImageRect.Left+ImageRect.Height*Ratio,
                              ImageRect.Top+ImageRect.Height);
    end;
  finally
    aSize.Free;
    AIni.Free;
  end;
end;

function TRatioFrame.GetSizeStr: string;
begin
  Result := IntToStr(FRatioWidth)+'_'+InttoStr(FRatioHeight);
end;

procedure TRatioFrame.pbPreviewMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  StartPoint := PointF(X,Y);
  if ssCtrl in Shift then
    Mode := mDrag
  else
  begin
    Mode := mDraw;
    SelectRect := RectF(StartPoint.X, StartPoint.Y, StartPoint.X, StartPoint.Y)
  end;
end;

procedure TRatioFrame.pbPreviewMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  case Mode of
    mDraw:
    begin
      if ssLeft in Shift then
      begin
        EndPoint := PointF(StartPoint.X+(Y-StartPoint.Y)*Ratio,StartPoint.Y+(Y-StartPoint.Y));
        FSelectRect.BottomRight := EndPoint;
      end
      else
        Mode := mNone;
    end;
    mDrag:
    begin
      if (ssLeft in Shift) and (ssCtrl in Shift) then
      begin
        OffsetRect(FSelectRect,X-StartPoint.X, Y-StartPoint.Y);
        if SelectRect.Left < ImageRect.Left then
          OffsetRect(FSelectRect, ImageRect.Left-SelectRect.Left, 0);
        if SelectRect.Right > ImageRect.Right then
          OffsetRect(FSelectRect, ImageRect.Right-SelectRect.Right, 0);
        if SelectRect.Top < ImageRect.Top then
          OffsetRect(FSelectRect, 0, ImageRect.Top-SelectRect.Top);
        if SelectRect.Bottom > ImageRect.Bottom then
          OffsetRect(FSelectRect, 0, ImageRect.Bottom-SelectRect.Bottom);
        StartPoint := PointF(X,Y);
      end
      else
        Mode := mNone;
    end
  else
    if ssLeft in Shift then
      pbPreviewMouseDown(Sender, TMouseButton.mbLeft, Shift, X, Y);
  end;
  pbPreview.Repaint;
end;

procedure TRatioFrame.pbPreviewMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  case Mode of
    mDraw:
    begin
      EndPoint := PointF(StartPoint.X+(Y-StartPoint.Y)*Ratio,StartPoint.Y+(Y-StartPoint.Y));
      FSelectRect.BottomRight := EndPoint;
      SelectRectChange;
    end;
    mDrag:
    begin
      OffsetRect(FSelectRect,X-StartPoint.X, Y-StartPoint.Y);
      if SelectRect.Left < ImageRect.Left then
        OffsetRect(FSelectRect, ImageRect.Left-SelectRect.Left, 0);
      if SelectRect.Right > ImageRect.Right then
        OffsetRect(FSelectRect, ImageRect.Right-SelectRect.Right, 0);
      if SelectRect.Top < ImageRect.Top then
        OffsetRect(FSelectRect, 0, ImageRect.Top-SelectRect.Top);
      if SelectRect.Bottom > ImageRect.Bottom then
        OffsetRect(FSelectRect, 0, ImageRect.Bottom-SelectRect.Bottom);
      SelectRectChange;
    end;
  end;
  Mode := mNone;
  pbPreview.Repaint;
end;

procedure TRatioFrame.pbPreviewPaint(Sender: TObject; Canvas: TCanvas);
begin
  Canvas.BeginScene;
  try
    Canvas.Stroke.Color := TAlphaColorRec.Black;
    Canvas.DrawRect(ImageRect, 0, 0, AllCorners, 1);
//    Canvas.DrawRect(pbPreview.BoundsRect, 0, 0, AllCorners, 1);
    Canvas.DrawDashRect(SelectRect, 0, 0, AllCorners, 1, TAlphaColorRec.Red);
  finally
    Canvas.EndScene;
  end;
end;

procedure TRatioFrame.RatioChanged;
begin
  imPreview.Width := imPreview.Height * Ratio;
  Caption := Ratio.ToString+':1';
  Label2.Text := 'Select images that are '+RatioWidth.ToString+'x'+RatioHeight.ToString+
    ' size or larger for best results';
end;

procedure TRatioFrame.SelectRectChange;
begin
  SettingRect[SizeStr] := FSelectRect;
end;

procedure TRatioFrame.SetCaption(const Value: String);
begin
  GroupBox1.Text := Value;
end;

procedure TRatioFrame.SetEndPoint(const Value: TPointF);
begin
  FEndPoint := Value;
  if FEndPoint.X < ImageRect.Left then
    FEndPoint.X := ImageRect.Left
  else if FEndPoint.X > ImageRect.Right then
    FEndPoint.X := ImageRect.Right;
  if FEndPoint.Y < ImageRect.Top then
    FEndPoint.Y := ImageRect.Top
  else if FEndPoint.Y > ImageRect.Bottom then
    FEndPoint.Y := ImageRect.Bottom;
end;

procedure TRatioFrame.SetFilename(const Value: String);
begin
  if (Value <> '') and (not FileExists(Value)) then
    raise EFileNotFoundException.Create('File does not exist: '+Value);
  OpenDialog1.FileName := Value;
  FilenameChanged;
end;

procedure TRatioFrame.SetMode(const Value: TMode);
begin
  FMode := Value;
end;

procedure TRatioFrame.SetRatioHeight(const Value: Integer);
begin
  if Value <> RatioHeight then
  begin
    FRatioHeight := Value;
    RatioChanged;
  end;
end;

procedure TRatioFrame.SetRatioWidth(const Value: Integer);
begin
  if Value <> FRatioWidth then
  begin
    FRatioWidth := Value;
    RatioChanged;
  end;
end;

procedure TRatioFrame.SetSelectRect(const Value: TRectF);
begin
  FSelectRect := Value;
  SelectRectChange;
end;

procedure TRatioFrame.SetSetting(AName: string; const Value: string);
var
  AIni: TMemIniFile;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    AIni.WriteString('images', AName, Value);
    AIni.UpdateFile;
  finally
    AIni.Free;
  end;
end;

procedure TRatioFrame.SetSettingRect(AName: string; const Value: TRectF);
var
  AIni: TMemIniFile;
  aSize: TStringList;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  aSize := TStringList.Create;
  try
    aSize.Delimiter := ',';
    aSize.Add(FloatToStr(Value.Left));
    aSize.Add(FloatToStr(Value.Top));
    aSize.Add(FloatToStr(Value.Right));
    aSize.Add(FloatToStr(Value.Bottom));
    AIni.WriteString('selections', AName, aSize.DelimitedText);
    AIni.UpdateFile;
  finally
    aSize.Free;
    AIni.Free;
  end;
end;

procedure TRatioFrame.SetStartPoint(const Value: TPointF);
begin
  FStartPoint := Value;
  if FStartPoint.X < ImageRect.Left then
    FStartPoint.X := ImageRect.Left
  else if FStartPoint.X > ImageRect.Right then
    FStartPoint.X := ImageRect.Right;
  if FStartPoint.Y < ImageRect.Top then
    FStartPoint.Y := ImageRect.Top
  else if FStartPoint.Y > ImageRect.Bottom then
    FStartPoint.Y := ImageRect.Bottom;
end;

function TRatioFrame.ZoomRect: TRectF;
begin
  result := RectF( (SelectRect.Left-ImageRect.Left)/ImageRect.Width,
                   (SelectRect.Top-ImageRect.Top)/ImageRect.Height,
                   (SelectRect.Right-ImageRect.Left)/ImageRect.Width,
                   (SelectRect.Bottom-ImageRect.Top)/ImageRect.Height );
end;

procedure TRatioFrame.sbSelectAllClick(Sender: TObject);
begin
  if (ImageRect.Left+ImageRect.Height*Ratio) > ImageRect.Right then
    FSelectRect := RectF( ImageRect.Left,
                          ImageRect.Top,
                          ImageRect.Left+ImageRect.Width,
                          ImageRect.Top+ImageRect.Width/Ratio)
  else
    FSelectRect := RectF( ImageRect.Left,
                          ImageRect.Top,
                          ImageRect.Left+ImageRect.Height*Ratio,
                          ImageRect.Top+ImageRect.Height);
  pbPreview.Repaint;
end;

end.
