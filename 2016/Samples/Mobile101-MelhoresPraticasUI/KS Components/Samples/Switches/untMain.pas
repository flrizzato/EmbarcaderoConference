unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, ksTypes, ksTableView;

type
  TForm24 = class(TForm)
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ksTableView1SwitchClick(Sender: TObject; AItem: TksTableViewItem; ASwitch: TksTableViewItemSwitch; ARowID: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24: TForm24;

implementation

uses System.UIConsts;

{$R *.fmx}

procedure TForm24.FormCreate(Sender: TObject);
var
  ICount: integer;
  AItem: TksTableViewItem;
begin
  // add 50 items to the ksTableView...
  ksTableView1.BeginUpdate;
  try
    for ICount := 1 to 20 do
    begin
      AItem := ksTableView1.Items.AddItem('Item: '+IntToStr(ICount), atNone);
      AItem.AddSwitch(0, False, TksTableItemAlign.Trailing);
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

procedure TForm24.ksTableView1SwitchClick(Sender: TObject; AItem: TksTableViewItem; ASwitch: TksTableViewItemSwitch; ARowID: string);
var
  AStr: string;
begin
    // show a message for the switch toggled...
  case ASwitch.Checked of
    True: AStr := 'Checked';
    False: AStr := 'Unchecked';
  end;
  ShowMessage('Switch on on item index '+IntToStr(AItem.Index)+' - '+AStr);
end;

end.
