unit uFrmAutoForm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBaseAutoForm, FMTBcd, DB, DBClient, Provider, SqlExpr,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, SimpleDS, ComCtrls,
  ToolWin, ImgList, ActnList, WideStrings, DBXFirebird,
  uDM, System.ImageList, System.Actions;

const
  MARGIN = 10;

type
  TDefaultValue = record
    FieldName: string;
    DefaultValue: Variant;
  end;

  TTipoFloat = (tfFloat, tfBCD, tfFMTBCD, tfCurrency, tfExtended, tfSingle);

type
  TfrmAutoForm = class(TfrmBaseAutoForm)
    sdsMetaData: TSimpleDataSet;
    sqAutoForm: TSQLDataSet;
    dspAutoForm: TDataSetProvider;
    cdsAutoForm: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure cdsAutoFormNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Ac_ConfirmarExecute(Sender: TObject);
  private
    { Private declarations }
    FTableDisplayName: string;
    FKeyField: string;
    FCurHeight: Integer;
    FCurWidth: Integer;
    FMaxHeight: Integer;
    FDefaultValues: array of TDefaultValue;
    procedure AddKeyField(const KeyField: string; const ToDataSet: TDataSet);
    procedure SetUpWithReadMetaData(const Field: TField);
    procedure AddControl(const Control: TControl; const DisplayLabel: string);
    function InternalAddStringField(const FieldName, DisplayFieldName: string;
                                 DisplayWidth: Integer; const ToDataSet: TDataSet; Mascara: String = ''; SetFcous: Boolean = False): TControl;
    function InternalAddDateField(const FieldName, DisplayFieldName: string;
                                   const ToDataSet: TDataSet): TControl;
    function InternalAddFloatField(const FieldName, DisplayFieldName: string;
                                   DisplayWidth: Integer; const ToDataSet: TDataSet; TipoFloat: TTipoFloat; Currency: Boolean = False): TControl;
    function InternalAddIntegerField(const FieldName, DisplayFieldName: string;
                                   DisplayWidth: Integer; const ToDataSet: TDataSet): TControl;
    function InternalAddMemoField(const FieldName, DisplayFieldName: string;
                                   DisplayWidth, DisplayHeight: Integer; const ToDataSet: TDataSet;
                                   StringField: Boolean = False): TControl;
    function InternalAddTimeField(const FieldName, DisplayFieldName: string;
                                   const ToDataSet: TDataSet): TControl;
    function InternalAddLookupField(const FieldName, DisplayFieldName, KeyField,
                                   ListField, SQL: string; DisplayWidth: Integer;
                                   const ToDataSet: TDataSet): TControl;overload;
    function InternalAddLookupField(const FieldName, DisplayFieldName, KeyField,
                                   ListField, SQL: string; DisplayWidth: Integer;
                                   const ToDataSet: TDataSet;Dominio: Boolean): TControl;overload;
    function CreateStringControl(const Field: TField; SetFcous: Boolean = False): TControl;
    function CreateDateControl(const Field: TField): TControl;
    function CreateFloatControl(const Field: TField): TControl;
    function CreateIntegerControl(const Field: TField): TControl;
    function CreateMemoControl(const Field: TField; DisplayHeight: Integer): TControl;
    function CreateTimeControl(const Field: TField): TControl;
    function CreateComboControl(const Sql, DisplayFieldName: string;
                                 DisplayWidth: Integer): TControl;
    function CreateLookupControl(const Field: TField; const KeyField, ListField,
                                 SQL: string): TControl;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const TableName, TableDisplayName,
                            KeyField, Filter: string); reintroduce; overload;
    constructor Create(AOwner: TComponent; const SQL, TableDisplayName,
                            KeyField: string); reintroduce; overload;
    function GetDisplayName: string;override;
    function GetKeyField: string;override;
    procedure SetDefaultValue(const FieldName: string; const Value: Variant);
    procedure SetLookUpValue(const KeyField: string; const KeyValue: Variant);
    function AddStringField(const FieldName, DisplayFieldName: string;
                             DisplayWidth: Integer; Mascara: String = ''; SetFocus: Boolean = False): TControl;
    function AddIntegerField(const FieldName, DisplayFieldName: string;
                             DisplayWidth: Integer): TControl;
    function AddFloatField(const FieldName, DisplayFieldName: string;
                             DisplayWidth: Integer; TipoFloat: TTipoFloat; Currency: Boolean = False):  TControl;
    function AddMemoField(const FieldName, DisplayFieldName: string;
                             DisplayWidth, DisplayHeight: Integer): TControl;overload;
    function AddMemoField(const FieldName, DisplayFieldName: string;
                             DisplayWidth, DisplayHeight: Integer; StringField: Boolean): TControl;overload;
    function AddDateField(const FieldName, DisplayFieldName: string): TControl;
    function AddTimeField(const FieldName, DisplayFieldName: string): TControl;
    function AddComboBox(const Sql, DisplayFieldName: string;
                             DisplayWidth: Integer): TControl;
    function AddLookupField(const FieldName, DisplayFieldName, KeyField,
                             ListField, SQL: string; DisplayWidth: Integer): TControl; overload;
    function AddLookupField(const FieldName, DisplayFieldName, KeyField,
                             ListField, SQL: string; DisplayWidth: Integer; Dominio:Boolean) :TControl; overload;

    function AddSpace(DisplayWidth: Integer): TControl;
  end;

