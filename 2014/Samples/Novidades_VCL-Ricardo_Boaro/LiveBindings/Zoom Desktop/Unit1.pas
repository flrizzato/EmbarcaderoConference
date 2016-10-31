unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BindingsList1: TBindingsList;
    BindExpression1: TBindExpression;
    TrackBar1: TTrackBar;
    BindExpression2: TBindExpression;
    BindExpression3: TBindExpression;
    procedure Edit1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1Change(Sender: TObject);
begin
 BindingsList1.Notify(Sender,'');
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 BindingsList1.Notify(Sender,'');
end;

end.
