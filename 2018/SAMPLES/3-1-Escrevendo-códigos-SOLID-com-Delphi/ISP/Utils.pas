unit Utils;

interface

type
  TServicoEmail = class
    class procedure EnviarEmail(AObj: TObject; const ARemetente: string);
  end;

  TTipoImpressao = (impArquivo, impTimbrado, impImpressora);

  TImpressao = class
    class procedure Imprimir(AObj: TObject; const ATipoImpressao: TTipoImpressao);
  end;

implementation

{ TServicoEmail }

class procedure TServicoEmail.EnviarEmail(AObj: TObject;
  const ARemetente: string);
begin
  //
end;

{ TImpressao }

class procedure TImpressao.Imprimir(AObj: TObject;
  const ATipoImpressao: TTipoImpressao);
begin
  //
end;

end.
