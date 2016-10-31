unit MobileGfxSetupMain;
//=== File Prolog ============================================================
//    This code was developed by RiverSoftAVG.
//
//--- Notes ------------------------------------------------------------------
//
//--- Development History  ---------------------------------------------------
//
//      02/2015 T. Grubb
//              - Fixed optset bugs for iPhone larger sizes
//              - Added 750x1334 iPhone Launch image
//              - Added 2208x1242 iPhone Launch image
//              - Added Android Splash images that were added in XE7 (does not work
//                in optset though :-( )
//      02/2015 Thanks to Graham Murt for his updates:
//              - Added extra icons required in XE7 (87x87, 180x180, 75-x1334, 1242x2208, 2208x1242)
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
  FMX.Layouts, FMX.Memo, FMX.TabControl, FMX.Edit, FMX.Objects, FrameRatio,
  FMX.ListBox, System.Actions, FMX.ActnList, AndroidOptset, iOSOptset, XMLIntf;

type
  TSizeInfo = record
    Width,
    Height: Integer;
    AndroidName: String;
    iPhoneName: String;
    iPadName: String;
    constructor Create(const X, Y : Integer; aiPhoneName: String = ''; aiPadName: String = ''; aAndroidName: String = '');
  end;
  TSizeInfos = Array of TSizeInfo;
  TRatio = (r1to1, r1_77to1, r1_47to1, r1_37to1, r1_33to1, r0_76to1, r0_75to1, r0_66to1, r0_56to1);
  TRatioOutputs = Array[TRatio] of TSizeInfos;

  TfrmMobileGfxSetup = class(TForm)
    TabControl1: TTabControl;
    tiIntro: TTabItem;
    tiGraphics: TTabItem;
    tiSetup: TTabItem;
    tiGenerate: TTabItem;
    Memo1: TMemo;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    lbiiPhone: TListBoxItem;
    lbiiPad: TListBoxItem;
    lbiAndroid: TListBoxItem;
    cbOptset: TCheckBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    mmOutput: TMemo;
    Button2: TButton;
    ActionList1: TActionList;
    actGenerate: TAction;
    ceBaseName: TComboEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure ceBaseNameChange(Sender: TObject);
  private
    { Private declarations }
    procedure InitializeRatios;
    procedure InitializeGroupBoxes;
    procedure FilenameChange(Sender: TObject);
    function GetFrame( Ratio: TRatio ): TRatioFrame;
    procedure InitializeOptsets;
    function GetSetting(AName: string): string;
    procedure SetSetting(AName: string; const Value: string);
  public
    { Public declarations }
    AndroidOptions: IXMLAndroidProjectType;
    iOSOptions: IXMLiOSProjectType;
    function Validate: Boolean;
    procedure GenerateImage( aBitmap: TBitmap; Width, Height: Integer; aRect: TRectF; aFilename: String );
    procedure GenerateImages;
    procedure Log( const Msg: String ); virtual;
    property Setting[AName: string]: string read GetSetting write SetSetting;
  end;

var
  frmMobileGfxSetup: TfrmMobileGfxSetup;
  RatioOutputs: TRatioOutputs;

implementation

uses
  IOUtils, IniFiles;

{$R *.fmx}

procedure TfrmMobileGfxSetup.actGenerateExecute(Sender: TObject);
begin
  GenerateImages;
end;

procedure TfrmMobileGfxSetup.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ceBaseName.Text := ChangeFileExt( OpenDialog1.FileName, '.png' );
  end;
end;

procedure TfrmMobileGfxSetup.ceBaseNameChange(Sender: TObject);
begin
  Setting['base_filename'] := ceBaseName.Text;
end;

