unit uFormOSVersion;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts, FMX.Memo,
  FMX.Objects;

type
  TFormOSVersion = class(TForm)
    ButtonGetOSInfo: TButton;
    PanelTop: TPanel;
    MemoLog: TMemo;
    Image1: TImage;
    procedure ButtonGetOSInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOSVersion: TFormOSVersion;

implementation

{$R *.fmx}

uses
  uOSVersionUtils;

procedure TFormOSVersion.ButtonGetOSInfoClick(Sender: TObject);
begin
  with MemoLog.Lines do
  begin
    Clear;
    Add(TOSVersion.ToString);
    Add('');
    Add('Architecture: ' + OSArchitectureToStr(TOSVersion.Architecture));
    Add('Platform: ' + OSPlatformToStr(TOSVersion.Platform));
    Add('Build: ' + IntToStr(TOSVersion.Build));
    Add('Major: ' + IntToStr(TOSVersion.Major));
    Add('Minor: ' + IntToStr(TOSVersion.Minor));
    Add('Name: ' + TOSVersion.Name);
    Add('Service Pack - Major: ' + IntToStr(TOSVersion.ServicePackMajor));
    Add('Service Pack - Minor: ' + IntToStr(TOSVersion.ServicePackMinor));
  end;
end;

end.
