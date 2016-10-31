unit Unit1;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs
{$IFDEF FPC}
  , iPhoneAll
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    StyleBook1: TStyleBook;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  {$IFDEF FPC}
  UIApplication.sharedApplication.setStatusBarHidden(not UIApplication.sharedApplication.isStatusBarHidden);
  {$ENDIF}
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  {$IFDEF FPC}
  UIApplication.sharedApplication.setStatusBarHidden_withAnimation(not UIApplication.sharedApplication.isStatusBarHidden,UIStatusBarAnimationFade);
  {$ENDIF}
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  {$IFDEF FPC}
  UIApplication.sharedApplication.setStatusBarHidden_withAnimation(not UIApplication.sharedApplication.isStatusBarHidden,UIStatusBarAnimationSlide);
  {$ENDIF}
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  {$IFDEF FPC}
  UIApplication.sharedApplication.setNetworkActivityIndicatorVisible(not UIApplication.sharedApplication.isNetworkActivityIndicatorVisible);
  {$ENDIF}
end;

end.

