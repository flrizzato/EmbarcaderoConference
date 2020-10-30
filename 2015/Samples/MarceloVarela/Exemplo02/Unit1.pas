unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit;

type
  TForm1 = class(TForm)
    AmazonConnectionInfo1: TAmazonConnectionInfo;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Button4: TButton;
    ListBox2: TListBox;
    Button6: TButton;
    Button5: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListRowsClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Unit2, System.Generics.Collections;

procedure TForm1.Button1Click(Sender: TObject);
const
  bucketName = 'meuteste1';
  fileName = 'login_usuario.png';
var
  bstr: TBytesStream;
  amazonService: TAmazonStorageService;
begin
  bstr := TBytesStream.Create;
  try
    Image1.Bitmap.SaveToStream(bstr);
    amazonService := TAmazonStorageService.Create(AmazonConnectionInfo1);
    try
      if amazonService.UploadObject(bucketName, fileName, bstr.Bytes) then
      begin
        ShowMessage('Imagem enviada com sucesso.');
      end
      else
      begin
        ShowMessage('Erro ao enviar imagem.');
      end;
    finally
      amazonService.Free;
    end;
  finally
    bstr.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  tableName = 'imagens';
var
  tableService: TAmazonTableService;
begin
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    if tableService.CreateTable(tableName) then
    begin
      ShowMessage('Tabela criada com sucesso.');
    end
    else
    begin
      ShowMessage('Erro ao criar tabela');
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  tableService: TAmazonTableService;
begin
  ListBox1.Clear;
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    ListBox1.Items.AddStrings(tableService.QueryTables);
  finally
    tableService.Free;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
const
  tableName = 'imagens';
  columnName = 'imagem';
  fileName = 'login_usuario.png';
var
  aTableRow: TCloudTableRow;
  aRowId: string;
  tableService: TAmazonTableService;
begin
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  aRowId := TUtils.GerarNomeArquivo;
  try
    aTableRow := TCloudTableRow.Create;
    try
      aTableRow.SetColumn(columnName, fileName);
      if tableService.InsertRow(tableName, aRowId, aTableRow, nil) then
      begin
        ListRowsClick(Sender);
        ShowMessage('Dados inseridos com sucesso.');
      end
      else
      begin
        ShowMessage('Erro ao inserir dados');
      end;
    finally
      aTableRow.Free;
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
const
  tableName = 'imagens';
var
  aRowId: string;
  tableService: TAmazonTableService;
begin
  aRowId := Edit1.Text;
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    if tableService.DeleteRow(tableName, aRowId) then
    begin
      ListRowsClick(Sender);
      ShowMessage('Dados apagados com sucesso.');
    end
    else
    begin
      ShowMessage('Erro ao apagar dados');
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.ListRowsClick(Sender: TObject);
const
  tableName = 'imagens';
  columnName = 'imagem';
  fileName = 'login_usuario.png';
var
  tableService: TAmazonTableService;
  rows: TList<TCloudTableRow>;
  row: TCloudTableRow;
  i: Integer;
begin
  ListBox2.Clear;
  tableService := TAmazonTableService.Create(AmazonConnectionInfo1);
  try
    rows := tableService.GetRows(tableName);
    if rows <> nil then
    begin
      for row in rows do
      begin
        for i := 0 to row.Columns.Count - 1 do
        begin
          ListBox2.Items.Add(row.Columns[i].Name + ': ' + row.Columns[i].Value);
        end;
      end;
    end;
  finally
    tableService.Free;
  end;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
  Edit1.Text := TUtils.GetRowId(ListBox2.Selected.Text);
end;

end.
