unit untMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation,
  FMX.StdCtrls, ksTypes, ksLoadingIndicator, FMX.Edit;

type
  TForm64 = class(TForm)
    ToolBar2: TToolBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ksLoadingIndicator1: TksLoadingIndicator;
    Button1: TButton;
    Button2: TButton;
    Switch1: TSwitch;
    Modal: TLabel;
    Label2: TLabel;
    Switch2: TSwitch;
    timer3secs: TTimer;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Switch3: TSwitch;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure Switch2Switch(Sender: TObject);
    procedure timer3secsTimer(Sender: TObject);
    procedure Switch3Switch(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form64: TForm64;

implementation

{$R *.fmx}

procedure TForm64.Button1Click(Sender: TObject);
begin
  if ksLoadingIndicator1.IsModal then
    timer3secs.Enabled := True;

  ksLoadingIndicator1.LoadingText.Text := Edit1.Text;
  ksLoadingIndicator1.ShowLoading;
end;

procedure TForm64.Button2Click(Sender: TObject);
begin
  ksLoadingIndicator1.HideLoading;
end;

procedure TForm64.Switch1Switch(Sender: TObject);
begin
  ksLoadingIndicator1.IsModal := Switch1.IsChecked;
end;

procedure TForm64.Switch2Switch(Sender: TObject);
begin
  ksLoadingIndicator1.FadeBackground := Switch2.IsChecked;
end;

procedure TForm64.Switch3Switch(Sender: TObject);
begin
  ksLoadingIndicator1.LoadingText.Visible := Switch3.IsChecked;
end;

procedure TForm64.timer3secsTimer(Sender: TObject);
begin
  // auto hide the inidicator (if modal) after 3 seconds...
  timer3secs.Enabled := False;
  ksLoadingIndicator1.HideLoading;
end;

end.
