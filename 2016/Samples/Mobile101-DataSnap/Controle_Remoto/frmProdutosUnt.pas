unit frmProdutosUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.StdCtrls, FMX.ListBox, FMX.TabControl, FMX.Layouts, Data.DB,
  Datasnap.DBClient, System.Actions, FMX.ActnList,
  FMX.Platform, FMX.Controls.Presentation;

type
  TfrmProdutos = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    ToolBar1: TToolBar;
    ComboBoxBuscarProdutos: TComboBox;
    btnBuscarProduto: TButton;
    edtBuscarProduto: TEdit;
    imgBuscarProduto: TImage;
    ListBox1: TListBox;
    cdsBuscarProdutos: TClientDataSet;
    ListBoxDetalhes: TListBox;
    tmrEAN: TTimer;
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure ComboBoxBuscarProdutosChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure tmrEANTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    ClipService: IFMXClipboardService;
    Elapsed: integer;

  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.fmx}

uses ClientModuleDistrimedUnt, DBXCommon, DBXCDSReaders,
  Androidapi.NativeActivity,
  Androidapi.Helpers,
  Androidapi.Jni.GraphicsContentViewText;


procedure TfrmProdutos.btnBuscarProdutoClick(Sender: TObject);
var
  ReaderProdutos : TDBXReader;
  i: integer;
  Linha : string;
  lbItem : TListBoxItem;
begin
  try

    ListBox1.Clear;
    ReaderProdutos := ClientModuleDistrimed.DSServerModuleEstoqueClient.GetProdutos(
                                ComboBoxBuscarProdutos.ItemIndex, edtBuscarProduto.Text);
    TDBXClientDataSetReader.CopyReaderToClientDataSet(ReaderProdutos, cdsBuscarProdutos);
    ReaderProdutos.Free;

    cdsBuscarProdutos.Open;
    cdsBuscarProdutos.First;
    ListBox1.BeginUpdate;
    for I := 0 to cdsBuscarProdutos.RecordCount -1 do
    begin
      Linha := '%s - %s';
      lbItem := TListBoxItem.Create(ListBox1);
      lbItem.StyleLookup := 'listboxitembottomdetail';
      lbItem.StyledSettings := [TStyledSetting.ssFontColor];
      // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
      lbItem.ItemData.Accessory := TListBoxItemData.TAccessory(1);

//      if Odd(cdsBuscarProdutos.RecNo) then
//        begin
//          lbItem.WordWrap:=True;
//          lbItem.Font.Size:= 8;
//          lbItem.Height := 120;
//          lbItem.TextSettings.FontColor := TAlphaColorRec.Blue;
//        end
//      else
//        begin
//
//        end;
      lbItem.TextSettings.FontColor := TAlphaColorRec.Blue;
      lbItem.ItemData.Text      := Format(Linha, [cdsBuscarProdutos.Fields[1].AsString, cdsBuscarProdutos.Fields[2].AsString]);
      lbItem.ItemData.Detail    := cdsBuscarProdutos.Fields[3].AsString;
      ListBox1.AddObject(lbItem);
      cdsBuscarProdutos.Next;
    end;
    ListBox1.EndUpdate;
    TabControl1.ActiveTab := TabItem2;
  except on E: Exception do
    ShowMessage('Erro:' + E.Message );
  end;
end;

procedure TfrmProdutos.ComboBoxBuscarProdutosChange(Sender: TObject);
var
 Intent : JIntent;

begin
  ClipService.SetClipboard('nil');
  edtBuscarProduto.Text := EmptyStr;
  case ComboBoxBuscarProdutos.ItemIndex of
    0: begin
        edtBuscarProduto.KeyboardType := TVirtualKeyboardType.vktNumberPad;
    end;
    1: begin
        edtBuscarProduto.KeyboardType := TVirtualKeyboardType.vktAlphabet;
    end;
    2: begin
        edtBuscarProduto.KeyboardType := TVirtualKeyboardType.vktNumberPad;
//        ShowMessage('Chamar busca pela leitura de CODIGO DE BARRAS');
        if assigned(ClipService) then
          begin
            clipservice.SetClipboard('nil');
            Intent := TJIntent.Create;
            Intent.setAction(StringToJString('com.google.zxing.client.android.SCAN'));
            TAndroidHelper.Activity.startActivityForResult(Intent, 0);
//            SharedActivity.startActivityForResult(Intent,0);
            Elapsed := 0;
            tmrEAN.Enabled := True;
          end;
    end;

  end;
end;

procedure TfrmProdutos.FormActivate(Sender: TObject);
begin
  ClipService.SetClipboard('nil');
  TabControl1.ActiveTab := TabItem1;
  ComboBoxBuscarProdutos.ItemIndex := 1;


end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
    if not TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(ClipService)) then
      begin
        ClipService := nil;
      end;
    Elapsed := 0;
end;

procedure TfrmProdutos.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
    begin
      btnBuscarProdutoClick(Application);
    end;
end;

procedure TfrmProdutos.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  lbItemDetalhe : TListBoxItem;
  I: Integer;
begin
  ListBoxDetalhes.Clear;
  ListBoxDetalhes.BeginUpdate;
  cdsBuscarProdutos.RecNo :=  ListBox1.ItemIndex +1;
  for I := 0 to cdsBuscarProdutos.FieldCount -1 do
  begin
      lbItemDetalhe := TListBoxItem.Create(ListBoxDetalhes);
      lbItemDetalhe.StyleLookup := 'listboxitembottomdetail';
      // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
      lbItemDetalhe.ItemData.Accessory := TListBoxItemData.TAccessory(2);
      lbItemDetalhe.TextSettings.FontColor := TAlphaColorRec.Blue;
      lbItemDetalhe.ItemData.Text      := cdsBuscarProdutos.Fields[i].asString;
      lbItemDetalhe.ItemData.Detail    := cdsBuscarProdutos.Fields[i].FieldName;
      ListBoxDetalhes.AddObject(lbItemDetalhe);
  end;
  ListBoxDetalhes.EndUpdate;

  TabControl1.ActiveTab := TabItem3;


end;

procedure TfrmProdutos.tmrEANTimer(Sender: TObject);

begin
  if (ClipService.GetClipboard.ToString <> 'nil') then
  begin
    tmrEAN.Enabled := false;
    Elapsed := 0;
    edtBuscarProduto.PasteFromClipboard;

  end
  else
    begin
      if Elapsed > 9 then
        begin
          tmrEAN.Enabled := false;
          Elapsed := 0;
        end
      else
          Elapsed := Elapsed +1;
    end;
end;

end.