var
  frmAutoForm: TfrmAutoForm;

implementation


{$R *.dfm}

{ TfrmAutoForm }

constructor TfrmAutoForm.Create(AOwner: TComponent; const TableName,
  TableDisplayName, KeyField, Filter: string);
var
  ASql: string;
begin
  ASql := 'select * from ' + TableName;

  if Filter <> '' then
    ASql := ASql + ' where ' + Filter;

  Self.Create(AOwner, ASql, TableDisplayName, KeyField);
end;

constructor TfrmAutoForm.Create(AOwner: TComponent; const SQL,
  TableDisplayName, KeyField: string);
begin
  inherited Create(AOwner);

  FKeyField := KeyField;
  FTableDisplayName := TableDisplayName;

  sqAutoForm.CommandText := SQL;

  sdsMetaData.DataSet.CommandText := SQL;
  sdsMetaData.Open;

  AddKeyField(KeyField, sqAutoForm);
  AddKeyField(KeyField, cdsAutoForm);

  FCurHeight := MARGIN;
  FCurWidth := MARGIN;
  FMaxHeight := MARGIN;
end;

function TfrmAutoForm.CreateComboControl(const Sql, DisplayFieldName: string;
  DisplayWidth: Integer): TControl;
var
  AControl: TComboBox;
  ASql: TSimpleDataSet;
begin
  AControl := TComboBox.Create(Self);
  AControl.Width := DisplayWidth * 6;
  AControl.BevelKind := bkFlat;
  AControl.Height := 24;
  ASql := TSimpleDataSet.Create(Self);
  { TODO 5 -oRodrigo -cMelhorias : Chamar Singleton Aqui }
  ASql.Connection := DM.DBConn;
  ASql.DataSet.CommandText := Sql;
  ASql.Open;
  ASql.First;
  AControl.Parent := pnlControls;
  while not ASql.Eof do
  begin
    AControl.Items.Add(ASql.Fields[0].AsString);
    ASql.Next;
  end;
  AddControl(AControl, DisplayFieldName);
  Result := AControl;
end;

function TfrmAutoForm.GetKeyField: string;
begin
  Result := FKeyField;
end;

function TfrmAutoForm.GetDisplayName: string;
begin
  Result := FTableDisplayName;
end;

procedure TfrmAutoForm.AddKeyField(const KeyField: string; const ToDataSet: TDataSet);
var
  AddedKeyField: TField;
begin
  AddedKeyField := TIntegerField.Create(ToDataSet);
  AddedKeyField.FieldName := KeyField;
  AddedKeyField.Visible := False;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;
end;

function TfrmAutoForm.AddLookupField(const FieldName, DisplayFieldName,
  KeyField, ListField, SQL: string; DisplayWidth: Integer; Dominio: Boolean): TControl;
begin
  InternalAddLookupField(FieldName, DisplayFieldName, KeyField, ListField, SQL,
    DisplayWidth, sqAutoForm, Dominio);
 Result := InternalAddLookupField(FieldName, DisplayFieldName, KeyField, ListField, SQL,
    DisplayWidth, cdsAutoForm, Dominio);

