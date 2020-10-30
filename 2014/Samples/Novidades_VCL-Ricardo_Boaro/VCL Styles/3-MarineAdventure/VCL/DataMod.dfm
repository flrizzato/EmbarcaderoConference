object MastData: TMastData
  OldCreateOrder = True
  OnCreate = MastDataCreate
  Height = 474
  Width = 922
  object tbParts: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'PARTS'
    Left = 252
    Top = 136
    object tbPartsPartNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 8
      FieldName = 'PARTNO'
      Required = True
    end
    object tbPartsDescription: TStringField
      DisplayWidth = 21
      FieldName = 'DESCRIPTION'
      Required = True
      Size = 30
    end
    object tbPartsVendorNo: TFloatField
      DisplayWidth = 9
      FieldName = 'VENDORNO'
    end
    object tbPartsOnHand: TFloatField
      DisplayWidth = 9
      FieldName = 'ONHAND'
    end
    object tbPartsOnOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'ONORDER'
    end
    object tbPartsCost: TCurrencyField
      DisplayWidth = 12
      FieldName = 'COST'
    end
    object tbPartsListPrice: TCurrencyField
      DisplayWidth = 12
      FieldName = 'LISTPRICE'
    end
  end
  object qryPartsQuery: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM PARTS'
      ' WHERE (PARTS.ONORDER > PARTS.ONHAND)')
    SQLConnection = Database
    Left = 828
    Top = 133
    object qryPartsQueryPartNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 8
      FieldName = 'PARTNO'
    end
    object qryPartsQueryDescription: TStringField
      DisplayWidth = 21
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object qryPartsQueryVendorNo: TFloatField
      FieldName = 'VENDORNO'
    end
    object qryPartsQueryOnHand: TFloatField
      DisplayWidth = 9
      FieldName = 'ONHAND'
    end
    object qryPartsQueryOnOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'ONORDER'
    end
    object qryPartsQueryCost: TCurrencyField
      FieldName = 'COST'
    end
    object qryPartsQueryListPrice: TCurrencyField
      FieldName = 'LISTPRICE'
    end
  end
  object tbVendors: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'VENDORS'
    Left = 396
    Top = 132
  end
  object tbOrders: TSQLTable
    IndexFieldNames = 'ORDERNO'
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'ORDERS'
    Left = 28
    Top = 136
    object tbOrdersOrderNo: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'OrderNo'
      FieldName = 'ORDERNO'
    end
    object tbOrdersCustNo: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'CustNo'
      FieldName = 'CUSTNO'
      Required = True
    end
    object tbOrdersSaleDate: TSQLTimeStampField
      DisplayLabel = 'Sale Date'
      FieldName = 'SALEDATE'
    end
    object tbOrdersShipDate: TSQLTimeStampField
      DisplayLabel = 'Ship Date'
      FieldName = 'SHIPDATE'
    end
    object tbOrdersShipToContact: TStringField
      DisplayLabel = 'Ship to Contact'
      FieldName = 'SHIPTOCONTACT'
    end
    object tbOrdersShipToAddr1: TStringField
      DisplayLabel = 'Ship to Addr1'
      FieldName = 'SHIPTOADDR1'
      Size = 30
    end
    object tbOrdersShipToAddr2: TStringField
      DisplayLabel = 'Ship to Addr2'
      FieldName = 'SHIPTOADDR2'
      Size = 30
    end
    object tbOrdersShipToCity: TStringField
      DisplayLabel = 'Ship to City'
      FieldName = 'SHIPTOCITY'
      Size = 15
    end
    object tbOrdersShipToState: TStringField
      DisplayLabel = 'Ship to State'
      FieldName = 'SHIPTOSTATE'
    end
    object tbOrdersShipToZip: TStringField
      DisplayLabel = 'Ship to Zip'
      FieldName = 'SHIPTOZIP'
      Size = 10
    end
    object tbOrdersShipToCountry: TStringField
      DisplayLabel = 'Ship to Country'
      FieldName = 'SHIPTOCOUNTRY'
    end
    object tbOrdersShipToPhone: TStringField
      DisplayLabel = 'Ship to Phone'
      FieldName = 'SHIPTOPHONE'
      Size = 15
    end
    object tbOrdersShipVIA: TStringField
      DisplayLabel = 'Ship VIA'
      FieldName = 'SHIPVIA'
      Size = 7
    end
    object tbOrdersPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object tbOrdersEmpNo: TIntegerField
      DisplayLabel = 'Emp No'
      FieldName = 'EMPNO'
      Required = True
    end
    object tbOrdersTerms: TStringField
      DisplayLabel = 'Terms'
      FieldName = 'TERMS'
      Size = 6
    end
    object tbOrdersPaymentMethod: TStringField
      DisplayLabel = 'Payment Hod'
      FieldName = 'PAYMENTMETHOD'
      Size = 7
    end
    object tbOrdersItemsTotal: TCurrencyField
      DisplayLabel = 'Items Total'
      FieldName = 'ITEMSTOTAL'
    end
    object tbOrdersTaxRate: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
      DisplayFormat = '0.00%;(0.00%);0%'
      MaxValue = 100.000000000000000000
    end
    object tbOrdersFreight: TCurrencyField
      DisplayLabel = 'Freight'
      FieldName = 'FREIGHT'
    end
    object tbOrdersAmountPaid: TCurrencyField
      DisplayLabel = 'Amount Paid'
      FieldName = 'AMOUNTPAID'
    end
  end
  object tbCustByOrd: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'CUSTOMER'
    Left = 108
    Top = 140
    object tbCustByOrdCustNo: TFloatField
      DisplayLabel = 'Customer ID'
      FieldName = 'CUSTNO'
    end
    object tbCustByOrdCompany: TStringField
      DisplayLabel = 'Company'
      FieldName = 'COMPANY'
      Size = 30
    end
    object tbCustByOrdAddr1: TStringField
      DisplayLabel = 'Address 1'
      FieldName = 'ADDR1'
      Size = 30
    end
    object tbCustByOrdAddr2: TStringField
      DisplayLabel = 'Address 2'
      FieldName = 'ADDR2'
      Size = 30
    end
    object tbCustByOrdCity: TStringField
      DisplayLabel = 'City'
      FieldName = 'CITY'
      Size = 15
    end
    object tbCustByOrdState: TStringField
      DisplayLabel = 'State'
      FieldName = 'STATE'
    end
    object tbCustByOrdZip: TStringField
      DisplayLabel = 'Zip'
      FieldName = 'ZIP'
      Size = 10
    end
    object tbCustByOrdCountry: TStringField
      DisplayLabel = 'Country'
      FieldName = 'COUNTRY'
    end
    object tbCustByOrdPhone: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'PHONE'
      Size = 15
    end
    object tbCustByOrdFAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 15
    end
    object tbCustByOrdTaxRate: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
    end
    object tbCustByOrdContact: TStringField
      DisplayLabel = 'Contact'
      FieldName = 'CONTACT'
    end
    object tbCustByOrdLastInvoiceDate: TSQLTimeStampField
      DisplayLabel = 'Last Invoice Date'
      FieldName = 'LASTINVOICEDATE'
    end
  end
  object tbItems: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'ITEMS'
    Left = 180
    Top = 136
    object tbItemsItemNo: TFloatField
      DisplayLabel = 'Item No'
      FieldName = 'ITEMNO'
      Visible = False
    end
    object tbItemsOrderNo: TFloatField
      DisplayLabel = 'Order No'
      FieldName = 'ORDERNO'
      Visible = False
    end
    object tbItemsPartNo: TFloatField
      DisplayLabel = 'Part No'
      FieldName = 'PARTNO'
      OnValidate = tbItemsPartNoValidate
    end
    object tbItemsDescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 28
      FieldKind = fkLookup
      FieldName = 'DESCRIPTION'
      LookupDataSet = tbParts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'Description'
      KeyFields = 'PartNo'
      ReadOnly = True
      Size = 30
      Lookup = True
    end
    object tbItemsSellPrice: TCurrencyField
      DisplayLabel = 'Sell Price'
      DisplayWidth = 9
      FieldKind = fkLookup
      FieldName = 'SELLPRICE'
      LookupDataSet = tbParts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'ListPrice'
      KeyFields = 'PartNo'
      Lookup = True
    end
    object tbItemsQty: TIntegerField
      DisplayLabel = 'Qty'
      DisplayWidth = 5
      FieldName = 'QTY'
      OnValidate = tbItemsQtyValidate
    end
    object tbItemsDiscount: TFloatField
      DisplayLabel = 'Discount'
      DisplayWidth = 7
      FieldName = 'DISCOUNT'
      DisplayFormat = '0.00%'
      MaxValue = 100.000000000000000000
    end
    object tbItemsExtPrice: TCurrencyField
      DisplayLabel = 'Ext Price'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'EXTPRICE'
      Calculated = True
    end
  end
  object tbEmps: TSQLTable
    IndexFieldNames = 'EMPNO'
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'EMPLOYEE'
    Left = 332
    Top = 136
    object tbEmpsEmpNo: TIntegerField
      FieldName = 'EMPNO'
    end
    object tbEmpsLastName: TStringField
      FieldName = 'LASTNAME'
    end
    object tbEmpsFirstName: TStringField
      FieldName = 'FIRSTNAME'
      Size = 15
    end
    object tbEmpsPhoneExt: TStringField
      FieldName = 'PHONEEXT'
      Size = 4
    end
    object tbEmpsHireDate: TSQLTimeStampField
      FieldName = 'HIREDATE'
    end
    object tbEmpsSalary: TFloatField
      FieldName = 'SALARY'
    end
  end
  object LastItemQuery: TSQLQuery
    DataSource = OrdersSource
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftFloat
        Name = 'ORDERNO'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT MAX(ITEMNO) FROM ITEMS '
      'WHERE ORDERNO = :ORDERNO')
    SQLConnection = Database
    Left = 355
    Top = 60
  end
  object qryCust: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'CUSTOMER'
    Left = 468
    Top = 136
    object qryCustCustNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'CUSTNO'
    end
    object qryCustCompany: TStringField
      DisplayWidth = 26
      FieldName = 'COMPANY'
      Required = True
      Size = 30
    end
    object qryCustPhone: TStringField
      DisplayWidth = 15
      FieldName = 'PHONE'
      Size = 15
    end
    object qryCustLastInvoiceDate: TSQLTimeStampField
      DisplayLabel = 'LastInvoice'
      DisplayWidth = 10
      FieldName = 'LASTINVOICEDATE'
      DisplayFormat = 'DDDDD'
    end
    object qryCustAddr1: TStringField
      FieldName = 'ADDR1'
      Size = 30
    end
    object qryCustAddr2: TStringField
      FieldName = 'ADDR2'
      Size = 30
    end
    object qryCustCity: TStringField
      FieldName = 'CITY'
      Size = 15
    end
    object qryCustState: TStringField
      FieldName = 'STATE'
    end
    object qryCustZip: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object qryCustCountry: TStringField
      FieldName = 'COUNTRY'
    end
    object qryCustFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object qryCustTaxRate: TFloatField
      FieldName = 'TAXRATE'
    end
    object qryCustContact: TStringField
      FieldName = 'CONTACT'
    end
  end
  object qryCustQuery: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftTimeStamp
        Name = 'FromDate'
        ParamType = ptInput
      end
      item
        DataType = ftTimeStamp
        Name = 'ToDate'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT CUSTOMER.CUSTNO, CUSTOMER.COMPANY,'
      '             CUSTOMER.LASTINVOICEDATE, CUSTOMER.PHONE'
      'FROM CUSTOMER'
      'WHERE'
      '   (CUSTOMER.LASTINVOICEDATE >= :FromDate) AND'
      '   (CUSTOMER.LASTINVOICEDATE <= :ToDate)'
      ' ')
    SQLConnection = Database
    Left = 740
    Top = 133
    object qryCustQueryCustNo: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'CUSTNO'
    end
    object qryCustQueryCompany: TStringField
      DisplayWidth = 26
      FieldName = 'COMPANY'
      Size = 30
    end
    object qryCustQueryPhone: TStringField
      DisplayWidth = 15
      FieldName = 'PHONE'
      Size = 15
    end
    object qryCustQueryLastInvoiceDate: TSQLTimeStampField
      DisplayLabel = 'LastInvoice'
      DisplayWidth = 10
      FieldName = 'LASTINVOICEDATE'
      DisplayFormat = 'DDDDD'
    end
  end
  object qryOrdByCust: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'ORDERS'
    Left = 652
    Top = 136
    object qryOrdByCustOrderNo: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Order No'
      DisplayWidth = 10
      FieldName = 'ORDERNO'
    end
    object qryOrdByCustCustNo: TFloatField
      DisplayLabel = 'Cust No'
      FieldName = 'CUSTNO'
      Visible = False
    end
    object qryOrdByCustSaleDate: TSQLTimeStampField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 9
      FieldName = 'SALEDATE'
      DisplayFormat = 'DDDDD'
    end
    object qryOrdByCustShipDate: TSQLTimeStampField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 9
      FieldName = 'SHIPDATE'
      DisplayFormat = 'DDDDD'
    end
    object qryOrdByCustItemsTotal: TCurrencyField
      DisplayLabel = 'Items Total'
      FieldName = 'ITEMSTOTAL'
      Visible = False
    end
    object qryOrdByCustTaxRate: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
      Visible = False
    end
    object qryOrdByCustFreight: TCurrencyField
      DisplayLabel = 'Freight'
      FieldName = 'FREIGHT'
      Visible = False
    end
    object qryOrdByCustAmountPaid: TCurrencyField
      DisplayLabel = 'Amount Paid'
      DisplayWidth = 14
      FieldName = 'AMOUNTPAID'
    end
  end
  object qryCustByComp: TSQLTable
    IndexFieldNames = 'COMPANY'
    MaxBlobSize = -1
    SQLConnection = Database
    TableName = 'CUSTOMER'
    Left = 556
    Top = 140
  end
  object OrdersSource: TDataSource
    DataSet = cdsOrders
    Left = 32
    Top = 320
  end
  object CustByOrdSrc: TDataSource
    DataSet = cdsCustByOrd
    Left = 112
    Top = 316
  end
  object ItemsSource: TDataSource
    DataSet = cdsItems
    Left = 192
    Top = 320
  end
  object PartsSource: TDataSource
    DataSet = cdsParts
    Left = 256
    Top = 320
  end
  object EmpsSource: TDataSource
    DataSet = cdsEmps
    Left = 328
    Top = 320
  end
  object VendorSource: TDataSource
    DataSet = cdsVendors
    Left = 392
    Top = 324
  end
  object CustSource: TDataSource
    DataSet = cdsCust
    Left = 467
    Top = 328
  end
  object CustMasterSrc: TDataSource
    DataSet = cdsCust
    Left = 467
    Top = 392
  end
  object OrdByCustSrc: TDataSource
    DataSet = cdsOrdByCust
    Left = 651
    Top = 320
  end
  object CustByCompSrc: TDataSource
    DataSet = cdsCustByComp
    Left = 563
    Top = 328
  end
  object Database: TSQLConnection
    DriverName = 'INTERBASE'
    LoginPrompt = False
    Params.Strings = (
      'drivername=INTERBASE'
      'librarynameosx=libsqlib.dylib'
      'vendorlibwin64=ibclient64.dll'
      'vendorlibosx=libgds.dylib'
      'blobsize=-1'
      'commitretain=False'
      'database=C:\DTOURXE6\Data\MASTSQL2.IB'
      'localecode=0000'
      'password=masterkey'
      'rolename=RoleName'
      'sqldialect=3'
      'isolationlevel=ReadCommitted'
      'user_name=sysdba'
      'waitonlocks=True'
      'trim char=False')
    Left = 64
    Top = 64
  end
  object dspOrders: TDataSetProvider
    DataSet = tbOrders
    Left = 32
    Top = 192
  end
  object cdsOrders: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOrders'
    BeforeOpen = OrdersBeforeOpen
    BeforeClose = OrdersBeforeClose
    BeforeInsert = OrdersBeforeInsert
    BeforeEdit = OrdersBeforeEdit
    AfterPost = OrdersAfterPost
    BeforeCancel = OrdersBeforeCancel
    AfterCancel = OrdersAfterCancel
    BeforeDelete = OrdersBeforeDelete
    AfterDelete = OrdersAfterDelete
    OnCalcFields = OrdersCalcFields
    OnNewRecord = OrdersNewRecord
    Left = 36
    Top = 256
    object cdsOrdersORDERNO: TFloatField
      DisplayLabel = 'OrderNo'
      FieldName = 'ORDERNO'
    end
    object cdsOrdersCUSTNO: TFloatField
      DisplayLabel = 'CustNo'
      FieldName = 'CUSTNO'
      Required = True
      OnChange = OrdersCustNoChange
    end
    object cdsOrdersSALEDATE: TSQLTimeStampField
      DisplayLabel = 'Sale Date'
      FieldName = 'SALEDATE'
      OnValidate = OrdersSaleDateValidate
    end
    object cdsOrdersSHIPDATE: TSQLTimeStampField
      DisplayLabel = 'Ship Date'
      FieldName = 'SHIPDATE'
    end
    object cdsOrdersSHIPTOCONTACT: TStringField
      DisplayLabel = 'Ship to Contact'
      FieldName = 'SHIPTOCONTACT'
    end
    object cdsOrdersSHIPTOADDR1: TStringField
      DisplayLabel = 'Ship to Addr1'
      FieldName = 'SHIPTOADDR1'
      Size = 30
    end
    object cdsOrdersSHIPTOADDR2: TStringField
      DisplayLabel = 'Ship to Addr2'
      FieldName = 'SHIPTOADDR2'
      Size = 30
    end
    object cdsOrdersSHIPTOCITY: TStringField
      DisplayLabel = 'Ship to City'
      FieldName = 'SHIPTOCITY'
      Size = 15
    end
    object cdsOrdersSHIPTOSTATE: TStringField
      DisplayLabel = 'Ship to State'
      FieldName = 'SHIPTOSTATE'
    end
    object cdsOrdersSHIPTOZIP: TStringField
      DisplayLabel = 'Ship to Zip'
      FieldName = 'SHIPTOZIP'
      Size = 10
    end
    object cdsOrdersSHIPTOCOUNTRY: TStringField
      DisplayLabel = 'Ship to Country'
      FieldName = 'SHIPTOCOUNTRY'
    end
    object cdsOrdersSHIPTOPHONE: TStringField
      DisplayLabel = 'Ship to Phone'
      FieldName = 'SHIPTOPHONE'
      Size = 15
    end
    object cdsOrdersSHIPVIA: TStringField
      DisplayLabel = 'Ship VIA'
      FieldName = 'SHIPVIA'
      Size = 7
    end
    object cdsOrdersPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object cdsOrdersEMPNO: TIntegerField
      DisplayLabel = 'Emp No'
      FieldName = 'EMPNO'
      Required = True
    end
    object cdsOrdersTERMS: TStringField
      DisplayLabel = 'Terms'
      FieldName = 'TERMS'
      Size = 6
    end
    object cdsOrdersPAYMENTMETHOD: TStringField
      DisplayLabel = 'Payment Hod'
      FieldName = 'PAYMENTMETHOD'
      Size = 7
    end
    object cdsOrdersITEMSTOTAL: TCurrencyField
      DisplayLabel = 'Items Total'
      FieldName = 'ITEMSTOTAL'
    end
    object cdsOrdersTAXRATE: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
      DisplayFormat = '0.00%;(0.00%);0%'
    end
    object cdsOrdersTAXTOTAL: TCurrencyField
      DisplayLabel = 'Tax Total'
      FieldKind = fkCalculated
      FieldName = 'TAXTOTAL'
      ReadOnly = True
      Calculated = True
    end
    object cdsOrdersFREIGHT: TCurrencyField
      DisplayLabel = 'Freight'
      FieldName = 'FREIGHT'
      OnValidate = OrdersFreightValidate
    end
    object cdsOrdersAMOUNTPAID: TCurrencyField
      DisplayLabel = 'Amount Paid'
      FieldName = 'AMOUNTPAID'
    end
    object cdsOrdersAMOUNTDUE: TCurrencyField
      DisplayLabel = 'Amount Due'
      FieldKind = fkCalculated
      FieldName = 'AMOUNTDUE'
      ReadOnly = True
      Calculated = True
    end
    object cdsOrdersSALESPERSON: TStringField
      DisplayLabel = 'Sales Person'
      FieldKind = fkLookup
      FieldName = 'SALESPERSON'
      LookupDataSet = cdsEmps
      LookupKeyFields = 'EMPNO'
      LookupResultField = 'FULLNAME'
      KeyFields = 'EMPNO'
      ReadOnly = True
      Size = 40
      Lookup = True
    end
  end
  object cdsCustByOrd: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CUSTNO'
    MasterFields = 'CUSTNO'
    MasterSource = OrdersSource
    Params = <>
    ProviderName = 'dspCustByOrd'
    Left = 108
    Top = 252
    object cdsCustByOrdCUSTNO: TFloatField
      DisplayLabel = 'Customer ID'
      FieldName = 'CUSTNO'
    end
    object cdsCustByOrdCOMPANY: TStringField
      DisplayLabel = 'Company'
      FieldName = 'COMPANY'
      Size = 30
    end
    object cdsCustByOrdADDR1: TStringField
      DisplayLabel = 'Address 1'
      FieldName = 'ADDR1'
      Size = 30
    end
    object cdsCustByOrdADDR2: TStringField
      DisplayLabel = 'Address 2'
      FieldName = 'ADDR2'
      Size = 30
    end
    object cdsCustByOrdCITY: TStringField
      DisplayLabel = 'City'
      FieldName = 'CITY'
      Size = 15
    end
    object cdsCustByOrdSTATE: TStringField
      DisplayLabel = 'State'
      FieldName = 'STATE'
    end
    object cdsCustByOrdZIP: TStringField
      DisplayLabel = 'Zip'
      FieldName = 'ZIP'
      Size = 10
    end
    object cdsCustByOrdCOUNTRY: TStringField
      DisplayLabel = 'Country'
      FieldName = 'COUNTRY'
    end
    object cdsCustByOrdPHONE: TStringField
      DisplayLabel = 'Phone'
      FieldName = 'PHONE'
      Size = 15
    end
    object cdsCustByOrdFAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 15
    end
    object cdsCustByOrdTAXRATE: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
    end
    object cdsCustByOrdCONTACT: TStringField
      DisplayLabel = 'Contact'
      FieldName = 'CONTACT'
    end
    object cdsCustByOrdLASTINVOICEDATE: TSQLTimeStampField
      DisplayLabel = 'Last Invoice Date'
      FieldName = 'LASTINVOICEDATE'
    end
  end
  object dspCustByOrd: TDataSetProvider
    DataSet = tbCustByOrd
    Left = 112
    Top = 196
  end
  object dspItems: TDataSetProvider
    DataSet = tbItems
    Left = 176
    Top = 192
  end
  object dspParts: TDataSetProvider
    DataSet = tbParts
    Left = 248
    Top = 192
  end
  object dspEmps: TDataSetProvider
    DataSet = tbEmps
    Left = 328
    Top = 192
  end
  object dspVendors: TDataSetProvider
    DataSet = tbVendors
    Left = 392
    Top = 196
  end
  object cdsEmps: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEmps'
    OnCalcFields = EmpsCalcFields
    Left = 332
    Top = 256
    object cdsEmpsEMPNO: TIntegerField
      DisplayLabel = 'EmpNo'
      FieldName = 'EMPNO'
    end
    object cdsEmpsFULLNAME: TStringField
      DisplayLabel = 'FullName'
      FieldKind = fkCalculated
      FieldName = 'FULLNAME'
      ReadOnly = True
      Calculated = True
    end
    object cdsEmpsLASTNAME: TStringField
      DisplayLabel = 'Last Name'
      FieldName = 'LASTNAME'
    end
    object cdsEmpsFIRSTNAME: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'FIRSTNAME'
      Size = 15
    end
    object cdsEmpsPHONEEXT: TStringField
      DisplayLabel = 'Phone Ext'
      FieldName = 'PHONEEXT'
      Size = 4
    end
    object cdsEmpsHIREDATE: TSQLTimeStampField
      DisplayLabel = 'Hire Date'
      FieldName = 'HIREDATE'
    end
    object cdsEmpsSALARY: TFloatField
      DisplayLabel = 'Salary'
      FieldName = 'SALARY'
    end
  end
  object cdsItems: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ORDERNO'
    MasterFields = 'ORDERNO'
    MasterSource = OrdersSource
    Params = <>
    ProviderName = 'dspItems'
    BeforeOpen = ItemsBeforeOpen
    BeforeInsert = EnsureOrdersEdit
    BeforeEdit = ItemsBeforeEdit
    BeforePost = ItemsBeforePost
    AfterPost = ItemsAfterPost
    BeforeDelete = EnsureOrdersEdit
    AfterDelete = ItemsAfterDelete
    OnCalcFields = ItemsCalcFields
    OnNewRecord = ItemsNewRecord
    Left = 188
    Top = 256
    object cdsItemsITEMNO: TFloatField
      DisplayLabel = 'item No'
      FieldName = 'ITEMNO'
    end
    object cdsItemsORDERNO: TFloatField
      DisplayLabel = 'Order No'
      FieldName = 'ORDERNO'
    end
    object cdsItemsPARTNO: TFloatField
      DisplayLabel = 'Part No'
      FieldName = 'PARTNO'
    end
    object cdsItemsDESCRIPTION: TStringField
      DisplayLabel = 'Description'
      FieldKind = fkLookup
      FieldName = 'DESCRIPTION'
      LookupDataSet = cdsParts
      LookupKeyFields = 'PARTNO'
      LookupResultField = 'DESCRIPTION'
      KeyFields = 'PARTNO'
      ReadOnly = True
      Size = 30
      Lookup = True
    end
    object cdsItemsSELLPRICE: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'SELLPRICE'
      LookupDataSet = cdsParts
      LookupKeyFields = 'PARTNO'
      LookupResultField = 'LISTPRICE'
      KeyFields = 'PARTNO'
      ReadOnly = True
      Lookup = True
    end
    object cdsItemsQTY: TIntegerField
      DisplayLabel = 'Qty'
      DisplayWidth = 5
      FieldName = 'QTY'
    end
    object cdsItemsDISCOUNT: TFloatField
      DisplayLabel = 'Discount'
      DisplayWidth = 7
      FieldName = 'DISCOUNT'
      DisplayFormat = '0.00%'
    end
    object cdsItemsEXTPRICE: TCurrencyField
      DisplayLabel = 'Ext Price'
      FieldKind = fkCalculated
      FieldName = 'EXTPRICE'
      ReadOnly = True
      Calculated = True
    end
  end
  object cdsParts: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspParts'
    BeforeOpen = PartsBeforeOpen
    OnCalcFields = PartsCalcFields
    Left = 252
    Top = 256
    object cdsPartsPARTNO: TFloatField
      DisplayLabel = 'Part No'
      DisplayWidth = 8
      FieldName = 'PARTNO'
      Required = True
    end
    object cdsPartsDESCRIPTION: TStringField
      DisplayWidth = 21
      FieldName = 'DESCRIPTION'
      Required = True
      Size = 30
    end
    object cdsPartsVENDORNO: TFloatField
      DisplayWidth = 9
      FieldName = 'VENDORNO'
    end
    object cdsPartsONHAND: TFloatField
      DisplayWidth = 9
      FieldName = 'ONHAND'
    end
    object cdsPartsONORDER: TFloatField
      FieldName = 'ONORDER'
    end
    object cdsPartsBACKORD: TBooleanField
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'BACKORD'
      ReadOnly = True
      DisplayValues = 'Yes;No'
      Calculated = True
    end
    object cdsPartsCOST: TCurrencyField
      DisplayWidth = 12
      FieldName = 'COST'
    end
    object cdsPartsLISTPRICE: TCurrencyField
      DisplayWidth = 12
      FieldName = 'LISTPRICE'
    end
  end
  object cdsVendors: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVendors'
    Left = 396
    Top = 260
  end
  object cdsCust: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCust'
    BeforeOpen = CustBeforeOpen
    BeforePost = CustBeforePost
    Left = 464
    Top = 256
    object cdsCustCUSTNO: TFloatField
      Alignment = taLeftJustify
      DisplayWidth = 6
      FieldName = 'CUSTNO'
    end
    object cdsCustCOMPANY: TStringField
      DisplayWidth = 26
      FieldName = 'COMPANY'
      Required = True
      Size = 30
    end
    object cdsCustPHONE: TStringField
      FieldName = 'PHONE'
      Size = 15
    end
    object cdsCustLASTINVOICEDATE: TSQLTimeStampField
      DisplayLabel = 'lastInvoice'
      DisplayWidth = 10
      FieldName = 'LASTINVOICEDATE'
      DisplayFormat = 'DDDDD'
    end
    object cdsCustADDR1: TStringField
      FieldName = 'ADDR1'
      Size = 30
    end
    object cdsCustADDR2: TStringField
      FieldName = 'ADDR2'
      Size = 30
    end
    object cdsCustCITY: TStringField
      FieldName = 'CITY'
      Size = 15
    end
    object cdsCustSTATE: TStringField
      FieldName = 'STATE'
    end
    object cdsCustZIP: TStringField
      FieldName = 'ZIP'
      Size = 10
    end
    object cdsCustCOUNTRY: TStringField
      FieldName = 'COUNTRY'
    end
    object cdsCustFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object cdsCustTAXRATE: TFloatField
      FieldName = 'TAXRATE'
    end
    object cdsCustCONTACT: TStringField
      FieldName = 'CONTACT'
    end
  end
  object dspCust: TDataSetProvider
    DataSet = qryCust
    Left = 464
    Top = 192
  end
  object dspCustbyComp: TDataSetProvider
    DataSet = qryCustByComp
    Left = 552
    Top = 192
  end
  object cdsCustByComp: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'COMPANY'
    Params = <>
    ProviderName = 'dspCustbyComp'
    Left = 552
    Top = 256
  end
  object dspOrdByCust: TDataSetProvider
    DataSet = qryOrdByCust
    Left = 648
    Top = 192
  end
  object cdsOrdByCust: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CUSTNO'
    MasterFields = 'CUSTNO'
    MasterSource = CustMasterSrc
    PacketRecords = 0
    Params = <>
    ProviderName = 'dspOrdByCust'
    OnCalcFields = OrdByCustCalcFields
    Left = 648
    Top = 256
    object cdsOrdByCustORDERNO: TFloatField
      Alignment = taLeftJustify
      DisplayLabel = 'Order No'
      FieldName = 'ORDERNO'
    end
    object cdsOrdByCustCUSTNO: TFloatField
      DisplayLabel = 'Cust No'
      FieldName = 'CUSTNO'
    end
    object cdsOrdByCustSALEDATE: TSQLTimeStampField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 9
      FieldName = 'SALEDATE'
      DisplayFormat = 'DDDDD'
    end
    object cdsOrdByCustSHIPDATE: TSQLTimeStampField
      DisplayLabel = 'Ship Date'
      DisplayWidth = 9
      FieldName = 'SHIPDATE'
      DisplayFormat = 'DDDDD'
    end
    object cdsOrdByCustITEMSTOTAL: TCurrencyField
      DisplayLabel = 'Items Total'
      FieldName = 'ITEMSTOTAL'
    end
    object cdsOrdByCustTAXRATE: TFloatField
      DisplayLabel = 'Tax Rate'
      FieldName = 'TAXRATE'
    end
    object cdsOrdByCustFREIGHT: TCurrencyField
      DisplayLabel = 'Freight'
      FieldName = 'FREIGHT'
    end
    object cdsOrdByCustAMOUNTPAID: TCurrencyField
      DisplayLabel = 'Amount Paid'
      DisplayWidth = 14
      FieldName = 'AMOUNTPAID'
    end
    object cdsOrdByCustAMOUNTDUE: TCurrencyField
      DisplayLabel = 'Amount Due'
      FieldKind = fkCalculated
      FieldName = 'AMOUNTDUE'
      ReadOnly = True
      Calculated = True
    end
  end
  object dspPartsQuery: TDataSetProvider
    DataSet = qryPartsQuery
    Left = 832
    Top = 192
  end
  object cdsPartsQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPartsQuery'
    OnCalcFields = PartsQueryCalcFields
    Left = 832
    Top = 256
    object cdsPartsQueryPARTNO: TFloatField
      DisplayLabel = 'Part No'
      DisplayWidth = 8
      FieldName = 'PARTNO'
    end
    object cdsPartsQueryDESCRIPTION: TStringField
      DisplayWidth = 21
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object cdsPartsQueryVENDORNO: TFloatField
      DisplayWidth = 9
      FieldName = 'VENDORNO'
    end
    object cdsPartsQueryONHAND: TFloatField
      DisplayWidth = 9
      FieldName = 'ONHAND'
    end
    object cdsPartsQueryONORDER: TFloatField
      DisplayWidth = 9
      FieldName = 'ONORDER'
    end
    object cdsPartsQueryBACKORD: TBooleanField
      DisplayWidth = 9
      FieldKind = fkCalculated
      FieldName = 'BACKORD'
      ReadOnly = True
      DisplayValues = 'Yes;No'
      Calculated = True
    end
    object cdsPartsQueryCOST: TCurrencyField
      FieldName = 'COST'
    end
    object cdsPartsQueryLISTPRICE: TCurrencyField
      FieldName = 'LISTPRICE'
    end
  end
  object cdsCustQuery: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCustQuery'
    Left = 744
    Top = 256
    object cdsCustQueryCUSTNO: TFloatField
      FieldName = 'CUSTNO'
    end
    object cdsCustQueryCOMPANY: TStringField
      FieldName = 'COMPANY'
      Size = 30
    end
    object cdsCustQueryPHONE: TStringField
      FieldName = 'PHONE'
      Size = 15
    end
    object cdsCustQueryLASTINVOICEDATE: TSQLTimeStampField
      FieldName = 'LASTINVOICEDATE'
    end
  end
  object dspCustQuery: TDataSetProvider
    DataSet = qryCustQuery
    Left = 736
    Top = 192
  end
  object qryGetNextCust: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select gen_id(GEN_NEXTCUST,1) from rdb$database')
    SQLConnection = Database
    Left = 147
    Top = 60
  end
  object qryGetNextOrd: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select gen_id(GEN_NEXTORD,1) from rdb$database')
    SQLConnection = Database
    Left = 251
    Top = 60
  end
  object qryGetNextItem: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select gen_id(GEN_NEXTITEM,1) from rdb$database')
    SQLConnection = Database
    Left = 459
    Top = 60
  end
end
