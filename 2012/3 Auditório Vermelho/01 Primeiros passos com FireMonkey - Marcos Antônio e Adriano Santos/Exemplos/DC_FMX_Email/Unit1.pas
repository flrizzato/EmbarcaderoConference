
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Unit1;

interface

uses
  SysUtils, Types, UITypes, Classes, Variants, FMX_Types, FMX_Controls, FMX_Forms,
  FMX_Dialogs, FMX_Layouts, FMX_Memo, FMX_Edit, SharedApplication;

type
  TEmail = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Label3: TLabel;
    iOSEmail1: TiOSEmail;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Email: TEmail;

implementation

{$R *.lfm}

procedure TEmail.Button1Click(Sender: TObject);
begin
 iOSEmail1.Recipient := Edit1.Text;
 iOSEmail1.Subject := Edit2.Text;
 iOSEmail1.Body := Memo1.Text;
 iOSEmail1.Send;
 ShowMessage('Mensagem enviada!');
end;

end.

