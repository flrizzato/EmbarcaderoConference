unit frmVendedoresUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  frmMoldeTelasUnt, Data.DB, Datasnap.DBClient, FMX.Objects, FMX.Edit,
  FMX.ListBox, FMX.TabControl, FMX.Layouts, FMX.Gestures,
  FMX.Controls.Presentation;

type
  TfrmVendedores = class(TfrmMoldeTelas)
    TabItem2: TTabItem;
    ListBox1: TListBox;
    TabItem3: TTabItem;
    ListBoxDetalhes: TListBox;
    procedure btnBuscarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure edtBuscarKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ListBox1ItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ListBox1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure ListBoxDetalhesItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendedores: TfrmVendedores;

implementation

{$R *.fmx}
uses Androidapi.Helpers,
  ClientModuleDistrimedUnt, DBXCommon, DBXCDSReaders,
 IdURI, FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText, Androidapi.Jni.Net, Androidapi.Jni.JavaTypes,
  Androidapi.JNIBridge;

procedure TfrmVendedores.btnBuscarClick(Sender: TObject);
var
  Reader :  TDBXReader;
  i : integer;
  lbItem : TListBoxItem;
  Linha : string;

begin
  inherited;
  try
    ListBox1.Clear;
    Reader := ClientModuleDistrimed.DSServerModuleEstoqueClient.GetVendedores(ComboBox1.ItemIndex,
                    edtBuscar.Text);
    TDBXClientDataSetReader.CopyReaderToClientDataSet(Reader, ClientDataSet1);
    Reader.Free;
    ClientDataSet1.Open;
    ClientDataSet1.First;
    if ClientDataSet1.RecordCount <= 0 then
    begin
      TabItem3.Enabled := False;
      TabItem2.Enabled := False;
    end
    else
    begin
      TabItem3.Enabled := True;
      TabItem2.Enabled := True;

      ListBox1.BeginUpdate;
      for i := 0 to ClientDataSet1.RecordCount -1 do
      begin
        Linha := '%s - %s';
        lbItem := TListBoxItem.Create(ListBox1);
        lbItem.StyleLookup := 'listboxitembottomdetail';
        lbItem.StyledSettings := [TStyledSetting.ssFontColor];
        // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
        lbItem.ItemData.Accessory := TListBoxItemData.TAccessory(1);
        lbItem.ItemData.Text      := Format(Linha, [ClientDataSet1.Fields[1].AsString, ClientDataSet1.Fields[2].AsString]);
        lbItem.ItemData.Detail    := ClientDataSet1.Fields[4].AsString;
        ListBox1.AddObject(lbItem);
        ClientDataSet1.Next;
      end;
      ListBox1.EndUpdate;
      TabControl1.ActiveTab := TabItem2;
    end;
  except on E: Exception do
    ShowMessage( 'Erro: ' + E.Message);
  end;
end;

procedure TfrmVendedores.ComboBox1Change(Sender: TObject);
begin
  inherited;
  case ComboBox1.ItemIndex of
    0: begin
        edtBuscar.KeyboardType := TVirtualKeyboardType.vktNumberPad;
    end;
    1: begin
        edtBuscar.KeyboardType := TVirtualKeyboardType.vktAlphabet;
    end;
    2: begin
        edtBuscar.KeyboardType := TVirtualKeyboardType.vktNumberPad;

    end;

  end;

end;

procedure TfrmVendedores.edtBuscarKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
    begin
      btnBuscarClick(Application);
    end;
end;

procedure TfrmVendedores.FormActivate(Sender: TObject);
begin
  inherited;
   edtBuscar.KeyboardType := TVirtualKeyboardType.vktNumberPad;
   TabItem2.Enabled := False;
   TabItem3.Enabled := False;
end;

procedure TfrmVendedores.ListBox1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  uri : string;
  Intent : JIntent;
begin
  inherited;
  if (ClientDataSet1.FieldByName('ENDERECO').AsString <> EmptyStr) and
      (ClientDataSet1.FieldByName('CIDADE').AsString <> EmptyStr) then
  begin
    case EventInfo.GestureID of
      igiLongTap :
        begin
          uri :=Format('geo://0,0?q=%s, %s, %s', [ClientDataSet1.FieldByName('ENDERECO').AsString,
                                                  ClientDataSet1.FieldByName('BAIRRO').AsString,
                                                  ClientDataSet1.FieldByName('CIDADE').AsString ]);
          try
            Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
                        TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
            SharedActivity.startActivity(Intent);
          except on E: Exception do
            ShowMessage(E.Message);
          end;
        end;
    end;
  end
  else
    ShowMessage('Endereço vazio! Mapa Cancelado');

end;

procedure TfrmVendedores.ListBox1ItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  lbItemDetalhe : TListBoxItem;
  I: Integer;