procedure TfrmMobileGfxSetup.FilenameChange(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TRatioFrame) and
      (TRatioFrame(Components[i]).ceFilename.Items.IndexOf((Sender as TRatioFrame).Filename) = -1) then
      TRatioFrame(Components[i]).ceFilename.Items.Add((Sender as TRatioFrame).Filename);
  if ceBaseName.Items.IndexOf((Sender as TRatioFrame).Filename) = -1 then
    ceBaseName.Items.Add((Sender as TRatioFrame).Filename);
end;

procedure TfrmMobileGfxSetup.FormCreate(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  InitializeRatios;
  InitializeGroupBoxes;
  ceBaseName.Text := Setting['base_filename'];
end;

procedure TfrmMobileGfxSetup.GenerateImage(aBitmap: TBitmap; Width, Height: Integer;
  aRect: TRectF; aFilename: String);
var
  NewBitmap: TBitmap;
  SrcRect: TRectF;
begin
  NewBitmap := TBitmap.Create(Width, Height);
  try
    // aRect contains percentages of bitmap
    NewBitmap.Canvas.BeginScene;
    try
      NewBitmap.Canvas.Clear(TAlphaColorRec.Null);
      SrcRect := RectF( aBitmap.Width*aRect.Left,
                        aBitmap.Height*aRect.Top,
                        aBitmap.Width*aRect.Right,
                        aBitmap.Height*aRect.Bottom );
      NewBitmap.Canvas.DrawBitmap(aBitmap, SrcRect,
                                  RectF(0,0,Width,Height),
                                  1);
    finally
      NewBitmap.Canvas.EndScene;
    end;
    NewBitmap.SaveToFile(aFilename);
  finally
    NewBitmap.Free;
  end;
end;

procedure TfrmMobileGfxSetup.GenerateImages;
var
  i: TRatio;
  rf: TRatioFrame;
  j: Integer;
  aFilename: String;
  Overwrite: Integer;
begin
  InitializeOptsets;
  Log('Generating images...');
  Overwrite := mrYes;
  for I := Low(TRatio) to High(TRatio) do
  begin
    rf := GetFrame(i);
    Log('   Generating '+rf.Caption+' images...');
    for j := 0 to Length(RatioOutputs[i]) - 1 do
    begin
      // first, see if we are generating this file
      if not (((RatioOutputs[i][j].AndroidName <> '') and lbiAndroid.IsChecked) or
        ((RatioOutputs[i][j].iPhoneName <> '') and lbiiPhone.IsChecked) or
        ((RatioOutputs[i][j].iPadName <> '') and lbiiPad.IsChecked)) then Continue;
      // generate filename: basename + WidthXHeight.png
      aFilename := TPath.Combine(TPath.GetDirectoryName(ceBaseName.Text), TPath.ChangeExtension(
        TPath.GetFileNameWithoutExtension( ceBaseName.Text ) +
        RatioOutputs[i][j].Width.ToString+'x'+RatioOutputs[i][j].Height.ToString, '.png' ));
      // save into optsets
      if (RatioOutputs[i][j].AndroidName <> '') and lbiAndroid.IsChecked then
        AndroidOptions.PropertyGroup.ChildValues[RatioOutputs[i][j].AndroidName] := aFilename;
      if (RatioOutputs[i][j].iPhoneName <> '') and lbiiPhone.IsChecked then
        iOSOptions.PropertyGroup.ChildValues[RatioOutputs[i][j].iPhoneName] := aFilename;
      if (RatioOutputs[i][j].iPadName <> '') and lbiiPad.IsChecked then
        iOSOptions.PropertyGroup.ChildValues[RatioOutputs[i][j].iPadName] := aFilename;
      // generate file
      if FileExists(aFilename) then
      begin
        case Overwrite of
          mrYesToAll: ;
          mrNoToAll:
          begin
              Log('      '+aFilename+' exists.  Skipping.');
              Continue;
          end;
        else
          Overwrite := MessageDlg(aFilename+' exists.  Overwrite?', TMsgDlgType.mtWarning,
            [TMsgDlgBtn.mbYesToAll,TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo,TMsgDlgBtn.mbNoToAll,TMsgDlgBtn.mbCancel], 0);
          case Overwrite of
            mrYes,
            mrYesToAll:;
            mrNo,
            mrNoToAll:
            begin
              Log('      '+aFilename+' exists.  Skipping.');
              Continue;
            end;
            mrCancel: Exit;
          end;
        end;
      end;
      Log('      '+aFilename);

      GenerateImage( RF.imPreview.Bitmap, RatioOutputs[i][j].Width, RatioOutputs[i][j].Height,
        RF.ZoomRect, aFilename );
    end;
  end;
  if cbOptset.IsChecked then
  begin
    if lbiAndroid.IsChecked then
    begin
      aFilename := TPath.Combine( TPath.GetDirectoryName(ceBaseName.Text),
                                  TPath.ChangeExtension( ceBaseName.Text, '.android.optset' ));
      AndroidOptions.OwnerDocument.SaveToFile(aFilename);
    end;
    if lbiiPhone.IsChecked or lbiiPad.IsChecked then
    begin
      aFilename := TPath.Combine( TPath.GetDirectoryName(ceBaseName.Text),
                                  TPath.ChangeExtension( ceBaseName.Text, '.ios.optset' ));
      iOSOptions.OwnerDocument.SaveToFile(aFilename);
    end;
  end;
  Log('Operation complete.');
end;

function TfrmMobileGfxSetup.GetFrame(Ratio: TRatio): TRatioFrame;
var
  i: Integer;
begin
  result := nil;
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TRatioFrame) and (Components[i].Tag = Ord(Ratio)) then
    begin
      result := TRatioFrame(Components[i]);
      Break;
    end;
