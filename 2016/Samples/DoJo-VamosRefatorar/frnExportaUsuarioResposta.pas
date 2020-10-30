unit frnExportaUsuarioResposta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Vcl.StdCtrls, Vcl.Grids, Vcl.ValEdit,
  FireDAC.Stan.StorageJSON, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.DBGrids, uUsuario,
  uExportador;

type
  TForm2 = class(TForm)
    btnExportarDados: TButton;
    DBGrid1: TDBGrid;
    rdgTipoArquivo: TRadioGroup;
    MemTable: TFDMemTable;
    MemTableCodigo: TIntegerField;
    MemTableNome: TStringField;
    MemTableData: TDateTimeField;
    MemTableCargo: TStringField;
    DataSource1: TDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    vleRegistro: TValueListEditor;
    Button1: TButton;
    memArquivo: TMemo;
    procedure btnExportarDadosClick(Sender: TObject);
  private
    procedure InicializarUsuarioPeloRegistroDaTabela(pUsuario: TUsuario);
    procedure InicializarUsuarioPeloValueListEditor(pUsuario: TUsuario);

    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.btnExportarDadosClick(Sender: TObject);
var
  lUsuario: TUsuario;
  lExportador: TExportador;
  lArquivo: string;
begin
  lUsuario := TUsuario.Create;
  try
    InicializarUsuarioPeloRegistroDaTabela(lUsuario);

    {case rdgTipoArquivo.ItemIndex of
      0: lExportador := TExportadorXML.Create;
      1: lExportador := TExportadorJson.Create;
      2: lExportador := TExportadorTXT.Create;
    end;}

    lExportador := TExportadorFactory.CriarExportador(TTipoExportador(rdgTipoArquivo.ItemIndex));

    try
      lArquivo := ExtractFilePath(Application.ExeName)+'Registro'+TTipoExportador(rdgTipoArquivo.ItemIndex).Extensao;
      lExportador.Exportar(lUsuario, lArquivo);
      memArquivo.Lines.LoadFromFile(lArquivo);
    finally
      lExportador.Free;
    end;

  finally
    lUsuario.Free;
  end;
end;

procedure TForm2.InicializarUsuarioPeloRegistroDaTabela(pUsuario: TUsuario);
begin
  pUsuario.Codigo := MemTable.FieldByName('Codigo').AsInteger;
  pUsuario.Nome   := MemTable.FieldByName('Nome').AsString;
  pUsuario.Data   := MemTable.FieldByName('Data').AsDateTime;
  pUsuario.Cargo  := MemTable.FieldByName('Cargo').AsString;
end;

procedure TForm2.InicializarUsuarioPeloValueListEditor(pUsuario: TUsuario);
begin
  pUsuario.Codigo := StrToIntDef(vleRegistro.Values['Codigo'],0);
  pUsuario.Nome   := vleRegistro.Values['Nome'];
  pUsuario.Data   := StrToDateTimeDef(vleRegistro.Values['Data'],0);
  pUsuario.Cargo  := vleRegistro.Values['Cargo'];
end;

end.
