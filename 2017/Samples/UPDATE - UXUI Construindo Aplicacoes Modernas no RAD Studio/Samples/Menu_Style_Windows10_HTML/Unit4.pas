unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.MultiView, FMX.Controls.Presentation, ceffmx,
  ceflib;

type
  TForm4 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Layout2: TLayout;
    Layout3: TLayout;
    MultiView1: TMultiView;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    StyleBook1: TStyleBook;
    ChromiumFMX1: TChromiumFMX;
    procedure FormCreate(Sender: TObject);
    procedure ChromiumFMX1AddressChange(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.ChromiumFMX1AddressChange(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; const url: ustring);
begin
    ChromiumFMX1.Browser.GoBack;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  ChromiumFMX1.Load('C:\Users\thuli\Desktop\Conference\UX_UI\Samples\Menu_Style_Windows10_HTML\html\index.html');
end;

end.
