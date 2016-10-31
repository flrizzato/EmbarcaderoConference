unit fExecutaExemplos5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Exemplo5,
  Exemplo5_1;

type
  TfrmExecutaExemplos5 = class(TForm)
    Label1: TLabel;
    rdgTipo: TRadioGroup;
    btnExemplo5: TButton;
    procedure btnExemplo5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure PreencherFicha(pFicha: TFichaUsuario);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExecutaExemplos5: TfrmExecutaExemplos5;

implementation

{$R *.dfm}

procedure TfrmExecutaExemplos5.btnExemplo5Click(Sender: TObject);
var
  lFicha : TFichaUsuario;
  lExportaFichaUsuario : TExportaFichaUsuario;
begin
  lFicha := TFichaUsuario.Create;

  try
    PreencherFicha(lFicha);

    case rdgTipo.ItemIndex of
      0: lExportaFichaUsuario := TExportaFichaUsuarioTxt.Create(lFicha);
      1: lExportaFichaUsuario := TExportaFichaUsuarioXML.Create(lFicha);
      2: lExportaFichaUsuario := TExportaFichaUsuarioJson.Create(lFicha);
    end;

    lExportaFichaUsuario.Exportar('Ficha');
  finally
    lFicha.Free;
    lExportaFichaUsuario.Free;
  end;


end;

procedure TfrmExecutaExemplos5.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmExecutaExemplos5.PreencherFicha(pFicha: TFichaUsuario);
begin
  pFicha.Codigo := 1212;
  pFicha.Nome   := 'Ana Luiza';
  pFicha.Data   := Date;
  pFicha.Cargo  := 'Gerente';
end;

end.
