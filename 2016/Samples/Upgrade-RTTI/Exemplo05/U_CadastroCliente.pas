unit U_CadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_CadastroBase, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
   TF_CadastroCliente = class(TF_CadastroBase)
      MRazaoSocial: TEdit;
      MEndereco: TEdit;
      Label1: TLabel;
      Label2: TLabel;
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   F_CadastroCliente: TF_CadastroCliente;

implementation

{$R *.dfm}

end.
