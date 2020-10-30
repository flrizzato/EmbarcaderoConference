program RecebeScheme;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmRecebeSchemeUnt in 'frmRecebeSchemeUnt.pas' {frmRecebeScheme};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRecebeScheme, frmRecebeScheme);
  Application.Run;
end.
