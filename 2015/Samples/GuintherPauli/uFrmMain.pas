{
Sobre o autor:
Guinther Pauli
Cursos Treinamentos Consultoria
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#,ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://guintherpauli.blogspot.com
http://www.gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
Emails: guintherpauli@gmail.com; guinther@gpauli.com
Suporte Skype: guinther.pauli
}
unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TFrmMain = class(TForm)
    lstForms: TComboBox;
    Image1: TImage;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure lstFormsChange(Sender: TObject);
  private
    procedure ListAllFormClasses(Target: TStrings);
    function GetFormByCaption(ACaption: string): TForm;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  System.Rtti;

function TFrmMain.GetFormByCaption(ACaption: string): TForm;
var
  i: integer;
begin
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].Caption = ACaption then
      exit(Screen.Forms[i]);
end;

procedure TFrmMain.ListAllFormClasses(Target: TStrings);
var
  aClass: TClass;
  context: TRttiContext;
  types: TArray<TRttiType>;
  aType: TRttiType;
begin
  context := TRttiContext.Create;
  types := context.GetTypes;
  for aType in types do
  begin
    if aType.TypeKind = tkClass then
    begin
      aClass := aType.AsInstance.MetaclassType;
      if (aClass <> TForm) and aClass.InheritsFrom(TForm) then
        Target.Add(aClass.ClassName);
    end;
  end;
end;

procedure TFrmMain.lstFormsChange(Sender: TObject);
var
  frm: TForm;
begin
  frm := GetFormByCaption(lstForms.Items[lstForms.ItemIndex]);
  frm.Position := poScreenCenter;
  frm.ShowModal();
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  i: integer;
begin
  lstForms.Items.Clear();
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i] <> self then
     lstForms.Items.Add(Screen.Forms[i].Caption);
  //ListAllFormClasses(lstForms.Items);
end;

end.
