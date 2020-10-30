unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.Themes,
  Vcl.ImgList;

type
  TForm13 = class(TForm)
    Edit1: TEdit;
    PopupMenu1: TPopupMenu;
    Item12: TMenuItem;
    Item23: TMenuItem;
    Item32: TMenuItem;
    Item42: TMenuItem;
    ListBox1: TListBox;
    CheckBox1: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N2: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    Contents1: TMenuItem;
    Contents2: TMenuItem;
    Contents3: TMenuItem;
    Contents4: TMenuItem;
    SearchforHelpOn1: TMenuItem;
    HowtoUseHelp1: TMenuItem;
    About1: TMenuItem;
    ImageList1: TImageList;
    N3: TMenuItem;
    Checked1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

{$R *.dfm}

procedure TForm13.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    TStyleManager.SystemHooks := TStyleManager.SystemHooks + [shMenus]
  else
    TStyleManager.SystemHooks := TStyleManager.SystemHooks - [shMenus];
end;

procedure TForm13.FormCreate(Sender: TObject);
var
  StyleName: string;
begin
  for StyleName in TStyleManager.StyleNames do
    ListBox1.Items.Add(StyleName);
end;

procedure TForm13.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <> -1 then
    TStyleManager.SetStyle(ListBox1.Items[ListBox1.ItemIndex]);
end;

procedure TForm13.About1Click(Sender: TObject);
begin
  ShowMessage('Hello from "About" box');
end;

end.
