unit dmDatabase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase,
  FireDAC.VCLUI.Login, Inifiles;

type
  TdtmdDatabase = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryCategory: TFDQuery;
    qryMedicine: TFDQuery;
    qryMedicineCategories: TFDQuery;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    FDStoredProc1: TFDStoredProc;
    dsCategory: TDataSource;
    FDStoredProc1NEWID: TIntegerField;
    qryMedicineCategoriesCATEGORY_ID: TIntegerField;
    qryMedicineCategoriesMEDICINE_ID: TIntegerField;
    qryMedicineCategoriesMEDICINE_NAME: TStringField;
    procedure FDConnectionAfterConnect(Sender: TObject);
    procedure qryCategoryNewRecord(DataSet: TDataSet);
    procedure qryMedicineNewRecord(DataSet: TDataSet);
    procedure qryMedicineCategoriesNewRecord(DataSet: TDataSet);
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    function GetID: Integer;
  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TdtmdDatabase.FDConnectionAfterConnect(Sender: TObject);
begin
  qryCategory.Open();
  qryMedicine.Open();
  qryMedicineCategories.Open();
end;

procedure TdtmdDatabase.FDConnectionBeforeConnect(Sender: TObject);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PharmacyApp.Ini');
  try
    FDConnection.Params.Database := INI.ReadString('Database', 'Remote',
      '127.0.0.1:c:\data\medicines.ib');
  finally
    INI.Free;
  end;
end;

function TdtmdDatabase.GetID: Integer;
begin
  FDStoredProc1.ExecProc;
  Result := FDStoredProc1.Params[0].AsInteger;
end;

procedure TdtmdDatabase.qryCategoryNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('CATEGORY_ID').AsInteger := GetID;
end;

procedure TdtmdDatabase.qryMedicineCategoriesNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('MEDICINE_ID').AsInteger :=
    qryMedicine.FieldByName('MEDICINE_ID').AsInteger;
  DataSet.Post;
end;

procedure TdtmdDatabase.qryMedicineNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('MEDICINE_ID').AsInteger := GetID;
end;

end.
