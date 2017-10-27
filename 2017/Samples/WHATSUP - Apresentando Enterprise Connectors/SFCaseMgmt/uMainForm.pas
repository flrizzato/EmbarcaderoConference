unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.StdCtrls, FMX.ListView, FMX.Edit, FMX.Layouts, FMX.ListBox, FMX.Objects,
  FMX.Controls.Presentation, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.GenData, Data.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Bind.Editors, FMX.Ani,
  Data.Bind.DBScope;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    imgLogo: TImage;
    Label1: TLabel;
    TabControl1: TTabControl;
    tabLogin: TTabItem;
    LayoutLogin: TLayout;
    edtPassword: TEdit;
    PasswordEditButton1: TPasswordEditButton;
    edtUsername: TEdit;
    ClearEditButton1: TClearEditButton;
    tabCases: TTabItem;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    actLogin: TAction;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    lstCases: TListView;
    RectAnimation1: TRectAnimation;
    tabDetails: TTabItem;
    lstDetails: TListBox;
    StatusBar1: TStatusBar;
    labelLoggedInUser: TLabel;
    butGoBack: TSpeedButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    edtServerIP: TEdit;
    ClearEditButton2: TClearEditButton;
    butLogin: TButton;
    procedure actLoginExecute(Sender: TObject);
    procedure edtUsernameChangeTracking(Sender: TObject);
    procedure edtPasswordChangeTracking(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lstCasesUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lstCasesItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure edtServerIPChangeTracking(Sender: TObject);
  private
    { Private declarations }
    procedure BuildDetailScreen;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}

uses FMX.VirtualKeyboard, FMX.Platform, FMX.DialogService, uMainDM;

procedure TMainForm.actLoginExecute(Sender: TObject);
begin
  MainDM.ServerIP := edtServerIP.Text;
  MainDM.UserName := edtUsername.Text;
  MainDM.Password := edtPassword.Text;

  try
    LayoutLogin.Enabled := False;
    if MainDM.UserLogin then
    begin
      MainDM.LoadSFCases;
      NextTabAction1.ExecuteTarget(nil);
      labelLoggedInUser.Text := 'User: ' + edtUsername.Text;
    end
    else
    begin
      edtPassword.SetFocus;
      edtPassword.Text := '';
      labelLoggedInUser.Text := 'Invalid user/pass combination!';
    end;
  finally
    LayoutLogin.Enabled := True;
  end;
end;

procedure TMainForm.BuildDetailScreen;
var
  i: Integer;
  ListBoxEdit: TEdit;
  ListBoxItem: TListBoxItem;
  ListBoxGroupHeader: TListBoxGroupHeader;
begin
  lstDetails.BeginUpdate;
  try
    lstDetails.Items.Clear;

    ListBoxGroupHeader := TListBoxGroupHeader.Create(lstDetails);
    ListBoxGroupHeader.Text := 'Case Details';
    lstDetails.AddObject(ListBoxGroupHeader);

    for i := 0 to MainDM.CaseMemTable.Fields.Count - 1 do
    begin
      ListBoxItem := TListBoxItem.Create(lstDetails);
      ListBoxItem.ItemData.Text := MainDM.CaseMemTable.Fields[i].FieldName;

      ListBoxEdit := TEdit.Create(ListBoxItem);
      ListBoxEdit.Align := TAlignLayout.VertCenter;
      ListBoxEdit.Margins.Left := 180;
      ListBoxEdit.Margins.Right := 05;
      ListBoxEdit.Font.Size := 10;
      ListBoxEdit.StyledSettings := ListBoxEdit.StyledSettings -
        [TStyledSetting.Size];
      ListBoxEdit.Text := MainDM.CaseMemTable.Fields[i].AsString;
      ListBoxEdit.ReadOnly := True;
      ListBoxItem.AddObject(ListBoxEdit);

      lstDetails.AddObject(ListBoxItem);
    end;
  finally
    lstDetails.EndUpdate;
  end;
end;

