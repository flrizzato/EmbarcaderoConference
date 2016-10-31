
{****************************************************************************}
{                                                                            }
{                              XML Data Binding                              }
{                                                                            }
{         Generated on: 2/7/2015 8:24:04 AM                                  }
{       Generated from: C:\Comps\Projects\Kakiyomimasho\Images\Android.xml   }
{   Settings stored in: C:\Comps\Projects\Kakiyomimasho\Images\Android.xdb   }
{                                                                            }
{****************************************************************************}

unit AndroidOptset;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLAndroidProjectType = interface;
  IXMLAndroidPropertyGroupType = interface;
  IXMLAndroidProjectExtensionsType = interface;
  IXMLAndroidBorlandProjectType = interface;

{ IXMLAndroidProjectType }

  IXMLAndroidProjectType = interface(IXMLNode)
    ['{007F9DA0-5216-41B3-B0E7-6E1D12791BD6}']
    { Property Accessors }
    function Get_Xmlns: UnicodeString;
    function Get_PropertyGroup: IXMLAndroidPropertyGroupType;
    function Get_ProjectExtensions: IXMLAndroidProjectExtensionsType;
    procedure Set_Xmlns(Value: UnicodeString);
    { Methods & Properties }
    property Xmlns: UnicodeString read Get_Xmlns write Set_Xmlns;
    property PropertyGroup: IXMLAndroidPropertyGroupType read Get_PropertyGroup;
    property ProjectExtensions: IXMLAndroidProjectExtensionsType read Get_ProjectExtensions;
  end;

{ IXMLAndroidPropertyGroupType }

  IXMLAndroidPropertyGroupType = interface(IXMLNode)
    ['{5069BDC1-75E1-4089-9395-5B6F7D1A5C3C}']
    { Property Accessors }
    function Get_Android_LauncherIcon96: UnicodeString;
    function Get_VerInfo_Build: Integer;
    function Get_Android_LauncherIcon48: UnicodeString;
    function Get_Android_LauncherIcon144: UnicodeString;
    function Get_Android_LauncherIcon36: UnicodeString;
    function Get_Android_LauncherIcon72: UnicodeString;
    procedure Set_Android_LauncherIcon96(Value: UnicodeString);
    procedure Set_VerInfo_Build(Value: Integer);
    procedure Set_Android_LauncherIcon48(Value: UnicodeString);
    procedure Set_Android_LauncherIcon144(Value: UnicodeString);
    procedure Set_Android_LauncherIcon36(Value: UnicodeString);
    procedure Set_Android_LauncherIcon72(Value: UnicodeString);
    { Methods & Properties }
    property Android_LauncherIcon96: UnicodeString read Get_Android_LauncherIcon96 write Set_Android_LauncherIcon96;
    property VerInfo_Build: Integer read Get_VerInfo_Build write Set_VerInfo_Build;
    property Android_LauncherIcon48: UnicodeString read Get_Android_LauncherIcon48 write Set_Android_LauncherIcon48;
    property Android_LauncherIcon144: UnicodeString read Get_Android_LauncherIcon144 write Set_Android_LauncherIcon144;
    property Android_LauncherIcon36: UnicodeString read Get_Android_LauncherIcon36 write Set_Android_LauncherIcon36;
    property Android_LauncherIcon72: UnicodeString read Get_Android_LauncherIcon72 write Set_Android_LauncherIcon72;
  end;

{ IXMLAndroidProjectExtensionsType }

  IXMLAndroidProjectExtensionsType = interface(IXMLNode)
    ['{7EBA6C53-988E-43F3-B3F9-CF83A0BCF1A1}']
    { Property Accessors }
    function Get_BorlandPersonality: UnicodeString;
    function Get_BorlandProjectType: UnicodeString;
    function Get_BorlandProject: IXMLAndroidBorlandProjectType;
    function Get_ProjectFileVersion: Integer;
    procedure Set_BorlandPersonality(Value: UnicodeString);
    procedure Set_BorlandProjectType(Value: UnicodeString);
    procedure Set_ProjectFileVersion(Value: Integer);
    { Methods & Properties }
    property BorlandPersonality: UnicodeString read Get_BorlandPersonality write Set_BorlandPersonality;
    property BorlandProjectType: UnicodeString read Get_BorlandProjectType write Set_BorlandProjectType;
    property BorlandProject: IXMLAndroidBorlandProjectType read Get_BorlandProject;
    property ProjectFileVersion: Integer read Get_ProjectFileVersion write Set_ProjectFileVersion;
  end;

