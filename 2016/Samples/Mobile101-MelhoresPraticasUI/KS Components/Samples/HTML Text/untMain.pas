unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, ksTableView,
  FMX.Objects, ksTypes;

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
  AItem: tkstableviewitem;
begin
  ksTableView1.BeginUpdate;
  try

    for ICount := 1 to 50 do
    begin
      AItem := ksTableView1.Items.AddItem('', atMore);
      with AItem.Title do
      begin
        Text := ('<font size="16"><B>Some</B> HTML text in <I><font color="#0000FF">TksTableView</FONT></I><font color="#FF0000">  :-)</font>');
        IsHtmlText := True;
      end;
    end;
  finally
    ksTableView1.EndUpdate;
  end;
end;

end.
