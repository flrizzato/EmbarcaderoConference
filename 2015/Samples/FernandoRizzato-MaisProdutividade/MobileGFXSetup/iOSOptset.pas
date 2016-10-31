
{************************************************************************}
{                                                                        }
{                            XML Data Binding                            }
{                                                                        }
{         Generated on: 2/7/2015 8:46:50 AM                              }
{       Generated from: C:\Comps\Projects\Kakiyomimasho\Images\iOS.xml   }
{   Settings stored in: C:\Comps\Projects\Kakiyomimasho\Images\iOS.xdb   }
{                                                                        }
{************************************************************************}

unit iOSOptset;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLiOSProjectType = interface;
  IXMLPropertyGroupType = interface;
  IXMLProjectExtensionsType = interface;
  IXMLBorlandProjectType = interface;

{ IXMLiOSProjectType }

  IXMLiOSProjectType = interface(IXMLNode)
    ['{DA320759-BA81-4A1B-B755-26E010BBD556}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    function Get_PropertyGroup: IXMLPropertyGroupType;
    function Get_ProjectExtensions: IXMLProjectExtensionsType;
    procedure Set_Xmlns(Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
    property PropertyGroup: IXMLPropertyGroupType read Get_PropertyGroup;
    property ProjectExtensions: IXMLProjectExtensionsType read Get_ProjectExtensions;
  end;

{ IXMLPropertyGroupType }

  IXMLPropertyGroupType = interface(IXMLNode)
    ['{EA4B320A-A85C-4449-A309-8613A637B16D}']
    { Property Accessors }
    function Get_IPhone_Launch320: UnicodeString;
    function Get_IPhone_Launch640: UnicodeString;
    function Get_IPhone_Launch750: UnicodeString;
    function Get_IPhone_Launch1242: UnicodeString;
    function Get_IPhone_Launch2208: UnicodeString;
    function Get_IPad_AppIcon76: UnicodeString;
    function Get_IPhone_Launch640x1136: UnicodeString;
    function Get_IPhone_AppIcon120: UnicodeString;
    function Get_IPhone_AppIcon57: UnicodeString;
    function Get_IPhone_AppIcon60: UnicodeString;
    function Get_IPhone_Spotlight29: UnicodeString;
    function Get_IPhone_Spotlight80: UnicodeString;
    function Get_VerInfo_UIDeviceFamily: Integer;
    function Get_IPad_Launch1536: UnicodeString;
    function Get_IPhone_Spotlight58: UnicodeString;
    function Get_IPad_Launch2048: UnicodeString;
    function Get_IPhone_Spotlight40: UnicodeString;
    function Get_IPhone_AppIcon114: UnicodeString;
    function Get_IPad_Launch2048x1536: UnicodeString;
    function Get_IPad_SpotLight100: UnicodeString;
    function Get_IPad_Setting29: UnicodeString;
    function Get_IPad_SpotLight40: UnicodeString;
    function Get_IPad_Launch768x1024: UnicodeString;
    function Get_IPad_Launch1024: UnicodeString;
    function Get_IPad_Launch1024x768: UnicodeString;
    function Get_IPad_AppIcon144: UnicodeString;
    function Get_IPad_SpotLight50: UnicodeString;
    function Get_IPad_AppIcon72: UnicodeString;
    function Get_IPad_AppIcon152: UnicodeString;
    function Get_IPad_Launch1536x2048: UnicodeString;
    function Get_IPad_Launch768: UnicodeString;
    function Get_IPad_SpotLight80: UnicodeString;
    function Get_VerInfo_IncludeVerInfo: Integer;
    function Get_IPad_Setting58: UnicodeString;
    procedure Set_IPhone_Launch320(Value: UnicodeString);
    procedure Set_IPhone_Launch640(Value: UnicodeString);
    procedure Set_IPhone_Launch750(Value: UnicodeString);
    procedure Set_IPhone_Launch1242(Value: UnicodeString);
    procedure Set_IPhone_Launch2208(Value: UnicodeString);
    procedure Set_IPad_AppIcon76(Value: UnicodeString);
    procedure Set_IPhone_Launch640x1136(Value: UnicodeString);
    procedure Set_IPhone_AppIcon120(Value: UnicodeString);
    procedure Set_IPhone_AppIcon57(Value: UnicodeString);
    procedure Set_IPhone_AppIcon60(Value: UnicodeString);
    procedure Set_IPhone_Spotlight29(Value: UnicodeString);
    procedure Set_IPhone_Spotlight80(Value: UnicodeString);
    procedure Set_VerInfo_UIDeviceFamily(Value: Integer);
    procedure Set_IPad_Launch1536(Value: UnicodeString);
    procedure Set_IPhone_Spotlight58(Value: UnicodeString);
    procedure Set_IPad_Launch2048(Value: UnicodeString);
    procedure Set_IPhone_Spotlight40(Value: UnicodeString);
    procedure Set_IPhone_AppIcon114(Value: UnicodeString);
    procedure Set_IPad_Launch2048x1536(Value: UnicodeString);
    procedure Set_IPad_SpotLight100(Value: UnicodeString);
    procedure Set_IPad_Setting29(Value: UnicodeString);
    procedure Set_IPad_SpotLight40(Value: UnicodeString);
    procedure Set_IPad_Launch768x1024(Value: UnicodeString);
    procedure Set_IPad_Launch1024(Value: UnicodeString);
    procedure Set_IPad_Launch1024x768(Value: UnicodeString);
    procedure Set_IPad_AppIcon144(Value: UnicodeString);
    procedure Set_IPad_SpotLight50(Value: UnicodeString);
    procedure Set_IPad_AppIcon72(Value: UnicodeString);
    procedure Set_IPad_AppIcon152(Value: UnicodeString);
    procedure Set_IPad_Launch1536x2048(Value: UnicodeString);
    procedure Set_IPad_Launch768(Value: UnicodeString);
    procedure Set_IPad_SpotLight80(Value: UnicodeString);
    procedure Set_VerInfo_IncludeVerInfo(Value: Integer);
    procedure Set_IPad_Setting58(Value: UnicodeString);
    { Methods & Properties }
    property IPhone_Launch320: UnicodeString read Get_IPhone_Launch320 write Set_IPhone_Launch320;
    property IPhone_Launch640: UnicodeString read Get_IPhone_Launch640 write Set_IPhone_Launch640;
    property IPhone_Launch750: UnicodeString read Get_IPhone_Launch750 write Set_IPhone_Launch750;
    property IPhone_Launch1242: UnicodeString read Get_IPhone_Launch1242 write Set_IPhone_Launch1242;
    property IPhone_Launch2208: UnicodeString read Get_IPhone_Launch2208 write Set_IPhone_Launch2208;
    property IPad_AppIcon76: UnicodeString read Get_IPad_AppIcon76 write Set_IPad_AppIcon76;
    property IPhone_Launch640x1136: UnicodeString read Get_IPhone_Launch640x1136 write Set_IPhone_Launch640x1136;
    property IPhone_AppIcon120: UnicodeString read Get_IPhone_AppIcon120 write Set_IPhone_AppIcon120;
    property IPhone_AppIcon57: UnicodeString read Get_IPhone_AppIcon57 write Set_IPhone_AppIcon57;
    property IPhone_AppIcon60: UnicodeString read Get_IPhone_AppIcon60 write Set_IPhone_AppIcon60;
    property IPhone_Spotlight29: UnicodeString read Get_IPhone_Spotlight29 write Set_IPhone_Spotlight29;
    property IPhone_Spotlight80: UnicodeString read Get_IPhone_Spotlight80 write Set_IPhone_Spotlight80;
    property VerInfo_UIDeviceFamily: Integer read Get_VerInfo_UIDeviceFamily write Set_VerInfo_UIDeviceFamily;
    property IPad_Launch1536: UnicodeString read Get_IPad_Launch1536 write Set_IPad_Launch1536;
    property IPhone_Spotlight58: UnicodeString read Get_IPhone_Spotlight58 write Set_IPhone_Spotlight58;
    property IPad_Launch2048: UnicodeString read Get_IPad_Launch2048 write Set_IPad_Launch2048;
    property IPhone_Spotlight40: UnicodeString read Get_IPhone_Spotlight40 write Set_IPhone_Spotlight40;
    property IPhone_AppIcon114: UnicodeString read Get_IPhone_AppIcon114 write Set_IPhone_AppIcon114;
    property IPad_Launch2048x1536: UnicodeString read Get_IPad_Launch2048x1536 write Set_IPad_Launch2048x1536;
    property IPad_SpotLight100: UnicodeString read Get_IPad_SpotLight100 write Set_IPad_SpotLight100;
    property IPad_Setting29: UnicodeString read Get_IPad_Setting29 write Set_IPad_Setting29;
    property IPad_SpotLight40: UnicodeString read Get_IPad_SpotLight40 write Set_IPad_SpotLight40;
    property IPad_Launch768x1024: UnicodeString read Get_IPad_Launch768x1024 write Set_IPad_Launch768x1024;
    property IPad_Launch1024: UnicodeString read Get_IPad_Launch1024 write Set_IPad_Launch1024;
    property IPad_Launch1024x768: UnicodeString read Get_IPad_Launch1024x768 write Set_IPad_Launch1024x768;
    property IPad_AppIcon144: UnicodeString read Get_IPad_AppIcon144 write Set_IPad_AppIcon144;
    property IPad_SpotLight50: UnicodeString read Get_IPad_SpotLight50 write Set_IPad_SpotLight50;
    property IPad_AppIcon72: UnicodeString read Get_IPad_AppIcon72 write Set_IPad_AppIcon72;
    property IPad_AppIcon152: UnicodeString read Get_IPad_AppIcon152 write Set_IPad_AppIcon152;
    property IPad_Launch1536x2048: UnicodeString read Get_IPad_Launch1536x2048 write Set_IPad_Launch1536x2048;
    property IPad_Launch768: UnicodeString read Get_IPad_Launch768 write Set_IPad_Launch768;
    property IPad_SpotLight80: UnicodeString read Get_IPad_SpotLight80 write Set_IPad_SpotLight80;
    property VerInfo_IncludeVerInfo: Integer read Get_VerInfo_IncludeVerInfo write Set_VerInfo_IncludeVerInfo;
    property IPad_Setting58: UnicodeString read Get_IPad_Setting58 write Set_IPad_Setting58;
  end;

{ IXMLProjectExtensionsType }

  IXMLProjectExtensionsType = interface(IXMLNode)
    ['{9E088EFB-23D0-4054-98B5-2B8D0857FAC5}']
    { Property Accessors }
    function Get_BorlandPersonality: UnicodeString;
    function Get_BorlandProjectType: UnicodeString;
    function Get_BorlandProject: IXMLBorlandProjectType;
    function Get_ProjectFileVersion: Integer;
    procedure Set_BorlandPersonality(Value: UnicodeString);
    procedure Set_BorlandProjectType(Value: UnicodeString);
    procedure Set_ProjectFileVersion(Value: Integer);
    { Methods & Properties }
    property BorlandPersonality: UnicodeString read Get_BorlandPersonality write Set_BorlandPersonality;
    property BorlandProjectType: UnicodeString read Get_BorlandProjectType write Set_BorlandProjectType;
    property BorlandProject: IXMLBorlandProjectType read Get_BorlandProject;
    property ProjectFileVersion: Integer read Get_ProjectFileVersion write Set_ProjectFileVersion;
  end;

{ IXMLBorlandProjectType }

  IXMLBorlandProjectType = interface(IXMLNode)
    ['{F3DF8091-5261-4052-9A93-528786B76CF4}']
    { Property Accessors }
    function Get_DelphiPersonality: UnicodeString;
    procedure Set_DelphiPersonality(Value: UnicodeString);
    { Methods & Properties }
    property DelphiPersonality: UnicodeString read Get_DelphiPersonality write Set_DelphiPersonality;
  end;

{ Forward Decls }

  TXMLiOSProjectType = class;
  TXMLPropertyGroupType = class;
  TXMLProjectExtensionsType = class;
  TXMLBorlandProjectType = class;

{ TXMLiOSProjectType }

  TXMLiOSProjectType = class(TXMLNode, IXMLiOSProjectType)
  protected
    { IXMLiOSProjectType }
    function Get_Xmlns: UnicodeString;
    function Get_PropertyGroup: IXMLPropertyGroupType;
    function Get_ProjectExtensions: IXMLProjectExtensionsType;
    procedure Set_Xmlns(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPropertyGroupType }

  TXMLPropertyGroupType = class(TXMLNode, IXMLPropertyGroupType)
  protected
    { IXMLPropertyGroupType }
    function Get_IPhone_Launch320: UnicodeString;
    function Get_IPhone_Launch640: UnicodeString;
    function Get_IPhone_Launch750: UnicodeString;
    function Get_IPhone_Launch1242: UnicodeString;
    function Get_IPhone_Launch2208: UnicodeString;
    function Get_IPad_AppIcon76: UnicodeString;
    function Get_IPhone_Launch640x1136: UnicodeString;
    function Get_IPhone_AppIcon120: UnicodeString;
    function Get_IPhone_AppIcon57: UnicodeString;
    function Get_IPhone_AppIcon60: UnicodeString;
    function Get_IPhone_Spotlight29: UnicodeString;
    function Get_IPhone_Spotlight80: UnicodeString;
    function Get_VerInfo_UIDeviceFamily: Integer;
    function Get_IPad_Launch1536: UnicodeString;
    function Get_IPhone_Spotlight58: UnicodeString;
    function Get_IPad_Launch2048: UnicodeString;
    function Get_IPhone_Spotlight40: UnicodeString;
    function Get_IPhone_AppIcon114: UnicodeString;
    function Get_IPad_Launch2048x1536: UnicodeString;
    function Get_IPad_SpotLight100: UnicodeString;
    function Get_IPad_Setting29: UnicodeString;
    function Get_IPad_SpotLight40: UnicodeString;
    function Get_IPad_Launch768x1024: UnicodeString;
    function Get_IPad_Launch1024: UnicodeString;
    function Get_IPad_Launch1024x768: UnicodeString;
    function Get_IPad_AppIcon144: UnicodeString;
    function Get_IPad_SpotLight50: UnicodeString;
    function Get_IPad_AppIcon72: UnicodeString;
    function Get_IPad_AppIcon152: UnicodeString;
    function Get_IPad_Launch1536x2048: UnicodeString;
    function Get_IPad_Launch768: UnicodeString;
    function Get_IPad_SpotLight80: UnicodeString;
    function Get_VerInfo_IncludeVerInfo: Integer;
    function Get_IPad_Setting58: UnicodeString;
    procedure Set_IPhone_Launch320(Value: UnicodeString);
    procedure Set_IPhone_Launch640(Value: UnicodeString);
    procedure Set_IPhone_Launch750(Value: UnicodeString);
    procedure Set_IPhone_Launch1242(Value: UnicodeString);
    procedure Set_IPhone_Launch2208(Value: UnicodeString);
    procedure Set_IPad_AppIcon76(Value: UnicodeString);
    procedure Set_IPhone_Launch640x1136(Value: UnicodeString);
    procedure Set_IPhone_AppIcon120(Value: UnicodeString);
    procedure Set_IPhone_AppIcon57(Value: UnicodeString);
    procedure Set_IPhone_AppIcon60(Value: UnicodeString);
    procedure Set_IPhone_Spotlight29(Value: UnicodeString);
    procedure Set_IPhone_Spotlight80(Value: UnicodeString);
    procedure Set_VerInfo_UIDeviceFamily(Value: Integer);
    procedure Set_IPad_Launch1536(Value: UnicodeString);
    procedure Set_IPhone_Spotlight58(Value: UnicodeString);
    procedure Set_IPad_Launch2048(Value: UnicodeString);
    procedure Set_IPhone_Spotlight40(Value: UnicodeString);
    procedure Set_IPhone_AppIcon114(Value: UnicodeString);
    procedure Set_IPad_Launch2048x1536(Value: UnicodeString);
    procedure Set_IPad_SpotLight100(Value: UnicodeString);
    procedure Set_IPad_Setting29(Value: UnicodeString);
    procedure Set_IPad_SpotLight40(Value: UnicodeString);
    procedure Set_IPad_Launch768x1024(Value: UnicodeString);
    procedure Set_IPad_Launch1024(Value: UnicodeString);
    procedure Set_IPad_Launch1024x768(Value: UnicodeString);
    procedure Set_IPad_AppIcon144(Value: UnicodeString);
    procedure Set_IPad_SpotLight50(Value: UnicodeString);
    procedure Set_IPad_AppIcon72(Value: UnicodeString);
    procedure Set_IPad_AppIcon152(Value: UnicodeString);
    procedure Set_IPad_Launch1536x2048(Value: UnicodeString);
    procedure Set_IPad_Launch768(Value: UnicodeString);
    procedure Set_IPad_SpotLight80(Value: UnicodeString);
    procedure Set_VerInfo_IncludeVerInfo(Value: Integer);
    procedure Set_IPad_Setting58(Value: UnicodeString);
  end;

{ TXMLProjectExtensionsType }

  TXMLProjectExtensionsType = class(TXMLNode, IXMLProjectExtensionsType)
  protected
    { IXMLProjectExtensionsType }
    function Get_BorlandPersonality: UnicodeString;
    function Get_BorlandProjectType: UnicodeString;
    function Get_BorlandProject: IXMLBorlandProjectType;
    function Get_ProjectFileVersion: Integer;
    procedure Set_BorlandPersonality(Value: UnicodeString);
    procedure Set_BorlandProjectType(Value: UnicodeString);
    procedure Set_ProjectFileVersion(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLBorlandProjectType }

  TXMLBorlandProjectType = class(TXMLNode, IXMLBorlandProjectType)
  protected
    { IXMLBorlandProjectType }
    function Get_DelphiPersonality: UnicodeString;
    procedure Set_DelphiPersonality(Value: UnicodeString);
  end;

{ Global Functions }

function GetiOSOptset(Doc: IXMLDocument): IXMLiOSProjectType;
function LoadiOSOptset(const FileName: string): IXMLiOSProjectType;
function NewiOSOptset: IXMLiOSProjectType;

const
  TargetNamespace = 'http://schemas.microsoft.com/developer/msbuild/2003';

implementation

{ Global Functions }

function GetiOSOptset(Doc: IXMLDocument): IXMLiOSProjectType;
begin
  Result := Doc.GetDocBinding('iOSOptset', TXMLiOSProjectType, TargetNamespace) as IXMLiOSProjectType;
end;

function LoadiOSOptset(const FileName: string): IXMLiOSProjectType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('iOSOptset', TXMLiOSProjectType, TargetNamespace) as IXMLiOSProjectType;
end;

function NewiOSOptset: IXMLiOSProjectType;
begin
  Result := NewXMLDocument.GetDocBinding('iOSOptset', TXMLiOSProjectType, TargetNamespace) as IXMLiOSProjectType;
end;

{ TXMLiOSProjectType }

procedure TXMLiOSProjectType.AfterConstruction;
begin
  RegisterChildNode('PropertyGroup', TXMLPropertyGroupType);
  RegisterChildNode('ProjectExtensions', TXMLProjectExtensionsType);
  inherited;
end;

function TXMLiOSProjectType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLiOSProjectType.Set_Xmlns(Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLiOSProjectType.Get_PropertyGroup: IXMLPropertyGroupType;
begin
  Result := ChildNodes['PropertyGroup'] as IXMLPropertyGroupType;
end;

function TXMLiOSProjectType.Get_ProjectExtensions: IXMLProjectExtensionsType;
begin
  Result := ChildNodes['ProjectExtensions'] as IXMLProjectExtensionsType;
end;

{ TXMLPropertyGroupType }

function TXMLPropertyGroupType.Get_IPhone_Launch320: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch320'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch320(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch320'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Launch640: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch640'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch640(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch640'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Launch750: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch750'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch750(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch750'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Launch1242: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch1242'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch1242(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch1242'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Launch2208: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch2208'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch2208(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch2208'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_AppIcon76: UnicodeString;
begin
  Result := ChildNodes['iPad_AppIcon76'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_AppIcon76(Value: UnicodeString);
begin
  ChildNodes['iPad_AppIcon76'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Launch640x1136: UnicodeString;
begin
  Result := ChildNodes['iPhone_Launch640x1136'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Launch640x1136(Value: UnicodeString);
begin
  ChildNodes['iPhone_Launch640x1136'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_AppIcon120: UnicodeString;
begin
  Result := ChildNodes['iPhone_AppIcon120'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_AppIcon120(Value: UnicodeString);
begin
  ChildNodes['iPhone_AppIcon120'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_AppIcon57: UnicodeString;
begin
  Result := ChildNodes['iPhone_AppIcon57'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_AppIcon57(Value: UnicodeString);
begin
  ChildNodes['iPhone_AppIcon57'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_AppIcon60: UnicodeString;
begin
  Result := ChildNodes['iPhone_AppIcon60'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_AppIcon60(Value: UnicodeString);
begin
  ChildNodes['iPhone_AppIcon60'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Spotlight29: UnicodeString;
begin
  Result := ChildNodes['iPhone_Spotlight29'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Spotlight29(Value: UnicodeString);
begin
  ChildNodes['iPhone_Spotlight29'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Spotlight80: UnicodeString;
begin
  Result := ChildNodes['iPhone_Spotlight80'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Spotlight80(Value: UnicodeString);
begin
  ChildNodes['iPhone_Spotlight80'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_VerInfo_UIDeviceFamily: Integer;
begin
  Result := ChildNodes['VerInfo_UIDeviceFamily'].NodeValue;
end;

procedure TXMLPropertyGroupType.Set_VerInfo_UIDeviceFamily(Value: Integer);
begin
  ChildNodes['VerInfo_UIDeviceFamily'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch1536: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch1536'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch1536(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch1536'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Spotlight58: UnicodeString;
begin
  Result := ChildNodes['iPhone_Spotlight58'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Spotlight58(Value: UnicodeString);
begin
  ChildNodes['iPhone_Spotlight58'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch2048: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch2048'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch2048(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch2048'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_Spotlight40: UnicodeString;
begin
  Result := ChildNodes['iPhone_Spotlight40'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_Spotlight40(Value: UnicodeString);
begin
  ChildNodes['iPhone_Spotlight40'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPhone_AppIcon114: UnicodeString;
begin
  Result := ChildNodes['iPhone_AppIcon114'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPhone_AppIcon114(Value: UnicodeString);
begin
  ChildNodes['iPhone_AppIcon114'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch2048x1536: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch2048x1536'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch2048x1536(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch2048x1536'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_SpotLight100: UnicodeString;
begin
  Result := ChildNodes['iPad_SpotLight100'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_SpotLight100(Value: UnicodeString);
begin
  ChildNodes['iPad_SpotLight100'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Setting29: UnicodeString;
begin
  Result := ChildNodes['iPad_Setting29'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Setting29(Value: UnicodeString);
begin
  ChildNodes['iPad_Setting29'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_SpotLight40: UnicodeString;
begin
  Result := ChildNodes['iPad_SpotLight40'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_SpotLight40(Value: UnicodeString);
begin
  ChildNodes['iPad_SpotLight40'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch768x1024: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch768x1024'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch768x1024(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch768x1024'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch1024: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch1024'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch1024(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch1024'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch1024x768: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch1024x768'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch1024x768(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch1024x768'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_AppIcon144: UnicodeString;
begin
  Result := ChildNodes['iPad_AppIcon144'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_AppIcon144(Value: UnicodeString);
begin
  ChildNodes['iPad_AppIcon144'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_SpotLight50: UnicodeString;
begin
  Result := ChildNodes['iPad_SpotLight50'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_SpotLight50(Value: UnicodeString);
begin
  ChildNodes['iPad_SpotLight50'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_AppIcon72: UnicodeString;
begin
  Result := ChildNodes['iPad_AppIcon72'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_AppIcon72(Value: UnicodeString);
begin
  ChildNodes['iPad_AppIcon72'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_AppIcon152: UnicodeString;
begin
  Result := ChildNodes['iPad_AppIcon152'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_AppIcon152(Value: UnicodeString);
begin
  ChildNodes['iPad_AppIcon152'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch1536x2048: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch1536x2048'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch1536x2048(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch1536x2048'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Launch768: UnicodeString;
begin
  Result := ChildNodes['iPad_Launch768'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Launch768(Value: UnicodeString);
begin
  ChildNodes['iPad_Launch768'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_SpotLight80: UnicodeString;
begin
  Result := ChildNodes['iPad_SpotLight80'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_SpotLight80(Value: UnicodeString);
begin
  ChildNodes['iPad_SpotLight80'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_VerInfo_IncludeVerInfo: Integer;
begin
  Result := ChildNodes['VerInfo_IncludeVerInfo'].NodeValue;
end;

procedure TXMLPropertyGroupType.Set_VerInfo_IncludeVerInfo(Value: Integer);
begin
  ChildNodes['VerInfo_IncludeVerInfo'].NodeValue := Value;
end;

function TXMLPropertyGroupType.Get_IPad_Setting58: UnicodeString;
begin
  Result := ChildNodes['iPad_Setting58'].Text;
end;

procedure TXMLPropertyGroupType.Set_IPad_Setting58(Value: UnicodeString);
begin
  ChildNodes['iPad_Setting58'].NodeValue := Value;
end;

{ TXMLProjectExtensionsType }

procedure TXMLProjectExtensionsType.AfterConstruction;
begin
  RegisterChildNode('BorlandProject', TXMLBorlandProjectType);
  inherited;
end;

function TXMLProjectExtensionsType.Get_BorlandPersonality: UnicodeString;
begin
  Result := ChildNodes['Borland.Personality'].Text;
end;

procedure TXMLProjectExtensionsType.Set_BorlandPersonality(Value: UnicodeString);
begin
  ChildNodes['Borland.Personality'].NodeValue := Value;
end;

function TXMLProjectExtensionsType.Get_BorlandProjectType: UnicodeString;
begin
  Result := ChildNodes['Borland.ProjectType'].NodeValue;
end;

procedure TXMLProjectExtensionsType.Set_BorlandProjectType(Value: UnicodeString);
begin
  ChildNodes['Borland.ProjectType'].NodeValue := Value;
end;

function TXMLProjectExtensionsType.Get_BorlandProject: IXMLBorlandProjectType;
begin
  Result := ChildNodes['BorlandProject'] as IXMLBorlandProjectType;
end;

function TXMLProjectExtensionsType.Get_ProjectFileVersion: Integer;
begin
  Result := ChildNodes['ProjectFileVersion'].NodeValue;
end;

procedure TXMLProjectExtensionsType.Set_ProjectFileVersion(Value: Integer);
begin
  ChildNodes['ProjectFileVersion'].NodeValue := Value;
end;

{ TXMLBorlandProjectType }

function TXMLBorlandProjectType.Get_DelphiPersonality: UnicodeString;
begin
  Result := ChildNodes['Delphi.Personality'].Text;
end;

procedure TXMLBorlandProjectType.Set_DelphiPersonality(Value: UnicodeString);
begin
  ChildNodes['Delphi.Personality'].NodeValue := Value;
end;

end.