{ IXMLAndroidBorlandProjectType }

  IXMLAndroidBorlandProjectType = interface(IXMLNode)
    ['{0F302909-F3FC-4953-8B3D-E6C212037173}']
    { Property Accessors }
    function Get_DelphiPersonality: UnicodeString;
    procedure Set_DelphiPersonality(Value: UnicodeString);
    { Methods & Properties }
    property DelphiPersonality: UnicodeString read Get_DelphiPersonality write Set_DelphiPersonality;
  end;

{ Forward Decls }

  TXMLAndroidProjectType = class;
  TXMLAndroidPropertyGroupType = class;
  TXMLAndroidProjectExtensionsType = class;
  TXMLAndroidBorlandProjectType = class;

{ TXMLAndroidProjectType }

  TXMLAndroidProjectType = class(TXMLNode, IXMLAndroidProjectType)
  protected
    { IXMLAndroidProjectType }
    function Get_Xmlns: UnicodeString;
    function Get_PropertyGroup: IXMLAndroidPropertyGroupType;
    function Get_ProjectExtensions: IXMLAndroidProjectExtensionsType;
    procedure Set_Xmlns(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAndroidPropertyGroupType }

  TXMLAndroidPropertyGroupType = class(TXMLNode, IXMLAndroidPropertyGroupType)
  protected
    { IXMLAndroidPropertyGroupType }
    function Get_Android_LauncherIcon96: UnicodeString;
    function Get_VerInfo_Build: Integer;
    function Get_Android_LauncherIcon48: UnicodeString;
    function Get_Android_LauncherIcon144: UnicodeString;
    function Get_Android_LauncherIcon36: UnicodeString;
    function Get_Android_LauncherIcon72: UnicodeString;
    procedure Set_Android_LauncherIcon96(Value: UnicodeString);
    procedure Set_VerInfo_Build(Value: Integer);
    procedure Set_Android_LauncherIcon48(Value: UnicodeString);
    procedure Set_Android_LauncherIcon144(Value: UnicodeString);
    procedure Set_Android_LauncherIcon36(Value: UnicodeString);
    procedure Set_Android_LauncherIcon72(Value: UnicodeString);
  end;

{ TXMLAndroidProjectExtensionsType }

  TXMLAndroidProjectExtensionsType = class(TXMLNode, IXMLAndroidProjectExtensionsType)
  protected
    { IXMLAndroidProjectExtensionsType }
    function Get_BorlandPersonality: UnicodeString;
    function Get_BorlandProjectType: UnicodeString;
    function Get_BorlandProject: IXMLAndroidBorlandProjectType;
    function Get_ProjectFileVersion: Integer;
    procedure Set_BorlandPersonality(Value: UnicodeString);
    procedure Set_BorlandProjectType(Value: UnicodeString);
    procedure Set_ProjectFileVersion(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLAndroidBorlandProjectType }

  TXMLAndroidBorlandProjectType = class(TXMLNode, IXMLAndroidBorlandProjectType)
  protected
    { IXMLAndroidBorlandProjectType }
    function Get_DelphiPersonality: UnicodeString;
    procedure Set_DelphiPersonality(Value: UnicodeString);
  end;

{ Global Functions }

function GetAndroidOptset(Doc: IXMLDocument): IXMLAndroidProjectType;
function LoadAndroidOptset(const FileName: string): IXMLAndroidProjectType;
function NewAndroidOptset: IXMLAndroidProjectType;

const
  TargetNamespace = 'http://schemas.microsoft.com/developer/msbuild/2003';

implementation

{ Global Functions }

function GetAndroidOptset(Doc: IXMLDocument): IXMLAndroidProjectType;
begin
  Result := Doc.GetDocBinding('Project', TXMLAndroidProjectType, TargetNamespace) as IXMLAndroidProjectType;
end;

function LoadAndroidOptset(const FileName: string): IXMLAndroidProjectType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('Project', TXMLAndroidProjectType, TargetNamespace) as IXMLAndroidProjectType;
end;

function NewAndroidOptset: IXMLAndroidProjectType;
begin
  Result := NewXMLDocument.GetDocBinding('Project', TXMLAndroidProjectType, TargetNamespace) as IXMLAndroidProjectType;
end;

{ TXMLAndroidProjectType }

procedure TXMLAndroidProjectType.AfterConstruction;
begin
  RegisterChildNode('PropertyGroup', TXMLAndroidPropertyGroupType);
  RegisterChildNode('ProjectExtensions', TXMLAndroidProjectExtensionsType);
  inherited;
end;

function TXMLAndroidProjectType.Get_Xmlns: UnicodeString;
begin
  Result := AttributeNodes['xmlns'].Text;
end;

procedure TXMLAndroidProjectType.Set_Xmlns(Value: UnicodeString);
begin
  SetAttribute('xmlns', Value);
end;

function TXMLAndroidProjectType.Get_PropertyGroup: IXMLAndroidPropertyGroupType;
begin
  Result := ChildNodes['PropertyGroup'] as IXMLAndroidPropertyGroupType;
