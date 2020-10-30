unit FMXFormCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.SearchBox, FMX.Layouts;

type
  TFormCadastro = class(TForm)
    ListBox1: TListBox;
    SearchBox1: TSearchBox;
    ListBoxHeader1: TListBoxHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadastro: TFormCadastro;

implementation

{$R *.fmx}

end.
