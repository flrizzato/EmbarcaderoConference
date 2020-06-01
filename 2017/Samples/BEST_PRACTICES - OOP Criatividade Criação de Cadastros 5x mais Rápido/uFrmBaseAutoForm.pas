unit uFrmBaseAutoForm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, DB, ExtCtrls, Grids, DBGrids, DBCtrls,
  DBClient, Provider, SqlExpr, StdCtrls, Buttons, ComCtrls, ToolWin,
  ImgList, ActnList, WideStrings, DBXFirebird, uFrmBaseForm, System.ImageList,
  System.Actions;

type
  TfrmBaseAutoForm = class(TFrmBaseForm)
    dsAutoForm: TDataSource;
    pnlControls: TPanel;
    PnTitulo: TPanel;
    Pc: TPageControl;
    TbCadastro: TTabSheet;
    TbConsulta: TTabSheet;
    PnConsulta: TPanel;
    ActionList1: TActionList;
    Ac_Incluir: TAction;
    Ac_Excluir: TAction;
    Ac_Alterar: TAction;
    Ac_Confirmar: TAction;
    ImageList1: TImageList;
    EdtValorPesquisa: TButtonedEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton9: TSpeedButton;
    lblTitulo: TLabel;
    SaveDlgExport: TSaveDialog;
    StatusBar1: TStatusBar;
    Ac_Fechar: TAction;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cdsAutoFormBeforePost(DataSet: TDataSet);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ac_IncluirExecute(Sender: TObject);
    procedure Ac_ExcluirExecute(Sender: TObject);
    procedure Ac_AlterarExecute(Sender: TObject);
    procedure Ac_ConsultarExecute(Sender: TObject);
    procedure Ac_ImprimirExecute(Sender: TObject);
    procedure Ac_ConfirmarExecute(Sender: TObject);
    procedure Ac_FecharExecute(Sender: TObject);
    procedure GradeTitleClick(Column: TColumn);
    procedure Ac_IncluirUpdate(Sender: TObject);
    procedure Ac_ConfirmarUpdate(Sender: TObject);
    procedure cdsAutoFormNewRecord(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtValorPesquisaRightButtonClick(Sender: TObject);
    procedure EdtValorPesquisaLeftButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JvDBGrid1DblClick(Sender: TObject);
  private
    FConexao: TSQLConnection;
    procedure SetConexao(const Value: TSQLConnection);
    procedure DoAfterScroll(DataSet: TDataSet);
    { Private declarations }
  protected
    FieldFilter: TField;
    function GetNextKeyValue: Integer;
    function GetKeyField: string;virtual;abstract;
    function GetDisplayName: string;virtual;abstract;
    property Conexao: TSQLConnection read FConexao write SetConexao;
    { TODO 5 -oRodrigo -cMelhorias : Chamar o Singleton para setar a conexao }
  public
    { Public declarations }
  end;

var
  frmBaseAutoForm: TfrmBaseAutoForm;

implementation

uses
  Winapi.Windows;

{$R *.dfm}


procedure TfrmBaseAutoForm.Ac_IncluirExecute(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  Pc.ActivePage := TbCadastro;
  DsAutoForm.DataSet.Insert;
  for I := 0 to pnlControls.ControlCount - 1 do
    begin
      if pnlControls.Controls[i].Tag = 99 then
         TDBEdit(pnlControls.Controls[i]).SetFocus
    end;
end;

procedure TfrmBaseAutoForm.Ac_ExcluirExecute(Sender: TObject);
begin
  inherited;
  DsAutoForm.DataSet.Delete;
  TClientDataSet(DsAutoForm.DataSet).ApplyUpdates(0);
end;

procedure TfrmBaseAutoForm.Ac_AlterarExecute(Sender: TObject);
begin
  inherited;
  Pc.ActivePage := TbCadastro;
  DsAutoForm.DataSet.Edit;
end;

procedure TfrmBaseAutoForm.Ac_ConsultarExecute(Sender: TObject);
begin
  inherited;
  if pc.ActivePage = TbCadastro then
    Pc.ActivePage := TbConsulta
  else
    pc.ActivePage := TbCadastro;
end;

procedure TfrmBaseAutoForm.Ac_ImprimirExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseAutoForm.Ac_ConfirmarExecute(Sender: TObject);
begin
  inherited;
  TClientDataSet(DsAutoForm.DataSet).ApplyUpdates(0);
    Pc.ActivePage := TbConsulta;
end;

procedure TfrmBaseAutoForm.Ac_FecharExecute(Sender: TObject);
begin
  FadeOut.Enabled := true;
  DsAutoForm.DataSet.Close;
{  Action      := Cafree;}
  FrmBaseAutoForm := nil;
end;

function TfrmBaseAutoForm.GetNextKeyValue: Integer;
var
  AClone: TClientDataSet;
begin
  Result := 1;
  if not  dsAutoForm.DataSet.IsEmpty then
  begin
    AClone := TClientDataSet.Create(Self);
    try
      AClone.CloneCursor( TClientDataSet(dsAutoForm.DataSet), False);
      AClone.IndexFieldNames := GetKeyField;
      AClone.Last;
      Result := AClone.FieldByName(GetKeyField).AsInteger + 1;
    finally
      AClone.Free;
    end;
  end;
end;


procedure TfrmBaseAutoForm.FormShow(Sender: TObject);
begin
  AlphaBlendValue := 0;
  FadeIn.Enabled := true;
  lblTitulo.Caption := GetDisplayName;
  Self.Caption := '';
  dsAutoForm.DataSet.Open;
  Pc.ActivePage := TbConsulta;
end;

procedure TfrmBaseAutoForm.btnOkClick(Sender: TObject);
begin
  TClientDataSet(dsAutoForm.DataSet).ApplyUpdates(0);
end;

procedure TfrmBaseAutoForm.cdsAutoFormBeforePost(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to dsAutoForm.DataSet.FieldCount - 1 do
  begin
    if (dsAutoForm.DataSet.Fields[i].FieldKind = fkData) and
      dsAutoForm.DataSet.Fields[i].Required and (dsAutoForm.DataSet.Fields[i].IsNull or
        (dsAutoForm.DataSet.Fields[i].AsString = '')) then
      begin
        MessageDlg('Campo requerido não foi preenchido: ' +
          dsAutoForm.DataSet.Fields[i].DisplayLabel, mtError, [mbOk], 0);
        Abort;
      end;
  end;
end;

procedure TfrmBaseAutoForm.cdsAutoFormNewRecord(DataSet: TDataSet);
begin
  if dsAutoForm.DataSet.FieldByName(GetKeyField).IsNull then
    dsAutoForm.DataSet.FieldByName(GetKeyField).AsInteger := GetNextKeyValue;
end;

procedure TfrmBaseAutoForm.DBGrid1TitleClick(Column: TColumn);
begin
  if Column.Field.FieldKind = fkData then
  begin
    FieldFilter := Column.Field;
    EdtValorPesquisa.TextHint :=
      'Digite aqui para pesquisar em ' + Column.Title.Caption;
    TClientDataSet(dsAutoForm.DataSet).IndexFieldNames := Column.FieldName;
  end;
end;

procedure TfrmBaseAutoForm.DoAfterScroll(DataSet: TDataSet);
begin
  StatusBar1.SimpleText := 'Total de Cadastros: '+intToStr(dsAutoForm.DataSet.RecordCount);
end;

procedure TfrmBaseAutoForm.EdtValorPesquisaLeftButtonClick(Sender: TObject);
begin
  inherited;
  EdtValorPesquisa.Clear;
  FreeAndNil(FieldFilter);
  TClientDataSet(dsAutoForm.DataSet).Filtered := False;
  TClientDataSet(dsAutoForm.DataSet).Open;
end;

procedure TfrmBaseAutoForm.EdtValorPesquisaRightButtonClick(Sender: TObject);
var
  Filter: String;
begin
  if Assigned(FieldFilter) then
  begin
    if FieldFilter.FieldKind = fkData then
    begin
      case FieldFilter.DataType of
        ftUnknown:;
        ftBoolean:;

        ftString, ftFixedChar,
        ftWideString, ftFixedWideChar,
        ftWideMemo,ftMemo:  Filter := 'upper('+FieldFilter.FieldName + ') like ' + QuotedStr(UpperCase(EdtValorPesquisa.Text + '%'));

        ftSmallint, ftInteger,
        ftWord, ftLargeint,
        ftLongWord, ftShortint,
        ftBytes, ftByte: Filter := FieldFilter.FieldName + ' = ' + FieldFilter.AsString;

        ftFloat, ftCurrency, ftBCD,
        ftFMTBcd, ftExtended, ftSingle: Filter := FieldFilter.FieldName + ' = ' + EdtValorPesquisa.Text;

        ftDate, ftTime, ftDateTime: Filter := FieldFilter.FieldName + ' = ' + EdtValorPesquisa.Text;
      end;
      TClientDataSet(dsAutoForm.DataSet).Filter := Filter;
      TClientDataSet(dsAutoForm.DataSet).Filtered := true;
    end;
  end;
end;


procedure TfrmBaseAutoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DsAutoForm.DataSet.Close;
  Action      := Cafree;
  FrmBaseAutoForm := nil;
end;

procedure TfrmBaseAutoForm.FormCreate(Sender: TObject);
begin
  inherited;
  dsAutoForm.DataSet.AfterScroll := doAfterScroll;
end;

procedure TfrmBaseAutoForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
    begin
      if (dsAutoForm.State in [dsInsert, dsEdit]) then
      begin
        if MessageDlg('Deseja cancelar a operação em andamento?',mtConfirmation,mbYesNo,0) = mrYes then
          begin
            TClientDataSet(dsAutoForm.DataSet).CancelUpdates;
            Pc.ActivePage:= TbConsulta;
          end;
      end
      else
        inherited;
    end;
    VK_RETURN: inherited;
  end;
end;

procedure TfrmBaseAutoForm.SetConexao(const Value: TSQLConnection);
begin
  FConexao := Value;
end;

procedure TfrmBaseAutoForm.GradeTitleClick(Column: TColumn);
begin
  TClientDataSet(DsAutoForm.DataSet).IndexFieldNames := Column.FieldName;
end;

procedure TfrmBaseAutoForm.JvDBGrid1DblClick(Sender: TObject);
begin
  inherited;
  Pc.ActivePage := TbCadastro;

end;

procedure TfrmBaseAutoForm.Ac_IncluirUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=
                not (dsAutoForm.DataSet.State in [dsInsert, dsEdit]);
end;

procedure TfrmBaseAutoForm.Ac_ConfirmarUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=
               (dsAutoForm.DataSet.State in [dsInsert, dsEdit]);
end;

end.
