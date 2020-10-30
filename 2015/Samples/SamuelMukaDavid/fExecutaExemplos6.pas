unit fExecutaExemplos6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Exemplo6,
  Exemplo6_1;

type
  TfrmExecutaExemplos6 = class(TForm)
    Label1: TLabel;
    rdgTipo: TRadioGroup;
    btnExemplo6: TButton;
    procedure btnExemplo6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure PreencherFicha(pFicha: TFichaUsuario);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExecutaExemplos6: TfrmExecutaExemplos6;

implementation

{$R *.dfm}

procedure TfrmExecutaExemplos6.btnExemplo6Click(Sender: TObject);
var
  lFicha : TFichaUsuario;
  lExportaFichaUsuario : TExportaFichaUsuario;
  lTipoFicha: TTipoFicha;
begin
  lFicha := TFichaUsuario.Create;

  try
    PreencherFicha(lFicha);

    lTipoFicha := TTipoFicha(rdgTipo.ItemIndex);

    lExportaFichaUsuario :=
      TExportaFichaUsuarioFactory.ObterExportador(lTipoFicha);
    lExportaFichaUsuario.Exportar(lFicha,'Ficha');

  finally
    lFicha.Free;
    lExportaFichaUsuario.Free;
  end;

end;

procedure TfrmExecutaExemplos6.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmExecutaExemplos6.PreencherFicha(pFicha: TFichaUsuario);
begin
  pFicha.Codigo := 1212;
  pFicha.Nome   := 'Ana Luiza';
  pFicha.Data   := Date;
  pFicha.Cargo  := 'Gerente';
end;


end.
