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
  AEdit: TksTableViewItemEmbeddedEdit;
begin
  // add 20 items to the ksTableView...
  ksTableView1.BeginUpdate;
  try
    for ICount := 1 to 20 do
    begin
      AItem := ksTableView1.Items.AddItem('Edit box: '+IntToStr(ICount), atNone);
      // add an edit box to the table item...
      AEdit := AItem.AddEdit(0, 0, 150, '');
      AEdit.Align := TksTableItemAlign.Trailing;
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

end.
