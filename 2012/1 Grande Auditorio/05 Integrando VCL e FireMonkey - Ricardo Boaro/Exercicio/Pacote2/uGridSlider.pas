unit uGridSlider;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope,
  Data.Bind.DBLinks, Fmx.Bind.DBLinks, FMX.Layouts, FMX.Grid, Data.DB,
  Datasnap.DBClient, FMX.Edit, System.Rtti, System.Bindings.Outputs;


type
  TFrmGridSlider = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    ClientDataSet3: TClientDataSet;
    BindingsList1: TBindingsList;
    BindScopeDB1: TBindScopeDB;
    DBLinkStringGrid11: TBindDBGridLink;
    BindScopeDB2: TBindScopeDB;
    DBLinkStringGrid21: TBindDBGridLink;
    BindScopeDB3: TBindScopeDB;
    DBLinkStringGrid31: TBindDBGridLink;
    Edit1: TEdit;
    DBLinkEdit1ItemsTotal1: TBindDBEditLink;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    StyleBook1: TStyleBook;
    BindGridLinkProgressBar11: TBindGridLink;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

procedure TFrmGridSlider.Button1Click(Sender: TObject);
begin
  StringGrid1.AnimateFloat('Height',20,1);
  StringGrid2.AnimateFloat('Height',20,1);
  StringGrid3.AnimateFloat('Height',20,1);

  StringGrid1.AnimateFloatDelay('Position.Y',StringGrid2.Position.Y,1,1);
  StringGrid2.AnimateFloatDelay('Position.Y',StringGrid3.Position.Y,1,1);
  StringGrid3.AnimateFloatDelay('Position.Y',StringGrid1.Position.Y,1,1);

  StringGrid1.AnimateFloatDelay('Height',200,1,2);
  StringGrid2.AnimateFloatDelay('Height',200,1,2);
  StringGrid3.AnimateFloatDelay('Height',200,1,2);
end;

end.
