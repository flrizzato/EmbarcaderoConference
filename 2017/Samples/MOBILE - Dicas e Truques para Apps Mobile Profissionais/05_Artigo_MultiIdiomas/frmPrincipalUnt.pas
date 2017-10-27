unit frmPrincipalUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Controls.Presentation;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image2: TImage;
    Tradutor: TLang;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}
uses FMX.Platform,
    System.IOUtils;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  raise Exception.Create(Translate('Erro do botão 1'));
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
 LoadLangFromStrings(Tradutor.LangStr['BR']);
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  LoadLangFromStrings(Tradutor.LangStr['EN']);
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
var
  Local : IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, Local) then
    begin
      // Atribuimos o Valor do ID do Idioma do Dispositvo ao TLang
      // Como o resultado é minúsculo, convertemos para maiúsculo, como usuado
      // nos idiomas em nosso TLang
      Tradutor.Lang := UpperCase(Local.GetCurrentLangID);
    end;

  //Veja que o valor do Edit1 agora contém o idioma retornado do Dispositivo
  Edit1.Text := Local.GetCurrentLangID;

  if Tradutor.Lang = 'PO' then
    // Quando o idioma for Português no dispositivo vamos usar o BR de nosso TLang
    LoadLangFromStrings(Tradutor.LangStr['BR']);

  //Forçamos a tradução do conteúdo do Edit2
  Edit2.Text := Translate(Edit2.Text);
  Memo1.Lines.Clear;
  //Forçamos a tradução do conteúdo do Memo
  Memo1.Lines.Add(Translate('Linha 1'));

end;

end.
