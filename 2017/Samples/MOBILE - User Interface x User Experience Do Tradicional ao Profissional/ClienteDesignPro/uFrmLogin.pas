unit uFrmLogin;

interface

uses
   System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
   System.IOUtils, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
   FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.wwEdit, FMX.StdCtrls,
   FMX.Layouts, FMX.ListBox, FGX.ProgressDialog, Data.FireDACJSONReflect;

type
   TfrmLogin = class(TForm)
      StyleBook1: TStyleBook;
      Image1: TImage;
      Image2: TImage;
      Image4: TImage;
      edtusuario: TwwEdit;
      wwEdit1: TwwEdit;
      Layout1: TLayout;
      Layout2: TLayout;
      Layout6: TLayout;
      Layout4: TLayout;
      Layout5: TLayout;
      ListBox4: TListBox;
      ListBoxItem8: TListBoxItem;
      ListBoxItem9: TListBoxItem;
      lytContent: TLayout;
      ScrollBoxContent: TScrollBox;
      ListBox3: TListBox;
      ListBoxItem5: TListBoxItem;
      ListBoxItem6: TListBoxItem;
      btnLogin: TButton;
      ListBoxItem7: TListBoxItem;
      Image3: TImage;
      edtSenha: TwwEdit;
      lytLembrarSenha: TLayout;
      ListBox5: TListBox;
      ListBoxItem10: TListBoxItem;
      ListBoxItem11: TListBoxItem;
      swtLembrarSenha: TSwitch;
      lblLembrarSenha: TLabel;
      lytUsuario: TLayout;
      ListBoxItem12: TListBoxItem;
      edtEmail: TEdit;
      lytNotConnected: TLayout;
      rectNotConnected: TRectangle;
      lblNotConnected: TLabel;
      lytSenha: TLayout;
      Image6: TImage;
      wwEdit3: TwwEdit;
      procedure btnLoginClick(Sender: TObject);
      procedure edtusuarioTyping(Sender: TObject);
      procedure edtSenhaTyping(Sender: TObject);
      procedure FormCreate(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses uFrmMobile;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
 begin
   frmMobile.fgActivityDialogMobile.Message := 'Autenticando Usuário!';
   frmMobile.fgActivityDialogMobile.Show;

         try
            frmMobile.tbClient.ActiveTab := frmMobile.tbsCliente;

            frmMobile.ShowModal(
               procedure(ModalResult: TModalResult)
               begin

               end);

         finally
            // frmMobile.DisposeOf;
         end;
 end;

procedure TfrmLogin.edtSenhaTyping(Sender: TObject);
begin
   TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text);

   if (Length(TEdit(Sender).Text) > TEdit(Sender).MaxLength) then
      TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text).Substring(0, TEdit(Sender).MaxLength);
end;

procedure TfrmLogin.edtusuarioTyping(Sender: TObject);
begin
   TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text);

   if (Length(TEdit(Sender).Text) > TEdit(Sender).MaxLength) then
      TEdit(Sender).Text := AnsiLowerCase(TEdit(Sender).Text).Substring(0, TEdit(Sender).MaxLength);
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
   Self.lytNotConnected.Height := 16;
   Self.lblNotConnected.Font.Size := 10;
   Self.lblNotConnected.FontColor := TAlphaColorRec.White;
   Self.lblNotConnected.Repaint;

   {$IFDEF MSWINDOWS}
   Self.Top := 8;
   Self.Left := 8;
   Self.Height := 640;
   Self.Width := 360;
   Self.ClientHeight := Self.Height;
   Self.ClientWidth := Self.Width;
   {$ENDIF}
end;

end.