end;

function TXMLAndroidProjectType.Get_ProjectExtensions: IXMLAndroidProjectExtensionsType;
begin
  Result := ChildNodes['ProjectExtensions'] as IXMLAndroidProjectExtensionsType;
end;

{ TXMLAndroidPropertyGroupType }

function TXMLAndroidPropertyGroupType.Get_Android_LauncherIcon96: UnicodeString;
begin
  Result := ChildNodes['Android_LauncherIcon96'].Text;
end;

procedure TXMLAndroidPropertyGroupType.Set_Android_LauncherIcon96(Value: UnicodeString);
begin
  ChildNodes['Android_LauncherIcon96'].NodeValue := Value;
end;

function TXMLAndroidPropertyGroupType.Get_VerInfo_Build: Integer;
begin
  Result := ChildNodes['VerInfo_Build'].NodeValue;
end;

procedure TXMLAndroidPropertyGroupType.Set_VerInfo_Build(Value: Integer);
begin
  ChildNodes['VerInfo_Build'].NodeValue := Value;
end;

function TXMLAndroidPropertyGroupType.Get_Android_LauncherIcon48: UnicodeString;
begin
  Result := ChildNodes['Android_LauncherIcon48'].Text;
end;

procedure TXMLAndroidPropertyGroupType.Set_Android_LauncherIcon48(Value: UnicodeString);
begin
  ChildNodes['Android_LauncherIcon48'].NodeValue := Value;
end;

function TXMLAndroidPropertyGroupType.Get_Android_LauncherIcon144: UnicodeString;
begin
  Result := ChildNodes['Android_LauncherIcon144'].Text;
end;

procedure TXMLAndroidPropertyGroupType.Set_Android_LauncherIcon144(Value: UnicodeString);
begin
  ChildNodes['Android_LauncherIcon144'].NodeValue := Value;
end;

function TXMLAndroidPropertyGroupType.Get_Android_LauncherIcon36: UnicodeString;
begin
  Result := ChildNodes['Android_LauncherIcon36'].Text;
end;

procedure TXMLAndroidPropertyGroupType.Set_Android_LauncherIcon36(Value: UnicodeString);
begin
  ChildNodes['Android_LauncherIcon36'].NodeValue := Value;
end;

function TXMLAndroidPropertyGroupType.Get_Android_LauncherIcon72: UnicodeString;
begin
  Result := ChildNodes['Android_LauncherIcon72'].Text;
end;

procedure TXMLAndroidPropertyGroupType.Set_Android_LauncherIcon72(Value: UnicodeString);
begin
  ChildNodes['Android_LauncherIcon72'].NodeValue := Value;
end;

{ TXMLAndroidProjectExtensionsType }

procedure TXMLAndroidProjectExtensionsType.AfterConstruction;
begin
  RegisterChildNode('BorlandProject', TXMLAndroidBorlandProjectType);
  inherited;
end;

function TXMLAndroidProjectExtensionsType.Get_BorlandPersonality: UnicodeString;
begin
  Result := ChildNodes['Borland.Personality'].Text;
end;

procedure TXMLAndroidProjectExtensionsType.Set_BorlandPersonality(Value: UnicodeString);
begin
  ChildNodes['Borland.Personality'].NodeValue := Value;
end;

function TXMLAndroidProjectExtensionsType.Get_BorlandProjectType: UnicodeString;
begin
  Result := ChildNodes['Borland.ProjectType'].NodeValue;
end;

procedure TXMLAndroidProjectExtensionsType.Set_BorlandProjectType(Value: UnicodeString);
begin
  ChildNodes['Borland.ProjectType'].NodeValue := Value;
end;

function TXMLAndroidProjectExtensionsType.Get_BorlandProject: IXMLAndroidBorlandProjectType;
begin
  Result := ChildNodes['BorlandProject'] as IXMLAndroidBorlandProjectType;
end;

function TXMLAndroidProjectExtensionsType.Get_ProjectFileVersion: Integer;
begin
  Result := ChildNodes['ProjectFileVersion'].NodeValue;
end;

procedure TXMLAndroidProjectExtensionsType.Set_ProjectFileVersion(Value: Integer);
begin
  ChildNodes['ProjectFileVersion'].NodeValue := Value;
end;

{ TXMLAndroidBorlandProjectType }

function TXMLAndroidBorlandProjectType.Get_DelphiPersonality: UnicodeString;
begin
  Result := ChildNodes['Delphi.Personality'].Text;
end;

procedure TXMLAndroidBorlandProjectType.Set_DelphiPersonality(Value: UnicodeString);
begin
  ChildNodes['Delphi.Personality'].NodeValue := Value;
end;

end.
