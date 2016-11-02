unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, ksTypes, ksTableView, ksSegmentButtons;

type
  TForm24 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    ToolBar2: TToolBar;
    ksTableView1: TksTableView;
    ksSegmentButtons1: TksSegmentButtons;
    procedure FormCreate(Sender: TObject);
    procedure ksSegmentButtons1Change(Sender: TObject);
  private
    function GetSelectedColor: TAlphaColor;
    procedure PopulateList;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24: TForm24;

implementation

uses System.UIConsts, TypInfo;

{$R *.fmx}

procedure TForm24.FormCreate(Sender: TObject);
begin
  PopulateList;
end;

function TForm24.GetSelectedColor: TAlphaColor;
begin
  Result := claNull;
  case ksSegmentButtons1.ItemIndex of
    0: Result := claSilver;
    1: Result := claRed;
    2: Result := claGreen;
    3: Result := claDodgerblue;
  end;
end;

procedure TForm24.ksSegmentButtons1Change(Sender: TObject);
begin
  PopulateList;
end;

procedure TForm24.PopulateList;
var
  ICount: TksAccessoryType;
  AEnumName: string;
  AItem: TksTableViewItem;
begin
  ksTableView1.AccessoryOptions.Color := GetSelectedColor;
  ksTableView1.BeginUpdate;
  try
    ksTableView1.ClearItems;
    for ICount := Low(TksAccessoryType) to High(TksAccessoryType) do
    begin
      AEnumName := GetENumName(TypeInfo(TksAccessoryType), Ord(ICount));
      AItem := ksTableView1.Items.AddItem(AEnumName, ICount);
      AItem.Accessory.Color := GetSelectedColor;
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

end.
