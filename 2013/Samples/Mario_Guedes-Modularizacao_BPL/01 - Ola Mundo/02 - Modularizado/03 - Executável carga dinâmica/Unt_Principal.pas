unit Unt_Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  shlobj;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
const
  C_PLUGIN = 'DC2013.OlaMundo.Pacote.bpl.XE5';
var
  hModulo       : NativeUInt;
  _ola_mundo    : function: string;
  sMensagem     : string;
  iError        : Cardinal;
  sCaminho      : array [0 .. MAX_PATH] of Char;
  sArquivoPlugIn: string;
begin
  { Para efeitos *didáticos* estamos procurando o plugin no Desktop }
  ShGetSpecialFolderPath(0, sCaminho, CSIDL_DESKTOP, False);
  sArquivoPlugIn := sCaminho;
  sArquivoPlugIn := sArquivoPlugIn + '\02 - OlaMundo - Pacote\' + C_PLUGIN;

  { Validando a existência do PlugIn }
  if not(FileExists(sArquivoPlugIn)) then
  begin
    raise Exception.CreateFmt('O arquivo [%s] não foi localizado!', [C_PLUGIN]);
  end;

  { Carregando o módulo }
  hModulo := LoadPackage(sArquivoPlugIn);
  if (hModulo <= 0) then
  begin
    iError := GetLastError;
    ShowMessageFmt('Erro ao carregar a BPL: [%d] - %s', [iError, SysErrorMessage(iError)]);
    Exit;
  end;

  { Retornando o endereço de um procedimento }
  _ola_mundo := GetProcAddress(hModulo, 'OlaMundo');
  if (Assigned(_ola_mundo)) then
  begin
    { Executando o procedimento }
    sMensagem := _ola_mundo;
    ShowMessage(sMensagem);
  end;

  { Descarregando o módulo }
  UnloadPackage(hModulo);
end;

end.
