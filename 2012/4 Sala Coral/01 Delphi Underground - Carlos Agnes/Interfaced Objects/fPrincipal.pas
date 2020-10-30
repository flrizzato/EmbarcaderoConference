unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs;

type
  ITelefone = interface
    procedure FazerLigacao;
    procedure ReceberLigacao;
  end;

  IMP3Player = interface
    procedure TocarMusica;
  end;

  ICameraFotografica = interface
    procedure Fotografar;
  end;

  TTelefoneCelular = class(TInterfacedObject, ITelefone, IMP3Player, ICameraFotografica)
  public
    destructor Destroy; override;

    procedure FazerLigacao;
    procedure ReceberLigacao;
    procedure TocarMusica;
    procedure Fotografar;
  end;

  TfrmPrincipal = class(TForm)
    btnUtilizandoContagemReferencias: TButton;
    procedure btnUtilizandoContagemReferenciasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

{ TTelefoneCelular }

destructor TTelefoneCelular.Destroy;
begin
  ShowMessage('TTelefoneCelular.Destroy');
  inherited;
end;

procedure TTelefoneCelular.FazerLigacao;
begin
  ShowMessage('TTelefoneCelular.FazerLigacao');
end;

procedure TTelefoneCelular.Fotografar;
begin
  ShowMessage('TTelefoneCelular.Fotografar');
end;

procedure TTelefoneCelular.ReceberLigacao;
begin
  ShowMessage('TTelefoneCelular.ReceberLigacao');
end;

procedure TTelefoneCelular.TocarMusica;
begin
  ShowMessage('TTelefoneCelular.TocarMusica');
end;

procedure TfrmPrincipal.btnUtilizandoContagemReferenciasClick(Sender: TObject);
var
  lTelefoneCelular: TTelefoneCelular;
  lCelular: ITelefone;
  lMP3Player: IMP3Player;
  lCameraFotografica: ICameraFotografica;
begin
  lTelefoneCelular := TTelefoneCelular.Create;

  lCelular := lTelefoneCelular;
  lMP3Player := lTelefoneCelular;
  lCameraFotografica := lTelefoneCelular;

  lCelular.FazerLigacao;
  lMP3Player.TocarMusica;
  lCameraFotografica.Fotografar;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

end.
