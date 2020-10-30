program FireDACEC2015;

uses
  Vcl.Forms,
  uFrmRecoveringConnection in 'uFrmRecoveringConnection.pas' {FrmRecoveringConnection},
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmOffliningConnection in 'uFrmOffliningConnection.pas' {FrmOffliningConnection},
  uFrmSQLDialectAbstraction in 'uFrmSQLDialectAbstraction.pas' {FrmSQLDialectAbstraction},
  uFrmSubstitutionVariablesMacros in 'uFrmSubstitutionVariablesMacros.pas' {FrmSubstitutionVariablesMacros},
  uFrmArrayDML in 'uFrmArrayDML.pas' {FrmArrayDML},
  uFrmExecutingSQLScripts in 'uFrmExecutingSQLScripts.pas' {FrmExecutingSQLScripts},
  uFrmLocalSQL in 'uFrmLocalSQL.pas' {FrmLocalSQL},
  uFrmETL in 'uFrmETL.pas' {FrmETL},
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  uFrmMetaData in 'uFrmMetaData.pas' {FrmMetaData},
  uFrmCacheUpdate in 'uFrmCacheUpdate.pas' {FrmCacheUpdate},
  uFrmSaveToFile in 'uFrmSaveToFile.pas' {FrmSaveToFile},
  uFrmFetch in 'uFrmFetch.pas' {FrmFetch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmETL, FrmETL);
  Application.CreateForm(TFrmLocalSQL, FrmLocalSQL);
  Application.CreateForm(TFrmExecutingSQLScripts, FrmExecutingSQLScripts);
  Application.CreateForm(TFrmArrayDML, FrmArrayDML);
  Application.CreateForm(TFrmSubstitutionVariablesMacros, FrmSubstitutionVariablesMacros);
  Application.CreateForm(TFrmSQLDialectAbstraction, FrmSQLDialectAbstraction);
  Application.CreateForm(TFrmOffliningConnection, FrmOffliningConnection);
  Application.CreateForm(TFrmRecoveringConnection, FrmRecoveringConnection);
  Application.CreateForm(TFrmMetaData, FrmMetaData);
  Application.CreateForm(TFrmCacheUpdate, FrmCacheUpdate);
  Application.CreateForm(TFrmSaveToFile, FrmSaveToFile);
  Application.CreateForm(TFrmFetch, FrmFetch);
  Application.Run;
end.