end;

function TfrmAutoForm.AddMemoField(const FieldName, DisplayFieldName: string;
  DisplayWidth, DisplayHeight: Integer; StringField: Boolean): TControl;
begin
  InternalAddMemoField(FieldName, DisplayFieldName, DisplayWidth, DisplayHeight, sqAutoForm, StringField);
  Result := InternalAddMemoField(FieldName, DisplayFieldName, DisplayWidth, DisplayHeight, cdsAutoForm, StringField);
end;

procedure TfrmAutoForm.SetUpWithReadMetaData(const Field: TField);
begin
  Field.Size     := sdsMetadata.FieldByName(Field.FieldName).Size;
  Field.Required := sdsMetadata.FieldByName(Field.FieldName).Required;

  if Field.FieldName = FKeyField then
  begin
    Field.ProviderFlags := [pfInWhere, pfInUpdate, pfInKey];
    //Field.Required := False;
  end
  else
    Field.ProviderFlags := [pfInUpdate];
end;

function TfrmAutoForm.AddSpace(DisplayWidth: Integer): TControl;
var
  AControl: TEdit;
begin
  AControl := TEdit.Create(Self);
  AControl.Visible := False;
  AControl.Width := DisplayWidth * 6;
  AddControl(AControl, '');
  Result := AControl;
end;

function TfrmAutoForm.AddStringField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer; Mascara: String = ''; SetFocus: Boolean = False): TControl;
begin
  InternalAddStringField(FieldName, DisplayFieldName, DisplayWidth, sqAutoForm);
  Result := InternalAddStringField(FieldName, DisplayFieldName, DisplayWidth, cdsAutoForm, Mascara, SetFocus);
end;

function TfrmAutoForm.InternalAddStringField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer; const ToDataSet: TDataSet; Mascara: String = ''; SetFcous: Boolean = False): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;

  AddedKeyField := TStringField.Create(ToDataSet);
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
  begin
    Result := CreateStringControl(AddedKeyField,SetFcous);
    AddedKeyField.EditMask := Mascara;
  end;
end;

function TfrmAutoForm.CreateStringControl(const Field: TField; SetFcous: Boolean = False): TControl;
var
  AControl: TDBEdit;
begin
  AControl := nil;
  AControl := TDBEdit.Create(Self);
  AControl.Width := Field.DisplayWidth * 6;
  AControl.DataSource := dsAutoForm;
  AControl.DataField := Field.FieldName;
  AControl.BevelKind := bkFlat;
  AControl.BorderStyle := bsNone;
  AControl.Height := 24;
  if SetFcous then AControl.Tag := 99;
  AddControl(AControl, Field.DisplayLabel);
  Result := AControl;
end;

procedure TfrmAutoForm.Ac_ConfirmarExecute(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  for I := 0 to cdsAutoForm.FieldCount - 1 do
  begin
    if cdsAutoForm.Fields[I].FieldKind = fkLookup then
    begin
      cdsAutoForm.Fields[I].LookupDataSet.Refresh;
    end;
  end;
end;

function TfrmAutoForm.AddComboBox(const Sql, DisplayFieldName: string;
  DisplayWidth: Integer): TControl;
begin
  Result := CreateComboControl(Sql,DisplayFieldName,DisplayWidth);
end;

procedure TfrmAutoForm.AddControl(const Control: TControl;
  const DisplayLabel: string);
const
  BETWEEN_CONTROL_AND_LABEL = 3;
  BETWEEN_CONTROLS_Y = 8;
  BETWEEN_CONTROLS_X = 10;
var
  ALabel: TLabel;
  ATempMax: Integer;
begin
  ALabel := TLabel.Create(Self);
  ALabel.Caption := DisplayLabel;

  if Control.Width < ALabel.Width then
    Control.Width := ALabel.Width;

  if (FCurWidth + Control.Width + MARGIN) > pnlControls.Width then
  begin
    FCurHeight := FMaxHeight - MARGIN + BETWEEN_CONTROLS_Y;
    FCurWidth := MARGIN;
  end;

  ALabel.Parent := pnlControls;
  ALabel.Left := FCurWidth;
  ALabel.Top := FCurHeight;

  Control.Parent := pnlControls;
  Control.Left := FCurWidth;
  if DisplayLabel = '' then
  begin
    Control.Top := FCurHeight;
    ALabel.Height := 0;
  end
  else
    Control.Top := FCurHeight + ALabel.Height + BETWEEN_CONTROL_AND_LABEL;

  ATempMax := Control.Top + Control.Height + MARGIN;
  if ATempMax > FMaxHeight then
    FMaxHeight := ATempMax;

  Inc(FCurWidth, Control.Width + BETWEEN_CONTROLS_X);
end;

function TfrmAutoForm.AddIntegerField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer): TControl;
begin
  InternalAddIntegerField(FieldName, DisplayFieldName, DisplayWidth, sqAutoForm);
  Result := InternalAddIntegerField(FieldName, DisplayFieldName, DisplayWidth, cdsAutoForm);
