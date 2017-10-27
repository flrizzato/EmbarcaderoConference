unit uFrmMobile;

interface

uses
   Data.Bind.Components,
   Data.Bind.DBScope,
   Data.Bind.EngExt,
   Data.DB,
   Data.FireDACJSONReflect,
   FGX.ProgressDialog,
   FireDAC.Comp.Client,
   FireDAC.Comp.DataSet,
   FireDAC.Comp.UI,
   FireDAC.DApt,
   FireDAC.DApt.Intf,
   FireDAC.DatS,
   FireDAC.FMXUI.Wait,
   FireDAC.Phys,
   FireDAC.Phys.Intf,
   FireDAC.Phys.SQLite,
   FireDAC.Phys.SQLiteDef,
   FireDAC.Stan.Async,
   FireDAC.Stan.Def,
   FireDAC.Stan.Error,
   FireDAC.Stan.ExprFuncs,
   FireDAC.Stan.Intf,
   FireDAC.Stan.Option,
   FireDAC.Stan.Param,
   FireDAC.Stan.Pool,
   FireDAC.Stan.StorageBin,
   FireDAC.Stan.StorageJSON,
   FireDAC.UI.Intf,
   FMX.ActnList,
   FMX.Ani,
   FMX.Bind.DBEngExt,
   FMX.Bind.Editors,
   FMX.Controls,
   FMX.Controls.Presentation,
   FMX.DateTimeCtrls,
   FMX.Dialogs,
   FMX.Edit,
   FMX.Forms,
   FMX.Gestures,
   FMX.Graphics,
   FMX.ImgList,
   FMX.Layouts,
   FMX.ListBox,
   FMX.ListView,
   FMX.ListView.Adapters.Base,
   FMX.ListView.Appearances,
   FMX.ListView.Types,
   FMX.Objects,
   FMX.StdCtrls,
   FMX.TabControl,
   FMX.Types,
   FMX.wwBaseGrid,
   FMX.wwColumnTypes,
   FMX.wwDataGrid,
   FMX.wwLayouts,
   //ksListView,
   //ksSlideMenu,
   System.Actions,
   System.Bindings.Outputs,
   System.Classes,
   System.ImageList,
   System.Math,
   System.Rtti,
   System.SysUtils,
   System.Types,
   System.UITypes,
   System.Variants,
   //uFrmMapView,
   FMX.ScrollBox,
   FMX.Memo,
   FMX.Effects,
   FMXTee.Engine,
   FMXTee.Procs,
   FMXTee.Chart,
   FMXTee.Series,
   System.UIConsts, ksSlideMenu;

