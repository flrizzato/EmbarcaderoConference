unit frmMoldeTelasUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Edit, FMX.ListBox, FMX.Objects, Data.DB, Datasnap.DBClient,
  FMX.Gestures, FMX.Controls.Presentation;

type
  TfrmMoldeTelas = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ToolBar1: TToolBar;
    ComboBox1: TComboBox;
    edtBuscar: TEdit;
    btnBuscar: TButton;
    Image1: TImage;
    ClientDataSet1: TClientDataSet;
    gmGestos: TGestureManager;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMoldeTelas: TfrmMoldeTelas;

implementation

{$R *.fmx}
uses ClientModuleDistrimedUnt, DBXCommon, DBXCDSReaders;

procedure TfrmMoldeTelas.FormActivate(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem1;
  ComboBox1.ItemIndex := 0;

end;

end.