end;

function TfrmAutoForm.AddFloatField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer; TipoFloat: TTipoFloat; Currency: Boolean = False): TControl;
begin
  InternalAddFloatField(FieldName, DisplayFieldName, DisplayWidth, sqAutoForm, TipoFloat);
  Result := InternalAddFloatField(FieldName, DisplayFieldName, DisplayWidth, cdsAutoForm, TipoFloat, Currency);
end;

function TfrmAutoForm.AddMemoField(const FieldName,
  DisplayFieldName: string; DisplayWidth, DisplayHeight: Integer): TControl;
begin
  InternalAddMemoField(FieldName, DisplayFieldName, DisplayWidth, DisplayHeight, sqAutoForm);
  Result := InternalAddMemoField(FieldName, DisplayFieldName, DisplayWidth, DisplayHeight, cdsAutoForm);
end;

function TfrmAutoForm.AddDateField(const FieldName,
  DisplayFieldName: string): TControl;
begin
  InternalAddDateField(FieldName, DisplayFieldName, sqAutoForm);
  Result := InternalAddDateField(FieldName, DisplayFieldName, cdsAutoForm);
end;

function TfrmAutoForm.AddTimeField(const FieldName,
  DisplayFieldName: string): TControl;
begin
  InternalAddTimeField(FieldName, DisplayFieldName, sqAutoForm);
  Result := InternalAddTimeField(FieldName, DisplayFieldName, cdsAutoForm);
end;

function TfrmAutoForm.InternalAddIntegerField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer; const ToDataSet: TDataSet): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;
  AddedKeyField := TIntegerField.Create(ToDataSet);
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
    Result := CreateIntegerControl(AddedKeyField);
end;

function TfrmAutoForm.InternalAddLookupField(const FieldName, DisplayFieldName,
  KeyField, ListField, SQL: string; DisplayWidth: Integer;
  const ToDataSet: TDataSet; Dominio: Boolean): TControl;
var
  AddedKeyField: TField;
  AControl: TDBLookupComboBox;
begin
  Result := nil;
  AddedKeyField := TStringField.Create(ToDataSet);
  AddedKeyField.Visible := False;
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;
  if ToDataSet = cdsAutoForm then
  begin
    AControl := (CreateLookupControl(AddedKeyField, KeyField, ListField, SQL) as TDBLookupComboBox);

    AddedKeyField := TStringField.Create(ToDataSet);
    AddedKeyField.FieldKind := fkLookup;
    AddedKeyField.FieldName := 'LOOKUP' + ListField+FieldName;
    AddedKeyField.DisplayLabel := DisplayFieldName;
    AddedKeyField.DisplayWidth := DisplayWidth;
    AddedKeyField.Size := AControl.ListSource.DataSet.FieldByName(ListField).Size;
    AddedKeyField.LookupDataSet := AControl.ListSource.DataSet;
    AddedKeyField.LookupKeyFields := KeyField;
    AddedKeyField.LookupResultField := ListField;
    AddedKeyField.KeyFields := FieldName;
    AddedKeyField.Lookup := True;
    AddedKeyField.DataSet := ToDataSet;
  end;
  Result := AControl;
end;

function TfrmAutoForm.CreateIntegerControl(const Field: TField): TControl;
begin
  Result := CreateStringControl(Field);
end;