type
   TfrmMobile = class(TForm)
      ActionList1: TActionList;
      btnClienteCarga: TButton;
      btnClienteDescarga: TButton;
      btnClienteRelatorios: TButton;
      btnConfig: TButton;
      btnIdioma: TButton;
      btnLigar: TButton;
      btnLocalidadeCarga: TButton;
      btnLocalidadeDescarga: TButton;
      btnLocalidadeRelatorios: TButton;
      btnMapa: TButton;
      btnRelatFechar: TButton;
      btnSensorAtualizar: TButton;
      btnSensorCarga: TButton;
      btnSensorDescarga: TButton;
      btnSensorRelatorio: TButton;
      btnSiloAdd: TButton;
      btnSiloCarga: TButton;
      btnSiloGrafico: TButton;
      btnSiloMapa: TButton;
      btnSiloRelatorios: TButton;
      btnTrocarSenhaSalvar: TButton;
      btnUniarcAdd: TButton;
      btnUniarcCarga: TButton;
      btnUniarcDescarga: TButton;
      btnUniarcLigar: TButton;
      btnUniarcMapa: TButton;
      btnUniarcRelatorios: TButton;
      Button10: TButton;
      Button11: TButton;
      Button17: TButton;
      Button1: TButton;
      Button2: TButton;
      Button3: TButton;
      Button4: TButton;
      Button5: TButton;
      Button6: TButton;
      Button8: TButton;
      cbbParamRelatCliente: TComboBox;
      cbxUmidade: TComboBox;
      Circle2: TCircle;
      Circle3: TCircle;
      Circle4: TCircle;
      Circle5: TCircle;
      edtParamRelatFornec: TEdit;
      edtParamRelatNumero: TEdit;
      edtParamRelatPeriodoFinal: TDateEdit;
      edtParamRelatPeriodoInicial: TDateEdit;
      edtParamRelatTransp: TEdit;
      edtTrocarSenhaAtual: TEdit;
      edtTrocarSenhaNova: TEdit;
      grdCliente: TwwDataGrid;
      grdClienteAtual: TwwGridColumn;
      grdClienteGrao: TwwGridColumn;
      grdClienteInicial: TwwGridColumn;
      grdClienteLivre: TwwGridColumn;
      grdClienteTotal: TwwGridColumn;
      grdLocalidade: TwwDataGrid;
      grdLocalidadeAtual: TwwGridColumn;
      grdLocalidadeGrao: TwwGridColumn;
      grdLocalidadeInicial: TwwGridColumn;
      grdLocalidadeLivre: TwwGridColumn;
      grdLocalidadeTotal: TwwGridColumn;
      grdSilos1: TwwDataGrid;
      grdSilos2: TwwDataGrid;
      grdSilos2Atual: TwwGridColumn;
      grdSilos2Grao: TwwGridColumn;
      grdSilos2Inicial: TwwGridColumn;
      grdSilos2Livre: TwwGridColumn;
      grdSilos2Total: TwwGridColumn;
      grdUniarc: TwwDataGrid;
      grdUniarcAtual: TwwGridColumn;
      grdUniarcGrao: TwwGridColumn;
      grdUniarcInicial: TwwGridColumn;
      grdUniarcLivre: TwwGridColumn;
      grdUniarcTotal: TwwGridColumn;
      Image10: TImage;
      Image11: TImage;
      Image13: TImage;
      Image15: TImage;
      Image17: TImage;
      Image19: TImage;
      Image1: TImage;
      imgLogoCarga: TImage;
      Image24: TImage;
      Image25: TImage;
      Image26: TImage;
      Image27: TImage;
      Image28: TImage;
      Image29: TImage;
      Image2: TImage;
      Image30: TImage;
      Image31: TImage;
      Image32: TImage;
      Image33: TImage;
      Image34: TImage;
      Image35: TImage;
      imgClienteCarga: TImage;
      Image37: TImage;
      Image38: TImage;
      Image3: TImage;
      Image40: TImage;
      Image41: TImage;
      Image42: TImage;
      Image43: TImage;
      Image44: TImage;
      Image45: TImage;
      Image46: TImage;
      Image47: TImage;
      Image49: TImage;
      Image4: TImage;
      Image50: TImage;
      Image51: TImage;
      Image52: TImage;
      Image53: TImage;
      Image54: TImage;
      Image5: TImage;
      Image60: TImage;
      Image61: TImage;
      Image6: TImage;
      Image7: TImage;
      Image8: TImage;
      Image9: TImage;
      imgConfig: TImage;
      ksSlideMenuConfig: TksSlideMenu;
      Label10: TLabel;
      Label11: TLabel;
      Label12: TLabel;
      lblClienteCarga: TLabel;
      Label14: TLabel;
      Label15: TLabel;
      Label16: TLabel;
      Label17: TLabel;
      Label18: TLabel;
      Label19: TLabel;
      Label1: TLabel;
      Label20: TLabel;
      Label21: TLabel;
      Label22: TLabel;
      Label23: TLabel;
      Label24: TLabel;
      Label25: TLabel;
      Label26: TLabel;
      lblLocalidadeSendor: TLabel;
      Label28: TLabel;
      Label29: TLabel;
      Label31: TLabel;
      Label32: TLabel;
      Label33: TLabel;
      Label34: TLabel;
      Label35: TLabel;
      Label36: TLabel;
      Label37: TLabel;
      Label38: TLabel;
      Label39: TLabel;
      Label3: TLabel;
      Label40: TLabel;
      Label41: TLabel;
      Label42: TLabel;
      Label43: TLabel;
      Label44: TLabel;
      Label45: TLabel;
      Label46: TLabel;
      Label47: TLabel;
      Label48: TLabel;
      Label49: TLabel;
      Label4: TLabel;
      Label53: TLabel;
      Label55: TLabel;
      Label56: TLabel;
      Label57: TLabel;
      Label58: TLabel;
      Label59: TLabel;
      Label5: TLabel;
      Label64: TLabel;
      Label6: TLabel;
      Label74: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      Label9: TLabel;
      Layout100: TLayout;
      Layout101: TLayout;
      Layout102: TLayout;
      Layout103: TLayout;
      Layout104: TLayout;
      Layout105: TLayout;
      Layout106: TLayout;
      Layout107: TLayout;
      Layout108: TLayout;
      Layout109: TLayout;
      Layout10: TLayout;
      Layout110: TLayout;
      Layout111: TLayout;
      Layout112: TLayout;
      Layout113: TLayout;
      Layout114: TLayout;
      Layout115: TLayout;
      Layout116: TLayout;
      Layout117: TLayout;
      lytContentCarga: TLayout;
      lytCenterCarga: TLayout;
      Layout11: TLayout;
      lytTitleCarga: TLayout;
      Layout126: TLayout;
      Layout127: TLayout;
      Layout128: TLayout;
      Layout129: TLayout;
      Layout12: TLayout;
      Layout130: TLayout;
      Layout131: TLayout;
      Layout132: TLayout;
      Layout133: TLayout;
      Layout134: TLayout;
      Layout135: TLayout;
      Layout136: TLayout;
      Layout137: TLayout;
      Layout138: TLayout;
      Layout139: TLayout;
      Layout140: TLayout;
      Layout141: TLayout;
      Layout142: TLayout;
      Layout143: TLayout;
      Layout144: TLayout;
      Layout145: TLayout;
      Layout148: TLayout;
      Layout149: TLayout;
      Layout14: TLayout;
      Layout150: TLayout;
      Layout151: TLayout;
      Layout153: TLayout;
      Layout154: TLayout;
      Layout155: TLayout;
      Layout156: TLayout;
      Layout157: TLayout;
      Layout158: TLayout;
      Layout159: TLayout;
      Layout15: TLayout;
      Layout16: TLayout;
      Layout17: TLayout;
      Layout18: TLayout;
      Layout19: TLayout;
      Layout1: TLayout;
      Layout20: TLayout;
      Layout21: TLayout;
      Layout22: TLayout;
      Layout23: TLayout;
      Layout24: TLayout;
      Layout25: TLayout;
      Layout26: TLayout;
      Layout27: TLayout;
      Layout28: TLayout;
      Layout29: TLayout;
      Layout2: TLayout;
      Layout30: TLayout;
      Layout31: TLayout;
      Layout32: TLayout;
      Layout33: TLayout;
      Layout34: TLayout;
      Layout35: TLayout;
      Layout36: TLayout;
      Layout37: TLayout;
      Layout38: TLayout;
      Layout39: TLayout;
      Layout3: TLayout;
      Layout40: TLayout;
      Layout41: TLayout;
      Layout42: TLayout;
      Layout43: TLayout;
      Layout44: TLayout;
      Layout45: TLayout;
      Layout46: TLayout;
      Layout48: TLayout;
      Layout49: TLayout;
      Layout4: TLayout;
      Layout50: TLayout;
      Layout51: TLayout;
      Layout52: TLayout;
      lytSensorMapa: TLayout;
      Layout58: TLayout;
      Layout59: TLayout;
      Layout5: TLayout;
      Layout60: TLayout;
      Layout61: TLayout;
      Layout62: TLayout;
      Layout63: TLayout;
      Layout64: TLayout;
      Layout65: TLayout;
      Layout66: TLayout;
      Layout67: TLayout;
      Layout68: TLayout;
      Layout69: TLayout;
      Layout70: TLayout;
      Layout71: TLayout;
      Layout72: TLayout;
      Layout73: TLayout;
      Layout74: TLayout;
      Layout76: TLayout;
      Layout77: TLayout;
      Layout78: TLayout;
      Layout79: TLayout;
      Layout7: TLayout;
      Layout80: TLayout;
      Layout81: TLayout;
      Layout82: TLayout;
      Layout83: TLayout;
      Layout84: TLayout;
      Layout85: TLayout;
      Layout86: TLayout;
      Layout87: TLayout;
      Layout88: TLayout;
      Layout89: TLayout;
      Layout8: TLayout;
      Layout90: TLayout;
      Layout91: TLayout;
      Layout92: TLayout;
      Layout93: TLayout;
      Layout94: TLayout;
      Layout95: TLayout;
      Layout96: TLayout;
      Layout97: TLayout;
      Layout98: TLayout;
      Layout99: TLayout;
      Layout9: TLayout;
      lblContato: TLabel;
      lblLocalizacao: TLabel;
      lblNomeCliente2: TLabel;
      lblNomeCliente: TLabel;
      lblParamRelatCliente: TLabel;
      lblParamRelatFornec: TLabel;
      lblParamRelatNumero: TLabel;
      lblParamRelatPeriodoFinal: TLabel;
      lblParamRelatPeriodoInicial: TLabel;
      lblParamRelatTransp: TLabel;
      lblQtLocalidades: TLabel;
      lblResponsavel: TLabel;
      lblSensoresOperacionais: TLabel;
      lblSensoresOperacionais_: TLabel;
      lblSensorTempIntervLeit: TLabel;
      lblSensorTempVlLeitura: TLabel;
      lblSensorID: TLabel;
      lblSensorLuminIntervLeit: TLabel;
      lblSensorUmidIntervLeit: TLabel;
      lblSensorZona: TLabel;
      lblSensorLuminVlLeitura: TLabel;
      lblSensorLuminVlLeituraInterno: TLabel;
      lblSensorIdCjNome: TLabel;
      lblSensorPoximaTransData: TLabel;
      lblSensorPoximaTransHora: TLabel;
      lblSensorTempUltLeitData: TLabel;
      lblSensorTempUltLeitHora: TLabel;
      lblSensorTempVlLeituraInterno: TLabel;
      lblSensorLuminUltLeitData: TLabel;
      lblSensorLuminUltLeitHora: TLabel;
      lblSensorUltimaTransData: TLabel;
      lblSensorUltimaTransHora: TLabel;
      lblSensorUmidVlLeitura: TLabel;
      lblSensorUmidUltLeitData: TLabel;
      lblSensorUmidUltLeitHora: TLabel;
      lblSensorUmidVlLeituraInterno: TLabel;
      lblSiloLocalizacao: TLabel;
      lblSiloNome: TLabel;
      lblSilos2: TLabel;
      lblSilos: TLabel;
      lblToneladas2: TLabel;
      lblToneladas: TLabel;
      lblTotalSensores: TLabel;
      lblTotalSensores_: TLabel;
      lblTrocarSenha: TLabel;
      lblUniarcContato: TLabel;
      lblUniarcLocalizacao: TLabel;
      lblUniarcResponsavel: TLabel;
      lblUniarcs2: TLabel;
      lblUniarcs: TLabel;
      Line1: TLine;
      Line2: TLine;
      Line3: TLine;
      Line4: TLine;
      ListBox1: TListBox;
      ListBox2: TListBox;
      ListBox3: TListBox;
      ListBox4: TListBox;
      ListBox5: TListBox;
      ListBox6: TListBox;
      ListBoxItem10: TListBoxItem;
      ListBoxItem11: TListBoxItem;
      ListBoxItem12: TListBoxItem;
      ListBoxItem13: TListBoxItem;
      ListBoxItem14: TListBoxItem;
      ListBoxItem15: TListBoxItem;
      ListBoxItem16: TListBoxItem;
      ListBoxItem17: TListBoxItem;
      ListBoxItem18: TListBoxItem;
      ListBoxItem1: TListBoxItem;
      ListBoxItem2: TListBoxItem;
      ListBoxItem3: TListBoxItem;
      ListBoxItem4: TListBoxItem;
      ListBoxItem5: TListBoxItem;
      ListBoxItem7: TListBoxItem;
      ListBoxItem8: TListBoxItem;
      ListBoxItem9: TListBoxItem;
      lstiOperacionais: TListBoxItem;
      lstiParamRelatPeriodoFinal: TListBoxItem;
      lstiParamRelatPeriodoFinal_: TListBoxItem;
      lstiParamRelatPeriodoInicial: TListBoxItem;
      lstiParamRelatPeriodoInicial_: TListBoxItem;
      lstiTotalSensores: TListBoxItem;
      lstiTrocarSenhaAtual: TListBoxItem;
      lstiTrocarSenhaAtual_: TListBoxItem;
      lstiTrocarSenhaNova: TListBoxItem;
      lstiTrocarSenhaNova_: TListBoxItem;
      lstParamRelatPeriodoFinal: TListBox;
      lstParamRelatPeriodoInicial: TListBox;
      lstTotalSensores: TListBox;
      lstTrocarSenha: TListBox;
      lvlSensorPorcentID: TLabel;
      lytAlinhamentConfig: TLayout;
      lytAlinhamentLinguagem: TLayout;
      lytBotoes: TLayout;
      lytBtnAdd: TLayout;
      lytClient: TLayout;
      lytCliente: TLayout;
      lytClienteLocalizacao: TLayout;
      lytContent: TLayout;
      lytContentClient: TLayout;
      lytContentLocalidade: TLayout;
      lytContentRelat: TLayout;
      lytContentSensor: TLayout;
      lytContentSilo: TLayout;
      lytContentUniarc: TLayout;
      lytDadosCliente: TLayout;
      lytGridCliente: TLayout;
      lytGridLocalidade: TLayout;
      lytGridUniarc: TLayout;
      lytInfoUniarc: TLayout;
      lytListRelat: TLayout;
      lytLocalidades: TLayout;
      lytLocaUniSilos: TLayout;
      lytMapaLigarUniarc: TLayout;
      lytNome: TLayout;
      lytParamRelatCliente: TLayout;
      lytParamRelatFornec: TLayout;
      lytParamRelatNumero: TLayout;
      lytParamRelatPeriodoFinal: TLayout;
      lytParamRelatPeriodoInicial: TLayout;
      lytParamRelatTransp: TLayout;
      lytSelect: TLayout;
      lytSelectCarga: TLayout;
      lytSelectCliente: TLayout;
      lytSelectIdioma: TLayout;
      lytSelectLocalidade: TLayout;
      lytSelectRelat: TLayout;
      lytSelectSensor: TLayout;
      lytSelectSilos: TLayout;
      lytSelectUniarc: TLayout;
      lytSendRelat: TLayout;
      lytSilos: TLayout;
      lytTopAlinhamento: TLayout;
      lytTopRelat: TLayout;
      lytTotalSensores: TLayout;
      lytTrocarSenha: TLayout;
      lytUniarcs: TLayout;
      NextTabAction1: TNextTabAction;
      Panel10: TPanel;
      Panel1: TPanel;
      Panel2: TPanel;
      Panel3: TPanel;
      Panel4: TPanel;
      Panel5: TPanel;
      pnlSelectCarga: TPanel;
      Panel8: TPanel;
      Panel9: TPanel;
      PreviousTabAction1: TPreviousTabAction;
      rctId: TRectangle;
      rctLux: TRectangle;
      rcTopA: TRectangle;
      rcTopo: TRectangle;
      rctTemperatura: TRectangle;
      rctTransmissao: TRectangle;
      rctUmidade: TRectangle;
      Rectangle10: TRectangle;
      Rectangle11: TRectangle;
      Rectangle12: TRectangle;
      Rectangle13: TRectangle;
      Rectangle14: TRectangle;
      Rectangle15: TRectangle;
      Rectangle16: TRectangle;
      Rectangle17: TRectangle;
      Rectangle18: TRectangle;
      Rectangle1: TRectangle;
      Rectangle21: TRectangle;
      Rectangle22: TRectangle;
      Rectangle23: TRectangle;
      Rectangle25: TRectangle;
      Rectangle26: TRectangle;
      Rectangle27: TRectangle;
      Rectangle29: TRectangle;
      Rectangle2: TRectangle;
      Rectangle30: TRectangle;
      Rectangle31: TRectangle;
      Rectangle32: TRectangle;
      Rectangle33: TRectangle;
      Rectangle34: TRectangle;
      Rectangle35: TRectangle;
      rectBgCenterCarga: TRectangle;
      Rectangle3: TRectangle;
      Rectangle40: TRectangle;
      Rectangle41: TRectangle;
      Rectangle42: TRectangle;
      Rectangle4: TRectangle;
      Rectangle5: TRectangle;
      Rectangle6: TRectangle;
      Rectangle7: TRectangle;
      Rectangle8: TRectangle;
      Rectangle9: TRectangle;
      rectListRelat: TRectangle;
      rectParamRelat: TRectangle;
      rectRelatEnviar: TRectangle;
      rtgAerador: TRectangle;
      StyleBook1: TStyleBook;
      tbClient: TTabControl;
      tbcRelat: TTabControl;
      tbiListRelat: TTabItem;
      tbiParamRelat: TTabItem;
      tbsCliente: TTabItem;
      tbsLocalidade: TTabItem;
      tbsSensor: TTabItem;
      tbsSilo: TTabItem;
      tbsUniarc: TTabItem;
      VertScrollBox1: TVertScrollBox;
      VertScrollBox2: TVertScrollBox;
      wwDataGrid1: TwwDataGrid;
      wwDataGrid4: TwwDataGrid;
      wwDataGrid4Atual: TwwGridColumn;
      wwDataGrid4Grao: TwwGridColumn;
      wwDataGrid4Inicial: TwwGridColumn;
      wwDataGrid4Livre: TwwGridColumn;
      wwDataGrid4Total: TwwGridColumn;
      wwDataGrid5: TwwDataGrid;
      wwDataGrid5Atual: TwwGridColumn;
      wwDataGrid5Grao: TwwGridColumn;
      wwDataGrid5Inicial: TwwGridColumn;
      wwDataGrid5Livre: TwwGridColumn;
      wwDataGrid5Total: TwwGridColumn;
      wwGridColumn1: TwwGridColumn;
      wwGridColumn2: TwwGridColumn;
      wwGridColumn3: TwwGridColumn;
      wwGridColumn4: TwwGridColumn;
      wwGridColumn5: TwwGridColumn;
      StyleBookCbb: TStyleBook;
      StyleBookDateEdit: TStyleBook;
      vrtContentRelat: TVertScrollBox;
      lytRelatClose: TLayout;
      rectRelatClose: TRectangle;
      btnRelatClose: TButton;
      lytUniarcSilos: TLayout;
      lstUniarcSilos: TListBox;
      lstiUniarcSilosUniarc: TListBoxItem;
      lblParamRelatUniarc: TLabel;
      lstiUniarcSilosSilos: TListBoxItem;
      cbbParamRelatUniarc: TComboBox;
      cbbParamRelatSilos: TComboBox;
      lblParamSilos: TLabel;
      lytParamRelat: TLayout;
      lstRelatEnviar: TListBox;
      lstiRelatEnviar: TListBoxItem;
      lstiRelatFechar: TListBoxItem;
      btnRelatEnviar: TButton;
      Label2: TLabel;
      lblCapacidade: TLabel;
      rectBgTitleCarga: TRectangle;
      lblTitleCarga: TLabel;
      lytParamCargaGrao: TLayout;
      lblParamCargaGrao: TLabel;
      cbbParamCargaGrao: TComboBox;
      vrtCenterCarga: TVertScrollBox;
      lytConfirmaCarga: TLayout;
      rectBgConfirmaCarga: TRectangle;
      lstConfirmaCarga: TListBox;
      lstiCancelaCarga: TListBoxItem;
      btnCargaCancela: TButton;
      lstiConfirmaCarga: TListBoxItem;
      btnCargaConfirma: TButton;
      lytParamCargaLocalidade: TLayout;
      lblParamCargaLocalidade: TLabel;
      cbbParamCargaLocalidade: TComboBox;
      lytParamCargaUniarcSilos: TLayout;
      lstParamCargaUniarcSilos: TListBox;
      lstiParamCargaUniarc: TListBoxItem;
      lblParamCargaUniarc: TLabel;
      cbbParamCargaUniarc: TComboBox;
      lstiParamCargaSilos: TListBoxItem;
      cbbParamCargaSilos: TComboBox;
      lblParamCargaSilos: TLabel;
      lytParamCargaOrigem: TLayout;
      lblParamCargaOrigem: TLabel;
      edtParamCargaOrigem: TEdit;
      lytParamCargaTransportador: TLayout;
      gplytParamCargaTransportador: TGridPanelLayout;
      edtParamCargaTransportador: TEdit;
      edtParamCargaTranspNumero: TEdit;
      lblParamCargaTransportador: TLabel;
      lblParamCargaTranspNumero: TLabel;
      lytParamCargaQtdeTonelada: TLayout;
      lblParamCargaQtdeTonelada: TLabel;
      edtParamCargaQtdeTonelada: TEdit;
      imgTitleCarga: TImage;
      lytNotConnected: TLayout;
      rectNotConnected: TRectangle;
      lblNotConnected: TLabel;
      Label13: TLabel;
      lblCapacidade2: TLabel;
      Layout6: TLayout;
      Layout47: TLayout;
      lblUniarcNome: TLabel;
      Layout54: TLayout;
      Layout55: TLayout;
      Label50: TLabel;
      lblUniarcs3: TLabel;
      Layout56: TLayout;
      Label52: TLabel;
      Label54: TLabel;
      lblSilos3: TLabel;
      lblToneladas3: TLabel;
      Label62: TLabel;
      lblCapacidade3: TLabel;
      lblSiloConservacao: TLabel;
      shdSiloConservacao: TShadowEffect;
      lytSobre: TLayout;
      Panel6: TPanel;
      Layout53: TLayout;
      Layout57: TLayout;
      Rectangle19: TRectangle;
      ListBox7: TListBox;
      ListBoxItem6: TListBoxItem;
      ListBoxItem21: TListBoxItem;
      Layout75: TLayout;
      Rectangle20: TRectangle;
      btnSobreFechar: TButton;
      Layout118: TLayout;
      Image20: TImage;
      Rectangle24: TRectangle;
      Label27: TLabel;
      lstbiSobreVersao: TListBoxItem;
      fgActivityDialogMobile: TfgActivityDialog;
      tbiHistMovtoSilo: TTabItem;
      lytHistMovtoSilo: TLayout;
      rectBgHistMovtoSilo: TRectangle;
      lblTitleHistMovtoSilo: TLabel;
      lytContentHistMovtoSilo: TLayout;
      grdHistMovtoSilo: TwwDataGrid;
      grdHistMovtoSiloCollumns: TwwDataGrid;
      grdHistMovtoSiloCollumnsnmGrao: TwwGridColumn;
      grdHistMovtoSiloCollumnsdthrmovto: TwwGridColumn;
      grdHistMovtoSiloCollumnsqtdeinformada: TwwGridColumn;
      grdHistMovtoSiloCollumnstp_movimento: TwwGridColumn;
      grdHistMovtoSilonmGrao: TwwGridColumn;
      grdHistMovtoSilodthrmovto: TwwGridColumn;
      grdHistMovtoSiloqtdeinformada: TwwGridColumn;
      grdHistMovtoSilotp_movimento: TwwGridColumn;
      grdSilos1dscVlCalcIdeal: TwwGridColumn;
      grdSilos1DscVlCalcAtual: TwwGridColumn;
      grdSilos1DSCTPSENSOR: TwwGridColumn;
      lytSelectSilosGrafico: TLayout;
      Panel7: TPanel;
      lytContentSilosGrafico: TLayout;
      Layout123: TLayout;
      Rectangle38: TRectangle;
      lytSilosGraficoBotao: TLayout;
      rectSilosGraficoFechar: TRectangle;
      btnSelectSilosGraficoFechar: TButton;
      Layout125: TLayout;
      Image23: TImage;
      tbcGraficoFiltro: TTabControl;
      tbiFiltro: TTabItem;
      lytFiltroGrid: TLayout;
      Layout13: TLayout;
      Layout222: TLayout;
      Layout3223: TLayout;
      Label100: TLabel;
      edtParamGraficoDtInicial: TDateEdit;
      Layout422: TLayout;
      Layout532: TLayout;
      Label287: TLabel;
      edtParamGraficoDtFinal: TDateEdit;
      Layout722: TLayout;
      Label388: TLabel;
      Layout119: TLayout;
      Layout120: TLayout;
      Layout121: TLayout;
      Label30: TLabel;
      cbbParamGraficoAnalise: TComboBox;
      Layout146: TLayout;
      Layout147: TLayout;
      Label51: TLabel;
      cbbParamGraficoTipo: TComboBox;
      lytGraficoFiltroTitulo: TLayout;
      lblGraficoFiltroTitulo: TLabel;
      tbiGrafico: TTabItem;
      lytGrafico: TLayout;
      chtSensoresSilos: TChart;
      lytGraficoGraficoTitulo: TLayout;
      lblGraficoGraficoTitulo: TLabel;
      mmoDebugCliente: TMemo;
      mmoDebugLocalidade: TMemo;
      mmoDebugUniarc: TMemo;
      mmoDebugSilos: TMemo;
      mmoDebugSensores: TMemo;
      btnSelectSilosGraficoGerar: TButton;
      grdlytSilosGraficoBotao: TGridPanelLayout;
      rectSelectSilosGraficoGerar: TRectangle;
      vrtsGraficoFiltro: TVertScrollBox;
      vrtsGraficoGrafico: TVertScrollBox;
      btnSelectSilosGraficoVoltar: TButton;
      procedure btnIdiomaClick(Sender: TObject);
      procedure btnSensorCargaClick(Sender: TObject);
      procedure btnSiloGraficoClick(Sender: TObject);
      procedure Button10Click(Sender: TObject);
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure Button3Click(Sender: TObject);
      procedure Button4Click(Sender: TObject);
      procedure Button5Click(Sender: TObject);
      procedure Button6Click(Sender: TObject);
      procedure btnFecharCargaClick(Sender: TObject);
      procedure btnSelectSilosGraficoFecharClick(Sender: TObject);
      procedure edtTrocarSenhaAtualTyping(Sender: TObject);
      procedure edtTrocarSenhaNovaTyping(Sender: TObject);
      procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
      procedure edtParamRelatEmailDestTyping(Sender: TObject);
      procedure FormFocusChanged(Sender: TObject);
      procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const[Ref]
