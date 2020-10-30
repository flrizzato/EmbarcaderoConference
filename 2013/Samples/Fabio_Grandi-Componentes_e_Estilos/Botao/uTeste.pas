unit uTeste;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uBotaoSeguro, FMX.Edit, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, FMX.Ani, FMX.Objects;

type
  TForm1 = class(TForm)
    BotaoSeguro1: TBotaoSeguro;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    BotaoSeguro2: TBotaoSeguro;
    Edit2: TEdit;
    StyleBook1: TStyleBook;
    CheckBox2: TCheckBox;
    procedure BotaoSeguro1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1ChangeTracking(Sender: TObject);
    procedure Edit2ChangeTracking(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.BotaoSeguro1Click(Sender: TObject);
begin
  ShowMessage('Clicou');
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  BotaoSeguro1.Confirma := CheckBox1.IsChecked;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
var
  aRes: TResourceStream;
begin
//  if CheckBox2.IsChecked then
//    StyleBook1.Resource.LoadFromFile('C:\Evento\Botao\Estilos.style')
//  else
//    StyleBook1.Resource.LoadFromFile('C:\Evento\Botao\Estilos2.style');

  try
    if CheckBox2.IsChecked then
      aRes := TResourceStream.Create(0,'ESTILOS',RT_RCDATA)
    else
      aRes := TResourceStream.Create(0,'ESTILOS2',RT_RCDATA);
    aRes.Position := 0;
    StyleBook1.Resource.LoadFromStream(aRes);
  finally
    aRes.Free;
  end;

end;

procedure TForm1.Edit1ChangeTracking(Sender: TObject);
begin
  BotaoSeguro1.Mensagem := Edit1.Text;
  CheckBox1.IsChecked := BotaoSeguro1.Confirma;
end;

procedure TForm1.Edit2ChangeTracking(Sender: TObject);
begin
  TText(BotaoSeguro1.FindStyleResource('subtext')).Text := Edit2.Text;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  aRes: TResourceStream;
begin
  CheckBox1.IsChecked := BotaoSeguro1.Confirma;
  Edit1.Text := BotaoSeguro1.Mensagem;

{$IFDEF MACOS}
  aRes := TResourceStream.Create(0,'ESTILO_MAC',RT_RCDATA);
{$ENDIF}
{$IFDEF MSWINDOWS}
  aRes := TResourceStream.Create(0,'ESTILOS2',RT_RCDATA);
{$ENDIF}
  try
    aRes.Position := 0;
    StyleBook1.Resource.LoadFromStream(aRes);
  finally
    aRes.Free;
  end;

end;

end.