end;

function TfrmMobileGfxSetup.GetSetting(AName: string): string;
var
  AIni: TMemIniFile;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    Result := AIni.ReadString('settings', AName, '');
  finally
    AIni.Free;
  end;
end;

procedure TfrmMobileGfxSetup.InitializeGroupBoxes;
var
  i: TRatio;
begin
  for I := Low(TRatio) to High(TRatio) do
  begin
    with TRatioFrame.Create(Self, RatioOutputs[i][0].Width, RatioOutputs[i][0].Height) do
    begin
      Parent := VertScrollBox1;
      Align := TAlignLayout.alTop;
      OnChange := Self.FilenameChange;
      Tag := Ord(i);
    end;
  end;
end;

procedure TfrmMobileGfxSetup.InitializeRatios;
begin
  SetLength(RatioOutputs[r1to1], 19);
  RatioOutputs[r1to1][0] := TSizeInfo.Create(152, 152, '', 'iPad_AppIcon152');
  RatioOutputs[r1to1][1] := TSizeInfo.Create(76, 76, '', 'iPad_AppIcon76');
  RatioOutputs[r1to1][2] := TSizeInfo.Create(120, 120, 'iPhone_AppIcon120');
  RatioOutputs[r1to1][3] := TSizeInfo.Create(57, 57, 'iPhone_AppIcon57');
  RatioOutputs[r1to1][4] := TSizeInfo.Create(60, 60, 'iPhone_AppIcon60');
  RatioOutputs[r1to1][5] := TSizeInfo.Create(29, 29, 'iPhone_Spotlight29', 'iPad_Setting29');
  RatioOutputs[r1to1][6] := TSizeInfo.Create(80, 80, 'iPhone_Spotlight80', 'iPad_SpotLight80');
  RatioOutputs[r1to1][7] := TSizeInfo.Create(58, 58, 'iPhone_Spotlight58', 'iPad_Setting58');
  RatioOutputs[r1to1][8] := TSizeInfo.Create(40, 40, 'iPhone_Spotlight40', 'iPad_SpotLight40');
  RatioOutputs[r1to1][9] := TSizeInfo.Create(114, 114, 'iPhone_AppIcon114');
  RatioOutputs[r1to1][10] := TSizeInfo.Create(100, 100, '', 'iPad_SpotLight100');
  RatioOutputs[r1to1][11] := TSizeInfo.Create(144, 144, '', 'iPad_AppIcon144', 'Android_LauncherIcon144');
  RatioOutputs[r1to1][12] := TSizeInfo.Create(50, 50, '', 'iPad_SpotLight50');
  RatioOutputs[r1to1][13] := TSizeInfo.Create(72, 72, '', 'iPad_AppIcon72', 'Android_LauncherIcon72');
  RatioOutputs[r1to1][14] := TSizeInfo.Create(96, 96, '', '', 'Android_LauncherIcon96');
  RatioOutputs[r1to1][15] := TSizeInfo.Create(48, 48, '', '', 'Android_LauncherIcon48');
  RatioOutputs[r1to1][16] := TSizeInfo.Create(36, 36, '', '', 'Android_LauncherIcon36');
  RatioOutputs[r1to1][17] := TSizeInfo.Create(87, 87, 'iPhone_AppIcon87');
  RatioOutputs[r1to1][18] := TSizeInfo.Create(180, 180, 'iPhone_AppIcon180');

  SetLength(RatioOutputs[r1_47to1], 1);
  RatioOutputs[r1_47to1][0] := TSizeInfo.Create(470, 320, '', '', 'Android_SplashImage470');

  SetLength(RatioOutputs[r1_37to1], 2);
  RatioOutputs[r1_37to1][0] := TSizeInfo.Create(2048, 1496, '', 'iPad_Launch2048');
  RatioOutputs[r1_37to1][1] := TSizeInfo.Create(1024, 748, '', 'iPad_Launch1024');

  SetLength(RatioOutputs[r1_33to1], 5);
  RatioOutputs[r1_33to1][0] := TSizeInfo.Create(2048, 1536, '', 'iPad_Launch2048x1536');
  RatioOutputs[r1_33to1][1] := TSizeInfo.Create(1024, 768, '', 'iPad_Launch1024x768');
  RatioOutputs[r1_33to1][2] := TSizeInfo.Create(640, 480, '', '', 'Android_SplashImage640');
  RatioOutputs[r1_33to1][3] := TSizeInfo.Create(960, 720, '', '', 'Android_SplashImage960');
  RatioOutputs[r1_33to1][4] := TSizeInfo.Create(426, 320, '', '', 'Android_SplashImage426'); // 1.33125

  SetLength(RatioOutputs[r1_77to1], 1);
  RatioOutputs[r1_77to1][0] := TSizeInfo.Create(2208, 1242, 'iPhone_Launch2208x1242');


  SetLength(RatioOutputs[r0_76to1], 2);
  RatioOutputs[r0_76to1][0] := TSizeInfo.Create(1536, 2008, '', 'iPad_Launch1536');
  RatioOutputs[r0_76to1][1] := TSizeInfo.Create(768, 1004, '', 'iPad_Launch768');

  SetLength(RatioOutputs[r0_75to1], 2);
  RatioOutputs[r0_75to1][0] := TSizeInfo.Create(1536, 2048, '', 'iPad_Launch1536x2048');
  RatioOutputs[r0_75to1][1] := TSizeInfo.Create(768, 1024, '', 'iPad_Launch768x1024');

  SetLength(RatioOutputs[r0_66to1], 2);
  RatioOutputs[r0_66to1][0] := TSizeInfo.Create(640, 960, 'iPhone_Launch640');
  RatioOutputs[r0_66to1][1] := TSizeInfo.Create(320, 480, 'iPhone_Launch320');

  SetLength(RatioOutputs[r0_56to1], 3);
  RatioOutputs[r0_56to1][0] := TSizeInfo.Create(640, 1136, 'iPhone_Launch640x1136');
  RatioOutputs[r0_56to1][1] := TSizeInfo.Create(750, 1334, 'iPhone_Launch750x1134');
  RatioOutputs[r0_56to1][2] := TSizeInfo.Create(1242, 2208, 'iPhone_Launch1242x2208');
