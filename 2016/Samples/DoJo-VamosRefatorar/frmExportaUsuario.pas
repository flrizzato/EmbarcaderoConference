unit frmExportaUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Xml.XMLDoc, Xml.XMLIntf, System.Json, Data.DBXJSONReflect, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.StorageJSON, Vcl.OleCtrls, SHDocVw, Vcl.ExtCtrls, FireDAC.Stan.StorageBin, Vcl.ValEdit;

type
  TForm1 = class(TForm)
    btnExportarDados: TButton;
    MemTable: TFDMemTable;
    MemTableCodigo: TIntegerField;
    MemTableNome: TStringField;
    MemTableData: TDateTimeField;
    MemTableCargo: TStringField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    rdgTipoArquivo: TRadioGroup;
    vleRegistro: TValueListEditor;
    Button1: TButton;
    memArquivo: TMemo;
    procedure MemTableAfterPost(DataSet: TDataSet);
    procedure MemTableAfterDelete(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure btnExportarDadosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnExportarDadosClick(Sender: TObject);
var
  lXml: IXMLDocument;
  lNode: IXMLNode;
  lJsonObject: TJSONObject;
  lTexto : TStringList;
begin
  if rdgTipoArquivo.ItemIndex = 0 then
  begin
    lXml := TXmlDocument.Create(nil);
    lXml.Active  := True;
    lXml.Version := '1.0';
    lXml.Encoding:= 'UTF-8';
    lXml.Options := lXml.Options + [doNodeAutoIndent];

    lNode := lXml.AddChild('Registro');
    lNode.AddChild('Codigo').NodeValue := MemTable.FieldByName('Codigo').AsInteger;
    lNode.AddChild('Nome').NodeValue   := MemTable.FieldByName('Nome').AsString;
    lNode.AddChild('Data').NodeValue   := MemTable.FieldByName('Data').AsDateTime;
    lNode.AddChild('Cargo').NodeValue  := MemTable.FieldByName('Cargo').AsString;

    lXml.SaveToFile(ExtractFilePath(Application.ExeName)+'Registro.xml');
    memArquivo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'Registro.xml');
  end else begin
    lJsonObject := TJSONObject.Create;
    try
      lJsonObject.AddPair(TJSONPair.Create('Codigo', MemTable.FieldByName('Codigo').AsString));
      lJsonObject.AddPair(TJSONPair.Create('Nome', MemTable.FieldByName('Nome').AsString));
      lJsonObject.AddPair(TJSONPair.Create('Data', MemTable.FieldByName('Data').AsString));
      lJsonObject.AddPair(TJSONPair.Create('Cargo', MemTable.FieldByName('Cargo').AsString));

      lTexto := TStringList.Create;
      try
        lTexto.Text := lJsonObject.ToString;
        lTexto.SaveToFile(ExtractFilePath(Application.ExeName)+'Registro.json');
        memArquivo.Lines.LoadFromFile(ExtractFilePath(Application.ExeName)+'Registro.json');
      finally
        lTexto.Free;
      end;
    finally
      lJsonObject.Free;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //ShowMessage(ValueListEditor1.Values['Codigo']);
end;

procedure TForm1.MemTableAfterDelete(DataSet: TDataSet);
begin
  MemTable.SaveToFile(ExtractFilePath(Application.ExeName)+'Usuarioss.json',sfJSON);
end;

procedure TForm1.MemTableAfterPost(DataSet: TDataSet);
begin
  MemTable.SaveToFile(ExtractFilePath(Application.ExeName)+'Usuarioss.json',sfJSON);
end;

end.
