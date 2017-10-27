unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.CDataSalesforce, FireDAC.Phys.CDataSalesforceDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TMainForm = class(TForm)
    DBGrid1: TDBGrid;
    CdatasfConnection: TFDConnection;
    ContactTable: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysCDataSalesforceDriverLink1: TFDPhysCDataSalesforceDriverLink;
    DataSource1: TDataSource;
    ContactTableId: TWideStringField;
    ContactTableIsDeleted: TBooleanField;
    ContactTableMasterRecordId: TWideStringField;
    ContactTableAccountId: TWideStringField;
    ContactTableLastName: TWideStringField;
    ContactTableFirstName: TWideStringField;
    ContactTableSalutation: TWideStringField;
    ContactTableName: TWideStringField;
    ContactTableOtherStreet: TWideStringField;
    ContactTableOtherCity: TWideStringField;
    ContactTableOtherState: TWideStringField;
    ContactTableOtherPostalCode: TWideStringField;
    ContactTableOtherCountry: TWideStringField;
    ContactTableOtherLatitude: TFloatField;
    ContactTableOtherLongitude: TFloatField;
    ContactTableOtherGeocodeAccuracy: TWideStringField;
    ContactTableMailingStreet: TWideStringField;
    ContactTableMailingCity: TWideStringField;
    ContactTableMailingState: TWideStringField;
    ContactTableMailingPostalCode: TWideStringField;
    ContactTableMailingCountry: TWideStringField;
    ContactTableMailingLatitude: TFloatField;
    ContactTableMailingLongitude: TFloatField;
    ContactTableMailingGeocodeAccuracy: TWideStringField;
    ContactTablePhone: TWideStringField;
    ContactTableFax: TWideStringField;
    ContactTableMobilePhone: TWideStringField;
    ContactTableHomePhone: TWideStringField;
    ContactTableOtherPhone: TWideStringField;
    ContactTableAssistantPhone: TWideStringField;
    ContactTableReportsToId: TWideStringField;
    ContactTableEmail: TWideStringField;
    ContactTableTitle: TWideStringField;
    ContactTableDepartment: TWideStringField;
    ContactTableAssistantName: TWideStringField;
    ContactTableLeadSource: TWideStringField;
    ContactTableBirthdate: TSQLTimeStampField;
    ContactTableDescription: TWideMemoField;
    ContactTableOwnerId: TWideStringField;
    ContactTableCreatedDate: TSQLTimeStampField;
    ContactTableCreatedById: TWideStringField;
    ContactTableLastModifiedDate: TSQLTimeStampField;
    ContactTableLastModifiedById: TWideStringField;
    ContactTableSystemModstamp: TSQLTimeStampField;
    ContactTableLastActivityDate: TSQLTimeStampField;
    ContactTableLastCURequestDate: TSQLTimeStampField;
    ContactTableLastCUUpdateDate: TSQLTimeStampField;
    ContactTableLastViewedDate: TSQLTimeStampField;
    ContactTableLastReferencedDate: TSQLTimeStampField;
    ContactTableEmailBouncedReason: TWideStringField;
    ContactTableEmailBouncedDate: TSQLTimeStampField;
    ContactTableIsEmailBounced: TBooleanField;
    ContactTablePhotoUrl: TWideStringField;
    ContactTableJigsaw: TWideStringField;
    ContactTableJigsawContactId: TWideStringField;
    ContactTableCleanStatus: TWideStringField;
    ContactTableLevel__c: TWideStringField;
    ContactTableLanguages__c: TWideStringField;
    Panel1: TPanel;
    SpeedButton3: TSpeedButton;
    DBNavigator1: TDBNavigator;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  ContactTable.ApplyUpdates(-1);
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  ContactTable.CancelUpdates;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
  ContactTable.Close;
  ContactTable.Open;
end;

end.
