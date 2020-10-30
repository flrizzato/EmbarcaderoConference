unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Fmx.Bind.GenData, Data.Bind.GenData, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView, MultiDetailAppearanceU, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmMain = class(TForm)
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    ToolBar1: TToolBar;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  I     : Integer;
  Grupo : Integer;
  Item  : Integer;
  Cont  : Integer;
begin
  with ListView1.Items.Insert(0) do
  begin
    Text    := 'Grupo 0';
    Purpose := TListItemPurpose.Header;
  end;

  Cont  := 0;
  Grupo := 0;

  for I := 0 to Pred(ListView1.Items.Count) do
  begin
    Inc(Cont);
    if Cont = 10 then
    begin
      Inc(Grupo);
      with ListView1.Items.Insert(I+1) do
      begin
        Text := Format('Grupo %d', [Grupo]);
        Purpose := TListItemPurpose.Header;
      end;
      Cont := 0;
    end;
  end;



//  for Grupo in [1..4] do
//  begin
//    Inc(Cont);
//    if Cont = 10 then
//    begin
//      with ListView1.Items.Insert(Grupo) do
//      begin
//        Text := Format('Grupo %d', [Grupo]);
//        Purpose := TListItemPurpose.Header;
//      end;
//      Cont := 0;
//    end;
////    for Item in [1..10] do
////      ListView1.Items.Add.Text := Format('Regular item %d.%d', [Grupo, Item]);
//  end;
end;

end.
