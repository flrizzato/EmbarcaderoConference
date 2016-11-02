unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, ksTypes,
  ksVirtualListView;

type
  TForm24 = class(TForm)
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    ksVirtualListView1: TksVirtualListView;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
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

procedure TForm24.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.IsChecked then
    ksVirtualListView1.CheckBoxes.Mode := TksSelectionType.ksMultiSelect
  else
    ksVirtualListView1.CheckBoxes.Mode := TksSelectionType.ksSingleSelect;
end;

procedure TForm24.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: ksVirtualListView1.CheckBoxes.Alignment := TksVListCheckBoxAlign.ksCbLeftAlign;
    1: ksVirtualListView1.CheckBoxes.Alignment := TksVListCheckBoxAlign.ksCbRightAlign;
  end;
end;

procedure TForm24.FormCreate(Sender: TObject);
var
  ICount: integer;
begin
  // add 20 items to the ksVirtualListView1...
  ksVirtualListView1.BeginUpdate;
  try
    for ICount := 1 to 20 do
      ksVirtualListView1.Items.Add('Item: '+IntToStr(ICount), '', '', atNone);
  finally
    ksVirtualListView1.EndUpdate;
  end;
end;

end.
