unit Form.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    buttonREST: TButton;
    buttonSOAP: TButton;
    buttonBlueTooth: TButton;
    buttonNFC: TButton;
    procedure buttonRESTClick(Sender: TObject);
    procedure buttonNFCClick(Sender: TObject);
    procedure buttonSOAPClick(Sender: TObject);
    procedure buttonBlueToothClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses Form.REST, Form.NFC, Form.SOAP, Form.BlueTooth;

procedure TfrmPrincipal.buttonBlueToothClick(Sender: TObject);
begin
  frmBlueTooth.Show;
end;

procedure TfrmPrincipal.buttonNFCClick(Sender: TObject);
begin
  frmNFC.Show;
end;

procedure TfrmPrincipal.buttonRESTClick(Sender: TObject);
begin
  frmREST.Show;
end;

procedure TfrmPrincipal.buttonSOAPClick(Sender: TObject);
begin
  frmSOAP.Show;
end;

end.
