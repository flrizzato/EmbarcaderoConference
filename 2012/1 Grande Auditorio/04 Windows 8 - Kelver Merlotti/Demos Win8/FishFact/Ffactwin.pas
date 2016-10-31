
//---------------------------------------------------------------------------

// This software is Copyright (c) 2011 Embarcadero Technologies, Inc. 
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit Ffactwin;

{ This application shows how to display Paradox style memo and graphic
 fields in a form. Table1's DatabaseName property should point to the
 Delphi sample database. Table1's TableName property should be set to
 the BIOLIFE table. }

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, DBCtrls, DBGrids, DB, DBTables, Buttons, Grids, ExtCtrls,
  IBDatabase, IBCustomDataSet, IBTable, Vcl.Styles, Vcl.Themes;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    DataSource1: TDataSource;
    IBTable1: TIBTable;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBTable1CATEGORY: TIBStringField;
    IBTable1COMMON_NAME: TIBStringField;
    IBTable1SPECIES_NAME: TIBStringField;
    IBTable1LENGTH__CM_: TFloatField;
    IBTable1LENGTH_IN: TFloatField;
    IBTable1NOTES: TMemoField;
    IBTable1GRAPHIC: TBlobField;
    Panel5: TPanel;
    lbStyle: TLabel;
    cbStyles: TComboBox;
    Panel1: TPanel;
    Panel3: TPanel;
    DBLabel1: TDBText;
    DBImage1: TDBImage;
    Panel6: TPanel;
    DBMemo1: TDBMemo;
    DBGrid1: TDBGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cbStylesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.cbStylesClick(Sender: TObject);
begin
  TStyleManager.SetStyle(TComboBox(Sender).Items[TComboBox(Sender).ItemIndex]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cbStyles.Items.AddStrings(TStyleManager.StyleNames);
  cbStyles.ItemIndex := cbStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);
end;

end.
