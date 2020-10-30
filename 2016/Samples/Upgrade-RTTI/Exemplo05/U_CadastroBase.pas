unit U_CadastroBase;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
   Vcl.StdCtrls, Vcl.Buttons, System.Rtti;

type
   TF_CadastroBase = class(TForm)
      Panel1: TPanel;
      BitBtn1: TBitBtn;
      BitBtn2: TBitBtn;
      procedure BitBtn1Click(Sender: TObject);
      procedure BitBtn2Click(Sender: TObject);
   private
   public
      function Consiste() : Boolean;
   end;

var
   F_CadastroBase: TF_CadastroBase;

implementation

{$R *.dfm}

procedure TF_CadastroBase.BitBtn1Click(Sender: TObject);
begin
   Close;
end;

procedure TF_CadastroBase.BitBtn2Click(Sender: TObject);
begin
   if Consiste() then
   begin
      ShowMessage('Validou !!');
   end;
end;

function TF_CadastroBase.Consiste: Boolean;
var
   rtCtx      : TRttiContext;   //Contexto Geral
   rtType     : TRttiType;      //Reflexao do Formulario
   rtTypeComp : TRttiType;      //Reflexao do Componente
   rtField    : TRttiField;     //Reflexao dos Campos
   rtMethod   : TRttiMethod;    //Reflexao dos Metodos
   rtProp     : TRttiProperty;  //Reflexao de Propriedades
   cValText   : String;         //Conteudo do Text do Campo
   cValHint   : String;         //Conteudo do Hint do Campo
   oComp      : TComponent;     //Referencia ao Componente
   aArgs      : TArray<TValue>; //Array de Argumentos
begin
   Result := True;
   rtCtx  := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(Self.ClassType);

      for rtField in rtType.GetDeclaredFields do
      begin
         oComp := FindComponent(rtField.Name);

         if Assigned(oComp) then
         begin
            cValText   := EmptyStr;
            cValHint   := EmptyStr;
            rtTypeComp := rtCtx.GetType(oComp.ClassType);

            rtProp := rtTypeComp.GetProperty('Text');
            if Assigned(rtProp) then
               cValText := rtProp.GetValue(oComp).ToString;

            rtProp := rtTypeComp.GetProperty('Hint');
            if Assigned(rtProp) then
               cValHint := rtProp.GetValue(oComp).AsString;

            if (Trim(cValHint) <> EmptyStr) and (Trim(cValText) = EmptyStr) then
            begin
               Result := False;
               ShowMessage( Format('%s deve ser informado !!',[cValHint]) );

               rtMethod := rtTypeComp.GetMethod('SetFocus');
               if Assigned(rtMethod) then
                  rtMethod.Invoke(oComp, aArgs);
            end;
         end;
      end;
   finally
      rtCtx.Free;
   end;
end;

end.
