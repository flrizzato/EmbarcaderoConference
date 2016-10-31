unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.JumpList, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    JumpList1: TJumpList;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
  private
   function CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
  public
   procedure DropFiles(var Msg: TWmDropFiles); message wm_DropFiles;
   procedure CopyData(var Msg: TWmCopyData); message wm_CopyData;
	 procedure OpenFile (filename: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ShellAPI;

function TForm1.CmdLineOpenFiles(AMultipleFiles: boolean): boolean;
var
 i, Cnt: integer;
begin
 Cnt := ParamCount;
 if Cnt > 0 then
  begin
    if not AMultipleFiles and (Cnt > 1) then
      Cnt := 1;
    for i := 1 to Cnt do
      OpenFile (ParamStr(i));
    Result := True;
 end
 else
   Result := False;
end;

procedure TForm1.CopyData(var Msg: TWmCopyData);
var
 Filename: string;
begin
  // restore the window if minimized
  if IsIconic(Application.Handle) then
    Application.Restore;

  // extract the filename from the data
  SetLength(FileName, Msg.CopyDataStruct.cbData);
  StrCopy(PChar(FileName), Msg.CopyDataStruct.lpData);
  Filename := PChar(FileName);
  // open the file
  OpenFile (FileName);
end;

procedure TForm1.DropFiles(var Msg: TWmDropFiles);
var
 nFiles, I: Integer;
 Filename: string;
 jumpItem: TJumpListItem;
begin
  // get the number of dropped files
  nFiles := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0);
  // for each file
  try
    for I := 0 to nFiles - 1 do
    begin
      // allocate memory
    SetLength(Filename, 1024);
      // read the file name
      DragQueryFile(Msg.Drop, I, PChar(Filename), 1024 * 2);
      // normalize file
      Filename := PChar(Filename);
      // open the file
      OpenFile(FileName);
      // add file to Jump List
      jumpItem := JumpList1.CustomCategories[0].Items.Add as TJumpListItem;
      jumpItem.FriendlyName := ExtractFilename (Filename);
      jumpItem.Arguments := Filename; // full path

    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 CmdLineOpenFiles(TRUE);
 // accept dragging to the form
 DragAcceptFiles(Handle, True);
end;

procedure TForm1.OpenFile(filename: string);
begin
  // this is just a placeholder
  ListBox1.Items.Add (filename);
end;

end.
