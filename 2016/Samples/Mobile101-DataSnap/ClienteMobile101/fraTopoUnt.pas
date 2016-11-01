unit fraTopoUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.MultiView, FMX.Edit, FMX.ListBox;

type
  TfraTopo = class(TFrame)
    FrameLay: TLayout;
    FrameTopLay: TLayout;
    imgTopFrame: TImage;
    ToolBar1: TToolBar;
    Rectangle1: TRectangle;
    btnFrameMenu: TButton;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    MultiView1: TMultiView;
    btnVoltar: TButton;
    Rectangle2: TRectangle;
    Label1: TLabel;
    ComboBox1: TComboBox;
    edtLocalizar: TEdit;
    btnLocalizar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
