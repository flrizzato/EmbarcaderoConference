unit fExecutaExemplos4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Exemplo4, Exemplo4_1, Exemplo4_2,
  Exemplo4_3, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmExecutaExemplos4 = class(TForm)
    rdgTipo: TRadioGroup;
    btnExemplo4: TButton;
    Label1: TLabel;
    procedure btnExemplo4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure PreencherFicha(pFicha: TFichaUsuario);
  public
    { Public declarations }
  end;

var
  frmExecutaExemplos4: TfrmExecutaExemplos4;

implementation

{$R *.dfm}

procedure TfrmExecutaExemplos4.btnExemplo4Click(Sender: TObject);
var
  lFicha : TFichaUsuario;
begin
  case rdgTipo.ItemIndex of
    0: lFicha := TFichaUsuarioTXT.Create;
    1: lFicha := TFichaUsuarioXML.Create;
    2: lFicha := TFichaUsuarioJson.Create;
  end;

  try
    PreencherFicha(lFicha);

    lFicha.Exportar('Ficha');
  finally
    lFicha.Free;
  end;
end;


procedure TfrmExecutaExemplos4.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmExecutaExemplos4.PreencherFicha(pFicha: TFichaUsuario);
begin
  pFicha.Codigo := 1212;
  pFicha.Nome   := 'Ana Luiza';
  pFicha.Data   := Date;
  pFicha.Cargo  := 'Gerente';
end;

end.