function TfrmAutoForm.InternalAddFloatField(const FieldName,
  DisplayFieldName: string; DisplayWidth: Integer; const ToDataSet: TDataSet; TipoFloat: TTipoFloat; Currency: Boolean = False): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;
  case TipoFloat of
    tfFloat:    AddedKeyField := TFloatField.Create(ToDataSet);
    tfBCD:      AddedKeyField := TBCDField.Create(ToDataSet);
    tfFMTBCD:   AddedKeyField := TFMTBCDField.Create(ToDataSet);
    tfCurrency: AddedKeyField := TCurrencyField.Create(ToDataSet);
    tfExtended: AddedKeyField := TExtendedField.Create(ToDataSet);
    tfSingle:   AddedKeyField := TSingleField.Create(ToDataSet);
  end;

  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
  begin
    Result := CreateFloatControl(AddedKeyField);
    TFloatField(AddedKeyField).Currency := Currency;
  end;
end;

function TfrmAutoForm.CreateFloatControl(const Field: TField): TControl;
begin
  Result := CreateStringControl(Field);
end;

function TfrmAutoForm.InternalAddMemoField(const FieldName,
  DisplayFieldName: string; DisplayWidth, DisplayHeight: Integer;
    const ToDataSet: TDataSet; StringField: Boolean = False): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;
  if StringField then
    AddedKeyField := TStringField.Create(ToDataSet)
  else
    AddedKeyField := TMemoField.Create(ToDataSet);
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
    Result := CreateMemoControl(AddedKeyField, DisplayHeight);
end;

function TfrmAutoForm.CreateMemoControl(const Field: TField; DisplayHeight: Integer): TControl;
var
  AControl: TDBMemo;
begin
  AControl := TDBMemo.Create(Self);
  AControl.Width := pnlControls.Width - (MARGIN * 2);
  AControl.Height := DisplayHeight;
  AControl.DataSource := dsAutoForm;
  AControl.DataField := Field.FieldName;
  AControl.ScrollBars := ssVertical;
  AControl.WantReturns := True;
  AControl.BevelKind := bkFlat;
  AControl.BorderStyle := bsNone;
  AddControl(AControl, Field.DisplayLabel);
  Result := AControl;
end;

function TfrmAutoForm.InternalAddDateField(const FieldName,
  DisplayFieldName: string; const ToDataSet: TDataSet): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;
  AddedKeyField := TDateField.Create(ToDataSet);
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := 15;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
    Result := CreateDateControl(AddedKeyField);
end;

function TfrmAutoForm.CreateDateControl(const Field: TField): TControl;
begin
  Field.EditMask := '!99/99/9999;1;_';
  Result := CreateStringControl(Field);
end;

function TfrmAutoForm.InternalAddTimeField(const FieldName,
  DisplayFieldName: string; const ToDataSet: TDataSet): TControl;
var
  AddedKeyField: TField;
begin
  Result := nil;
  AddedKeyField := TTimeField.Create(ToDataSet);
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
    Result := CreateTimeControl(AddedKeyField);
end;

function TfrmAutoForm.CreateTimeControl(const Field: TField): TControl;
begin
  Field.EditMask := '!99:99;1;_';
  Result := CreateStringControl(Field);
end;

function TfrmAutoForm.AddLookupField(const FieldName, DisplayFieldName,
  KeyField, ListField, SQL: string; DisplayWidth: Integer): TControl;
begin
  InternalAddLookupField(FieldName, DisplayFieldName, KeyField, ListField, SQL,
    DisplayWidth, sqAutoForm);
  Result := InternalAddLookupField(FieldName, DisplayFieldName, KeyField, ListField, SQL,
    DisplayWidth, cdsAutoForm);
end;

function TfrmAutoForm.InternalAddLookupField(const FieldName, DisplayFieldName,
  KeyField, ListField, SQL: string; DisplayWidth: Integer;
  const ToDataSet: TDataSet): TControl;
var
  AddedKeyField: TField;
  AControl: TDBLookupComboBox;
