unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.Objects, FMX.TabControl, FMX.ScrollBox, FMX.Memo, FMX.Effects;

type
  TfrmMain = class(TForm)
    lytContentMain: TLayout;
    vsbContentMain: TVertScrollBox;
    tbMain: TToolBar;
    tbcMain: TTabControl;
    lytClient: TLayout;
    tbiEmpresa: TTabItem;
    tbiPais: TTabItem;
    tbiEstado: TTabItem;
    tbiLoja: TTabItem;
    tbiGrupoProduto: TTabItem;
    lytContainerEmpresa: TLayout;
    vsbContainerEmpresa: TVertScrollBox;
    rctBackgroundEmpresa: TRectangle;
    lytLogo: TLayout;
    lytCamposEmpresa: TLayout;
    lytBotaoAddEmpresa: TLayout;
    Layout1: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    lblNomeEmpresa: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    lblLocalidade: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnAddEmpresa: TButton;
    lytBotaoFooter: TLayout;
    Rectangle3: TRectangle;
    Label8: TLabel;
    lytContentEmpresa: TLayout;
    mmoDebugEmpresa: TMemo;
    btnEmpresaF3: TSpeedButton;
    lytTopAlinhamento: TLayout;
    lytAlinhamentLinguagem: TLayout;
    btnIdioma: TButton;
    Image40: TImage;
    lytAlinhamentConfig: TLayout;
    btnConfig: TButton;
    imgLogo: TImage;
    imgConfig: TImage;
    lytContentPais: TLayout;
    vsbContentPais: TVertScrollBox;
    rtcBackgroundPais: TRectangle;
    lytCamposPais: TLayout;
    Layout8: TLayout;
    btnAddPais: TButton;
    Layout9: TLayout;
    Layout10: TLayout;
    lblNomePais: TLabel;
    Layout11: TLayout;
    Layout12: TLayout;
    lblLocalidadePais: TLabel;
    Label11: TLabel;
    Layout14: TLayout;
    Label14: TLabel;
    lblUniarcPais: TLabel;
    lytDadosPais: TLayout;
    Layout17: TLayout;
    Layout27: TLayout;
    Label12: TLabel;
    Image46: TImage;
    btnMapaPais: TButton;
    Layout28: TLayout;
    Image52: TImage;
    Label9: TLabel;
    btnLigarPais: TButton;
    Layout18: TLayout;
    Layout19: TLayout;
    Label20: TLabel;
    Layout20: TLayout;
    Layout21: TLayout;
    Label21: TLabel;
    Layout25: TLayout;
    lblResponsavel: TLabel;
    Layout2: TLayout;
    Layout16: TLayout;
    Label22: TLabel;
    Layout26: TLayout;
    lblContato: TLabel;
    Layout24: TLayout;
    lblLocalizacao: TLabel;
    lytBotaoFooterPais: TLayout;
    Rectangle6: TRectangle;
    Label15: TLabel;
    btnPaisF3: TSpeedButton;
    lytContPais: TLayout;
    mmoDebugLocalidade: TMemo;
    lytContentEstado: TLayout;
    vsbContentEstado: TVertScrollBox;
    rctBackgroundEstado: TRectangle;
    lytCamposEstado: TLayout;
    Layout22: TLayout;
    btnAddEstado: TButton;
    Layout23: TLayout;
    Layout29: TLayout;
    lblNomeEstado: TLabel;
    Layout30: TLayout;
    Label17: TLabel;
    Label18: TLabel;
    lytCampoEstado2: TLayout;
    Layout34: TLayout;
    Layout35: TLayout;
    Label24: TLabel;
    Image1: TImage;
    btnMapaEstado: TButton;
    Layout36: TLayout;
    Image2: TImage;
    Label25: TLabel;
    btnLigarEstado: TButton;
    Layout37: TLayout;
    Layout38: TLayout;
    Label26: TLabel;
    Layout39: TLayout;
    Layout40: TLayout;
    Label27: TLabel;
    Layout41: TLayout;
    lvlResponsavelEstado: TLabel;
    Layout42: TLayout;
    Layout43: TLayout;
    Label29: TLabel;
    Layout44: TLayout;
    lvlEstadoTelefone: TLabel;
    Layout45: TLayout;
    lblLocalizacaoEstado: TLabel;
    lytBotaoFooterEstado: TLayout;
    Rectangle9: TRectangle;
    Label23: TLabel;
    btnEstadoF3: TSpeedButton;
    lytContEstado: TLayout;
    mmoDebugEstado: TMemo;
    lytContentLoja: TLayout;
    vsbContentLoja: TVertScrollBox;
    rctContentLoja: TRectangle;
    lytCamposLoja: TLayout;
    Layout31: TLayout;
    Image43: TImage;
    Label47: TLabel;
    btnMapaLoja: TButton;
    Layout13: TLayout;
    Layout51: TLayout;
    Label28: TLabel;
    Layout145: TLayout;
    lblLocalizacaoLoja: TLabel;
    lytCamposLoja2: TLayout;
    Layout33: TLayout;
    Image44: TImage;
    btnAddLoja: TButton;
    Layout46: TLayout;
    Layout47: TLayout;
    lblNomeLoja: TLabel;
    LytBotaoLojaF: TLayout;
    Rectangle12: TRectangle;
    Label32: TLabel;
    btnLojaF3: TSpeedButton;
    Layout15: TLayout;
    VertScrollBox2: TVertScrollBox;
    rtgAerador: TRectangle;
    Layout32: TLayout;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    lytTotalSensores: TLayout;
    lstTotalSensores: TListBox;
    lstiTotalSensores: TListBoxItem;
    lblTotalSensores: TLabel;
    lstiOperacionais: TListBoxItem;
    Layout48: TLayout;
    cbxUmidade: TComboBox;
    lblConservacaoLoja: TLabel;
    shdSiloConservacao: TShadowEffect;
    mmoDebugLoja: TMemo;
    lytContentGrupoProduto: TLayout;
    vsbContentGrupoProduto: TVertScrollBox;
    Rectangle13: TRectangle;
    Layout49: TLayout;
    Rectangle14: TRectangle;
    Layout50: TLayout;
    Layout52: TLayout;
    Image45: TImage;
    Layout53: TLayout;
    Layout54: TLayout;
    lblNomeGrupoProduto: TLabel;
    Layout55: TLayout;
    Layout56: TLayout;
    lytSensorMapa: TLayout;
    Image49: TImage;
    Label36: TLabel;
    Button11: TButton;
    Layout72: TLayout;
    Image50: TImage;
    btnAtualizarGrupo: TButton;
    Layout66: TLayout;
    Layout67: TLayout;
    lblLocalidadeSendor: TLabel;
    Layout68: TLayout;
    lblSensorZona: TLabel;
    Line5: TLine;
    Layout57: TLayout;
    VertScrollBox1: TVertScrollBox;
    rctTransmissao: TRectangle;
    Layout159: TLayout;
    ListBox2: TListBox;
    ListBoxItem4: TListBoxItem;
    Layout58: TLayout;
    Layout92: TLayout;
    Label37: TLabel;
    Layout93: TLayout;
    lblSensorUltimaTransHora: TLabel;
    Layout94: TLayout;
    lblSensorUltimaTransData: TLabel;
    ListBoxItem5: TListBoxItem;
    Layout77: TLayout;
    Layout95: TLayout;
    Label41: TLabel;
    Layout96: TLayout;
    lblSensorPoximaTransHora: TLabel;
    Layout97: TLayout;
    lblSensorPoximaTransData: TLabel;
    rctId: TRectangle;
    Layout79: TLayout;
    Layout82: TLayout;
    lblSensorID: TLabel;
    Layout69: TLayout;
    Layout78: TLayout;
    Circle2: TCircle;
    Image8: TImage;
    Layout80: TLayout;
    lvlSensorPorcentID: TLabel;
    rctTemperatura: TRectangle;
    Layout84: TLayout;
    Layout71: TLayout;
    Label57: TLabel;
    lblSensorTempIntervLeit: TLabel;
    Layout73: TLayout;
    lblSensorTempVlLeituraInterno: TLabel;
    Layout74: TLayout;
    Label55: TLabel;
    lblSensorTempUltLeitData: TLabel;
    lblSensorTempUltLeitHora: TLabel;
    Label39: TLabel;
    Layout70: TLayout;
    Layout83: TLayout;
    Circle3: TCircle;
    Image9: TImage;
    Layout85: TLayout;
    lblSensorTempVlLeitura: TLabel;
    rctUmidade: TRectangle;
    Layout86: TLayout;
    Circle4: TCircle;
    Image10: TImage;
    Layout88: TLayout;
    lblSensorUmidVlLeitura: TLabel;
    Layout76: TLayout;
    Layout87: TLayout;
    Label40: TLabel;
    lblSensorUmidIntervLeit: TLabel;
    Layout144: TLayout;
    lblSensorUmidVlLeituraInterno: TLabel;
    Layout155: TLayout;
    Label46: TLabel;
    lblSensorUmidUltLeitData: TLabel;
    lblSensorUmidUltLeitHora: TLabel;
    Label49: TLabel;
    rctLux: TRectangle;
    Layout89: TLayout;
    Circle5: TCircle;
    Image11: TImage;
    Layout91: TLayout;
    lblSensorLuminVlLeitura: TLabel;
    Label74: TLabel;
    Layout90: TLayout;
    Layout156: TLayout;
    Label43: TLabel;
    lblSensorLuminIntervLeit: TLabel;
    Layout157: TLayout;
    lblSensorLuminVlLeituraInterno: TLabel;
    Layout158: TLayout;
    Label48: TLabel;
    lblSensorLuminUltLeitData: TLabel;
    lblSensorLuminUltLeitHora: TLabel;
    Label53: TLabel;
    btnAddGrupoProduto: TButton;
    lytModalEmpresa: TLayout;
    Layout98: TLayout;
    Rectangle28: TRectangle;
    Layout99: TLayout;
    Rectangle25: TRectangle;
    btnCloseModalEmpresa: TButton;
    lytModalEstado: TLayout;
    Panel2: TPanel;
    Layout63: TLayout;
    Layout64: TLayout;
    Rectangle15: TRectangle;
    Layout65: TLayout;
    Rectangle16: TRectangle;
    btnCloseModalEstado: TButton;
    lytModalGrupoProduto: TLayout;
    Panel4: TPanel;
    Layout102: TLayout;
    Layout103: TLayout;
    Rectangle22: TRectangle;
    Layout104: TLayout;
    Rectangle23: TRectangle;
    btnCloseModalGrupoProduto: TButton;
    lytModalLoja: TLayout;
    Panel3: TPanel;
    Layout75: TLayout;
    Layout100: TLayout;
    Rectangle20: TRectangle;
    Layout101: TLayout;
    Rectangle21: TRectangle;
    btnCloseModalLoja: TButton;
    lytModalPais: TLayout;
    Panel1: TPanel;
    lytSelect: TLayout;
    Layout61: TLayout;
    Rectangle17: TRectangle;
    Layout62: TLayout;
    Rectangle18: TRectangle;
    btnCloseModalPais: TButton;
    procedure btnAddEmpresaClick(Sender: TObject);
    procedure btnCloseModalEmpresaClick(Sender: TObject);
    procedure btnAddPaisClick(Sender: TObject);
    procedure btnCloseModalPaisClick(Sender: TObject);
    procedure btnAddEstadoClick(Sender: TObject);
    procedure btnCloseModalEstadoClick(Sender: TObject);
    procedure btnAddLojaClick(Sender: TObject);
    procedure btnCloseModalLojaClick(Sender: TObject);
    procedure btnAddGrupoProdutoClick(Sender: TObject);
    procedure btnCloseModalGrupoProdutoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnAddEmpresaClick(Sender: TObject);
