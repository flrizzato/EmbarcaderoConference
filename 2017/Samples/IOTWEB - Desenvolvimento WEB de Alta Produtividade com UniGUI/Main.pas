unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniLabel, uniBasicGrid,
  uniDBGrid, uniEdit, uniDBEdit, uniGUIBaseClasses, uniButton;

type
  TMainForm = class(TUniForm)
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniButton4: TUniButton;
    UniButton5: TUniButton;
    UniDBEdit1: TUniDBEdit;
    UniDBEdit2: TUniDBEdit;
    UniDBEdit3: TUniDBEdit;
    UniDBGrid1: TUniDBGrid;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniDBGrid1CellClick(Column: TUniDBGridColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, UntDM;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniButton1Click(Sender: TObject);
begin
  DM.qryClientes.Append;
end;

procedure TMainForm.UniDBGrid1CellClick(Column: TUniDBGridColumn);
begin
  if Column.Field = DM.qryClientesIMPRIMIR then
    showmessage('imprimir');
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  DM.qryClientes.Open();
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