procedure TMainForm.edtPasswordChangeTracking(Sender: TObject);
begin
  actLogin.Enabled := (edtUsername.Text.Length >= 3) and
    (edtPassword.Text.Length >= 3) and (edtServerIP.Text.Length >= 3);
end;

procedure TMainForm.edtServerIPChangeTracking(Sender: TObject);
begin
  actLogin.Enabled := (edtUsername.Text.Length >= 3) and
    (edtPassword.Text.Length >= 3) and (edtServerIP.Text.Length >= 3);
end;

procedure TMainForm.edtUsernameChangeTracking(Sender: TObject);
begin
  actLogin.Enabled := (edtUsername.Text.Length >= 3) and
    (edtPassword.Text.Length >= 3) and (edtServerIP.Text.Length >= 3);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
  end;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService
      (IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible
      in FService.VirtualKeyBoardState) then
    begin
      // do nothing...
    end
    else
    begin
      if TabControl1.TabIndex = 0 then
      begin
        Key := 0;
        TDialogService.MessageDialog('Close the application?',
          TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYes],
          TMsgDlgBtn.mbYes, 0,
          procedure(const AResult: TModalResult)
          begin
            case AResult of
              mrYES:
                begin
                  Application.Terminate;
                end;
            end;
          end);
      end
      else
      begin
        Key := 0;
        PreviousTabAction1.ExecuteTarget(Self);
      end;
    end;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  edtUsername.Text := MainDM.UserName;
  edtServerIP.Text := MainDM.ServerIP;

  TabControl1.ActiveTab := tabLogin;

{$IFDEF ANDROID}
  butGoBack.Visible := False;
{$ENDIF}
end;

procedure TMainForm.lstCasesItemClickEx(const Sender: TObject;
ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
begin
  if ItemObject.Name = 'butDetails' then
  begin
    BuildDetailScreen;
    NextTabAction1.ExecuteTarget(nil);
  end;
end;

procedure TMainForm.lstCasesUpdateObjects(const Sender: TObject;
const AItem: TListViewItem);
var
  UsedSpace: Single;
  AvailableWidth: Single;
  Drawable: TListItemText;

begin
  if TListView(Sender).EditMode = False then
  begin
    AvailableWidth := TListView(Sender).Width - TListView(Sender)
      .ItemSpaces.Left - TListView(Sender).ItemSpaces.Right - 15;

    Drawable := TListItemText(AItem.View.FindDrawable('butDetails'));
    Drawable.PlaceOffset.X := AvailableWidth - Drawable.Width;
    AvailableWidth := AvailableWidth - Drawable.Width + 5;

    Drawable := TListItemText(AItem.View.FindDrawable('txtSubject'));
    Drawable.Width := AvailableWidth;
    Drawable.PlaceOffset.X := 0;

    Drawable := TListItemText(AItem.View.FindDrawable('txtPriority'));
    Drawable.Width := ((AvailableWidth - 15) / 4);
    Drawable.PlaceOffset.X := AvailableWidth - Drawable.Width;

    UsedSpace := Drawable.Width + 5;

    Drawable := TListItemText(AItem.View.FindDrawable('txtUpdated'));
    Drawable.Width := ((AvailableWidth - 15) / 4);
    Drawable.PlaceOffset.X := AvailableWidth - Drawable.Width - UsedSpace;

    UsedSpace := UsedSpace + Drawable.Width + 5;

    Drawable := TListItemText(AItem.View.FindDrawable('txtCreated'));
    Drawable.Width := ((AvailableWidth - 15) / 4);
    Drawable.PlaceOffset.X := AvailableWidth - Drawable.Width - UsedSpace;

    UsedSpace := UsedSpace + Drawable.Width + 5;

    Drawable := TListItemText(AItem.View.FindDrawable('txtCaseNumber'));
    Drawable.Width := ((AvailableWidth - 15) / 4);
    Drawable.PlaceOffset.X := AvailableWidth - Drawable.Width - UsedSpace;
  end;
end;

end.
