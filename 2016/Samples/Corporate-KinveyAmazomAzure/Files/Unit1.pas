unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.TabControl;

type
  TForm1 = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    Image1: TImage;
    ListBox2: TListBox;
    TabControl1: TTabControl;
    tbStorage: TTabItem;
    tbTables: TTabItem;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure SpeedButton1Click(Sender: TObject);
  private
    function ByteContent(DataStream: TStream): TBytes;
    function UpLoad(AFileName: string): Boolean;
    function InsertRow(AFileName: string): Boolean;
    procedure ListRows;
    function DeleteRow(AFileName: string): Boolean;
    function DeleteFile(AFileName: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  tableName = 'imagens';
  columnName = 'imagem';
  bucketName = 'meuteste1';

implementation

{$R *.fmx}

uses Unit2, System.Generics.Collections;

function TForm1.DeleteFile(AFileName: string): Boolean;
var
  bstr: TBytesStream;
  amazonService: TAmazonStorageService;
begin
  bstr := TBytesStream.Create;
  try
    Image1.Bitmap.SaveToStream(bstr);
    amazonService := TAmazonStorageService.Create(AmazonConnectionInfo1);
    try
      Result := amazonService.DeleteObject(bucketName, AFileName);
    finally
      amazonService.Free;
    end;
  finally
    bstr.Free;
  end;
end;

function TForm1.DeleteRow(AFileName: string): Boolean;
var
  tableService: TAmazonTableService;
begin
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    Result := tableService.DeleteRow(tableName, AFileName);
  finally
    tableService.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := tbStorage;
end;

function TForm1.InsertRow(AFileName: string): Boolean;
var
  aTableRow: TCloudTableRow;
  tableService: TAmazonTableService;
begin
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    aTableRow := TCloudTableRow.Create;
    try
      aTableRow.SetColumn(columnName, AFileName);
      Result := tableService.InsertRow(tableName, AFileName, aTableRow, nil);
    finally
      aTableRow.Free;
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.ListRows;
var
  tableService: TAmazonTableService;
  rows: TList<TCloudTableRow>;
  row: TCloudTableRow;
begin
  ListBox2.Clear;
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    rows := tableService.GetRows(tableName);
    if rows <> nil then
    begin
      for row in rows do
      begin
        ListBox2.Items.Add(row.Columns[0].Value);
      end;
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Image1.Bitmap.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  fileName: string;
begin
  fileName := ListBox2.Selected.Text;
  if DeleteRow(fileName) then
  begin
    if DeleteFile(fileName) then
    begin
      ListRows;
      ShowMessage('Imagem apagada com sucesso.');
    end;
  end;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  ListRows;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  fileName: string;
begin
  //fileName := TUtils.GenerateFileName;
  fileName := ExtractFileName(OpenDialog1.FileName);
  if UpLoad(fileName) then
  begin
    if InsertRow(fileName) then
    begin
      ListRows;
      ShowMessage('Imagem enviada com sucesso.');
    end;
  end;
end;

procedure TForm1.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

function TForm1.UpLoad(AFileName: string): Boolean;
var
  bstr: TBytesStream;
  amazonService: TAmazonStorageService;
  Content: TBytes;
  RespInfo: TCloudResponseInfo;
begin
  bstr := TBytesStream.Create;
  try
    Image1.Bitmap.SaveToStream(bstr);
    amazonService := TAmazonStorageService.Create(AmazonConnectionInfo1);
    try
      RespInfo := TCloudResponseInfo.Create;
      try
        Result := amazonService.UploadObject(bucketName, AFileName, bstr.Bytes);
      finally
        RespInfo.Free;
      end;
    finally
      amazonService.Free;
    end;
  finally
    bstr.Free;
  end;
end;

function TForm1.ByteContent(DataStream: TStream): TBytes;
var
  Buffer: TBytes;
begin
  if not Assigned(DataStream) then
    exit(nil);

  SetLength(Buffer, DataStream.Size);
  // the content may have been read
  DataStream.Position := 0;
  if DataStream.Size > 0 then
    DataStream.Read(Buffer[0], DataStream.Size);

  Result := Buffer;
end;

end.
