program Encapsulamento;

uses
  Vcl.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uFrmEstatico in 'uFrmEstatico.pas' {Form1},
  uFrmDinâmico in 'uFrmDinâmico.pas' {Form2},
  uConnection in 'uConnection.pas',
  uFrmEncapsulado in 'uFrmEncapsulado.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