Bounds: TRect);
      procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const[Ref]
Bounds: TRect);
      procedure btnCargaCancelaClick(Sender: TObject);
      procedure btnClienteCargaMouseEnter(Sender: TObject);
      procedure btnClienteCargaMouseLeave(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure btnSobreFecharClick(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure cbbParamCargaLocalidadeChange(Sender: TObject);
      procedure btnSelectSilosGraficoGerarClick(Sender: TObject);
      procedure btnSelectSilosGraficoVoltarClick(Sender: TObject);
      procedure cbbParamGraficoAnaliseChange(Sender: TObject);
      procedure grdSilos1RowChanged(Sender: TwwDataGrid);
      procedure grdClienteRowChanged(Sender: TwwDataGrid);
      procedure wwDataGrid1RowChanged(Sender: TwwDataGrid);
      procedure grdLocalidadeRowChanged(Sender: TwwDataGrid);
      procedure wwDataGrid4RowChanged(Sender: TwwDataGrid);
      procedure grdUniarcRowChanged(Sender: TwwDataGrid);
      procedure wwDataGrid5RowChanged(Sender: TwwDataGrid);
      procedure grdSilos2RowChanged(Sender: TwwDataGrid);
   private
      FfgxLoadingStatus: Boolean;
      FKBBounds: TRectF;
      FNeedOffset: Boolean;
      procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
      procedure RestorePosition;
      procedure UpdateKBBounds;
      procedure ComboBoxGraficoStyle;
   public
      procedure wwDataGridAutoFit(AGrid: TwwDataGrid);
   end;

var
   frmMobile: TfrmMobile;


implementation

{$R *.fmx}

procedure TfrmMobile.wwDataGrid1RowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.wwDataGrid4RowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.wwDataGrid5RowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.wwDataGridAutoFit(AGrid: TwwDataGrid);
var
   i: Integer;
   iCol: Integer;
   iWidth: Integer;
   iColWidth: Integer;
   iColMiddle: Integer;
begin
   {$REGION 'Grade do Uniarc'}
   AGrid.KeyOptions := [];
   AGrid.DisableMouseWheel := False;
   AGrid.DisableFocusEffect := False;
   AGrid.TabStop := False;

   AGrid.BeginUpdate;
   AGrid.BeginLayout;
   iCol := AGrid.ColumnCount;
   iColMiddle := iCol div 2;
   iWidth := Trunc(AGrid.Width + AGrid.IndicatorWidth);
   iColWidth := (iWidth div iCol) - 2;

   for i := 0 to (iCol - 1) do
   begin
      AGrid.Columns.Items[i].Width := iColWidth;
      AGrid.Columns.Items[i].readonly := False;
      AGrid.Columns.Items[i].TabStop := False;
   end;
   AGrid.RefreshGrid;
   AGrid.EndLayout(True);
   AGrid.EndUpdate;
   {$ENDREGION}
end;

procedure TfrmMobile.ComboBoxGraficoStyle;
var
   i: Integer;
begin
   {$IF DEFINED(ANDROID)}
   for i := 0 to cbbParamGraficoAnalise.Items.Count - 1 do
   begin
      cbbParamGraficoAnalise.ListBox.ListItems[i].TextSettings.FontColor := 4289903039;
      // TAlphaColorRec.White;
      cbbParamGraficoAnalise.ListBox.ListItems[i].StyledSettings := cbbParamGraficoAnalise.ListBox.ListItems[0].StyledSettings - [TStyledSetting.ssFontColor];
   end;
   //cbbParamGraficoAnalise.ItemIndex := -1;
   for i := 0 to cbbParamGraficoTipo.Items.Count - 1 do
   begin
      cbbParamGraficoTipo.ListBox.ListItems[i].TextSettings.FontColor := 4289903039;
      // TAlphaColorRec.White;
      cbbParamGraficoTipo.ListBox.ListItems[i].StyledSettings := cbbParamGraficoTipo.ListBox.ListItems[0].StyledSettings - [TStyledSetting.ssFontColor];
   end;
   //cbbParamGraficoTipo.ItemIndex := -1;
   edtParamGraficoDtInicial.TextSettings.FontColor := 4289903039;
   // TAlphaColorRec.White;
   edtParamGraficoDtInicial.StyledSettings := edtParamGraficoDtInicial.StyledSettings - [TStyledSetting.ssFontColor];
   edtParamGraficoDtFinal.TextSettings.FontColor := 4289903039;
   // TAlphaColorRec.White;
   edtParamGraficoDtFinal.StyledSettings := edtParamGraficoDtFinal.StyledSettings - [TStyledSetting.ssFontColor];
   {$ENDIF}
   //

   {$IF DEFINED(iOS)}
   edtParamGraficoDtInicial.TextSettings.FontColor := TAlphaColorRec.Black;
   edtParamGraficoDtInicial.StyledSettings := edtParamGraficoDtInicial.StyledSettings - [TStyledSetting.ssFontColor];

   edtParamGraficoDtFinal.TextSettings.FontColor := TAlphaColorRec.Black;
   edtParamGraficoDtFinal.StyledSettings := edtParamGraficoDtFinal.StyledSettings - [TStyledSetting.ssFontColor];
   {$ENDIF}
   //

end;


procedure TfrmMobile.RestorePosition;
begin
   vrtContentRelat.ViewportPosition := PointF(vrtContentRelat.ViewportPosition.x, 0);

   lytSelectRelat.Align := TAlignLayout.Client;
   vrtContentRelat.RealignContent;

   with vrtCenterCarga, lytCenterCarga do
   begin
      ViewportPosition := PointF(ViewportPosition.x, 0);
      Align := TAlignLayout.Client;
      RealignContent;
   end;
end;


procedure TfrmMobile.UpdateKBBounds;
var
   LFocused: TControl;
   LFocusRect: TRectF;
begin
   FNeedOffset := False;
   if Assigned(Focused) then
   begin
      LFocused := TControl(Focused.GetObject);
      LFocusRect := LFocused.AbsoluteRect;
      LFocusRect.Offset(vrtContentRelat.ViewportPosition);
      if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
      begin
         FNeedOffset := True;
         lytSelectRelat.Align := TAlignLayout.Horizontal;
         vrtContentRelat.RealignContent;
         Application.ProcessMessages;
         vrtContentRelat.ViewportPosition := PointF(vrtContentRelat.ViewportPosition.x, LFocusRect.Bottom - FKBBounds.Top);
      end;

      with vrtCenterCarga, lytCenterCarga do
      begin
         LFocused := TControl(Focused.GetObject);
         LFocusRect := LFocused.AbsoluteRect;
         LFocusRect.Offset(ViewportPosition);
         if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
         begin
            FNeedOffset := True;
            Align := TAlignLayout.Horizontal;
            RealignContent;
            Application.ProcessMessages;
            ViewportPosition := PointF(ViewportPosition.x, LFocusRect.Bottom - FKBBounds.Top);
         end;
      end;
   end;
   if not FNeedOffset then
      RestorePosition;
end;

procedure TfrmMobile.btnCargaCancelaClick(Sender: TObject);
begin
   lytSelectCarga.Visible := False;
end;

procedure TfrmMobile.btnClienteCargaMouseEnter(Sender: TObject);
begin
   TButton(Sender).AnimateFloat('Opacity', 0.4);
end;

procedure TfrmMobile.btnClienteCargaMouseLeave(Sender: TObject);
begin
   TButton(Sender).AnimateFloat('Opacity', 1);
end;

procedure TfrmMobile.btnIdiomaClick(Sender: TObject);
begin
   fgActivityDialogMobile.Message := 'Carregando Idiomas!';
   fgActivityDialogMobile.Show;
   try
      lytSelectIdioma.Visible := True;
      lytSelectIdioma.Opacity := 1; // 0.9;
   finally
      fgActivityDialogMobile.Hide;
   end;
end;

procedure TfrmMobile.btnSensorCargaClick(Sender: TObject);
begin
   lytSelectCarga.Visible := True;
end;

procedure TfrmMobile.btnSiloGraficoClick(Sender: TObject);
begin
   cbbParamGraficoAnalise.Clear;
   cbbParamGraficoAnalise.Items.Add('Temperatura');
   cbbParamGraficoAnalise.Items.Add('Umidade');
   cbbParamGraficoAnalise.Items.Add('Temperatura x Umidade');

   cbbParamGraficoTipo.Clear;
   cbbParamGraficoTipo.Items.Add('Linha');
   cbbParamGraficoTipo.Items.Add('Barra');
   cbbParamGraficoTipo.Items.Add('Area');

   {$IFDEF MSWINDOWS}
   cbbParamGraficoAnalise.ItemIndex := 0;
   cbbParamGraficoTipo.ItemIndex := 0;
   edtParamGraficoDtInicial.Date := IncMonth(Now, -12);
   edtParamGraficoDtFinal.Date := IncMonth(Now, 12);

   {$ENDIF}
   //
   ComboBoxGraficoStyle;

   cbbParamGraficoAnalise.ItemIndex := -1;
   cbbParamGraficoTipo.ItemIndex := -1;

   tbcGraficoFiltro.ActiveTab := tbiFiltro;
   lytSelectSilosGrafico.Visible := True;
end;

procedure TfrmMobile.btnSobreFecharClick(Sender: TObject);
begin
   lytSobre.Visible := False;
   lytSobre.Opacity := 1;
end;

procedure TfrmMobile.Button10Click(Sender: TObject);
begin
   lytSelectIdioma.Visible := False;
   lytSelectIdioma.Opacity := 1;
end;

procedure TfrmMobile.Button1Click(Sender: TObject);
begin
   lytSelectLocalidade.Visible := False;
   lytSelectLocalidade.Opacity := 1;

end;

procedure TfrmMobile.Button2Click(Sender: TObject);
begin
   fgActivityDialogMobile.Message := 'Carregando Clientes!';
   fgActivityDialogMobile.Show;
   try
      lytSelectCliente.Visible := True;
      lytSelectCliente.Opacity := 0.9;
    finally
      fgActivityDialogMobile.Hide;
   end;
end;

procedure TfrmMobile.Button3Click(Sender: TObject);
begin
   lytSelectCliente.Visible := False;
   lytSelectCliente.Opacity := 1;
   tbClient.Opacity := 1;
end;

procedure TfrmMobile.Button4Click(Sender: TObject);
begin
   lytSelectUniarc.Visible := False;
   lytSelectUniarc.Opacity := 1;
end;

procedure TfrmMobile.Button5Click(Sender: TObject);
begin
   lytSelectSilos.Visible := False;
   lytSelectSilos.Opacity := 1;
end;

procedure TfrmMobile.Button6Click(Sender: TObject);
begin
   lytSelectSensor.Visible := False;
   lytSelectSensor.Opacity := 1;
end;

procedure TfrmMobile.btnFecharCargaClick(Sender: TObject);
begin
   lytSelectCarga.Visible := False;
   lytSelectCarga.Opacity := 1;
end;

procedure TfrmMobile.btnSelectSilosGraficoFecharClick(Sender: TObject);
begin
   lytSelectSilosGrafico.Visible := False;
   lytSelectSilosGrafico.Opacity := 1;
end;

procedure TfrmMobile.btnSelectSilosGraficoGerarClick(Sender: TObject);

   procedure RemoveSeries(AChart: TChart);
   var
      MySeries: TChartSeries;
   begin
      with AChart do
         while SeriesList.Count > 0 do
         begin
            MySeries := Series[0];
            RemoveSeries(Series[0]);
            MySeries.Free;
         end;
   end;

   procedure gerarGraficoTemperatura;

   begin
    end;

   procedure gerarGraficoUmidade;
   begin
   end;

begin

end;

procedure TfrmMobile.btnSelectSilosGraficoVoltarClick(Sender: TObject);
begin
   tbcGraficoFiltro.ActiveTab := tbiFiltro;
end;

procedure TfrmMobile.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
   if FNeedOffset and (FKBBounds.Top > 0) then
   begin
      ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
   end;
end;

procedure TfrmMobile.cbbParamCargaLocalidadeChange(Sender: TObject);
begin
   if (cbbParamCargaLocalidade.ItemIndex >= 0) then
   begin
      cbbParamCargaGrao.Items.Clear;
      cbbParamCargaUniarc.Items.Clear;
      cbbParamCargaSilos.Items.Clear;

   end;
end;

procedure TfrmMobile.cbbParamGraficoAnaliseChange(Sender: TObject);
begin
   cbbParamGraficoTipo.Clear;

   if (cbbParamGraficoAnalise.ItemIndex = 2) then
   begin
      cbbParamGraficoTipo.Items.Add('Linha');
   end
   else
   begin
      cbbParamGraficoTipo.Items.Add('Linha');
      cbbParamGraficoTipo.Items.Add('Barra');
      cbbParamGraficoTipo.Items.Add('Area');
   end;

   ComboBoxGraficoStyle;

   cbbParamGraficoTipo.ItemIndex := -1;
end;

procedure TfrmMobile.edtParamRelatEmailDestTyping(Sender: TObject);
begin
   TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text);

   if (Length(TEdit(Sender).Text) > TEdit(Sender).MaxLength) then
      TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text).Substring(0, TEdit(Sender).MaxLength);
