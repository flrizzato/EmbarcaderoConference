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
    ksTableView1: TksTableView;
    ToolBar2: TToolBar;
    procedure FormCreate(Sender: TObject);
  private

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

procedure TForm24.PopulateList;

begin
  ksTableView1.BeginUpdate;
  try
    ksTableView1.Items.AddItemSelector('Car', '', ['BMW', 'Mercedes', 'Ferrari', 'Bugatti']);
    ksTableView1.Items.AddItemSelector('Colour', '', ['Red', 'Green', 'Yellow', 'Blue']);
  finally
    ksTableView1.EndUpdate;
  end;
end;

end.
