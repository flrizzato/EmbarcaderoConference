unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs;

type
  TfrmPrincipal = class(TForm)
    btnTVirtualMethodInterceptor: TButton;
    btnSimulandoOrientacaoAspectos: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnTVirtualMethodInterceptorClick(Sender: TObject);
    procedure btnSimulandoOrientacaoAspectosClick(Sender: TObject);
  private
    FVMI: TVirtualMethodInterceptor;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uTeste, uNotaFiscal;

procedure TfrmPrincipal.btnSimulandoOrientacaoAspectosClick(Sender: TObject);
var
  lNotaFiscal: TNotaFiscal;
begin
  lNotaFiscal := TNotaFiscal.Create;

  try
    lNotaFiscal.Salvar;
  finally
    lNotaFiscal.Free;
  end;
end;

procedure TfrmPrincipal.btnTVirtualMethodInterceptorClick(Sender: TObject);
var
  lTeste: TTeste;
begin
  lTeste := TTeste.Create;

  try
    FVMI.Proxify(lTeste);

    try
      lTeste.Teste;
    finally
      FVMI.Unproxify(lTeste);
    end;
  finally
    lTeste.Free;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FVMI := TVirtualMethodInterceptor.Create(TTeste);

  FVMI.OnBefore :=
    procedure(Instance: TObject;
      Method: TRttiMethod; const Args: TArray<TValue>; out DoInvoke: Boolean;
      out Result: TValue)
    begin
      ShowMessage('Injetando código antes de métodos virtuais');
    end;
end;

end.