begin
  lytModalEmpresa.Visible := true;
end;

procedure TfrmMain.btnAddEstadoClick(Sender: TObject);
begin
  lytModalEstado.Visible := true;
end;

procedure TfrmMain.btnAddGrupoProdutoClick(Sender: TObject);
begin
  lytModalGrupoProduto.Visible := true;
end;

procedure TfrmMain.btnAddLojaClick(Sender: TObject);
begin
  lytModalLoja.Visible := true;
end;

procedure TfrmMain.btnAddPaisClick(Sender: TObject);
begin
  lytModalPais.Visible := true;
end;

procedure TfrmMain.btnCloseModalEmpresaClick(Sender: TObject);
begin
  lytModalEmpresa.Visible := false;
end;

procedure TfrmMain.btnCloseModalEstadoClick(Sender: TObject);
begin
  lytModalEstado.Visible := false;
end;

procedure TfrmMain.btnCloseModalGrupoProdutoClick(Sender: TObject);
begin
  lytModalGrupoProduto.Visible := false;
end;

procedure TfrmMain.btnCloseModalLojaClick(Sender: TObject);
begin
  lytModalLoja.Visible := false;
end;

procedure TfrmMain.btnCloseModalPaisClick(Sender: TObject);
begin
  lytModalPais.Visible := false;
end;

end.
