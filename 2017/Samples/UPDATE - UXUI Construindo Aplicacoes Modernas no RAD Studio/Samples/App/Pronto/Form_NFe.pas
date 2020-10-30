unit Form_NFe;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit, FMX.SearchBox,
  FMX.TabControl, System.Actions, FMX.ActnList;

type
  TfrmNotaFiscalEletronica = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    ListBox2: TListBox;
    ListBoxHeader1: TListBoxHeader;
    Label2: TLabel;
    StyleBook1: TStyleBook;
    TabControl1: TTabControl;
    tabNotaLista: TTabItem;
    TabNotaCancelar: TTabItem;
    tabNotaCorrecao: TTabItem;
    tabNotaStatus: TTabItem;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    SearchBox1: TSearchBox;
    tabNotaCriar: TTabItem;
    ActionList1: TActionList;
    ChangeNotaCancelar: TChangeTabAction;
    ChangeNotaCorrecao: TChangeTabAction;
    ChangeNotaCriar: TChangeTabAction;
    ChangeNotaListar: TChangeTabAction;
    ChangeNotaStatus: TChangeTabAction;
    ListBoxItem5: TListBoxItem;
    Button1: TButton;
    ToolBar2: TToolBar;
    Label3: TLabel;
    ListBoxItem6: TListBoxItem;
    Button2: TButton;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ToolBar3: TToolBar;
    Label4: TLabel;
    ToolBar4: TToolBar;
    Label5: TLabel;
    ToolBar5: TToolBar;
    Label6: TLabel;
    ToolBar6: TToolBar;
    Label7: TLabel;
    ListBox3: TListBox;
    ListBoxItem10: TListBoxItem;
    Label8: TLabel;
    Edit1: TEdit;
    ListBoxItem11: TListBoxItem;
    Label9: TLabel;
    Edit2: TEdit;
    ListBoxItem12: TListBoxItem;
    Label10: TLabel;
    Edit3: TEdit;
    ListBox4: TListBox;
    ListBoxItem13: TListBoxItem;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotaFiscalEletronica: TfrmNotaFiscalEletronica;

implementation

{$R *.fmx}

procedure TfrmNotaFiscalEletronica.FormCreate(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  TabControl1.TabPosition := TabControl1.TabPosition.tpNone;
end;

end.