begin
  inherited;
  ListBoxDetalhes.Clear;
  ListBoxDetalhes.BeginUpdate;
  ClientDataSet1.RecNo :=  ListBox1.ItemIndex +1;
  for I := 0 to ClientDataSet1.FieldCount -1 do
  begin
      lbItemDetalhe := TListBoxItem.Create(ListBoxDetalhes);
      lbItemDetalhe.StyleLookup := 'listboxitembottomdetail';
      lbItemDetalhe.StyledSettings := [TStyledSetting.ssFontColor];
      // (aNone=0, aMore=1, aDetail=2, aCheckmark=3)
      lbItemDetalhe.ItemData.Accessory := TListBoxItemData.TAccessory(2);
      lbItemDetalhe.TextSettings.FontColor := TAlphaColorRec.Blue;
      lbItemDetalhe.ItemData.Text      := ClientDataSet1.Fields[i].asString;
      lbItemDetalhe.ItemData.Detail    := ClientDataSet1.Fields[i].FieldName;
      ListBoxDetalhes.AddObject(lbItemDetalhe);
  end;
  ListBoxDetalhes.EndUpdate;
  TabControl1.ActiveTab :=TabItem3;

end;

procedure TfrmVendedores.ListBoxDetalhesItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var
  uri : string;
  Intent, Map : JIntent;
  Destinatarios: TJavaObjectArray<JString>;
  Destinatario : string;


begin
  inherited;
  if (Item.ItemData.Detail = 'ENDERECO') or  (Item.ItemData.Detail = 'CIDADE') then
    begin

      uri :=Format('geo://0,0?q=%s, %s, %s', [ClientDataSet1.FieldByName('ENDERECO').AsString,
                                                  ClientDataSet1.FieldByName('BAIRRO').AsString,
                                                  ClientDataSet1.FieldByName('CIDADE').AsString ]);
      try
        Map := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
                    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
        SharedActivity.startActivity(Map);
      except on E: Exception do
        ShowMessage(E.Message);
      end;

    end;

  if (Item.ItemData.Detail = 'CEL_VIVO_CORP') or
      (Item.ItemData.Detail = 'TEL') or
      (Item.ItemData.Detail = 'CEL_OUTRO') then
  begin
      if Item.ItemData.Text <> EmptyStr then
        begin
          uri :=Format('tel://0%s', [Item.ItemData.Text]);
          try
            Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_CALL,
                                    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
            SharedActivity.startActivity(Intent);
          except on E: Exception do
            ShowMessage(E.Message);
          end;
        end
      else
        ShowMessage('Informação incompleta! Ação cancelada!');

  end
  else
  begin
    if Item.ItemData.Detail = 'E_MAIL' then
      begin
//          uri :=Format('mailto://%s', ['landersongomes6@gmail.com']); //[Item.ItemData.Text]);

          try
            Destinatario := 'landerson_gomes@hotmail.com';
            Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
            Destinatarios := TJavaObjectArray<JString>.Create(1);
            Destinatarios.Items[0] := StringToJString(Destinatario);
//
            Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, Destinatarios);
            Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString('E-mail de Teste'));
            Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString('corpo do email'));
            Intent.setType(StringToJString('plain/text'));
            SharedActivity.startActivity(TJIntent.JavaClass.createChooser(Intent,
              StrToJCharSequence('Qual app usar?')));

//            Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_SEND);
//            Intent.setType(StringToJString('plain/text'));
//            intent.putExtra(tjintent.JavaClass.EXTRA_EMAIL, stringtojstring(QuotedStr('landerson_gomes@hotmail.com')));
//            intent.putExtra(tjintent.JavaClass.EXTRA_SUBJECT, stringtojstring('E-mail de Teste'));
//            intent.putExtra(tjintent.JavaClass.EXTRA_TEXT, stringtojstring('este é o corpo do email de teste.'));
//            SharedActivity.startActivity(Intent);

//  Intent := TJIntent.Create;
//  Intent.setAction(TJIntent.JavaClass.ACTION_Send);
//  Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
//  Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, StringToJString(Recipient));
//  Intent.putExtra(TJIntent.JavaClass.EXTRA_SUBJECT, StringToJString(Subject));
//  Intent.putExtra(TJIntent.JavaClass.EXTRA_TEXT, StringToJString(Content));
//  AttachmentFile := SharedActivity.getExternalFilesDir
//    (StringToJString(Attachment));
//  Uri := TJnet_Uri.JavaClass.fromFile(AttachmentFile);
//  Intent.putExtra(TJIntent.JavaClass.EXTRA_STREAM,
//    TJParcelable.Wrap((Uri as ILocalObject).GetObjectID));
//  Intent.setType(StringToJString('vnd.android.cursor.dir/email'));
//
//  SharedActivity.startActivity(Intent);


          except on E: Exception do
            ShowMessage(E.Message);
          end;
      end;

  end;






end;

end.
