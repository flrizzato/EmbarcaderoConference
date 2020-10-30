unit uDMCdata;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataGoogleDrive, FireDAC.Phys.CDataGoogleDriveDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FMX.Dialogs, FMX.Types,System.Generics.Collections,
  uCDataGDriveTypes;

type
  TdmCdata = class(TDataModule, IGDrive, IGDFile)
    fdGDriveCon: TFDConnection;
    fqFiles: TFDQuery;
    fqTemp: TFDQuery;
    spCreateFolder: TFDStoredProc;
    spUploadFile: TFDStoredProc;
    spDownloadFile: TFDStoredProc;
    fqRead: TFDQuery;
    fqSearch: TFDQuery;
    fqInsert: TFDQuery;
    fqUpdate: TFDQuery;
    fqDelete: TFDQuery;
    fqPermissions: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure fdGDriveConAfterConnect(Sender: TObject);
  private
    { Private declarations }
    FRootPath: GDPath;
    FCurPath: GDPath;
    FPath: TStack<GDPath>;
    procedure SetRootPath(const Value: GDPath);
    function GetRootPath: GDPath;
  public
    { Public declarations }
    property RootPath: GDPath read FRootPath write SetRootPath;
    property CurPath: GDPath read FCurPath write FCurPath;
    function PathToStr: string;
    procedure GetFolderFileList(FolderId:TFileId);
    { IGDrive = interface }
    procedure Connect;
    function UploadFile(name:string; description: string; FolderId: TFileID; localfile: string): TFileID;
    function DownloadFile(FileId: TFileID; fName,FileFormat: string; localfile: string; Overwrite:Boolean): boolean;
    function CreateFolder(name:string; description: string; FolderId: TFileID):TFileId;
    procedure Search(name:string);
    procedure SearchType(typenm:string);
    procedure SearchDate(StartDate, EndDate: TDatetime);
    function GetTablesList: TStringList;
    function InFolder(fileId:TFileId): GDPath;
    procedure JumpUp;
    procedure JumpTo(newFolder: GDPath); overload;
    procedure JumpTo(id:TFileId;name:string); overload;
    procedure JumpToRoot;
    { IGDFile = interface }
    function ReadGDFile(id:TFileId; out Buffer:TGDFileRec):boolean;
    function InsertGDFile(Buffer:TGDFileRec):TFileId;
    function UpdateGDFile(Buffer:TGDFileRec):boolean;
    function DeleteGDFile(id:TFileId): boolean;
  end;

  TMyDataset = TFDDataset;
  _GDFileRec = TGDFileRec;
  _GDPath = GDPath;

  function IsColumnHere(ds: TFDDataset; fName: string): Boolean;

var
  dmCdata: TdmCdata;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function IsColumnHere(ds: TFDDataset; fName: string): Boolean;
begin
  Result := False;
  if ds.FieldDefs.IndexOf(fName) > -1 then
    Result := True;
end;

{ TdmCdata }

function TdmCdata.GetTablesList: TStringList;
begin
  Result := TStringList.Create;
  fdGDriveCon.GetTableNames('', '', '', Result);
end;

procedure TdmCdata.Connect;
begin
  {todo 2 :
    if OAuthToken<>'' then begin
      fdGDriveCon.Params.Values['OAuthAuthorizeToken']:=OAuthToken;
    end;
  }
  fdGDriveCon.Connected := True;
  // moved to AfterConnected Event
end;

function TdmCdata.CreateFolder(name, description: string; FolderId: TFileID): TFileId;
begin
  spCreateFolder.ParamByName('Name').AsString := name;
  spCreateFolder.ParamByName('Parents').AsString := String(FolderID);
  if description <> '' then
    spUploadFile.ParamByName('Description').AsString := description;
  spCreateFolder.ExecProc;
end;

procedure TdmCdata.DataModuleCreate(Sender: TObject);
begin
  FPath:= TStack<GDPath>.Create;
  //  FRootPath: GDPath;
  //  FCurPath: GDPath;
end;

procedure TdmCdata.DataModuleDestroy(Sender: TObject);
begin
 FPath.Free;
end;

function TdmCdata.DeleteGDFile(id: TFileId): boolean;
begin
  fqDelete.ParamByName('fId').AsString:=string(id);
  try
    fqDelete.ExecSQL;
    Result:=True;
  except
    Result:=False;
  end;
end;

