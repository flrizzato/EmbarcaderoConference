unit UClassGlobal;

interface

uses System.IniFiles, System.IOUtils, SysUtils;

Type
  TGlobal = class
  private
    Ftoken: string;
    Fpass: string;
    Flogin: string;
    Ferror: string;
    FidUser: string;
    FDataExpira: TDate;
    FEmail: string;
    FDataAtual: TDate;
    FLongitude: string;
    FLatidude: string;
    procedure Settoken(const Value: string);
    procedure Setlogin(const Value: string);
    procedure Setpass(const Value: string);
    procedure Seterror(const Value: string);
    procedure SetidUser(const Value: string);
    procedure SetDataExpira(const Value: TDate);
    procedure SetDataAtual(const Value: TDate);
    procedure SetEmail(const Value: string);
    procedure SetLatidude(const Value: string);
    procedure SetLongitude(const Value: string);
  public
    property token: string read Ftoken write Settoken;
    property login: string read Flogin write Setlogin;
    property pass: string read Fpass write Setpass;
    property error: string read Ferror write Seterror;
    property idUser: string read FidUser write SetidUser;
    property DataExpira: TDate read FDataExpira write SetDataExpira;
    property DataAtual: TDate read FDataAtual write SetDataAtual;
    property Email: string read FEmail write SetEmail;
    property Latidude: string read FLatidude write SetLatidude;
    property Longitude: string read FLongitude write SetLongitude;
    class function LerINI(pSession: string; pID: string; pValue: Variant): Variant;
    class function GravarINI(pSession: string; pID: string; pValue: Variant): Boolean;
  end;

implementation
var
    IniFileName : String;
    arqINI: TMemIniFile;

{ TGlobal }

class function TGlobal.GravarINI(pSession, pID: string;
  pValue: Variant): Boolean;
var
    cSession, cID, cValue : String;

begin
  {$IFDEF ANDROID}
  IniFileName:= TPath.GetDocumentsPath + PathDelim + TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.dat';
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  IniFileName:= TPath.GetLibraryPath + TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.dat';
  {$ENDIF MSWINDOWS}

  try
    arqINI:= TMemIniFile.Create(IniFileName);
    case TVarData(pValue).vType of
      varString:  begin arqINI.WriteString(pSession,pID,pValue); result:= True end;
      varInteger: begin arqINI.WriteInteger(pSession,pID,pValue);result:= True end;
      varBoolean: begin arqINI.WriteBool(pSession,pID,pValue);   result:= True end;
      varDate:    begin arqINI.WriteDate(pSession,pID,pValue);   result:= True end;
      varDouble:  begin arqINI.WriteFloat(pSession,pID,pValue);  result:= True end;
      varUString: begin arqINI.WriteString(pSession,pID,pValue); result:= True end;
      else
      result:= False;
    end;

    cSession := pSession;
    cID := pID;
    cValue := pValue;

    arqINI.UpdateFile;
  finally
    FreeAndNil(arqINI);
  end;
end;

class function TGlobal.LerINI(pSession, pID: string; pValue: Variant): Variant;
var
  cSession, cID, cValue : String;
begin
  {$IFDEF ANDROID}
  IniFileName:= TPath.GetDocumentsPath + PathDelim + TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.dat';
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  IniFileName:= TPath.GetLibraryPath + TPath.GetFileNameWithoutExtension(ParamStr(0)) + '.dat';
  {$ENDIF MSWINDOWS}

  try
    arqINI:= TMemIniFile.Create(IniFileName);
    case TVarData(pValue).vType of
      varString: result:= arqINI.ReadString(pSession,pID,pValue);
      varInteger:result:= arqINI.ReadInteger(pSession,pID,pValue);
      varBoolean:result:= arqINI.ReadBool(pSession,pID,pValue);
      varDate:   result:= arqINI.ReadDate(pSession,pID,pValue);
      varDouble: result:= arqINI.ReadFloat(pSession,pID,pValue);
      varUString:result:= arqINI.ReadString(pSession,pID,pValue);
    end;

    cSession := pSession;
    cID := pID;
    cValue := pValue;
  finally
      FreeAndNil(arqINI);
  end;
end;

procedure TGlobal.SetDataAtual(const Value: TDate);
begin
  FDataAtual := Value;
end;

procedure TGlobal.SetDataExpira(const Value: TDate);
begin
  FDataExpira := Value;
end;

procedure TGlobal.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TGlobal.Seterror(const Value: string);
begin
  Ferror := Value;
end;

procedure TGlobal.SetidUser(const Value: string);
begin
  FidUser := Value;
end;

procedure TGlobal.SetLatidude(const Value: string);
begin
  FLatidude := Value;
end;

procedure TGlobal.Setlogin(const Value: string);
begin
  Flogin := Value;
end;

procedure TGlobal.SetLongitude(const Value: string);
begin
  FLongitude := Value;
end;

procedure TGlobal.Setpass(const Value: string);
begin
  Fpass := Value;
end;

procedure TGlobal.Settoken(const Value: string);
begin
  Ftoken := Value;
end;

end.
