unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList;

type
  TFrmMain = class(TForm)
    BtnApply: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ListBoxLoadedStyles: TListBox;
    BtnRegister: TButton;
    ListBoxDiskStyles: TListBox;
    Panel1: TPanel;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure BtnRegisterClick(Sender: TObject);
  private
    procedure LoadRegisteredStyles;
    procedure LoadStylesFromDisk;
    procedure RegisterAndSetStyleFromDisk(const StyleFileName: string);
    procedure SetStyleByIndex(Index: Integer);
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  TypInfo,
  System.IOUtils,
  Vcl.Styles,
  Vcl.Themes;

  {$R *.dfm}

procedure TFrmMain.BtnRegisterClick(Sender: TObject);
begin
  if ListBoxDiskStyles.ItemIndex >= 0 then
  begin
    RegisterAndSetStyleFromDisk(ListBoxDiskStyles.Items
      [ListBoxDiskStyles.ItemIndex]);
    ListBoxDiskStyles.Items.Delete(ListBoxDiskStyles.ItemIndex);
    LoadRegisteredStyles;
  end;
end;

procedure TFrmMain.BtnApplyClick(Sender: TObject);
begin
  if ListBoxLoadedStyles.ItemIndex >= 0 then
    SetStyleByIndex(ListBoxLoadedStyles.ItemIndex);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LoadRegisteredStyles;
  LoadStylesFromDisk;
  ListBoxLoadedStyles.ItemIndex := 0;
end;

procedure TFrmMain.LoadRegisteredStyles;
Var
  Name: string;
begin
  for Name in TStyleManager.StyleNames do
    if ListBoxLoadedStyles.Items.IndexOf(Name) = -1 then
      ListBoxLoadedStyles.Items.Add(Name);
end;

procedure TFrmMain.LoadStylesFromDisk;
Var
  FileName: string;
begin
  for FileName in TDirectory.GetFiles
    (IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Styles',
    '*' + TStyleEngine.FileExtension) do
    ListBoxDiskStyles.Items.Add(FileName);
end;

procedure TFrmMain.RegisterAndSetStyleFromDisk(const StyleFileName: string);
begin
  TStyleManager.SetStyle(TStyleManager.LoadFromFile(StyleFileName))
end;

procedure TFrmMain.SetStyleByIndex(Index: Integer);
begin
  TStyleManager.SetStyle(ListBoxLoadedStyles.Items[Index]);
end;

end.
