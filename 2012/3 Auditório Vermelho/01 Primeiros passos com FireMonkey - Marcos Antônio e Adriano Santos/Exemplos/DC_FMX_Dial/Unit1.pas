
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Unit1;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Edit
{$IFDEF FPC}
  , iPhoneAll
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StyleBook1: TStyleBook;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
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
  // Dial a phone number
  {$IFDEF FPC}
  UIApplication.sharedApplication.openUrl(NSUrl.URLWithString(NSSTR(PChar(String('tel://'+Edit1.Text)))));
  {$ENDIF}
end;

end.

