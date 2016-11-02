unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, ksTypes, ksTableView, ksSegmentButtons;

type
  TForm24 = class(TForm)
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ksSegmentButtons1: TksSegmentButtons;
    Label2: TLabel;
    switchSelect: TSwitch;
    procedure FormCreate(Sender: TObject);
    procedure ksSegmentButtons1Change(Sender: TObject);
    procedure switchSelectSwitch(Sender: TObject);
    procedure ksTableView1IndicatorExpand(Sender: TObject; AItem: TksTableViewItem; ABackground: TAlphaColor; var AForeground: TAlphaColor);
    procedure ksTableView1ItemClick(Sender: TObject; x, y: Single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
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
begin
  ksTableView1.BeginUpdate;
  try
    ksTableView1.Items.AddItem('Red', atMore).IndicatorColor := claRed;
    ksTableView1.Items.AddItem('Orange', atMore).IndicatorColor := claOrange;
    ksTableView1.Items.AddItem('Yellow', atMore).IndicatorColor := claYellow;
    ksTableView1.Items.AddItem('Green', atMore).IndicatorColor := claGreenyellow;
    ksTableView1.Items.AddItem('Blue', atMore).IndicatorColor := claBlue;
    ksTableView1.Items.AddItem('Indigo', atMore).IndicatorColor := claIndigo;
    ksTableView1.Items.AddItem('Violet', atMore).IndicatorColor := claViolet;
  finally
    ksTableView1.EndUpdate;
  end;
end;

procedure TForm24.ksSegmentButtons1Change(Sender: TObject);
begin
  case ksSegmentButtons1.ItemIndex of
    0: ksTableView1.RowIndicators.Alignment := TksTableViewRowIndicatorAlign.ksRowIndicatorLeft;
    1: ksTableView1.RowIndicators.Alignment := TksTableViewRowIndicatorAlign.ksRowIndicatorRight;
  end;
end;

procedure TForm24.ksTableView1IndicatorExpand(Sender: TObject; AItem: TksTableViewItem; ABackground: TAlphaColor; var AForeground: TAlphaColor);
begin
  if ABackground = claRed then AForeground := claWhite;
  if ABackground = claOrange then AForeground := claWhite;
  if ABackground = claBlue then AForeground := claWhite;
  if ABackground = claIndigo then AForeground := claWhite;
  if ABackground = claViolet then AForeground := claWhite;
end;

procedure TForm24.ksTableView1ItemClick(Sender: TObject; x, y: Single; AItem: TksTableViewItem; AId: string; ARowObj: TksTableViewItemObject);
begin
  ShowMessage(aid);
end;

procedure TForm24.switchSelectSwitch(Sender: TObject);
begin
  ksTableView1.RowIndicators.SelectRow := switchSelect.IsChecked;
  ksTableView1.SelectionOptions.ShowSelection := not switchSelect.IsChecked;
end;

end.
