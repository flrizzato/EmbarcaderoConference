unit Unit1;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.JSON.Writers,
  System.JSON.Types,
  System.Bindings.Outputs,
  System.Rtti,
  System.JSON,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Grid.Style,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Grid,
  FMX.Bind.DBEngExt,
  FMX.Bind.Grid,
  FMX.Bind.Editors,
  FMX.Edit,
  FMX.Layouts,
  FMX.Bind.Navigator,

  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.DB,
  Data.FireDACJSONReflect,
  Data.Bind.Controls,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,

  REST.Response.Adapter,
  REST.Client;

type
  TForm1 = class(TForm)
    BindingsList1: TBindingsList;
    Button3: TButton;
    memAuxiliar: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    strgrdTickets: TStringGrid;
    memTickets: TFDMemTable;
    bsrcTickets: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB32: TLinkGridToDataSource;
    memTicketsdata: TDateTimeField;
    memTicketshora: TTimeField;
    Button4: TButton;
    memTicketsstatus: TStringField;
    memTicketsid: TIntegerField;
    Button5: TButton;
    Button6: TButton;
    Button1: TButton;
    strgrdAuxiliar: TStringGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    edtItem: TEdit;
    edtData: TEdit;
    edtID: TEdit;
    edtHora: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    chkStatus: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure strgrdTicketsCellDblClick(const Column: TColumn;
      const Row: Integer);
  private
    { Private declarations }
    procedure GridAjustSize(AStringGrid: TStringGrid);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  UntDMRest, ClientModuleUnit1;

procedure TForm1.Button1Click(Sender: TObject);
const
  jOBJFormato =
    '{"%s":{'          +
    '   "id":"%s",'    +
    '   "data":"%s",'  +
    '   "hora":"%s",'  +
    '   "status":"%s"' +
    '}}';
var
  sJSON   : String;
  sStatus : String;
begin
  //Alterar somente o ticket selecionado
  if not (chkStatus.IsChecked)
  then sStatus := 'aberto'
  else sStatus := 'fechado';

  sJSON := Format(jOBJFormato, [edtItem.Text, edtID.Text, edtData.Text, edtHora.Text, sStatus]);
  if ClientModule1.SrvMetodosClient.PatchTicket(sJSON) then
    ShowMessage('Alteração concluída.')
  else
    ShowMessage('Ocorreu algum erro.')
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Dados : TFDJSONDataSets;
  lJSON : TJSONValue;
  I     : Integer;
  nValues : Integer;
  sValue : String;
begin
  Dados := ClientModule1.SrvMetodosClient.GetTickets('');
  if TFDJSONDataSetsReader.GetListCount(Dados) = 1 then
  begin
    memAuxiliar.AppendData(TFDJSONDataSetsReader.GetListValue(Dados, 0));
    memAuxiliar.Active := True;
    memTickets.Active  := True;
    for I := 0 to Pred(memAuxiliar.FieldCount) do
    begin
      lJSON := TJSONObject.ParseJSONValue(memAuxiliar.Fields[I].AsString);

      memTickets.Append;
      memTickets.FieldByName('id').Value     := (lJSON as TJSONObject).Values['id'].Value;
      memTickets.FieldByName('data').Value   := (lJSON as TJSONObject).Values['data'].Value;
      memTickets.FieldByName('hora').Value   := (lJSON as TJSONObject).Values['hora'].Value;
      memTickets.FieldByName('status').Value := (lJSON as TJSONObject).Values['status'].Value;
      memTickets.Post;
    end;
  end;

  GridAjustSize(strgrdTickets);
  GridAjustSize(strgrdAuxiliar);


//  nValues := (lJSON as TJSONObject).Count;
//  sValue  := (lJSON as TJSONObject).Pairs[I].ToString;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  StringWriter : TStringWriter;
  Writer       : TJsonTextWriter;
  I            : Integer;
  sJSON        : String;
  iCod         : Integer;
begin
{$REGION 'Formato JSON Total'}
(*
{
   "tickets":{
      "tk0001":{
         "id":"1",
         "data":"01/01/2018",
         "hora":"12:00",
         "status":"fechado"
      },
      "tk0002":{
         "id":"2",
         "data":"01/03/2018",
         "hora":"13:00",
         "status":"fechado"
      }
   }
}
*)
{$ENDREGION}

  StringWriter := TStringWriter.Create();
  Writer       := TJsonTextWriter.Create(StringWriter);

  Writer.Formatting := TJsonFormatting.Indented;
  Writer.WriteStartObject;
  iCod := 0;
  memTickets.First;
  while not memTickets.Eof do
  begin
    Inc(iCod);
    Writer.WritePropertyName(Format('tk%4.4d', [iCod]));
    Writer.WriteStartObject;
    for I := 0 to Pred(memTickets.FieldCount) do
    begin
      Writer.WritePropertyName(memTickets.Fields[I].FieldName);
      Writer.WriteValue(memTickets.Fields[I].AsString);
    end;
    Writer.WriteEndObject;
    memTickets.Next;
  end;
  Writer.WriteEndObject;

  sJSON := StringWriter.ToString;

  ClientModule1.SrvMetodosClient.PatchTicket(sjson);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  sJSON : String;
begin
  sJSON :=
    '{'+
    '   "tickets":{'+
    '      "tk0001":{'+
    '         "id":"1",'+
    '         "data":"01/01/2018",'+
    '         "hora":"12:00",'+
    '         "status":"fechado"'+
    '      },'+
    '      "tk0002":{'+
    '         "id":"2",'+
    '         "data":"01/03/2018",'+
    '         "hora":"13:00",'+
    '         "status":"fechado"'+
    '      },'+
    '      "tk0003":{'+
    '         "id":"3",'+
    '         "data":"01/03/2018",'+
    '         "hora":"13:18",'+
    '         "status":"fechado"'+
    '      }'+
    '   }'+
    '}';
  ClientModule1.SrvMetodosClient.Sincronizar(sJSON);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  sJSON : String;
begin
  //Alterar somente o ticket selecionado
  sJSON :=
    '{"tk0001":{'+
    '   "id":"1",'+
    '   "data":"01/01/2018",'+
    '   "hora":"12:00",'+
    '   "status":"aberto"'+
    '}}';
  ClientModule1.SrvMetodosClient.PatchTicket(sJSON);
end;

procedure TForm1.GridAjustSize(AStringGrid: TStringGrid);
var
  I : Integer;
begin
  for I := 0 to Pred(AStringGrid.ColumnCount) do
    AStringGrid.Columns[I].Width := 100;
end;

procedure TForm1.strgrdTicketsCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  edtItem.Text := Format('tk%4.4d', [memTicketsid.AsInteger]);
  edtID.Text   := memTicketsid.AsString;
  edtData.Text := memTicketsdata.AsString;
  edtHora.Text := memTicketshora.AsString;
  chkStatus.IsChecked := memTicketsstatus.AsString.Equals('fechado');
end;

end.
