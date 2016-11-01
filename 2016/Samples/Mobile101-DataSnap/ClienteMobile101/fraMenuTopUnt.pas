unit fraMenuTopUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.MultiView;

type
  TfraMenuTop = class(TFrame)
    Image1: TImage;
    ToolBar1: TToolBar;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    btnMenu: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
