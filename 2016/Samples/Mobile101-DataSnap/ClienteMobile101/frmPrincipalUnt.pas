unit frmPrincipalUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Layouts,
  FMX.Objects, FMX.Edit, IPPeerClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON,
  Data.FireDACJSONReflect, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.Bind.DBScope,
  FMX.ListView, FMX.MultiView, fraMenuTopUnt, FMX.ListBox, FMX.Gestures;

type
  TForm2 = class(TForm)
    LayMaster: TLayout;
    layClientTabIt: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    edtCNPJ: TEdit;
    RoundRect1: TRoundRect;
    Label1: TLabel;
    Button1: TButton;
    FlowLayoutBaixo: TFlowLayout;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDMemTable1CLIENTE: TStringField;
    FDMemTable1RAZAO: TStringField;
    FDMemTable1Fantasia: TStringField;
    FDMemTable1CONTATO: TStringField;
    FDMemTable1BLOQ: TStringField;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    BindSourceDB1: TBindSourceDB;
    lblCNPJ: TLabel;
    lblFantasia: TLabel;
    lblRazao: TLabel;
    fraMenuTop1: TfraMenuTop;
    MultiView1: TMultiView;
    RoundRect2: TRoundRect;
    EdtEmail: TEdit;
    Label2: TLabel;
    Button2: TButton;
    layBotton: TLayout;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    FDMemTable2: TFDMemTable;
    FDMemTable2PEDIDO: TStringField;
    FDMemTable2DATA: TStringField;
    FDMemTable2NOTA: TStringField;
    FDMemTable2OBS: TStringField;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    lblCodigo: TLabel;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem3: TListBoxItem;
    GestureManager1: TGestureManager;
    procedure FormSaveState(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure ListView1Gesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
  private
    procedure ListarPedidos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses System.JSON, Datasnap.DSClientRest, Rest.Types,
  ModuloClientRestUnt,
  System.Threading,
  System.IOUtils;


{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
   DSCliente : TFDJSONDataSets;
begin
  DSCliente := ModuloClientRest.DSServerClientesClient.AutenticaCNPJ(edtCNPJ.Text);
  FDMemTable1.Active := False;
  FDMemTable1.AppendData(
      TFDJSONDataSetsReader.GetListValue(DSCliente,0)
      );
  if FDMemTable1.RecordCount > 0 then
  begin
    lblCodigo.Text     := FDMemTable1CLIENTE.AsString;
    lblRazao.Text      := FDMemTable1RAZAO.AsString;
    lblFantasia.Text   := FDMemTable1Fantasia.AsString;
    lblCNPJ.Text       := edtCNPJ.Text;
    TabControl1.TabIndex := 1;
    edtCNPJ.Enabled := False;

  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  edtCNPJ.Text.Empty;
  edtCNPJ.Enabled := True;
  RESTResponse1.Content.Empty;
  SaveState.Stream.Clear;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  DadosSalvos: TBinaryReader;
begin
  TabControl1.TabIndex := 0;
  SaveState.StoragePath := TPath.GetHomePath;
  if SaveState.Stream.Size > 0 then begin
    DadosSalvos := TBinaryReader.Create(SaveState.Stream);
    try
        TabControl1.TabIndex := 1;
        lblCodigo.Text  := DadosSalvos.ReadString;
        lblCNPJ.Text    := DadosSalvos.ReadString;
        lblRazao.Text   := DadosSalvos.ReadString;
        lblFantasia.Text := DadosSalvos.ReadString;
        EdtEmail.Text   := DadosSalvos.ReadString;

    finally
      DadosSalvos.Free;
    end;
  end;
end;

procedure TForm2.FormSaveState(Sender: TObject);
var
  DadosCliente : TBinaryWriter;
begin
  SaveState.Stream.Clear;
  DadosCliente := TBinaryWriter.Create(SaveState.Stream);
  try
    DadosCliente.Write(lblCodigo.Text);
    DadosCliente.Write(lblRazao.Text);
    DadosCliente.Write(lblCNPJ.Text);
    DadosCliente.Write(lblFantasia.Text);
    DadosCliente.Write(EdtEmail.Text);

  finally
    DadosCliente.Free;
  end;

end;

procedure TForm2.ListBoxItem1Click(Sender: TObject);
begin
  ListarPedidos;
end;

procedure TForm2.ListarPedidos;
var
  DSPedidos: TFDJSONDataSets;
begin
  DSPedidos := ModuloClientRest.DSServerClientesClient.GetPedidos(lblCodigo.Text);
  FDMemTable2.Active := False;
  FDMemTable2.AppendData(TFDJSONDataSetsReader.GetListValue(DSPedidos, 0));
end;

procedure TForm2.ListBoxItem3Click(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  Button2Click(Sender);
end;

procedure TForm2.ListView1Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
  var
    Gesto, Mensagem : string;
    aTask: ITask;
  begin
  if GestureToIdent(EventInfo.GestureID, Gesto) then
    begin
      case EventInfo.GestureID of
        sgiRight :
          begin
            Mensagem := 'e-mail vazio!';
            if not EdtEmail.Text.IsEmpty then
              begin
                aTask := TTask.Create (procedure ()
                  begin
                    if ModuloClientRest.DSServerModuleEstoqueClient.AtualizaXMLStatusEnvio(
                                          StrToInt(FDMemTable2NOTA.AsString),
                                          LowerCase(edtEMAIL.Text),
                                          Mensagem ) then
                    ShowMessage(Mensagem);
                  end);
                aTask.Start;
              end
              else
                ShowMessage(Mensagem);

          end;
      end;
    end;

end;

procedure TForm2.ListView1PullRefresh(Sender: TObject);
begin
  ListarPedidos;
end;

end.
