unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.StdCtrls, FMX.Edit, FMX.Layouts,
  FMX.ListBox, Data.DB, Datasnap.DBClient, Data.Bind.DBScope, FMX.Gestures,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    EdtCod: TEdit;
    EdtName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ToolBar1: TToolBar;
    Label3: TLabel;
    Label4: TLabel;
    EdtAdress: TEdit;
    BindingsList1: TBindingsList;
    Label5: TLabel;
    TrackBar1: TTrackBar;
    BindExpression3: TBindExpression;
    EdtFontSize: TEdit;
    BindExpression4: TBindExpression;
    LinkControlToProperty1: TLinkControlToProperty;
    Label6: TLabel;
    ListBox1: TListBox;
    BindSourceDB1: TBindSourceDB;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Codigo: TIntegerField;
    ClientDataSet1Nome: TStringField;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    BindList1: TBindList;
    BindExpression1: TBindExpression;
    BindExpression2: TBindExpression;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
 if EventInfo.GestureID = sgiUp then
  begin
   TrackBar1.Value := TrackBar1.Value + 1;
   TrackBar1Change(Self);
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 BindingsList1.Notify(Sender,'');
end;

end.