end;

procedure TfrmMobile.edtTrocarSenhaAtualTyping(Sender: TObject);
begin
   TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text);

   if (Length(TEdit(Sender).Text) > TEdit(Sender).MaxLength) then
      TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text).Substring(0, TEdit(Sender).MaxLength);
end;

procedure TfrmMobile.edtTrocarSenhaNovaTyping(Sender: TObject);
begin
   TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text);

   if (Length(TEdit(Sender).Text) > TEdit(Sender).MaxLength) then
      TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text).Substring(0, TEdit(Sender).MaxLength);
end;

procedure TfrmMobile.FormCreate(Sender: TObject);
begin
   {$IFDEF MSWINDOWS}
   Self.Top := 8;
   Self.Left := 8;
   Self.Height := 640;
   Self.Width := 360;
   Self.ClientHeight := Self.Height;
   Self.ClientWidth := Self.Width;
   {$ENDIF}
   //
   mmoDebugCliente.Lines.Clear;
   mmoDebugLocalidade.Lines.Clear;
   mmoDebugUniarc.Lines.Clear;
   mmoDebugSilos.Lines.Clear;
   mmoDebugSensores.Lines.Clear;
   //
   {$IFDEF DEBUG}
   mmoDebugCliente.Visible := True;

   mmoDebugLocalidade.Visible := True;
   grdLocalidade.Height := 100;

   mmoDebugUniarc.Visible := True;
   grdUniarc.Height := 100;

   mmoDebugSilos.Visible := True;
   grdSilos2.Visible := False;

   mmoDebugSensores.Visible := True;
   rctTransmissao.Visible := False;
   {$ELSE}
   mmoDebugCliente.Visible := False;

   mmoDebugLocalidade.Visible := False;
   grdLocalidade.Height := 160;

   mmoDebugUniarc.Visible := False;
   grdUniarc.Height := 160;

   mmoDebugSilos.Visible := False;
   grdSilos2.Visible := True;

   mmoDebugSensores.Visible := False;
   rctTransmissao.Visible := True;
   {$ENDIF}
