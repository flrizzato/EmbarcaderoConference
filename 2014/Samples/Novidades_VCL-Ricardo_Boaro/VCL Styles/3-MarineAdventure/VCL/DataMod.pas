unit DataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Variants, VarUtils, UITypes,
  SQLTimSt, Data.DBXInterBase, Data.SqlExpr, Data.FMTBcd, Datasnap.DBClient,
  Datasnap.Provider;

type
  TClientDataSetArray = Array of TClientDataSet;

  TMastData = class(TDataModule)
    tbParts: TSQLTable;
    tbPartsPartNo: TFloatField;
    tbPartsDescription: TStringField;
    tbPartsOnHand: TFloatField;
    tbPartsOnOrder: TFloatField;
    qryPartsQuery: TSQLQuery;
    qryPartsQueryPartNo: TFloatField;
    qryPartsQueryDescription: TStringField;
    qryPartsQueryOnHand: TFloatField;
    qryPartsQueryOnOrder: TFloatField;
    tbVendors: TSQLTable;
    tbPartsVendorNo: TFloatField;
    tbPartsCost: TCurrencyField;
    tbPartsListPrice: TCurrencyField;
    qryPartsQueryVendorNo: TFloatField;
    qryPartsQueryCost: TCurrencyField;
    qryPartsQueryListPrice: TCurrencyField;
    tbOrders: TSQLTable;
    tbOrdersOrderNo: TFloatField;
    tbOrdersCustNo: TFloatField;
    tbOrdersSaleDate: TSQLTimeStampField;
    tbOrdersShipDate: TSQLTimeStampField;
    tbOrdersShipToContact: TStringField;
    tbOrdersShipToAddr1: TStringField;
    tbOrdersShipToAddr2: TStringField;
    tbOrdersShipToCity: TStringField;
    tbOrdersShipToState: TStringField;
    tbOrdersShipToZip: TStringField;
    tbOrdersShipToCountry: TStringField;
    tbOrdersShipToPhone: TStringField;
    tbOrdersShipVIA: TStringField;
    tbOrdersPO: TStringField;
    tbOrdersEmpNo: TIntegerField;
    tbOrdersTerms: TStringField;
    tbOrdersPaymentMethod: TStringField;
    tbOrdersItemsTotal: TCurrencyField;
    tbOrdersTaxRate: TFloatField;
    tbOrdersFreight: TCurrencyField;
    tbOrdersAmountPaid: TCurrencyField;
    tbCustByOrd: TSQLTable;
    tbCustByOrdCustNo: TFloatField;
    tbCustByOrdCompany: TStringField;
    tbCustByOrdAddr1: TStringField;
    tbCustByOrdAddr2: TStringField;
    tbCustByOrdCity: TStringField;
    tbCustByOrdState: TStringField;
    tbCustByOrdZip: TStringField;
    tbCustByOrdCountry: TStringField;
    tbCustByOrdPhone: TStringField;
    tbCustByOrdFAX: TStringField;
    tbCustByOrdTaxRate: TFloatField;
    tbCustByOrdContact: TStringField;
    tbCustByOrdLastInvoiceDate: TSQLTimeStampField;
    tbItems: TSQLTable;
    tbItemsItemNo: TFloatField;
    tbItemsOrderNo: TFloatField;
    tbItemsDescription: TStringField;
    tbItemsSellPrice: TCurrencyField;
    tbItemsQty: TIntegerField;
    tbItemsDiscount: TFloatField;
    tbItemsExtPrice: TCurrencyField;
    tbEmps: TSQLTable;
    tbEmpsEmpNo: TIntegerField;
    tbEmpsLastName: TStringField;
    tbEmpsFirstName: TStringField;
    tbEmpsPhoneExt: TStringField;
    tbEmpsHireDate: TSQLTimeStampField;
    tbEmpsSalary: TFloatField;
    LastItemQuery: TSQLQuery;
    qryCust: TSQLTable;
    qryCustCustNo: TFloatField;
    qryCustCompany: TStringField;
    qryCustPhone: TStringField;
    qryCustLastInvoiceDate: TSQLTimeStampField;
    qryCustQuery: TSQLQuery;
    qryCustQueryCustNo: TFloatField;
    qryCustQueryCompany: TStringField;
    qryCustQueryPhone: TStringField;
    qryCustQueryLastInvoiceDate: TSQLTimeStampField;
    qryOrdByCust: TSQLTable;
    qryOrdByCustOrderNo: TFloatField;
    qryOrdByCustCustNo: TFloatField;
    qryOrdByCustSaleDate: TSQLTimeStampField;
    qryOrdByCustShipDate: TSQLTimeStampField;
    qryOrdByCustItemsTotal: TCurrencyField;
    qryOrdByCustTaxRate: TFloatField;
    qryOrdByCustFreight: TCurrencyField;
    qryOrdByCustAmountPaid: TCurrencyField;
    tbItemsPartNo: TFloatField;
    qryCustAddr1: TStringField;
    qryCustAddr2: TStringField;
    qryCustCity: TStringField;
    qryCustState: TStringField;
    qryCustZip: TStringField;
    qryCustCountry: TStringField;
    qryCustFAX: TStringField;
    qryCustTaxRate: TFloatField;
    qryCustContact: TStringField;
    qryCustByComp: TSQLTable;
    OrdersSource: TDataSource;
    CustByOrdSrc: TDataSource;
    ItemsSource: TDataSource;
    PartsSource: TDataSource;
    EmpsSource: TDataSource;
    VendorSource: TDataSource;
    CustSource: TDataSource;
    CustMasterSrc: TDataSource;
    OrdByCustSrc: TDataSource;
    CustByCompSrc: TDataSource;
    Database: TSQLConnection;
    dspOrders: TDataSetProvider;
    cdsOrders: TClientDataSet;
    cdsCustByOrd: TClientDataSet;
    dspCustByOrd: TDataSetProvider;
    cdsCustByOrdCUSTNO: TFloatField;
    cdsCustByOrdCOMPANY: TStringField;
    cdsCustByOrdADDR1: TStringField;
    cdsCustByOrdADDR2: TStringField;
    cdsCustByOrdCITY: TStringField;
    cdsCustByOrdSTATE: TStringField;
    cdsCustByOrdZIP: TStringField;
    cdsCustByOrdCOUNTRY: TStringField;
    cdsCustByOrdPHONE: TStringField;
    cdsCustByOrdFAX: TStringField;
    cdsCustByOrdTAXRATE: TFloatField;
    cdsCustByOrdCONTACT: TStringField;
    cdsCustByOrdLASTINVOICEDATE: TSQLTimeStampField;
    cdsOrdersORDERNO: TFloatField;
    cdsOrdersCUSTNO: TFloatField;
    cdsOrdersSALEDATE: TSQLTimeStampField;
    cdsOrdersSHIPDATE: TSQLTimeStampField;
    cdsOrdersSHIPTOCONTACT: TStringField;
    cdsOrdersSHIPTOADDR1: TStringField;
    cdsOrdersSHIPTOADDR2: TStringField;
    cdsOrdersSHIPTOCITY: TStringField;
    cdsOrdersSHIPTOSTATE: TStringField;
    cdsOrdersSHIPTOZIP: TStringField;
    cdsOrdersSHIPTOCOUNTRY: TStringField;
    cdsOrdersSHIPTOPHONE: TStringField;
    cdsOrdersSHIPVIA: TStringField;
    cdsOrdersPO: TStringField;
    cdsOrdersEMPNO: TIntegerField;
    cdsOrdersTERMS: TStringField;
    cdsOrdersPAYMENTMETHOD: TStringField;
    cdsOrdersITEMSTOTAL: TCurrencyField;
    cdsOrdersTAXRATE: TFloatField;
    cdsOrdersTAXTOTAL: TCurrencyField;
    cdsOrdersFREIGHT: TCurrencyField;
    cdsOrdersAMOUNTPAID: TCurrencyField;
    cdsOrdersAMOUNTDUE: TCurrencyField;
    cdsOrdersSALESPERSON: TStringField;
    dspItems: TDataSetProvider;
    dspParts: TDataSetProvider;
    dspEmps: TDataSetProvider;
    dspVendors: TDataSetProvider;
    cdsEmps: TClientDataSet;
    cdsEmpsEMPNO: TIntegerField;
    cdsEmpsFULLNAME: TStringField;
    cdsEmpsLASTNAME: TStringField;
    cdsEmpsFIRSTNAME: TStringField;
    cdsEmpsPHONEEXT: TStringField;
    cdsEmpsHIREDATE: TSQLTimeStampField;
    cdsEmpsSALARY: TFloatField;
    cdsItems: TClientDataSet;
    cdsItemsITEMNO: TFloatField;
    cdsItemsORDERNO: TFloatField;
    cdsItemsPARTNO: TFloatField;
    cdsItemsDESCRIPTION: TStringField;
    cdsItemsSELLPRICE: TCurrencyField;
    cdsItemsQTY: TIntegerField;
    cdsItemsDISCOUNT: TFloatField;
    cdsItemsEXTPRICE: TCurrencyField;
    cdsParts: TClientDataSet;
    cdsPartsPARTNO: TFloatField;
    cdsPartsDESCRIPTION: TStringField;
    cdsPartsVENDORNO: TFloatField;
    cdsPartsONHAND: TFloatField;
    cdsPartsONORDER: TFloatField;
    cdsPartsBACKORD: TBooleanField;
    cdsPartsCOST: TCurrencyField;
    cdsPartsLISTPRICE: TCurrencyField;
    cdsVendors: TClientDataSet;
    cdsCust: TClientDataSet;
    dspCust: TDataSetProvider;
    cdsCustCUSTNO: TFloatField;
    cdsCustCOMPANY: TStringField;
    cdsCustPHONE: TStringField;
    cdsCustLASTINVOICEDATE: TSQLTimeStampField;
    cdsCustADDR1: TStringField;
    cdsCustADDR2: TStringField;
    cdsCustCITY: TStringField;
    cdsCustSTATE: TStringField;
    cdsCustZIP: TStringField;
    cdsCustCOUNTRY: TStringField;
    cdsCustFAX: TStringField;
    cdsCustTAXRATE: TFloatField;
    cdsCustCONTACT: TStringField;
    dspCustbyComp: TDataSetProvider;
    cdsCustByComp: TClientDataSet;
    dspOrdByCust: TDataSetProvider;
    cdsOrdByCust: TClientDataSet;
    cdsOrdByCustORDERNO: TFloatField;
    cdsOrdByCustCUSTNO: TFloatField;
    cdsOrdByCustSALEDATE: TSQLTimeStampField;
    cdsOrdByCustSHIPDATE: TSQLTimeStampField;
    cdsOrdByCustITEMSTOTAL: TCurrencyField;
    cdsOrdByCustTAXRATE: TFloatField;
    cdsOrdByCustFREIGHT: TCurrencyField;
    cdsOrdByCustAMOUNTPAID: TCurrencyField;
    cdsOrdByCustAMOUNTDUE: TCurrencyField;
    dspPartsQuery: TDataSetProvider;
    cdsPartsQuery: TClientDataSet;
    cdsPartsQueryPARTNO: TFloatField;
    cdsPartsQueryDESCRIPTION: TStringField;
    cdsPartsQueryVENDORNO: TFloatField;
    cdsPartsQueryONHAND: TFloatField;
    cdsPartsQueryONORDER: TFloatField;
    cdsPartsQueryBACKORD: TBooleanField;
    cdsPartsQueryCOST: TCurrencyField;
    cdsPartsQueryLISTPRICE: TCurrencyField;
    cdsCustQuery: TClientDataSet;
    dspCustQuery: TDataSetProvider;
    cdsCustQueryCUSTNO: TFloatField;
    cdsCustQueryCOMPANY: TStringField;
    cdsCustQueryPHONE: TStringField;
    cdsCustQueryLASTINVOICEDATE: TSQLTimeStampField;
    qryGetNextCust: TSQLQuery;
    qryGetNextOrd: TSQLQuery;
    qryGetNextItem: TSQLQuery;
    procedure PartsBeforeOpen(DataSet: TDataSet);
    procedure PartsCalcFields(DataSet: TDataSet);
    procedure PartsQueryCalcFields(DataSet: TDataSet);
    procedure OrdersAfterCancel(DataSet: TDataSet);
    procedure OrdersAfterPost(DataSet: TDataSet);
    procedure OrdersBeforeCancel(DataSet: TDataSet);
    procedure OrdersBeforeClose(DataSet: TDataSet);
    procedure OrdersBeforeDelete(DataSet: TDataSet);
    procedure OrdersBeforeInsert(DataSet: TDataSet);
    procedure OrdersBeforeOpen(DataSet: TDataSet);
    procedure OrdersCalcFields(DataSet: TDataSet);
    procedure OrdersNewRecord(DataSet: TDataSet);
    procedure ItemsAfterDelete(DataSet: TDataSet);
    procedure ItemsAfterPost(DataSet: TDataSet);
    procedure EnsureOrdersEdit(DataSet: TDataSet);
    procedure ItemsBeforeEdit(DataSet: TDataSet);
    procedure ItemsBeforeOpen(DataSet: TDataSet);
    procedure ItemsBeforePost(DataSet: TDataSet);
    procedure ItemsCalcFields(DataSet: TDataSet);
    procedure ItemsNewRecord(DataSet: TDataSet);
    procedure EmpsCalcFields(DataSet: TDataSet);
    procedure OrdersCustNoChange(Sender: TField);
    procedure tbItemsQtyValidate(Sender: TField);
    procedure OrdersFreightValidate(Sender: TField);
    procedure tbItemsPartNoValidate(Sender: TField);
    procedure OrdersSaleDateValidate(Sender: TField);
    procedure CustBeforeOpen(DataSet: TDataSet);
    procedure OrdByCustCalcFields(DataSet: TDataSet);
    procedure CustBeforePost(DataSet: TDataSet);
    procedure OrdersAfterDelete(DataSet: TDataSet);
    procedure OrdersBeforeEdit(DataSet: TDataSet);
    procedure MastDataCreate(Sender: TObject);
  private
    PrevPartNo: Double;       { remembers Item's previous part# }
    PrevQty: Longint;         { remembers Item's previous qty }
    DeletingItems: Boolean;   { suppress totals calc. if deleting items }
    FItemNo: Integer;
    //procedure SetDatabaseAlias(AliasName: string);
    procedure UpdateTotals;
    procedure DeleteItems;
  public
    //procedure UseLocalData;
    //procedure UseRemoteData;
    function DataSetApplyUpdates(DataSet: TDataSet; Apply: Boolean): Boolean;
    procedure PostAndUpdateDataSets(DataSets : TClientDataSetArray);
  end;

// function Confirm(Msg: string): Boolean;  // moved to "Utils.pas"

var
  MastData: TMastData;

implementation

uses
  Utils;

{$R *.dfm}

//{ Utility Functions }
//
//function Confirm(Msg: string): Boolean;
//begin
//  Result := MessageDlg(Msg, mtConfirmation, mbYesNoCancel, 0) = mrYes;
//end;


{ Event Handlers }

procedure TMastData.PartsBeforeOpen(DataSet: TDataSet);
begin
  cdsVendors.Open;
end;

procedure TMastData.PartsCalcFields(DataSet: TDataSet);
begin
  cdsPartsBackOrd.Value := cdsPartsOnOrder.Value > cdsPartsOnHand.Value;
end;

procedure TMastData.PartsQueryCalcFields(DataSet: TDataSet);
begin
  cdsPartsQueryBackOrd.Value := cdsPartsOnOrder.Value > cdsPartsOnHand.Value;
end;

procedure TMastData.PostAndUpdateDataSets(DataSets: TClientDataSetArray);
var
  DataSet: TClientDataSet;
begin
  for DataSet in DataSets do begin
    if DataSet.State in dsEditModes then
      DataSet.Post;

    if DataSet.ChangeCount > 0 then
      DataSet.ApplyUpdates(-1);
  end;
  for DataSet in DataSets do try
    DataSet.Refresh;
  except
  end;
end;

{ If user cancels the updates to the orders table, cancel the updates to
  the line items as well }

procedure TMastData.OrdersAfterCancel(DataSet: TDataSet);
begin
  cdsCust.Cancel;
  cdsParts.Cancel;
  cdsItems.Cancel;
  cdsOrders.Cancel;
end;

procedure TMastData.OrdersAfterDelete(DataSet: TDataSet);
var
  DSA: TClientDataSetArray;
begin
  SetLength(DSA,4);
  DSA[0] := cdsCust;
  DSA[1] := cdsParts;
  DSA[2] := cdsItems;
  DSA[3] := cdsOrders;
  PostAndUpdateDataSets(DSA);
end;

{ Order Entry }

{ Post new LastInvoiceDate to CUST table. }

procedure TMastData.OrdersAfterPost(DataSet: TDataSet);
var
  DSA: TClientDataSetArray;
begin
  if cdsCust.Locate('CustNo', cdsOrdersCustNo.Value, []) and
    (cdsCustLastInvoiceDate.AsDateTime < cdsOrdersShipDate.AsDateTime) then
  begin
    cdsCust.Edit;
    cdsCustLastInvoiceDate.Value := cdsOrdersShipDate.Value;
    cdsCust.Post;
  end;
  SetLength(DSA,4);
  DSA[0] := cdsCust;
  DSA[1] := cdsParts;
  DSA[2] := cdsItems;
  DSA[3] := cdsOrders;

   PostAndUpdateDataSets(DSA);
end;

procedure TMastData.OrdersBeforeCancel(DataSet: TDataSet);
begin
  if (cdsOrders.State = dsInsert) and not (cdsItems.BOF and cdsItems.EOF) then
    if not Confirm('Cancel order being inserted and delete all line items?') then
      Abort;
end;

procedure TMastData.OrdersBeforeClose(DataSet: TDataSet);
begin
  cdsItems.Close;
  cdsEmps.Close;
  cdsCustByOrd.Close;
end;

procedure TMastData.OrdersBeforeDelete(DataSet: TDataSet);
begin
  if not Confirm('Delete order and line items?') then
    Abort
  else
    DeleteItems;
end;

procedure TMastData.OrdersBeforeInsert(DataSet: TDataSet);
begin
  if cdsOrders.State in dsEditModes then
  begin
    if Confirm('An order is being processed.  Save changes and start a new one?') then
      cdsOrders.Post
    else
      Abort;
  end;
  FItemNo := 1;
end;

procedure TMastData.OrdersBeforeOpen(DataSet: TDataSet);
begin
  cdsCustByComp.Open;
  cdsCustByOrd.Open;
  cdsCust.Open;
  cdsEmps.Open;
  cdsItems.Open;
end;

{ Calculate the order's tax totals and amount due }

procedure TMastData.OrdersCalcFields(DataSet: TDataSet);
begin
  cdsOrdersTaxTotal.Value := cdsOrdersItemsTotal.Value * (cdsOrdersTaxRate.Value / 100);
  cdsOrdersAmountDue.Value := cdsOrdersItemsTotal.Value + cdsOrdersTaxTotal.Value +
    cdsOrdersFreight.Value - cdsOrdersAmountPaid.Value;
end;

{ Inititializes the record values as a result of an Orders.Insert. }

procedure TMastData.OrdersNewRecord(DataSet: TDataSet);
begin

  { Get the Next Order Value from the NextOrd Table }

  qryGetNextOrd.Close;
  // Calls the Gen_ID call and returns the next value.
  qryGetNextOrd.Open;
  try
    cdsOrdersOrderNo.Value := qryGetNextOrd.Fields[0].Value;
  finally
    qryGetNextOrd.Close;
  end;
  cdsOrdersSaleDate.AsSQLTimeStamp := DateTimeToSQLTimeStamp(Trunc(Now));
  cdsOrdersShipVia.Value := 'UPS';
  cdsOrdersTerms.Value := 'net 30';
  cdsOrdersPaymentMethod.Value := 'Check';
  cdsOrdersItemsTotal.Value := 0;
  cdsOrdersTaxRate.Value := 0;
  cdsOrdersFreight.Value := 0;
  cdsOrdersAmountPaid.Value := 0;
end;

procedure TMastData.ItemsAfterDelete(DataSet: TDataSet);
begin
  UpdateTotals;
end;

{ Update the order totals and the Parts table }

procedure TMastData.ItemsAfterPost(DataSet: TDataSet);

  { Reduce/increase Parts table's OnOrder field }

  procedure UpdateParts(PartNo: Double; Qty : Longint);
  begin
    if (PartNo > 0) and (Qty <> 0) then
    try
      if not cdsParts.Locate('PartNo', PartNo, []) then Abort;
      cdsParts.Edit;
      cdsPartsOnOrder.Value := cdsPartsOnOrder.Value + Qty;
      cdsParts.Post;
    except
      on E: Exception do
        ShowMessage(Format('Error updating parts table for PartNo: %d', [PartNo]));
    end;
  end;

begin
  { Maintain next available item number }
  Inc(FItemNo);
  UpdateTotals;
  if not ((PrevPartNo = cdsItemsPartNo.Value) and (PrevQty = cdsItemsQty.Value)) then
  begin
   { Reduce previous Part#'s OnOrder field by previous Qty }
    UpdateParts(PrevPartNo, -PrevQty);
   { Increase new Part#'s OnOrder field by previous Qty }
    UpdateParts(cdsItemsPartNo.Value, cdsItemsQty.Value);
  end;
end;

{  When a change to the detail table affects a field in the master, always make
  sure the master (orders) table is in edit or insert mode before allowing the
  detail table to be modified. }

procedure TMastData.EnsureOrdersEdit(DataSet: TDataSet);
begin
  cdsOrders.Edit;
end;

{ Remember previous PartNo and Qty for updating Parts.OnOrder after post.
  When a change to the detail table affects a field in the master, always make
  sure the master table is in edit or insert mode before allowing the
  detail table to be modified. }

procedure TMastData.ItemsBeforeEdit(DataSet: TDataSet);
begin
  cdsOrders.Edit;
  PrevPartNo := cdsItemsPartNo.Value;
  PrevQty := cdsItemsQty.Value;
end;

{ Make sure the Parts table opens before the Items table, since there are
  lookups which depend on it. }

procedure TMastData.ItemsBeforeOpen(DataSet: TDataSet);
begin
  cdsParts.Open;
end;

{ Complete the item's key by initializing its NextItemNo field }

procedure TMastData.ItemsBeforePost(DataSet: TDataSet);
begin
  cdsItemsItemNo.Value := FItemNo;
end;

{ Lookup PartNo info for the item; calculate its extended price }

procedure TMastData.ItemsCalcFields(DataSet: TDataSet);
begin
  cdsItemsExtPrice.Value := cdsItemsQty.Value *
    cdsItemsSellPrice.Value * (100 - cdsItemsDiscount.Value) / 100;
end;

{ New item. Zero the "prev" buckets, initialize the key }

procedure TMastData.ItemsNewRecord(DataSet: TDataSet);
begin
  PrevPartNo := 0;
  PrevQty := 0;
  cdsItemsOrderNo.Value := cdsOrdersOrderNo.Value;
  cdsItemsQty.Value := 1;
  cdsItemsDiscount.Value := 0;
end;

{ Concatenate last name + first name for the order's SoldBy DBLookupCombo }

procedure TMastData.EmpsCalcFields(DataSet: TDataSet);
begin
  cdsEmpsFullName.AsString := Format('%s, %s', [cdsEmpsLastName.AsString, cdsEmpsFirstName.AsString]);
end;

procedure TMastData.DeleteItems;
begin
  DeletingItems := True;    { suppress recalc of totals during delete }
  cdsItems.DisableControls;    { for faster table traversal }
  try
    cdsItems.First;
    while not cdsItems.EOF do cdsItems.Delete;
  finally
    DeletingItems := False;
    cdsItems.EnableControls;   { always re-enable controls after disabling }
  end;
end;

{ Steps through Items and gathers sum of ExtPrice. After OrdersItemsTotal
  is calculated, OrdersCalcFields is automatically called (which
  updates other calculated fields. }

procedure TMastData.UpdateTotals;
var
  TempTotal: Extended;
  PrevRecord: TBookmark;
begin
  if DeletingItems then Exit;		{ don't calculate if deleting all items }
  PrevRecord := cdsItems.GetBookmark;	{ returns nil if table is empty }
  try
    cdsItems.DisableControls;
    cdsItems.First;
    TempTotal := 0;			{ use temp for efficiency }
    while not cdsItems.EOF do
    begin
      TempTotal := TempTotal + cdsItemsExtPrice.Value;
      cdsItems.Next;
    end;
    cdsOrdersItemsTotal.Value := TempTotal;
  finally
     cdsItems.EnableControls;
     if PrevRecord <> nil then
     begin
       cdsItems.GoToBookmark(PrevRecord);
       cdsItems.FreeBookmark(PrevRecord);
     end;
  end;
end;

procedure TMastData.OrdersCustNoChange(Sender: TField);
var
  TaxRate: Variant;
begin
  cdsOrdersShipToContact.Value := '';
  cdsOrdersShipToPhone.Value := '';
  cdsOrdersShipToAddr1.Value := '';
  cdsOrdersShipToAddr2.Value := '';
  cdsOrdersShipToCity.Value := '';
  cdsOrdersShipToState.Value := '';
  cdsOrdersShipToZip.Value := '';
  cdsOrdersShipToCountry.Value := '';
  TaxRate := cdsCust.Lookup('CustNo', cdsOrdersCustNo.Value, 'TaxRate');
  if not VarIsNull(TaxRate) then
    cdsOrdersTaxRate.Value := TaxRate;
end;

{ Alternatively, could set the Qty field's Min and Max values in code
  or in the Object Inspector. }

procedure TMastData.tbItemsQtyValidate(Sender: TField);
begin
  if cdsItemsQty.Value < 1 then
    raise Exception.Create('Must specify quantity');
end;

{ Alternatively, could set the Freight field's Min and Max values in code
  or in the Object Inspector. }

procedure TMastData.OrdersFreightValidate(Sender: TField);
begin
  if cdsOrdersFreight.Value < 0 then
    raise Exception.Create('Freight cannot be less than zero');
end;

procedure TMastData.tbItemsPartNoValidate(Sender: TField);
begin
  if not cdsParts.Locate('PartNo', cdsItemsPartNo.Value, []) then
    raise Exception.Create('You must specify a valid PartNo');
end;

procedure TMastData.OrdersSaleDateValidate(Sender: TField);
begin
  if cdsOrdersSaleDate.AsDateTime > Now then
    raise Exception.Create('Cannot enter a future date');
end;

{ Browse Customers }

procedure TMastData.CustBeforeOpen(DataSet: TDataSet);
begin
  cdsOrdByCust.Open;
end;

procedure TMastData.OrdByCustCalcFields(DataSet: TDataSet);
begin
  cdsOrdByCustAmountDue.Value := cdsOrdByCustItemsTotal.Value +
    cdsOrdByCustItemsTotal.Value * cdsOrdByCustTaxRate.Value / 100 +
    cdsOrdByCustFreight.Value - cdsOrdByCustAmountPaid.Value;
end;

{ Get the next available customer number from the NextCust table }

procedure TMastData.CustBeforePost(DataSet: TDataSet);
begin
  if cdsCust.State = dsInsert then
  begin
    qryGetNextCust.Close;
    // Calls the Gen_ID call and returns the next value.
    qryGetNextCust.Open;
    try
      cdsCustCustNo.Value := qryGetNextCust.Fields[0].Value;
    finally
      qryGetNextCust.Close;
    end;
  end;
end;


function TMastData.DataSetApplyUpdates(DataSet: TDataSet; Apply: Boolean): Boolean;
begin
  Result := True;
  with DataSet do
  begin
    if (State in dsEditModes) then
      if Apply then begin
        DataSet.Post;
        try
          if DataSet is TClientDataSet then begin
             TClientDataSet(DataSet).ApplyUpdates(-1);
          end;
        except
          // Show Message about data not saved..
        end;
      end else
        DataSet.Cancel;
  end;
end;

{ Determine the next available ItemNo for this order }

procedure TMastData.OrdersBeforeEdit(DataSet: TDataSet);
begin
  LastItemQuery.Close;
  LastItemQuery.Open;
  { SQL servers return Null for some aggregates if no items are present }
  with LastItemQuery.Fields[0] do
    if IsNull then FItemNo := 1
    else FItemNo := AsInteger + 1;
end;

{
procedure TMastData.EditUpdateError(DataSet: TIBDataSet; E: EIBInterbaseError;
  UpdateKind: TUpdateKind; var UpdateAction: TIBUpdateAction);
var
  Key: Variant;
const
  UpdErrMsg = '%s.'#13#10'Discard the edits to %S %S and continue updating?';
begin
  if UpdateKind = ukDelete then
    Key := Dataset.Fields[0].OldValue else
    Key := Dataset.Fields[0].NewValue;
  if MessageDlg(Format(UpdErrMsg, [E.Message, DataSet.Fields[0].DisplayLabel, Key]),
    mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
    UpdateAction := uaSkip else
    UpdateAction := uaAbort;
end;
}

procedure TMastData.MastDataCreate(Sender: TObject);
begin
  Database.Open;
end;

end.

