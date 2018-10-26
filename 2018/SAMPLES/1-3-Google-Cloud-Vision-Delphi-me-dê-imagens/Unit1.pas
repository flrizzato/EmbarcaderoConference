unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FMX.Controls.Presentation, FMX.StdCtrls, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox, FMX.Grid, FMX.Edit,
  FMX.Objects, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, FMX.TabControl, System.Actions, FMX.ActnList, FMX.Layouts,
  FMX.StdActns, FMX.MediaLibrary.Actions, FMX.Memo;

type
  TForm1 = class(TForm)
    RESTClientFaces: TRESTClient;
    RESTRequestFaces: TRESTRequest;
    RESTResponseDataSetAdapterFaces: TRESTResponseDataSetAdapter;
    FDMemTableFaces: TFDMemTable;
    ButtonURL: TButton;
    StringGrid1: TStringGrid;
    edtURL: TEdit;
    IdHTTP1: TIdHTTP;
    Panel1: TPanel;
    Image1: TImage;
    ButtonBase64: TButton;
    OpenDialogWindows: TOpenDialog;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Rectangle1: TRectangle;
    ActionListAndroid: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ButtonOCR: TButton;
    RESTResponseFaces: TRESTResponse;
    FDMemTableOCR: TFDMemTable;
    RESTResponseDataSetAdapterOCR: TRESTResponseDataSetAdapter;
    RESTResponseOCR: TRESTResponse;
    RESTRequestOCR: TRESTRequest;
    RESTClientOCR: TRESTClient;
    procedure ButtonURLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonBase64Click(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure ButtonOCRClick(Sender: TObject);
  private
    procedure MarcarFaces;
    procedure ApagarFaces;
    procedure ConfigurarConexaoRESTClientLib(const aRESTClient: TRESTClient;
      const aRESTRequest: TRESTRequest; const aRESTResponse: TRESTResponse;
      const aRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
      const aFDMemTable: TFDMemTable);
    { Private declarations }
  public
    { Public declarations }
  end;
const
  CAMINHO_URL = 'http://i2.wp.com/www.landersongomes.com.br/wp-content/uploads/ngg_featured/LandersonGomes_EEN_2018_09.jpg';
var
  Form1: TForm1;

implementation

uses
  System.Threading, System.NetEncoding,
  System.JSON, System.UITypes;

{$R *.fmx}

procedure TForm1.ButtonOCRClick(Sender: TObject);
var
  lMemory : TMemoryStream;
  lString : TStringStream;
begin
  OpenDialogWindows.InitialDir := ExtractFilePath(ParamStr(0));
  if OpenDialogWindows.Execute then
    begin
      lMemory := TMemoryStream.Create;
      ConfigurarConexaoRESTClientLib( RESTClientOCR,
                                      RESTRequestOCR,
                                      RESTResponseOCR,
                                      RESTResponseDataSetAdapterOCR,
                                      FDMemTableOCR);
      try
        Image1.WrapMode := TImageWrapMode.Original;
        Image1.Bitmap.Clear(TAlphaColorRec.Null);
        lMemory.LoadFromFile(OpenDialogWindows.FileName);
        Image1.Bitmap.LoadFromStream(lMemory);
        lMemory.Position := 0;
        lString := TStringStream.Create;
        TNetEncoding.Base64.Encode(lMemory, lString);
        lString.Position := 0;
        ApagarFaces;
        RESTRequestOCR.Params[0].Value := Format(
              '{"requests":[ {"image":{"content": ' +
              '"%s"},"features":[{"type":"TEXT_DETECTION"}]}]}',
                            [lString.DataString] );
        RESTResponseOCR.RootElement := 'responses[0].textAnnotations[0].description';
        RESTRequestOCR.Execute;

        if FDMemTableOCR.RecordCount > 0 then
          ShowMessage(VarToStr(FDMemTableOCR.FieldValues['description']));

      finally
        lMemory.Free;
        lString.Free;
      end;
    end;
end;

procedure TForm1.ButtonBase64Click(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  lMemory : TMemoryStream;
  lString : TStringStream;
begin
  OpenDialogWindows.InitialDir := ExtractFilePath(ParamStr(0));
  if OpenDialogWindows.Execute then
    begin
      lMemory := TMemoryStream.Create;
      try
        ConfigurarConexaoRESTClientLib( RESTClientFaces,
                                        RESTRequestFaces,
                                        RESTResponseFaces,
                                        RESTResponseDataSetAdapterFaces,
                                        FDMemTableFaces);
        Image1.WrapMode := TImageWrapMode.Original;
        Image1.Bitmap.Clear(TAlphaColorRec.Null);
        lMemory.LoadFromFile(OpenDialogWindows.FileName);
        Image1.Bitmap.LoadFromStream(lMemory);
        lMemory.Position := 0;
        lString := TStringStream.Create;
        TNetEncoding.Base64.Encode(lMemory, lString);
        lString.Position := 0;
        ApagarFaces;
        RESTRequestFaces.Params[0].Value := Format(
              '{"requests":[ {"image":{"content": ' +
              '"%s"},"features":[{"type":"FACE_DETECTION"}]}]}',
                            [lString.DataString] );
        MarcarFaces;
      finally
        lMemory.Free;
        lString.Free;
      end;
    end;
{$ENDIF}
{$IFDEF ANDROID}
begin
  TakePhotoFromCameraAction1.Execute;
{$ENDIF}
end;

procedure TForm1.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
var
  lMemory : TMemoryStream;
  lString : TStringStream;
begin
  Image1.Bitmap := Image;
  lMemory := TMemoryStream.Create;
  lString := TStringStream.Create;
  try
    Image.SaveToStream(lMemory);
    lMemory.Position := 0;
    TNetEncoding.Base64.Encode(lMemory, lString);
    lString.Position := 0;
    RESTRequestFaces.Params[0].Value := Format(
          '{"requests":[ {"image":{"content": ' +
          '"%s"},"features":[{"type":"FACE_DETECTION"}]}]}',
                        [lString.DataString] );
    MarcarFaces;
  finally
    lMemory.Free;
    lString.Free;
  end;

end;

procedure TForm1.MarcarFaces;
var
  rostos: Integer;
  minX: Integer;
  minY: Integer;
  maxX: Integer;
  maxY: Integer;
  vertices: Integer;
begin
  ApagarFaces;
  RESTRequestFaces.Execute;
  RESTResponseFaces.RootElement := 'responses[0].faceAnnotations';
  for rostos := 0 to FDMemTableFaces.RecordCount - 1 do
    begin
      RESTResponseFaces.RootElement := Format('responses[0].faceAnnotations[%s].boundingPoly.vertices', [rostos.ToString]);
      minX := 0;
      minY := 0;
      maxX := 0;
      maxY := 0;
      for vertices := 0 to FDMemTableFaces.RecordCount - 1 do
        begin
          if (minX > VarToStr(FDMemTableFaces.FieldValues['x']).ToInteger) or (minX = 0) then
            minX := VarToStr(FDMemTableFaces.FieldValues['x']).ToInteger;

          if (maxX < VarToStr(FDMemTableFaces.FieldValues['x']).ToInteger) or (maxX = 0) then
            maxX := VarToStr(FDMemTableFaces.FieldValues['x']).ToInteger;

          if (minY > VarToStr(FDMemTableFaces.FieldValues['y']).ToInteger) or (minY = 0) then
            minY := VarToStr(FDMemTableFaces.FieldValues['y']).ToInteger;

          if (maxY < VarToStr(FDMemTableFaces.FieldValues['y']).ToInteger) or (maxY = 0) then
            maxY := VarToStr(FDMemTableFaces.FieldValues['y']).ToInteger;

          FDMemTableFaces.Next;
        end;

      // Cria os retângulos nos rostos e marca na tela
      TThread.Queue( nil,
        procedure ()
          var
            Face : TRectangle;
            begin
              Face := TRectangle.Create(Image1);
              Face.Parent := Image1;
              Face.ClipChildren := True;
              Face.Name := Format('Face%s', [IntToStr(rostos+1)]);
              Face.Fill.Kind := TBrushKind.None;
              Face.Stroke.Color := TAlphaColorRec.Red;
              Face.Stroke.Thickness := 5;
              Face.Position.X := minX;
              Face.Position.Y := minY;
              Face.Size.Height := (maxY - minY);
              Face.Size.Width := (maxX - minX);
              Face.Size.PlatformDefault := False;
              Face.Visible := True;
           end);
      RESTResponseFaces.RootElement := 'responses[0].faceAnnotations';
      FDMemTableFaces.Next;

    end;
end;

procedure TForm1.ApagarFaces;
var
  i: Integer;
begin
  i := 0;
  while i < Image1.ComponentCount do
  begin
    if Image1.Components[i] is TRectangle then
    begin
      Image1.Components[i].Destroy;
    end;
  end;
end;

procedure TForm1.ButtonURLClick(Sender: TObject);
var
  MemoryStream : TMemoryStream;
begin
  ConfigurarConexaoRESTClientLib( RESTClientFaces,
                                  RESTRequestFaces,
                                  RESTResponseFaces,
                                  RESTResponseDataSetAdapterFaces,
                                  FDMemTableFaces);
  Image1.Bitmap.Clear(TAlphaColorRec.Null);
  MemoryStream := TMemoryStream.Create;
  try
    edtURL.Text := edtURL.Text.Replace('https:', 'http:');
    // Capturando imagem da web e associando a um TImage
    IdHTTP1.Get(edtURL.Text, MemoryStream);
    MemoryStream.Seek(0, soFromBeginning);
    Image1.Bitmap.LoadFromStream(MemoryStream);

    RESTRequestFaces.Params[0].Value := Format(
              '{"requests":[ {"image":{"source": ' +
              '{"imageUri":"%s" }},"features":[{"type":"FACE_DETECTION"}]}]}',
                            [edtURL.Text] )  ;
    MarcarFaces;
  finally
    MemoryStream.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 edtURL.Text := CAMINHO_URL;
end;

procedure TForm1.ConfigurarConexaoRESTClientLib(
  const aRESTClient: TRESTClient; const aRESTRequest: TRESTRequest;
  const aRESTResponse: TRESTResponse;
  const aRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  const aFDMemTable: TFDMemTable);
begin
//        Configurando REST Client
  aFDMemTable.Active := False;
  aRESTClient.ResetToDefaults;
  aRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  aRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  aRESTClient.BaseURL := 'https://vision.googleapis.com';
  aRESTClient.HandleRedirects := True;
  aRESTClient.RaiseExceptionOn500 := False;
  // KEY = a chave de API registrada no Google Cloud Vision
  aRESTRequest.Resource := 'v1/images:annotate?key=AIzaSyAPdajiSnypUtEBdk-fFqU3IRNjGT2Wh10';

  aRESTRequest.Client := aRESTClient;
  aRESTRequest.Response := aRESTResponse;
  aRESTRequest.SynchronizedEvents := False;
  aRESTResponse.ContentType := 'application/json';
end;

end.
