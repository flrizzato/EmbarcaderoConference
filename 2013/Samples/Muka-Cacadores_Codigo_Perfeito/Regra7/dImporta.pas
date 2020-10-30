unit dImporta;

interface

uses
  SysUtils, Classes, ComCtrls, Forms;

type
  TdmdImporta = class(TDataModule)
  private
    FProgressBar: TProgressBar;
    { Private declarations }
  public
    { Public declarations }
    function Importar: string;
    function ImportarOld: string;
    property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
  end;

var
  dmdImporta: TdmdImporta;

implementation

{$R *.dfm}

uses fPrincipal;

{ TdmdImporta }

function TdmdImporta.Importar: string;
var
  lArquivo: TextFile;
  lLinha: WideString;
  li : integer;
  lStlTexto : TStringList;
begin
  lStlTexto := TStringList.Create;
  try
    AssignFile(lArquivo, 'Exemplo.txt');
    Reset(lArquivo);
    try
      // Retorna numero de Linha
      li := 0;
      while not Eof(lArquivo) do
      begin
        Readln(lArquivo, lLinha);
        inc(li);
      end;

      if FProgressBar <> nil then
      begin
        FProgressBar.Position := 0;
        FProgressBar.Max := li;
      end;

      Reset(lArquivo);
      while not Eof(lArquivo) do
      begin
        Readln(lArquivo, lLinha);
        if (copy(lLinha,1,1) = '1') then
          lStlTexto.Add(copy(lLinha,3,40));

        if FProgressBar <> nil then
          FProgressBar.Position := FProgressBar.Position + 1;

        Application.ProcessMessages;
      end;

    finally
      CloseFile(lArquivo);
    end;
    Result := lStlTexto.Text;
  finally
    lStlTexto.free;
  end;
end;

function TdmdImporta.ImportarOld: string;
var
  lArquivo: TextFile;
  lLinha: WideString;
  li : integer;
  lStlTexto : TStringList;
begin
  lStlTexto := TStringList.Create;
  try
    AssignFile(lArquivo, 'Exemplo.txt');
    Reset(lArquivo);
    try
      // Retorna numero de Linha
      li := 0;
      while not Eof(lArquivo) do
      begin
        Readln(lArquivo, lLinha);
        inc(li);
      end;

      frmPrincipal.pgbStatus.Position := 0;
      frmPrincipal.pgbStatus.Max := li;

      Reset(lArquivo);
      while not Eof(lArquivo) do
      begin
        Readln(lArquivo, lLinha);
        if (copy(lLinha,1,1) = '1') then
          lStlTexto.Add(copy(lLinha,3,40));

        frmPrincipal.pgbStatus.Position := frmPrincipal.pgbStatus.Position + 1;

        Application.ProcessMessages;
      end;

    finally
      CloseFile(lArquivo);
    end;
    Result := lStlTexto.Text;
  finally
    lStlTexto.free;
  end;

end;

end.
