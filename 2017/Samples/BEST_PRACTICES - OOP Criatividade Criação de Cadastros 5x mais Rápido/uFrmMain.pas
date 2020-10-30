unit uFrmMain;

interface

uses
   SysUtils, Variants,
  Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Model.FactoryForm;

type
  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

procedure TForm11.Button1Click(Sender: TObject);
begin
  TFactoryForm.GetInstance.GetForm(tfGrupo).ShowModal;
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
  TFactoryForm.GetInstance.GetForm(tfProduto).ShowModal;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  TFactoryForm.GetInstance.GetForm(tfFilm).ShowModal;
end;

end.
