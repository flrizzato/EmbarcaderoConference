unit untOtherForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ksTableView,
  ksFormTransition, FMX.StdCtrls, FMX.Controls.Presentation, ksTypes;

type
  TForm5 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    ksTableView1: TksTableView;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}


procedure TForm5.Button1Click(Sender: TObject);
begin
  PopForm;
end;

procedure TForm5.FormCreate(Sender: TObject);
var
  ICount: integer;
begin
  {$IFDEF MSWINDOWS}
  Width := FormFactor.Width;
  Height := FormFactor.Height;
  Left := 360;
  Top := 150;
  {$ENDIF}

  for ICount := 1 to 5 do
  begin
    ksTableView1.Items.AddItem('Setting '+InTtoStr(ICount)).AddSwitch(0, False);
  end;

end;

end.
