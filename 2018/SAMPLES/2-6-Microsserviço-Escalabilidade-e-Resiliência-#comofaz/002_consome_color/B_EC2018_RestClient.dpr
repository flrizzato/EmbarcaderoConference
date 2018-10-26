program B_EC2018_RestClient;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  DataModule in 'DataModule.pas' {DataModule1: TDataModule};

var
  i: Integer;

begin
  DataModule1 := TDataModule1.Create(nil);
  try
    { TODO -oUser -cConsole Main : Insert code here }

    for i := 1 to 100 do
    begin
      try
        DataModule1.RESTRequest1.Execute;
        Writeln(TJSONObject(DataModule1.RESTResponse1.JSONValue).GetValue('result').ToString);
      except
        on E: Exception do
          Writeln(E.ClassName, ': ', E.Message);
      end;
    end;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  DataModule1.Free;

end.
