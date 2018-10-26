unit fDataMapping;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DB;

type
  TFrmDataMapping = class(TForm)
    panLeft: TPanel;
    vleOffMapping: TValueListEditor;
    panRigth: TPanel;
    vleOnMapping: TValueListEditor;
    btnMappingOff: TButton;
    btnMappingOn: TButton;
    procedure btnMappingOffClick(Sender: TObject);
    procedure btnMappingOnClick(Sender: TObject);
  private
    function GetFieldType(Value: TFieldType): String;
    procedure GetFieldsProperties(List: TValueListEditor);
    procedure ClearMapRules;
    procedure SetMapRules;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDataMapping: TFrmDataMapping;

implementation

{$R *.dfm}

uses dDataMapping, FireDAC.Stan.Intf;

procedure TFrmDataMapping.btnMappingOffClick(Sender: TObject);
begin
  vleOffMapping.Strings.Clear;

  DMDataMapping.Connection.Connected := False;
  ClearMapRules;
  DMDataMapping.Connection.Connected := True;

  GetFieldsProperties(vleOffMapping);
end;

function TFrmDataMapping.GetFieldType(Value: TFieldType): String;
begin
  case Value of
    ftSmallint:   Result := 'ftSmallint';
    ftInteger:    Result := 'ftInteger';
    ftFloat:      Result := 'ftFloat';
    ftCurrency:   Result := 'ftCurrency';
    ftBCD:        Result := 'ftBCD';
    ftLargeint:   Result := 'ftLargeint';
    ftFMTBcd:     Result := 'ftFMTBcd';
    ftShortint:   Result := 'ftShortint';
    ftByte:       Result := 'ftByte';
    ftExtended:   Result := 'ftExtended';
  end;
end;

procedure TFrmDataMapping.btnMappingOnClick(Sender: TObject);
begin
  vleOnMapping.Strings.Clear;

  DMDataMapping.Connection.Connected := False;
  SetMapRules;
  DMDataMapping.Connection.Connected := True;

  GetFieldsProperties(vleOnMapping);
end;

procedure TFrmDataMapping.GetFieldsProperties(List: TValueListEditor);
var
  I: Integer;
begin
  DMDataMapping.Query.Open;
  for I := 0 to DMDataMapping.Query.FieldCount - 1 do
    List.Strings.Add(DMDataMapping.Query.Fields[I].FieldName + '=' +
                     GetFieldType(DMDataMapping.Query.Fields[I].DataType));
end;

procedure TFrmDataMapping.ClearMapRules;
begin
  DMDataMapping.Connection.FormatOptions.MapRules.Clear;
end;

procedure TFrmDataMapping.SetMapRules;
begin
  ClearMapRules;
  with DMDataMapping.Connection.FormatOptions do
  begin
    with MapRules.Add do begin
      SourceDataType := dtInt16;
      TargetDataType := dtInt64;
    end;
    with MapRules.Add do begin
      SourceDataType := dtInt32;
      TargetDataType := dtInt64;
    end;
    with MapRules.Add do begin
      ScaleMin := 4;
      ScaleMax := 4;
      PrecMin := 18;
      PrecMax := 18;
      SourceDataType := dtBcd;
      TargetDataType := dtCurrency;
    end;
    with MapRules.Add do begin
      ScaleMin := 6;
      ScaleMax := 6;
      PrecMin := 18;
      PrecMax := 18;
      SourceDataType := dtFmtBCD;
      TargetDataType := dtCurrency;
    end;
  end;
end;

end.