function TdmCdata.DownloadFile(FileId: TFileID; fName, FileFormat, localfile: string; Overwrite: Boolean): boolean;
begin
  Result := False;
  spDownloadFile.ParamByName('LocalFile').AsString := localfile;
  spDownloadFile.ParamByName('Id').AsString := String(FileId);
  spDownloadFile.ParamByName('FileFormat').AsString := FileFormat;
  if Overwrite then
    spDownloadFile.ParamByName('Overwrite').AsString := 'true'
  else
    spDownloadFile.ParamByName('Overwrite').AsString := 'false';
  spDownloadFile.ExecProc;
  Result := (spDownloadFile.ParamByName('success').AsString = 'true');
end;

procedure TdmCdata.fdGDriveConAfterConnect(Sender: TObject);
begin
  FRootPath := GetRootPath;
  JumpToRoot;
end;

procedure TdmCdata.GetFolderFileList(FolderId: TFileId);
begin
  fqfiles.Close;
  fqFiles.ParamByName('pId').AsString:=FolderID;
  fqFiles.Open;
end;

function TdmCdata.GetRootPath: GDPath;
var tsql: string;
begin
  tsql := 'select ParentIds from Files where Query='' ''''root'''' in parents'' limit 1';
  fqTemp.Open(tsql);
  if not fqTemp.Eof then begin
    Result.FolderID:= TFileId(fqTemp.FieldByName('ParentIds').AsString);
    Result.FolderName:='My Drive';
    Result.ParentID:='';
  end;
  fqTemp.Close;
end;

