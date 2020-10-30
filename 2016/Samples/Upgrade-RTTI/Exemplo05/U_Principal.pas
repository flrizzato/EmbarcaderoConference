unit U_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, U_CadastroCliente, Vcl.StdCtrls;

type
   TF_Principal = class(TForm)
      Button1: TButton;
      procedure Button1Click(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   F_Principal: TF_Principal;

implementation

{$R *.dfm}

procedure TF_Principal.Button1Click(Sender: TObject);
begin
   F_CadastroCliente := TF_CadastroCliente.Create(Application);
   try
      F_CadastroCliente.ShowModal;
   finally
      F_CadastroCliente.Free;
   end;
end;

end.
