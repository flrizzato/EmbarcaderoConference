unit uGDriveDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.CDataGoogleDriveDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.CDataGoogleDrive, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Comp.UI, System.Actions, Vcl.ActnList, Vcl.DBCtrls,
  FireDAC.Moni.Base, FireDAC.Moni.RemoteClient;

const
  DEFCOLWIDTH = 40;

type
  TfmGDriveSimpleDemo = class(TForm)
    paInfo: TPanel;
    StatusBar1: TStatusBar;
    FDConnection1: TFDConnection;
    FDPhysCDataGoogleDriveDriverLink1: TFDPhysCDataGoogleDriveDriverLink;
    fqQuery: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    sbRunQuery: TSpeedButton;
    meQuery: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    dsFiles: TDataSource;
    ActionList1: TActionList;
    acBrowseFiles: TAction;
    acBrowseFolders: TAction;
    acBrowseVideos: TAction;
    acCreateFolder: TAction;
    acFileUpload: TAction;
    acDownloadFile: TAction;
    acDescribe: TAction;
    fqFiles: TFDQuery;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    fspUpload: TFDStoredProc;
    fspDownload: TFDStoredProc;
    fspNewFolder: TFDStoredProc;
    acFolderSTree: TAction;
    Button2: TButton;
    Panel5: TPanel;
    DBGrid2: TDBGrid;
    tsMetadata: TTabSheet;
    fqPermissions: TFDQuery;
    Button1: TButton;
    tsConnection: TTabSheet;
    acFilePermissions: TAction;
    Button6: TButton;
    Button7: TButton;
    Button11: TButton;
    DBNavigator1: TDBNavigator;
    acBrowseDocs: TAction;
    acBrowseSheets: TAction;
    acBrowsePhotos: TAction;
    EdSearch: TEdit;
    Label2: TLabel;
    Button12: TButton;
    Button13: TButton;
    Edit2: TEdit;
    Edit1: TEdit;
    acFindByName: TAction;
    acFindByContent: TAction;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    edCDataName: TEdit;
    Button17: TButton;
    FDUpdateSQL1: TFDUpdateSQL;
    btApply: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    procedure fqQueryAfterOpen(DataSet: TDataSet);
    procedure sbRunQueryClick(Sender: TObject);
    procedure acBrowseFilesExecute(Sender: TObject);
    procedure acBrowseFoldersExecute(Sender: TObject);
    procedure fqFilesAfterOpen(DataSet: TDataSet);
    procedure acDescribeExecute(Sender: TObject);
    procedure acFileUploadExecute(Sender: TObject);
    procedure acDownloadFileExecute(Sender: TObject);
    procedure acFolderSTreeExecute(Sender: TObject);
    procedure acFindByNameExecute(Sender: TObject);
    procedure acFilePermissionsExecute(Sender: TObject);
    procedure fqPermissionsAfterOpen(DataSet: TDataSet);
    procedure ftFilesAfterOpen(DataSet: TDataSet);
    procedure acCreateFolderExecute(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure acBrowseVideosExecute(Sender: TObject);
    procedure acBrowseDocsExecute(Sender: TObject);
    procedure acBrowseSheetsExecute(Sender: TObject);
    procedure acBrowsePhotosExecute(Sender: TObject);
    procedure acFolderSTreeUpdate(Sender: TObject);
  private
    { Private declarations }
    procedure CutVisualWidth(ds: TDataset);
    procedure Describe(const Table: string; Tgt:TStrings);
    procedure RunQuery(ds:TFDQuery;SQL:string);
  public
    { Public declarations }
  end;

var
  fmGDriveSimpleDemo: TfmGDriveSimpleDemo;

implementation

{$R *.dfm}

uses
  UscanGDdir, uShowboard;

procedure TfmGDriveSimpleDemo.acBrowseDocsExecute(Sender: TObject);
begin
  if fqQuery.Active then fqQuery.Close;
  dsFiles.DataSet:=fqQuery;
  //dsFiles.Enabled:=False;
  fqQuery.Open('select * from Docs');
end;

procedure TfmGDriveSimpleDemo.acBrowseFilesExecute(Sender: TObject);
begin
  try
    RunQuery(fqFiles,'select * from Files');
  finally
    dsFiles.DataSet:=fqFiles;
    dsFiles.Enabled:=True;
  end;
end;

procedure TfmGDriveSimpleDemo.acBrowseFoldersExecute(Sender: TObject);
begin
  if fqQuery.Active then fqQuery.Close;
  dsFiles.DataSet:=fqQuery;
  //dsFiles.Enabled:=False;
  fqQuery.Open('select * from Folders');
end;

procedure TfmGDriveSimpleDemo.acBrowsePhotosExecute(Sender: TObject);
begin
  if fqQuery.Active then fqQuery.Close;
  dsFiles.DataSet:=fqQuery;
  //dsFiles.Enabled:=False;
  fqQuery.Open('select * from Photos');
end;

procedure TfmGDriveSimpleDemo.acBrowseSheetsExecute(Sender: TObject);
begin
  if fqQuery.Active then fqQuery.Close;
  dsFiles.DataSet:=fqQuery;
  //dsFiles.Enabled:=False;
  fqQuery.Open('select * from Sheets');
end;

procedure TfmGDriveSimpleDemo.acBrowseVideosExecute(Sender: TObject);
begin
  if fqQuery.Active then fqQuery.Close;
  dsFiles.DataSet:=fqQuery;
  //dsFiles.Enabled:=False;
  fqQuery.Open('select * from Videos');
end;

procedure TfmGDriveSimpleDemo.acCreateFolderExecute(Sender: TObject);
var fldnm: string;
begin
  if inputquery('','Enter folder name',fldnm) then begin
    fspNewFolder.Params.ParamByName('Name').AsString:=fldnm;
    fspNewFolder.Params.ParamByName('Parents').AsString:=dsFiles.DataSet.FieldByName('ParentIds').AsString;
    fspNewFolder.ExecProc;
    //fspNewFolder.ExecProc('CData.GoogleDrive.CreateFolder',[fldnm,'','True','False', dsFiles.DataSet.FieldByName('id').AsString]);
  end;

end;

procedure TfmGDriveSimpleDemo.acDescribeExecute(Sender: TObject);
begin
  if edCDataName.Text <> '' then begin
    fmShowboard.Memo1.Lines.Clear;
    Describe(edCDataName.Text, fmShowboard.memo1.Lines);
    fmShowboard.ShowBoard('Schema of "'+edCDataName.Text+'"');
  end;

end;

procedure TfmGDriveSimpleDemo.acDownloadFileExecute(Sender: TObject);
begin
  if (fqFiles.FieldByName('Folder').AsString <> 'True') then begin
    SaveDialog1.FileName:=fqFiles.FieldByName('Name').AsString;
    if SaveDialog1.Execute then
      fspDownload.ExecProc('CData.GoogleDrive.DownloadFile', [fqFiles.FieldByName('Id').AsString,
         '', //fqFiles.FieldByName('MIMEType').AsString,
         SaveDialog1.FileName]);
  end;
end;

procedure TfmGDriveSimpleDemo.acFilePermissionsExecute(Sender: TObject);
begin
  if fqPermissions.Active then fqPermissions.Close;
  fqPermissions.ParamByName('id').AsString := dsFiles.DataSet.FieldByName('Id').AsString;
  fqPermissions.Open();
  dsFiles.DataSet:=fqPermissions;
end;

procedure TfmGDriveSimpleDemo.acFileUploadExecute(Sender: TObject);
begin
 if OpenDialog1.Execute then
   if FileExists(OpenDialog1.FileName) then begin
   fspUpload.ParamByName('LocalFile').AsString:=OpenDialog1.FileName;
   fspUpload.ParamByName('Name').AsString:=ExtractFileName(OpenDialog1.FileName);
   fspUpload.ExecProc;
  end;
end;

procedure TfmGDriveSimpleDemo.acFindByNameExecute(Sender: TObject);
begin
  //if fqFiles.Active then fqFiles.Close;
  if Pos('%',EdSearch.Text) > 1 then
    RunQuery(fqFiles,'select * from Files where Name Like '''+EdSearch.Text+'''')
  else
    RunQuery(fqFiles,'select * from Files where Name = '''+EdSearch.Text+'''');

  dsFiles.DataSet:=fqFiles;
end;

procedure TfmGDriveSimpleDemo.acFolderSTreeExecute(Sender: TObject);
var
  tmpL: TStringList;
  nm: string;
begin
  nm:= fqFiles.FieldByName('Name').AsString;
  tmpL:=TStringList.Create;
  try
    ScanGoogleDriveDir(FDConnection1, nm,'*', 2, tmpL);
    fmShowboard.Memo1.Lines.Clear;
    fmShowboard.Memo1.Lines.AddStrings(tmpL);
    fmShowboard.Memo1.Lines.Add(Format('----- Total %d entry(s)',[tmpL.Count]));
    fmShowboard.ShowBoard('Folder Tree for '+nm);
  finally
    tmpL.Free;
  end;
end;

procedure TfmGDriveSimpleDemo.acFolderSTreeUpdate(Sender: TObject);
begin
  acFilePermissions.Enabled:=(fqFiles.Active and (fqFiles.RecordCount > 0)  );
  acFolderSTree.Enabled := acFilePermissions.Enabled;
  btApply.Enabled:=acFilePermissions.Enabled;
end;

procedure TfmGDriveSimpleDemo.btApplyClick(Sender: TObject);
begin
  //(DBGrid2.DataSource.DataSet as TFDQuery).ApplyUpdates(0);
  fqFiles.ApplyUpdates(0);
end;

procedure TfmGDriveSimpleDemo.CutVisualWidth(ds: TDataset);
var
  I: uint32;
begin
  for I := 0 to ds.Fields.Count-1 do begin
    if ds.Fields[i].DisplayWidth > DEFCOLWIDTH then
      ds.Fields[i].DisplayWidth := DEFCOLWIDTH;
  end;
end;

procedure TfmGDriveSimpleDemo.fqFilesAfterOpen(DataSet: TDataSet);
begin
  CutVisualWidth(Dataset);
end;

procedure TfmGDriveSimpleDemo.fqPermissionsAfterOpen(DataSet: TDataSet);
begin
  CutVisualWidth(DataSet);
end;

procedure TfmGDriveSimpleDemo.fqQueryAfterOpen(DataSet: TDataSet);
begin
  CutVisualWidth(Dataset);
end;

procedure TfmGDriveSimpleDemo.ftFilesAfterOpen(DataSet: TDataSet);
begin
 CutVisualWidth(Dataset);
end;

procedure TfmGDriveSimpleDemo.RunQuery(ds: TFDQuery; SQL: string);
begin
  if ds.Active then ds.Close;
  ds.Open(SQL);
end;

procedure TfmGDriveSimpleDemo.sbRunQueryClick(Sender: TObject);
begin
  RunQuery(fqQuery,meQuery.Lines.Text);
  dsFiles.DataSet:= fqQuery;
end;

procedure TfmGDriveSimpleDemo.Describe(const Table: string; Tgt:TStrings);
var
  Meta: TFDMetaInfoQuery;
  Attrs: TFDDataAttributes;
  Value: integer;
begin
  Meta := TFDMetaInfoQuery.Create(nil);
  try
    Meta.Connection := FDConnection1;
    Meta.MetaInfoKind := TFDPhysMetaInfoKind.mkTableTypeFields;
    Meta.ObjectName := Table;

    Meta.Open;
    try
      while not Meta.Eof do
      begin
        Value := Meta.FieldByName('COLUMN_ATTRIBUTES').AsInteger;
        Attrs := TFDDataAttributes(Pointer(@Value)^);

        Tgt.Add('Name: ' + Meta.FieldByName('COLUMN_NAME').AsString + ', ' +
                'Type: ' + Meta.FieldByName('COLUMN_TYPENAME').AsString + ', ' +
                'Nullable: ' + BoolToStr(caAllowNull in Attrs) + ', ' +
                'Auto increment: ' + BoolToStr(caAutoInc in Attrs));

        Meta.Next;
      end;
    finally
      Meta.Close;
    end;
  finally
    FreeAndNil(Meta);
  end;
end;

end.
