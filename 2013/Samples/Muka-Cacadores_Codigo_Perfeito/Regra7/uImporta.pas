unit uImporta;

interface

uses
  ComCtrls, Classes, Forms;

type
  TImporta = class
    FProgressBar: TProgressBar;
    function Importar: string;
    constructor Create(pProgressBar: TProgressBar);
    class function CarregarArquivo(pProgressBar: TProgressBar): string;
  end;

implementation

{ TImporta }

class function TImporta.CarregarArquivo(pProgressBar: TProgressBar): string;
var
  lImporta : TImporta;
begin
  lImporta := TImporta.Create(pProgressBar);
  try
    Result := lImporta.Importar;
  finally
    lImporta.Free;
  end;
end;

constructor TImporta.Create(pProgressBar: TProgressBar);
begin
  FProgressBar := pProgressBar;
end;

function TImporta.Importar: string;
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


end.
