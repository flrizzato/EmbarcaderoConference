unit U_Exemplo01;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  System.Rtti; //Biblioteca necessaria

type
   TMinhaClasse = class(TObject)
   private
      FCodigo : Integer;
      FNome : String;
      FDataClasse : TDateTime;
   public
      property Codigo : Integer read FCodigo write FCodigo;
      property Nome : string read FNome write FNome;
      property DataClasse : TDateTime read FDataClasse write FDataClasse;
   end;

   TF_Exemplo01 = class(TForm)
      MPropriedades: TMemo;
      MCampos: TMemo;
      MMetodos: TMemo;
      BtnListaForm: TButton;
      Propriedades: TLabel;
      Métodos: TLabel;
      Campos: TLabel;
      BtnListaClasse: TButton;
      BtnObterProp: TButton;
      procedure ListarDados(AObj : TObject);
      procedure BtnListaFormClick(Sender: TObject);
      procedure BtnListaClasseClick(Sender: TObject);
      procedure BtnObterPropClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   F_Exemplo01: TF_Exemplo01;

implementation

{$R *.dfm}

procedure TF_Exemplo01.BtnListaClasseClick(Sender: TObject);
var
   minhaClasse : TMinhaClasse;
begin
   minhaClasse := TMinhaClasse.Create;
   try
      ListarDados(minhaClasse);
   finally
      minhaClasse.Free;
   end;
end;

procedure TF_Exemplo01.BtnListaFormClick(Sender: TObject);
begin
   ListarDados(F_Exemplo01);
end;

procedure TF_Exemplo01.BtnObterPropClick(Sender: TObject);
var
   rtCtx : TRttiContext;
   rtType : TRttiType;
   rtProperty : TRttiProperty;
   valor  : TValue;
begin
   rtCtx := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(F_Exemplo01.ClassType);

      //Procupa pela prop Caption
      rtProperty := rtType.GetProperty('Caption');

      if Assigned(rtProperty) then
      begin
         valor := rtProperty.GetValue(F_Exemplo01);

         if not valor.IsEmpty then
            ShowMessage(rtProperty.Name + ' : ' + valor.ToString );
      end;

   finally
      rtCtx.Free;
   end;
end;

procedure TF_Exemplo01.ListarDados(AObj: TObject);
var
   rtCtx : TRttiContext;
   rtType : TRttiType;
   rtProperty : TRttiProperty;
   rtField : TRttiField;
   rtMethod : TRttiMethod;
begin
   MPropriedades.Lines.Clear;
   MCampos.Lines.Clear;
   MMetodos.Lines.Clear;

   rtCtx := TRttiContext.Create;
   try
      rtType := rtCtx.GetType(AObj.ClassType);
      if Assigned(rtType) then
      begin
         //Propriedades
         for rtProperty in rtType.GetProperties do
         begin
            MPropriedades.Lines.Add( rtProperty.Name + ' : ' + rtProperty.PropertyType.ToString );
         end;

         //Campos
         for rtField in rtType.GetFields do
         begin
            MCampos.Lines.Add( rtField.Name + ' : ' + rtField.FieldType.ToString );
         end;

         //Metodos
         for rtMethod in rtType.GetMethods do
         begin
            MMetodos.Lines.Add(  rtMethod.ToString );
         end;
      end;
   finally
      rtCtx.Free;
   end;
end;

end.
