unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ksTypes,
  ksCircleProgress, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm80 = class(TForm)
    Layout1: TLayout;
    ksCircleProgress1: TksCircleProgress;
    ToolBar1: TToolBar;
    Button1: TButton;
    ksCircleProgress2: TksCircleProgress;
    ksCircleProgress3: TksCircleProgress;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form80: TForm80;

implementation

uses FMX.Ani;

{$R *.fmx}

procedure TForm80.Button1Click(Sender: TObject);
begin
  ksCircleProgress1.Value := 0;
  ksCircleProgress2.Value := 0;
  ksCircleProgress3.Value := 0;

  TAnimator.AnimateFloat(ksCircleProgress1, 'Value', 100, 3);
  TAnimator.AnimateFloatDelay(ksCircleProgress2, 'Value', 100, 3, 0.7);
  TAnimator.AnimateFloatDelay(ksCircleProgress3, 'Value', 100, 3, 1.4);
end;

end.
