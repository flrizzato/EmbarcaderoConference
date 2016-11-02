unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, ksTableView, ksTypes;

type
  TForm24 = class(TForm)
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ksTableView1DropItem(Sender: TObject; ADragRow, ADropRow: TksTableViewItem; var AllowMove: Boolean);
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
begin
  // add 50 items to the ksTableView...
  ksTableView1.BeginUpdate;
  try
    for ICount := 1 to 10 do
    begin
      ksTableView1.Items.AddItem('Item: '+IntToStr(ICount),'sub title', 'some detail', atMore);
      //if ICount mod 2 = 0 then
      ///  ksTableView1.Items.AddHeader('HEADER '+IntToStr(ICount));
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

procedure TForm24.ksTableView1DropItem(Sender: TObject; ADragRow, ADropRow: TksTableViewItem; var AllowMove: Boolean);
begin
 application.mainform.caption := (IntToStr(ADragRow.Index)+'  '+IntToStr(ADropRow.Index));;

  AllowMove := True;
end;

end.
