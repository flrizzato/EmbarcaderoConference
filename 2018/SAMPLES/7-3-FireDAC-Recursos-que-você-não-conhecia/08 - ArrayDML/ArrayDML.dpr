program ArrayDML;

uses
  Vcl.Forms,
  fArrayDML in 'fArrayDML.pas' {FrmArrayDML},
  dArrayDML in 'dArrayDML.pas' {DMArrayDML: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmArrayDML, FrmArrayDML);
  Application.CreateForm(TDMArrayDML, DMArrayDML);
  Application.Run;
end.
