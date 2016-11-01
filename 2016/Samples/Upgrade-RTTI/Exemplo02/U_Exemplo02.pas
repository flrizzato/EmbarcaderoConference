unit U_Exemplo02;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,

  System.Rtti; //Biblioteca Necessaria

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1 : TForm1;
  rtCtx : TRttiContext;

implementation

{$R *.dfm}

//+------------------------------------------------+
//| Percorre todos os Componentes do Form e Altera |
//| As Propriedades "Caption" e "Text" para        |
//| "Embarcadero Conference 2016"                  |
//+------------------------------------------------+
procedure TForm1.Button1Click(Sender: TObject);
begin
   ShowMessage( Button1.Caption );
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
const
   C_STR_SUBST = 'Embarcadero Conference 2016';
var
   rtType     : TRttiType;
   rtTypeForm : TRttiType;
   rtProperty : TRttiProperty;
   rtField    : TRttiField;
   oComponent : TObject;
begin
   rtCtx := TRttiContext.Create;
   try
      rtTypeForm := rtCtx.GetType(Self.ClassType);

      for rtField in rtTypeForm.GetFields do
      begin
         oComponent := FindComponent(rtField.Name);

         if Assigned(oComponent) then
         begin
            rtType := rtCtx.GetType(oComponent.ClassType);

            rtProperty := rtType.GetProperty('Caption');
            if Assigned(rtProperty) then
               rtProperty.SetValue(oComponent, C_STR_SUBST);

            rtProperty := rtType.GetProperty('Text');
            if Assigned(rtProperty) then
               rtProperty.SetValue(oComponent, C_STR_SUBST);
         end;
      end;
   finally
      rtCtx.Free;
   end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
   rtType   : TRttiType;
   rtMethod : TRttiMethod;
   Args     : TArray<TValue>;
begin
   rtCtx := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(Button1.ClassType);

      rtMethod := rtType.GetMethod('Click');
      if Assigned(rtMethod) then
         rtMethod.Invoke(Button1, Args);

   finally
      rtCtx.Free;
   end;
end;

end.