begin
  Result := nil;
  AddedKeyField := TIntegerField.Create(ToDataSet);
  AddedKeyField.Visible := False;
  AddedKeyField.FieldName := FieldName;
  AddedKeyField.DisplayLabel := DisplayFieldName;
  AddedKeyField.DisplayWidth := DisplayWidth;
  SetUpWithReadMetaData(AddedKeyField);
  AddedKeyField.DataSet := ToDataSet;

  if ToDataSet = cdsAutoForm then
  begin
    AControl := (CreateLookupControl(AddedKeyField, KeyField, ListField, SQL) as TDBLookupComboBox);

    AddedKeyField := TStringField.Create(ToDataSet);
    AddedKeyField.FieldKind := fkLookup;
    AddedKeyField.FieldName := 'LOOKUP'+ListField+FieldName;
    AddedKeyField.DisplayLabel := DisplayFieldName;
    AddedKeyField.DisplayWidth := DisplayWidth;
    AddedKeyField.Size := AControl.ListSource.DataSet.FieldByName(ListField).Size;
    AddedKeyField.LookupDataSet := AControl.ListSource.DataSet;
    AddedKeyField.LookupKeyFields := KeyField;
    AddedKeyField.LookupResultField := ListField;
    AddedKeyField.KeyFields := FieldName;
    AddedKeyField.Lookup := True;
    AddedKeyField.DataSet := ToDataSet;
  end;
  Result := AControl;
end;

function TfrmAutoForm.CreateLookupControl(const Field: TField;
  const KeyField, ListField, SQL: string): TControl;
var
  AListSource: TDataSource;
  ADataSet: TSimpleDataSet;
  AControl: TDBLookupComboBox;
begin
  AListSource := TDataSource.Create(Self);
  ADataSet := TSimpleDataSet.Create(Self);
  { TODO 5 -oRodrigo -cMelhorias : Chamar Singleton Aqui }
  ADataSet.Connection := DM.DBConn;
  ADataSet.DataSet.CommandText := SQL;
  ADataSet.Open;

  AListSource.DataSet := ADataSet;

  AControl := TDBLookupComboBox.Create(Self);
  AControl.Parent := pnlControls;
  AControl.Width := Field.DisplayWidth * 6;
  AControl.KeyField := KeyField;
  AControl.ListField := ListField;
  AControl.ListSource := AListSource;
  AControl.DataSource := dsAutoForm;
  AControl.DataField := Field.FieldName;
  AControl.BevelKind := bkFlat;
  AControl.Height := 24;
  AddControl(AControl, Field.DisplayLabel);

  Result := AControl;
end;

procedure TfrmAutoForm.SetDefaultValue(const FieldName: string;
  const Value: Variant);
begin
  SetLength(FDefaultValues, Length(FDefaultValues) + 1);
  FDefaultValues[High(FDefaultValues)].FieldName := FieldName;
  FDefaultValues[High(FDefaultValues)].DefaultValue := Value;
end;

procedure TfrmAutoForm.SetLookUpValue(const KeyField: string;
  const KeyValue: Variant);
var
  sdsKeyField, cdsKeyField: TField;
begin
  sdsKeyField := TIntegerField.Create(sqAutoForm);
  sdsKeyField.FieldName := KeyField;
  SetUpWithReadMetaData(sdsKeyField);
  sdsKeyField.DataSet := sqAutoForm;

  cdsKeyField := TIntegerField.Create(cdsAutoForm);
  cdsKeyField.FieldName := KeyField;
  SetUpWithReadMetaData(cdsKeyField);
  cdsKeyField.DataSet := cdsAutoForm;

  SetDefaultValue(KeyField,KeyValue);
end;

procedure TfrmAutoForm.FormCreate(Sender: TObject);
begin
  inherited;
  //sdsMetaData.Connection := Conexao;
  { TODO 5 -oRodrigo -cMelhorias : Chamar Singleton Aqui }
  sdsMetaData.Connection := DM.DBConn;
end;

procedure TfrmAutoForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  pnlControls.Height := FMaxHeight;
  for i := 0 to pnlControls.ControlCount - 1 do
  begin
    if pnlControls.Controls[i] is TWinControl then
    begin
      //ActiveControl := (pnlControls.Controls[i] as TWinControl);
      Break;
    end;
  end;
end;

procedure TfrmAutoForm.cdsAutoFormNewRecord(DataSet: TDataSet);
var
  I: Integer;
begin
  inherited;
  for I := 0 to Length(FDefaultValues)-1 do
  begin
    cdsAutoForm.FindField(FDefaultValues[I].FieldName).Value :=
       FDefaultValues[I].DefaultValue;
  end;
end;

end.
