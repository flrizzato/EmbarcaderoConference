unit fExecutaExemplos7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Exemplo7_3,
  Exemplo7, Exemplo7_2, Exemplo7_4, Exemplo7_5, Exemplo7_6;

type
  TfrmExecutaExemplos7 = class(TForm)
    Label1: TLabel;
    rdgTipo: TRadioGroup;
    btnExemplo7: TButton;
    btnExemplo7Admin: TButton;
    btnExemplo7Helper: TButton;
    procedure btnExemplo7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExemplo7AdminClick(Sender: TObject);
    procedure btnExemplo7HelperClick(Sender: TObject);
  private
    procedure PreencherFicha(pFicha: TFichaUsuario);
    procedure PreencherFichaAdmin(pFicha: TAdministrador);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExecutaExemplos7: TfrmExecutaExemplos7;

implementation


{$R *.dfm}

procedure TfrmExecutaExemplos7.btnExemplo7Click(Sender: TObject);
var
  lFicha: TFichaUsuario;
  lGerenciadorFicha: TGerenciadorFicha;
  lTipoFicha: TTipoFicha;
begin
  lFicha := TFichaUsuario.Create;

  try
    PreencherFicha(lFicha);


    lGerenciadorFicha := TGerenciadorFicha.Create(lFicha);

    lTipoFicha := TTipoFicha(rdgTipo.ItemIndex);
    lGerenciadorFicha.Exportar(TExportaFichaUsuarioFactory.ObterExportador(lTipoFicha),'Ficha');

  finally
    lGerenciadorFicha.Free;
  end;

end;

procedure TfrmExecutaExemplos7.btnExemplo7HelperClick(Sender: TObject);
var
  lFicha: TFichaUsuario;
begin
  lFicha := TFichaUsuario.Create;
  PreencherFicha(lFicha);
  TGerenciadorFicha.CriarExportarDestruir(lFicha,TTipoFicha(rdgTipo.ItemIndex),'Ficha');
end;

procedure TfrmExecutaExemplos7.btnExemplo7AdminClick(Sender: TObject);
var
  lFicha: TFichaAdministrador;
  lGerenciadorFicha: TGerenciadorFicha;
  lTipoFicha: TTipoFicha;
begin
  lFicha := TFichaAdministrador.Create;

  try
    PreencherFichaAdmin(lFicha);

    lGerenciadorFicha := TGerenciadorFicha.Create(lFicha);

    lTipoFicha := TTipoFicha(rdgTipo.ItemIndex);
    lGerenciadorFicha.Exportar(TExportaFichaUsuarioFactory.ObterExportador(lTipoFicha),'FichaAdm');

  finally
    lGerenciadorFicha.Free;
  end;

end;

procedure TfrmExecutaExemplos7.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmExecutaExemplos7.PreencherFicha(pFicha: TFichaUsuario);
begin
  pFicha.Codigo := 1212;
  pFicha.Nome   := 'Landerson Gomes';
  pFicha.Data   := Now;
  pFicha.Cargo  := 'Tenente';
end;

procedure TfrmExecutaExemplos7.PreencherFichaAdmin(pFicha: TAdministrador);
begin
  pFicha.Codigo := 2114;
  pFicha.Nome   := 'Marcelo Varela';
  pFicha.Nivel  := 8;
  pFicha.Setor  := 'Operações Tática';
end;

end.
