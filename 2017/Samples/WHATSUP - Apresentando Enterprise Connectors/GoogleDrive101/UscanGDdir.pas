unit UscanGDdir;

interface

uses
  Classes, FireDAC.Comp.Client;

const
  IDENTCHAR = ' ';
  IDENTSTEP = 8;

procedure ScanGoogleDriveDir(Connect:TFDConnection; StartName: string; Ext: string; sIdent: byte; DList: TStrings);

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataGoogleDrive, FireDAC.Phys.CDataGoogleDriveDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.UI, FireDAC.Comp.DataSet;

procedure ScanGoogleDriveDir(Connect:TFDConnection; StartName: string; Ext: string; sIdent: byte; DList: TStrings);
var
  FQFolder, FQFiles: TFDQuery;
  function identStr(aLevel:byte; aStr: string):string;
  begin
    Result:=string.Create(IDENTCHAR,aLevel)+aStr;
  end;
begin
  FQFolder:= TFDQuery.Create(nil);
  FQFiles:= TFDQuery.Create(nil);
  try
    // Prepare Files query
    FQFiles.Connection := Connect;
    FQFiles.ResourceOptions.ParamCreate := False;
    FQFiles.Sql.Text := 'Select * from Files where ParentIds in ( :flrId )';
    with FQFiles.Params.Add do
    begin
      DataType := ftString; // Name:='flrId';
      ParamType := ptInput;
    end;
    FQFiles.Prepare;

    //Prepare Folders Query
    FQFolder.Connection := Connect;
    FQFolder.ResourceOptions.ParamCreate := False;
    if (StartName = '\') or (LowerCase(trim(StartName)) = 'root') then begin
      FQFolder.Sql.Text := 'select * from Files where Query='#39'('#39#39'root'#39#39' in parents)'#39;
      FQFolder.Prepare;
    end
    else begin
      FQFolder.Sql.Text := 'select * from Files where Name=:fnm order by Id';
      with FQFolder.Params.Add do begin
        DataType := ftString; // Name:='fnm';
        ParamType := ptInput;
      end;
      FQFolder.Prepare;
      FQFolder.Params[0].AsString := StartName;
    end;

    // Start Traverse
    FQFolder.Active:=True;
    FQFolder.First;
    while not FQFolder.Eof do begin
      if FQFolder.FieldByName('Folder').asString<>'True' then
        DList.Add(identStr(sIdent, FQFolder.FieldByName('Name').asString))  //StartName
      else begin
        DList.Add(identStr(sIdent, FQFolder.FieldByName('Name').asString)+'\');
        FQFiles.Params[0].asString:=FQFolder.FieldByName('Id').AsString;
        FQFiles.Active:=True;
        FQFiles.First;
        while not FQFiles.Eof do begin
          if FQFiles.FieldByName('Folder').asString<>'True' then
            DList.Add(identStr(sIdent+IDENTSTEP, FQFiles.FieldByName('Name').asString))
          else
            ScanGoogleDriveDir(Connect,FQFiles.FieldByName('Name').asString, '*', sIdent+IDENTSTEP, Dlist);
          FQFiles.Next;
        end;
        FQFiles.Close;
      end;
      FQFolder.Next;
    end;
    FQFolder.Close;
  finally
    FQFolder.Free;
    FQFiles.Free;
  end;
end;

end.