function TdmCdata.InFolder(fileId: TFileId): GDPath;
var tsql: string;
begin
  tsql := 'select F.Id, F.Name, F.ParentIds from Files S, Folders F where S.Id=''' +
    fileId + ''' and F.Id = S.parentIds limit 1';
  fqTemp.Open(tsql);
  if not fqTemp.Eof then begin
    Result.FolderID := TFileId(fqTemp.FieldByName('Id').AsString);
    Result.FolderName := TFileId(fqTemp.FieldByName('name').AsString);
    Result.ParentID := TFileId(fqTemp.FieldByName('ParentIds').AsString);
  end;
  fqTemp.Close;
end;

function TdmCdata.InsertGDFile(Buffer: TGDFileRec): TFileId;
begin
  Result:='';
  fqInsert.ParamByName('Name').AsString:=Buffer.Name;
  fqInsert.ParamByName('Description').AsString:=Buffer.Description;
  fqInsert.ParamByName('MIME').AsString:=Buffer.MIMEType;
  fqInsert.ParamByName('Starred').AsBoolean:=Buffer.Starred;
  fqInsert.ExecSQL;
  Result:= Buffer.ParentIds;
end;

procedure TdmCdata.JumpTo(newFolder: GDPath);
begin
  //  tsql:='select * from Files where ''' + string(folderId) +''' in (parentids)';
  //  tsql := tsql + ' and Trashed = ''False'' order by Folder Desc';
  //  fqFiles.Open(tsql);

  //  fqfiles.Close;
  //  fqFiles.ParamByName('pId').AsString:=newFolder.FolderID;
  //  fqFiles.Open;

  GetFolderFileList(newFolder.FolderID);
  FPath.Push(FCurPath);
  FCurPath:=newFolder;
end;

procedure TdmCdata.JumpTo(id: TFileId; name: string);
var
  bpath:GDPath;
begin
  bpath.FolderID:=id;
  bpath.FolderName:=name;
  bpath.ParentID:=FCurPath.FolderID;
  JumpTo(bpath);
end;

procedure TdmCdata.JumpToRoot;
begin
  JumpTo(FRootPath);
  FPath.Clear;
end;

procedure TdmCdata.JumpUp;
var tgtFolder: GDPath;
begin
  if FPath.Count > 0 then begin
    tgtFolder:=FPath.Pop;
    fqfiles.Close;
    fqFiles.ParamByName('pId').AsString:=tgtFolder.FolderID;
    fqFiles.Open;
    FCurPath:=tgtFolder;
  end;
end;

function TdmCdata.PathToStr: string;
var
  spart: string;
  //spart: GDPath;
  inarray: TArray<GDPath>;
  i: Integer;
begin
  Result:='';
  inarray:=FPath.ToArray;
  for i:=FPath.Count-1 downto 0 do begin
    spart := inarray[i].FolderName;
    Result := spart + '\' + Result;
  end;
  Result:=Result + FCurPath.FolderName;
end;

function TdmCdata.ReadGDFile(id: TFileId; out Buffer: TGDFileRec): boolean;
begin
  fqRead.ParamByName('Id').AsString:=string(id);
  Result:=False;
  fqRead.Open;
  try
    if fqRead.RecordCount > 0 then begin
      Result:=True;
      //if fqRead.Fields['id'] <> nil then
        Buffer.Id := fqRead.FieldByName('Id').AsString;
      Buffer.Name := fqRead.FieldByName('Name').AsString;
      Buffer.Description := fqRead.FieldByName('Description').AsString;
      Buffer.Extension := fqRead.FieldByName('Extension').AsString;
      Buffer.MIMEType := fqRead.FieldByName('MIMEType').AsString;
      Buffer.CreatedTime := fqRead.FieldByName('CreatedTime').AsDateTime;
      Buffer.ModifiedTime := fqRead.FieldByName('ModifiedTime').AsDateTime;
      Buffer.Size := fqRead.FieldByName('Size').AsInteger;
      Buffer.OwnerName := fqRead.FieldByName('OwnerName').AsString;
      Buffer.OwnerEmail := fqRead.FieldByName('OwnerEmail').AsString;
      Buffer.Folder := fqRead.FieldByName('Folder').AsBoolean;
      Buffer.Starred := fqRead.FieldByName('Starred').AsBoolean;
      Buffer.Hidden := fqRead.FieldByName('Hidden').AsBoolean;
      Buffer.Trashed := fqRead.FieldByName('Trashed').AsBoolean;
      Buffer.Viewed := fqRead.FieldByName('Viewed').AsBoolean;
      Buffer.ParentIds := fqRead.FieldByName('ParentIds').AsString;
      Buffer.ChildIds := fqRead.FieldByName('ChildIds').AsString;
      Buffer.ChildLinks := fqRead.FieldByName('ChildLinks').AsString;
    end;
  finally
    fqRead.Close;
  end;
  // todo 1 : Add File Permissions reading
end;

procedure TdmCdata.Search(name: string);
begin
  if Pos('%',name) > 1 then
    fqSearch.Open('select * from Files where Name Like '''+name+'''')
  else
    fqSearch.Open('select * from Files where Name = '''+name+'''');
end;

procedure TdmCdata.SearchDate(StartDate, EndDate: TDatetime);
begin
  //todo 1 : check dates validity
  fqSearch.Open('select Name, ModifiedTime, Starred, OwnerName from Files where ModifiedTime > '
    + DateToStr(StartDate)+' and ModifiedTime < ' + DateToStr(EndDate));
end;

procedure TdmCdata.SearchType(typenm: string);
var
  ltype, sqlfrom: string;
begin
  //application/pdf
  ltype:= typenm.ToLower;
  if ltype = 'folders' then
    sqlfrom := ' from Folders'
  else if ltype = 'photos' then
    sqlfrom := ' from Photos'
  else if ltype = 'sheets' then
    sqlfrom := ' from Sheets'
  else if (ltype = 'docs') or (ltype = 'pdf')then
    sqlfrom := ' from Docs'
  else if ltype = 'videos' then
    sqlfrom := ' from Videos'
  else if ltype = 'trashed' then
    sqlfrom := ' from Files where Trashed = ''True'''
  else
    exit;

  fqSearch.Open('select Id,Name,ModifiedTime,Starred,OwnerName ' + sqlfrom);
end;

procedure TdmCdata.SetRootPath(const Value: GDPath);
begin
  FRootPath := Value;
end;

function TdmCdata.UpdateGDFile(Buffer: TGDFileRec): boolean;
begin
  fqUpdate.ParamByName('Id').AsString:=Buffer.Id;
  fqUpdate.ParamByName('Name').AsString:=Buffer.Name;
  fqUpdate.ParamByName('Description').AsString:=Buffer.Description;
  fqUpdate.ParamByName('MIME').AsString:=Buffer.MIMEType;
  fqUpdate.ParamByName('Starred').asBoolean:=Buffer.Starred;
  try
    fqUpdate.ExecSQL;
    Result:=True;
  except
    Result:=False;
  end;
end;

function TdmCdata.UploadFile(name, description: string; FolderId: TFileID; localfile: string): TFileID;
begin
  spUploadFile.ParamByName('LocalFile').AsString := localfile;
  spUploadFile.ParamByName('Name').AsString := name; //ExtractFileName(localfile);
  spUploadFile.ParamByName('Parents').AsString := String(FolderID);
  if description <> '' then
    spUploadFile.ParamByName('Description').AsString := description;
  spUploadFile.ExecProc;
end;

end.
