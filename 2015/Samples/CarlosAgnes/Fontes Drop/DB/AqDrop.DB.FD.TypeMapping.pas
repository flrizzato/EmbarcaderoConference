unit AqDrop.DB.FD.TypeMapping;

interface

uses
  System.Classes,
{$if CompilerVersion >= 28}
  FireDAC.Stan.Intf,
{$endif}
{$if CompilerVersion >= 26}
  FireDAC.Stan.Param,
  FireDAC.Comp.Client;
{$else}
  uADStanParam,
  uADCompClient;
{$endif}


type
{$if CompilerVersion >= 26}
  TAqFDMappedParam = TFDParam;
  TAqFDMappedQuery = TFDQuery;
  TAqFDMappedConnection = TFDConnection;
{$else}
  TAqFDMappedParam = TADParam;
  TAqFDMappedQuery = TADQuery;
  TAqFDMappedConnection = TADConnection;
{$endif}

{$IF CompilerVersion >= 28}
  TAqFDMappedConnectionParameters = TFDConnectionDefParams;
{$ELSE}
  TAqFDMappedConnectionParameters = TStrings;
{$ENDIF}


implementation

end.