end;

procedure TfrmMobile.FormFocusChanged(Sender: TObject);
begin
   UpdateKBBounds;
end;

procedure TfrmMobile.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
   if (Key = vkHardwareBack) then
   begin
      Key := 0;

      if tbClient.ActiveTab = tbsCliente then
         Key := 0;

      if tbClient.ActiveTab = tbsLocalidade then
         tbClient.ActiveTab := tbsCliente;

      if tbClient.ActiveTab = tbsUniarc then
         tbClient.ActiveTab := tbsLocalidade;

      if tbClient.ActiveTab = tbsSilo then
         tbClient.ActiveTab := tbsUniarc;

      if tbClient.ActiveTab = tbsSensor then
         tbClient.ActiveTab := tbsSilo;

      if (lytSelectRelat.Visible) then
      begin
         lytSelectRelat.Visible := False;
         lytSelectRelat.Opacity := 1;
      end;
   end;
end;

procedure TfrmMobile.FormShow(Sender: TObject);
var
   i: Integer;
   b: Boolean;
   myThread: TThread;
begin
   vrtContentRelat.OnCalcContentBounds := CalcContentBoundsProc;
   vrtCenterCarga.OnCalcContentBounds := CalcContentBoundsProc;

   {$IFDEF MSWINDOWS}
   Self.Top := 8;
   Self.Left := 8;
    {$ENDIF}
   lytSelectIdioma.Visible := False;
   lytSelectCliente.Visible := False;
   lytSelectLocalidade.Visible := False;
   lytSelectUniarc.Visible := False;
   lytSelectSilos.Visible := False;
   lytSelectSensor.Visible := False;
   lytSelectRelat.Visible := False;
   lytSelectCarga.Visible := False;
   lytSelectSilosGrafico.Visible := False;
   lytSobre.Visible := False;

   Self.fgActivityDialogMobile.Message := 'Carregando!';
   Self.fgActivityDialogMobile.Show;

   try
      {$IF DEFINED(ANDROID)}
      for i := 0 to cbxUmidade.Items.Count - 1 do
      begin
         cbxUmidade.ListBox.ListItems[i].TextSettings.FontColor := $FFB2B9BF;
         cbxUmidade.ListBox.ListItems[i].StyledSettings := cbxUmidade.ListBox.ListItems[0].StyledSettings - [TStyledSetting.ssFontColor];
      end;
      {$ENDIF}
      //
        finally
      Self.fgActivityDialogMobile.Hide;
   end;
end;

procedure TfrmMobile.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const[Ref]
Bounds: TRect);
begin
   FKBBounds.Create(0, 0, 0, 0);
   FNeedOffset := False;
   RestorePosition;
end;

procedure TfrmMobile.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const[Ref]
Bounds: TRect);
begin
   FKBBounds := TRectF.Create(Bounds);
   FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
   FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
   UpdateKBBounds;
end;

procedure TfrmMobile.grdClienteRowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.grdLocalidadeRowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.grdSilos1RowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.grdSilos2RowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;

procedure TfrmMobile.grdUniarcRowChanged(Sender: TwwDataGrid);
begin
   wwDataGridAutoFit(TwwDataGrid(Sender));
end;



end.

