program GoogleDriveFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFMMain in 'uFMMain.pas' {fmFMMain},
  uDMCdata in 'uDMCdata.pas' {dmCdata: TDataModule},
  uCDataGDriveTypes in 'uCDataGDriveTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmCdata, dmCdata);
  Application.CreateForm(TfmFMMain, fmFMMain);
  Application.Run;
end.
