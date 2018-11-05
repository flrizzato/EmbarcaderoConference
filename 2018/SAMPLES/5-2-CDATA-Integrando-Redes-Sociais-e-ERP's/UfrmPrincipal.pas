unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, CloudBase, CloudBaseWin, CloudCustomLinkedIn,
  CloudLinkedIn, CloudImage, System.TypInfo, Vcl.Imaging.pngimage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataSAPERP, FireDAC.Phys.CDataSAPERPDef,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Menus,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Comp.DataSet, StrUtils;

type
  TfrmPrincipal = class(TForm)
    AdvLinkedIn1: TAdvLinkedIn;
    Image1: TImage;
    imgLogoGam: TImage;
    BitBtn1: TBitBtn;
    Image2: TImage;
    FDConexaoSAP: TFDConnection;
    FDQPA0000: TFDQuery;
    dsPA000: TDataSource;
    dbgPA000: TDBGrid;
    FDQPA0000PERNR: TStringField;
    FDQPA0000SNAME: TStringField;
    FDQPA0000ENAME: TStringField;
    AdvCloudImage1: TAdvCloudImage;
    mmPerfil: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgPA000DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    resultpage: Integer;
    resultcount: Integer;
    procedure Retornar_Perfil_GAM;
  public
    { Public declarations }
    Conectado: boolean;
  end;

var
  frmPrincipal: TfrmPrincipal;

const
  LinkedInAppkey = ''; //Informar ClientID Linkedin
  LinkedInAppSecret = ''; //Informar Secret Linkedin

implementation

{$R *.dfm}

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
var
  acc: boolean;
begin
  AdvLinkedIn1.App.Key := LinkedInAppKey;
  AdvLinkedIn1.App.Secret := LinkedInAppSecret;
  AdvLinkedIn1.Logging := True;
  AdvLinkedIn1.LogLevel := llDetail;

  if AdvLinkedIn1.App.Key <> '' then
  begin
    AdvLinkedIn1.PersistTokens.Location := plIniFile;
    AdvLinkedIn1.PersistTokens.Key := '.\linkedin.ini';
    AdvLinkedIn1.PersistTokens.Section := 'tokens';

    AdvLinkedIn1.LoadTokens;

    acc := AdvLinkedIn1.TestTokens;

    if not acc then
    begin
      AdvLinkedIn1.RefreshAccess;
      AdvLinkedIn1.DoAuth;
    end
    else
    begin
      Conectado := AdvLinkedIn1.Connect;
    end;
  end
  else
    ShowMessage('Por favor verifique suas credencias de conexão Linkedin!!!');

  FDConexaoSAP.Connected := True;
  FDQPA0000.Active := True;

  dbgPA000.Visible := True;
end;

procedure TfrmPrincipal.dbgPA000DblClick(Sender: TObject);
begin
  Retornar_Perfil_GAM;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FDConexaoSAP.Connected := False;
  FDQPA0000.Active := False;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  AdvCloudImage1.Visible := False;
  mmPerfil.Visible := False;

  FDConexaoSAP.Connected := False;
  FDQPA0000.Active := False;
end;

procedure TfrmPrincipal.Retornar_Perfil_GAM;
var
  Linkedin_Profile: TLinkedInProfile;
begin
  AdvCloudImage1.Visible := True;
  mmPerfil.Visible := True;

  AdvLinkedIn1.GetDefaultProfile;
  Linkedin_Profile := AdvLinkedIn1.DefaultProfile;
  AdvCloudImage1.URL := Linkedin_Profile.PictureURL;

  mmPerfil.Lines.Clear;
  mmPerfil.Lines.Add('Perfil: ' + Linkedin_Profile.FormattedName + #13 + #13);
  mmPerfil.Lines.Add('Perfil Publico: ' + Linkedin_Profile.PublicProfileURL + #13 + #13);
  mmPerfil.Lines.Add('Email: ' + Linkedin_Profile.EmailAddress + #13 + #13);
  mmPerfil.Lines.Add('Título: ' + Linkedin_Profile.Headline + #13 + #13);
  mmPerfil.Lines.Add('Resumo: ' + Linkedin_Profile.Summary + #13 + #13);
  mmPerfil.Lines.Add('Conexões: ' + IfThen(Linkedin_Profile.ConnectionsCapped, '+', '') + IntToStr(Linkedin_Profile.ConnectionsCount) + #13 + #13);
  mmPerfil.Lines.Add('Localização: ' + Linkedin_Profile.Location + #13 + #13);
  mmPerfil.Lines.Add('País: ' + Linkedin_Profile.CountryCode + #13 + #13);
end;

end.
