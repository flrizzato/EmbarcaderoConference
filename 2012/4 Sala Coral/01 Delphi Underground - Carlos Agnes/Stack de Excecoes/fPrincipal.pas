unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs;

type
  TfrmPrincipal = class(TForm)
    btnTratamentoStackExcecoes: TButton;
    btnSintaxe: TButton;
    procedure btnTratamentoStackExcecoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSintaxeClick(Sender: TObject);
  private
    procedure TratadorExcecoes(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uCliente;

procedure TfrmPrincipal.btnSintaxeClick(Sender: TObject);
begin
  try

  except
    on E: Exception do
    begin
      E.RaiseOuterException(Exception.Create('Nova excecão contendo a exceção capturada em InnerException.'));
    end;
  end;
end;

procedure TfrmPrincipal.btnTratamentoStackExcecoesClick(Sender: TObject);
var
  lCliente: TClientePF;
begin
  lCliente := TClientePF.Create;

  try
    lCliente.Nome := 'João da Silva';
    lCliente.Endereco := 'Centro de Convenções Rebouças';
    lCliente.CPF := 11122233385;

    lCliente.Salvar;
  finally
    lCliente.Free;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Application.OnException := TratadorExcecoes;
end;

procedure TfrmPrincipal.TratadorExcecoes(Sender: TObject; E: Exception);
var
  lMensagem: string;
begin
  lMensagem := '';
  while Assigned(E) do
  begin
    if lMensagem <> '' then
    begin
      lMensagem := lMensagem + sLineBreak + StringOfChar('-', 80) + sLineBreak;
    end;
    lMensagem := lMensagem + E.Message;

    E := E.InnerException;
  end;

  ShowMessage(lMensagem);
end;

end.