end;

procedure TfrmMobileGfxSetup.Log(const Msg: String);
begin
  mmOutput.Lines.Add(Msg);
end;

procedure TfrmMobileGfxSetup.SetSetting(AName: string; const Value: string);
var
  AIni: TMemIniFile;
begin
  AIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    AIni.WriteString('settings', AName, Value);
    AIni.UpdateFile;
  finally
    AIni.Free;
  end;
end;

procedure TfrmMobileGfxSetup.InitializeOptsets;
begin
  AndroidOptions := NewAndroidOptset;
  AndroidOptions.ProjectExtensions.BorlandPersonality := 'Delphi.Personality.12';
  AndroidOptions.ProjectExtensions.BorlandProjectType := 'OptionSet';
  AndroidOptions.ProjectExtensions.BorlandProject.DelphiPersonality := '';
  AndroidOptions.ProjectExtensions.ProjectFileVersion := 12;
  AndroidOptions.OwnerDocument.Options := AndroidOptions.OwnerDocument.Options + [doNodeAutoIndent];

  iOSOptions := NewiOSOptset;
  iOSOptions.ProjectExtensions.BorlandPersonality := 'Delphi.Personality.12';
  iOSOptions.ProjectExtensions.BorlandProjectType := 'OptionSet';
  iOSOptions.ProjectExtensions.BorlandProject.DelphiPersonality := '';
  iOSOptions.ProjectExtensions.ProjectFileVersion := 12;
  iOSOptions.OwnerDocument.Options := iOSOptions.OwnerDocument.Options + [doNodeAutoIndent];
