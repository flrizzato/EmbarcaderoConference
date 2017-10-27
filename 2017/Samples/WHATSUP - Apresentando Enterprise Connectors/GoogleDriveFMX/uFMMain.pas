unit uFMMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Actions, FMX.ActnList,
  FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Menus,
  FMX.Layouts,
  FMX.Edit, udmCData, System.ImageList, FMX.ImgList, FMX.Objects;

type
  TfmFMMain = class(TForm)
    ToolBar1: TToolBar;
    TabControl1: TTabControl;
    tbiView: TTabItem;
    tbiSearch: TTabItem;
    tbiDetails: TTabItem;
    ActionList1: TActionList;
    ctaView: TChangeTabAction;
    ctaSearch: TChangeTabAction;
    ctaDetails: TChangeTabAction;
    SpeedButton1: TSpeedButton;
    lbPath: TLabel;
    ListView1: TListView;
    ToolBar2: TToolBar;
    edSearchText: TEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    Label3: TLabel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    GridLayout1: TLayout;
    Panel2: TPanel;
    GridLayout2: TLayout;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Panel3: TPanel;
    GridLayout3: TLayout;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    ToolBar3: TToolBar;
    sbBack: TSpeedButton;
    sbDeleteDetails: TSpeedButton;
    sbSave: TSpeedButton;
    lbDetailsTitle: TLabel;
    SpeedButton20: TSpeedButton;
    asSearchName: TAction;
    acSearchDate: TAction;
    acJumpTo: TAction;
    acDetails: TAction;
    ToolBar4: TToolBar;
    SpeedButton21: TSpeedButton;
    acRefreshFiles: TAction;
    detType: TEdit;
    detSize: TEdit;
    detOwnerName: TEdit;
    detModified: TEdit;
    detCreated: TEdit;
    detDescription: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    lbLocation: TLabel;
    desStarred: TSwitch;
    ImageList1: TImageList;
    Name: TLabel;
    detName: TEdit;
    Image2: TImage;
    SpeedButton22: TSpeedButton;
    sbLocationFolder: TSpeedButton;
    sbEnterEditMode: TSpeedButton;
    spDownload: TSpeedButton;
    sbUpload: TSpeedButton;
    acSave: TAction;
    acEdit: TAction;
    lbHiddenID: TLabel;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure asSearchNameExecute(Sender: TObject);
    procedure acDetailsExecute(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure acRefreshFilesExecute(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure acDownloadExecute(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
    procedure detNameChange(Sender: TObject);
    procedure sbEnterEditModeClick(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure sbLocationFolderClick(Sender: TObject);
    procedure spDownloadClick(Sender: TObject);
    procedure sbDeleteDetailsClick(Sender: TObject);
    procedure sbUploadClick(Sender: TObject);
  private
    { Private declarations }
    EditMode: boolean;
    function MapMIMETypeToIdx(mime: string): integer;
    procedure FillDetails(buffer: _GDFileRec);
    procedure EnterEditMode;
  public
    { Public declarations }
    procedure RefreshView(ds: TmyDataset);
  end;

var
  fmFMMain: TfmFMMain;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

uses ioutils;

procedure TfmFMMain.acDetailsExecute(Sender: TObject);
begin
  ctaDetails.ExecuteTarget(self);
end;

procedure TfmFMMain.acDownloadExecute(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  SaveDlg := TSaveDialog.Create(nil);
  try
    SaveDlg.FileName := TPath.Combine(TPath.GetDocumentsPath, detName.Text);
    if SaveDlg.Execute then
      dmCdata.DownloadFile(lbHiddenID.Text, detName.Text, '',
        SaveDlg.FileName, False);
  finally
    SaveDlg.Free;
  end;
end;

procedure TfmFMMain.acEditExecute(Sender: TObject);
begin
  EnterEditMode;
end;

procedure TfmFMMain.acRefreshFilesExecute(Sender: TObject);
begin
  if not dmCdata.fdGDriveCon.Connected then
  begin
    dmCdata.Connect;
  end;
  if not(TabControl1.ActiveTab = tbiView) then
    ctaView.ExecuteTarget(tbiView);
  RefreshView(dmCdata.fqFiles);
end;

procedure TfmFMMain.acSaveExecute(Sender: TObject);
var
  buf: _GDFileRec;
begin
  buf.Id := lbHiddenID.Text;
  buf.Name := detName.Text;
  buf.Description := detDescription.Text;
  buf.Starred := desStarred.IsChecked;

  dmCdata.UpdateGDFile(buf);
  ctaView.ExecuteTarget(self);
end;

procedure TfmFMMain.asSearchNameExecute(Sender: TObject);
begin
  dmCdata.Search(edSearchText.Text);
  ctaView.ExecuteTarget(tbiView);
  RefreshView(dmCdata.fqSearch);
end;

procedure TfmFMMain.detNameChange(Sender: TObject);
begin
  acEditExecute(Sender);
end;

procedure TfmFMMain.EnterEditMode;
begin
  if EditMode or not(TabControl1.ActiveTab = tbiDetails) then
    exit;
  EditMode := True;
  detName.ReadOnly := False;
  detDescription.ReadOnly := False;
  lbDetailsTitle.Text := 'Details(Edited)';
  acSave.Enabled := True;
end;

procedure TfmFMMain.FillDetails(buffer: _GDFileRec);
begin
  lbDetailsTitle.Text := 'Details';
  lbHiddenID.Text := buffer.Id;
  detName.Text := buffer.Name;
  detType.Text := buffer.Extension;
  detSize.Text := IntToStr(buffer.Size div 1024) + ' K';
  detOwnerName.Text := buffer.OwnerName;
  detModified.Text := DateTimeToStr(buffer.ModifiedTime);
  detCreated.Text := DateTimeToStr(buffer.CreatedTime);
  detDescription.Text := buffer.Description;
  desStarred.IsChecked := buffer.Starred;
  lbLocation.Text := ''; // todo 1 : Infolder;
  detDescription.ReadOnly := True;
  acSave.Enabled := False;
end;

procedure TfmFMMain.FormCreate(Sender: TObject);
begin
  // dmCdata.Connect;
  TabControl1.ActiveTab:=tbiView;
  // RefreshView(dmCdata.fqFiles);
end;

procedure TfmFMMain.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  fid: string;
  recBuffer: _GDFileRec;
begin
  fid := AItem.TagString;
  if AItem.Tag = 0 then
  begin
    dmCdata.JumpTo(AItem.TagString, AItem.Text);
    acRefreshFiles.Execute;
  end
  else
  begin
    if dmCdata.ReadGDFile(fid, recBuffer) then
    begin
      FillDetails(recBuffer);
      acDetails.Execute;
    end;
  end;
end;

function TfmFMMain.MapMIMETypeToIdx(mime: string): integer;
begin
  if mime = 'application/vnd.google-apps.folder' then
    Result := 0
  else if mime = 'application/pdf' then
    Result := 13
  else if (mime = 'application/vnd.google-apps.spreadsheet') or
    (mime = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
  then
    Result := 10
  else if (mime = 'image/jpeg') or (mime = 'image/png') then
    Result := 5
  else if (mime = 'video/mp4') then
    Result := 4
  else if (mime = 'text/plain') or
    (mime = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    or (mime = 'text/html') or (mime = 'application/rtf') or
    (mime = 'application/vnd.oasis.opendocument.text') then
    Result := 3
  else
    Result := -1;
end;

procedure TfmFMMain.RefreshView(ds: TmyDataset);
var
  item: TListViewItem;
  FldHeader, FileHeader: boolean;
  FolderP: boolean;
  mimeIndex: integer;
begin
  ListView1.BeginUpdate;
  try
    ListView1.Items.Clear;
    ds.First;
    FldHeader := False;
    FileHeader := False;
    while not ds.Eof do
    begin
      FolderP := False;
      if isColumnHere(ds, 'Folder') then
      begin
        FolderP := ds.FieldByName('Folder').asBoolean;
        if FolderP then
        begin
          if not FldHeader then
          begin
            with ListView1.Items.Add do
            begin
              Purpose := TListItemPurpose.Header;
              Text := 'Folders';
              ImageIndex := MapMIMETypeToIdx
                ('application/vnd.google-apps.folder');
            end;
            FldHeader := True;
          end;
        end
        else
        begin
          if not FileHeader then
          begin
            with ListView1.Items.Add do
            begin
              Purpose := TListItemPurpose.Header;
              Text := 'Files';
              ImageIndex := -1; // No Image
            end;
            FileHeader := True;
          end;
        end;
      end;

      if isColumnHere(ds, 'MIMEType') then
      begin
        mimeIndex := MapMIMETypeToIdx(ds.FieldByName('MIMEType').AsString)
      end
      else
        mimeIndex := -1;

      item := ListView1.Items.Add;
      item.TagString := ds.FieldByName('id').AsString;
      if FolderP then
      begin
        item.Tag := 0;
      end
      else
        item.Tag := -1;
      // item.Objects.FindObjectT<TListItemText>('Text').Text := ds.FieldByName('name').AsString;
      item.Text := ds.FieldByName('name').AsString;
      item.Detail := 'Last modified ' + ds.FieldByName('ModifiedTime').AsString;
      item.ImageIndex := mimeIndex;
      ds.Next;
    end;
  finally
    ListView1.EndUpdate;
  end;
  lbPath.Text := dmCdata.PathToStr;
end;

procedure TfmFMMain.sbDeleteDetailsClick(Sender: TObject);
begin
  dmCdata.DeleteGDFile(lbHiddenID.Text);
  dmCdata.GetFolderFileList(dmCdata.CurPath.FolderID);
  acRefreshFiles.Execute;
end;

procedure TfmFMMain.SpeedButton22Click(Sender: TObject);
begin
  dmCdata.JumpUp;
  acRefreshFiles.Execute;
end;

procedure TfmFMMain.sbLocationFolderClick(Sender: TObject);
var
  temp: _GDPath;
begin
  temp := dmCdata.InFolder(lbHiddenID.Text);
  lbLocation.Text := temp.FolderName;
end;

procedure TfmFMMain.sbEnterEditModeClick(Sender: TObject);
begin
  EnterEditMode;
  ActiveControl := detDescription;
end;

procedure TfmFMMain.sbUploadClick(Sender: TObject);
var
  OpenDlg: TOpenDialog;
begin
  OpenDlg := TOpenDialog.Create(nil);
  try
    if OpenDlg.Execute then
      if FileExists(OpenDlg.FileName) then
      begin
        dmCdata.UploadFile(ExtractFileName(OpenDlg.FileName), '',
          dmCdata.CurPath.FolderID, OpenDlg.FileName);
      end;
  finally
    OpenDlg.Free;
    dmCdata.GetFolderFileList(dmCdata.CurPath.FolderID);
    acRefreshFiles.Execute;
  end;
end;

procedure TfmFMMain.spDownloadClick(Sender: TObject);
var
  SaveDlg: TSaveDialog;
begin
  SaveDlg := TSaveDialog.Create(nil);
  try
    SaveDlg.FileName := TPath.Combine(TPath.GetDocumentsPath, detName.Text);
    if SaveDlg.Execute then
      dmCdata.DownloadFile(lbHiddenID.Text, detName.Text, '',
        SaveDlg.FileName, False);
  finally
    SaveDlg.Free;
  end;
end;

procedure TfmFMMain.SpeedButton3Click(Sender: TObject);
begin
  dmCdata.SearchType((Sender as TSpeedButton).Text);
  if dmCdata.fqSearch.RecordCount > 0 then
  begin
    ctaView.ExecuteTarget(tbiView);
    RefreshView(dmCdata.fqSearch);
  end;
end;

end.
