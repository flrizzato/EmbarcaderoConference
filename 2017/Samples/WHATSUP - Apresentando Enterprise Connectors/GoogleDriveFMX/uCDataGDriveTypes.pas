unit uCDataGDriveTypes;

interface

uses
   FireDAC.Comp.DataSet;

Type
  TFileId = string;

  GDPath = record
    FolderID: TFileId;
    FolderName: string;
    ParentID: TFileId;
  end;

  TGDFileRec = record
    Id: String;           // RO:True  The ID of the file.
    Name: String;         //          The name of the file.
    { This is not necessarily unique within a folder.
      Note that for immutable items such as the top level folders of Team Drives, My Drive root folder,
      and Application Data folder the name is constant. }
    Description: string;  //          A short description of the file or folder.
    Extension: String;    // RO:True  The extension of the file.
    MIMEType: String;     //          The MIME type of the file.
    CreatedTime: TDatetime; //RO:True The creation date of the file or folder.
    ModifiedTime: TDatetime;//RO:True The last modified date of the file or folder.
    Size: integer;        //RO:True   The size of the file in bytes.
    OwnerName: String;    //RO:True   The name of the resource's owner.
    OwnerEmail: String;   // RO:True  The email of the resource's owner.

    Folder: Boolean;      // RO:True  This field shows whether or not the resource is a folder.
    Starred: Boolean;     //          This field sets whether or not the resource is starred.
    Hidden: Boolean;      // RO:True  This field sets whether or not the resource is hidden.
    Trashed: Boolean;     // RO:True  This field sets whether or not the resource has been moved to the trash.
    Viewed: Boolean;      // RO:True  This field sets whether or not the resource has been viewed by the current user.

    ParentIds: TFileId;  // RO:True   A semicolon-separated list of parent folder Ids.
    ChildIds: TFileId;   // RO:True   A semicolon-separated list of child resource Ids.
    ChildLinks: TFileId; // RO:True   A semicolon-separated list of child resource links.
  end;

  IGDrive = interface
    procedure Connect;
    function GetRootPath: GDPath;
    function UploadFile(name:string; description: string; FolderId: TFileID; localfile: string): TFileID;
    function DownloadFile(FileId: TFileID; fName,FileFormat: string; localfile: string; Overwrite:Boolean): boolean;
    function CreateFolder(name:string; description: string; FolderId: TFileID):TFileId;
    procedure Search(name:string);
    procedure SearchType(typenm:string);
    procedure SearchDate(StartDate, EndDate: TDatetime);
    function InFolder(fileId:TFileId): GDPath;
    procedure JumpUp;
    procedure JumpTo(newFolder: GDPath);
    procedure JumpToRoot;
  end;

  IGDFile = interface
    function ReadGDFile(id:TFileId; out Buffer:TGDFileRec):boolean;
    function InsertGDFile(Buffer:TGDFileRec):TFileId;
    function UpdateGDFile(Buffer:TGDFileRec):boolean;
    function DeleteGDFile(id:TFileId): boolean;
  end;
 (*
Update The following example executes a parameterized:

RowsAffected := FDConnection1.ExecSQL('update Files set Name=:Name where Id = :Id', ['My File 2','S']);

Insert

RowsAffected := FDConnection1.ExecSQL('insert into Files (Name) values (:Name)', ['My File']);

Delete

RowsAffected:= FDConnection1.ExecSQL('delete from Files set Id = :Id', ['S']);
*)

implementation

end.
