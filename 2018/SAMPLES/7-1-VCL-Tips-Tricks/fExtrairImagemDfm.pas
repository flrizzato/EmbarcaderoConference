unit fExtrairImagemDfm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, System.IOUtils,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Buttons, System.Types,
  Vcl.Samples.Gauges, uExtratorImagemDfm;

type
  TfrmExtrairImagemDfm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    edtDirDfm: TEdit;
    edtIconesOriginais: TEdit;
    edtIconesNovos: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    memArquivos: TMemo;
    Panel4: TPanel;
    btnListarArquivosDFM: TBitBtn;
    btnExtrairImagens: TBitBtn;
    btnEliminarDuplicados: TButton;
    GroupBox1: TGroupBox;
    cbxButtons: TCheckBox;
    cbxImages: TCheckBox;
    cbxImageList: TCheckBox;
    tbsFerramentas: TTabSheet;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Label2: TLabel;
    edtImagemNova: TEdit;
    Button4: TButton;
    memArquivosBmp: TMemo;
    image: TPanel;
    Shape8: TShape;
    Shape7: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Shape2: TShape;
    Shape1: TShape;
    imgBase: TImage;
    imgSubstituto: TImage;
    imgNova: TImage;
    imgOriginal: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Shape5: TShape;
    imgAtualDfm: TImage;
    Label11: TLabel;
    Shape6: TShape;
    imgDfmNovo: TImage;
    SpeedButton1: TSpeedButton;
    Label15: TLabel;
    imgPressionado: TImage;
    Label16: TLabel;
    Shape9: TShape;
    ImgDown: TImage;
    Label18: TLabel;
    btnCarregarImagem: TButton;
    btnLocalizarIcones: TButton;
    Button6: TButton;
    btnSalvaComoNovaImg: TButton;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    cbxAtualizarDfm: TCheckBox;
    btnSalvarNovaImg: TButton;
    Button1: TButton;
    Button2: TButton;
    Panel8: TPanel;
    Label12: TLabel;
    memImagem: TMemo;
    TabSheet2: TTabSheet;
    Splitter1: TSplitter;
    trvImagens: TTreeView;
    Panel5: TPanel;
    Label14: TLabel;
    ScrollBox1: TScrollBox;
    imgAmostra: TImage;
    Panel6: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnIdentificarImagens: TButton;
    btnExpNaoLoc: TButton;
    btnSubstituirImgSel: TButton;
    btnSubstituirTodasImg: TButton;
    btnListarImagensNovas: TButton;
    btnIdentificarImagemSel: TButton;
    btnAddImagemAvulsa: TButton;
    btnSalvarListagem: TButton;
    btnCarregarListagem: TButton;
    Panel7: TPanel;
    btnZoomMenos: TButton;
    btnZoomMais: TButton;
    clbClasses: TCheckListBox;
    Gauge1: TGauge;
    Gauge2: TGauge;
    procedure btnListarArquivosDFMClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExtrairImagensClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtrairImagemDfm: TfrmExtrairImagemDfm;

implementation

{$R *.dfm}

procedure TfrmExtrairImagemDfm.btnExtrairImagensClick(Sender: TObject);
var
  lComponenteUnit: TComponenteUnit;
  lSaveDir: String;
  li: integer;
begin
  lSaveDir := edtIconesOriginais.Text;
  Gauge1.Progress := 0;
  Gauge1.MaxValue := memArquivos.Lines.Count;
  for li := 0 to memArquivos.Lines.Count - 1 do
  begin
    Gauge1.Progress := li + 1;
    Application.ProcessMessages;

    if cbxImageList.Checked then
    begin
      for lComponenteUnit in TIdentificadorImagem.IdentificarImageList(memArquivos.Lines[li]) do
      begin
        TExtratorImagem.ExtrairImagemDoImageList(lComponenteUnit,lSaveDir);
      end;
    end;

    if cbxButtons.Checked then
    begin
      for lComponenteUnit in TIdentificadorImagem.IdentificarBotoesComImagem(memArquivos.Lines[li]) do
      begin
        TExtratorImagem.ExtrairImagemDoBotao(lComponenteUnit,lSaveDir);
      end;
    end;

    if cbxImages.Checked then
    begin
      for lComponenteUnit in TIdentificadorImagem.IdentificarBotoesComImagem(memArquivos.Lines[li]) do
      begin
        TExtratorImagem.ExtrairImagemDoImage(lComponenteUnit,lSaveDir);
      end;
    end;
  end;

  MessageDlg('Operação concluída.',mtConfirmation, [mbOK], 0);
end;

procedure TfrmExtrairImagemDfm.btnListarArquivosDFMClick(Sender: TObject);
var
  lArquivos : TStringDynArray;
  lFile: string;
begin
  lArquivos := TDirectory.GetFiles(edtDirDfm.Text,'*.dfm', TSearchOption.soAllDirectories);
  for lFile in lArquivos do
  begin
    if TFileAttribute.faArchive in TFile.GetAttributes(lFile) then
      memArquivos.Lines.Add(lFile);
  end;
end;

procedure TfrmExtrairImagemDfm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