end;

procedure TfrmMobileGfxSetup.TabControl1Change(Sender: TObject);
begin
  if (Sender as TTabControl).TabIndex = tiGenerate.Index then
  begin
    // validate the inputs
    mmOutput.Lines.Clear;
    if not Validate then
      raise Exception.Create('Errors were found in setup.  Please correct.');
    Log('Ready to generate images');
    actGenerate.Enabled := True;
  end
  else
    actGenerate.Enabled := False;
end;

function TfrmMobileGfxSetup.Validate: Boolean;
var
  i: Integer;
  rf: TRatioFrame;
  LDirectoryName: String;
begin
  if not (lbiiPhone.IsChecked or lbiiPad.IsChecked or lbiAndroid.IsChecked) then
    raise Exception.Create('An output device must be checked');
  result := True;
  Log('Validating Ratio Inputs...');
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TRatioFrame) then
    begin
      rf := TRatioFrame(Components[i]);
      Log('   Validating '+rf.Caption+'...');
      if rf.imPreview.Bitmap.IsEmpty then
      begin
        result := False;
        Log('      INVALID Bitmap (Empty)');
      end
      else
        Log('      Bitmap Ok');
      if rf.SelectRect.IsEmpty then
      begin
        result := False;
        Log('      INVALID Selection rectangle (Empty)');
      end
      else
        Log('      Selection rectangle Ok');
    end;
  Log('Validating Outputs...');
  try
    LDirectoryName := TPath.GetDirectoryName(ceBaseName.Text);
    if LDirectoryName = '' then
    begin
      result := False;
      Log('   No directory found at specified path for base name: '+ceBaseName.Text);
    end;
  except
    result := False;
    Log('   Incorrect path for base name: '+ceBaseName.Text);
  end;
end;

{ TSizeInfoInfo }

constructor TSizeInfo.Create(const X, Y: Integer; aiPhoneName, aiPadName, aAndroidName: String);
begin
  Width := X;
  Height := Y;
  iPhoneName := aiPhoneName;
  iPadName := aiPadName;
  AndroidName := aAndroidName;
end;

end.
