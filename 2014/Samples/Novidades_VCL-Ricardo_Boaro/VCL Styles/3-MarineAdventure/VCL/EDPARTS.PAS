unit Edparts;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DB, StdCtrls, ExtCtrls, Mask, DBCtrls,
  Buttons, UITypes;

type
  TEdPartsForm = class(TForm)
    Panel1: TPanel;
    Navigator: TDBNavigator;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdPartNo: TDBEdit;
    PrintBtn: TSpeedButton;
    DataComboBox1: TDBLookupComboBox;
    Bevel1: TBevel;
    PartsSource1: TDataSource;
    DBCheckBox1: TDBCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure PrintBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    procedure Edit(PartNo: Double);
  end;

var
  EdPartsForm: TEdPartsForm;

implementation

{$R *.dfm}

uses DataMod;


procedure TEdPartsForm.Edit(PartNo: Double);
begin
  MastData.cdsParts.Open;
  MastData.cdsParts.Locate('PartNo', PartNo, []);
  ShowModal;
end;

procedure TEdPartsForm.PrintBtnClick(Sender: TObject);
begin
  if MessageDlg('   Print this form?', mtConfirmation, [mbYes,mbNo], 0)
    = mrYes then Print;
end;

procedure TEdPartsForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := MastData.DataSetApplyUpdates(MastData.cdsParts, ModalResult = mrOK);
  {if CanClose then
    MastData.Transaction.CommitRetaining;
  }
end;

end.
