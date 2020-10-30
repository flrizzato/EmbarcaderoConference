unit Unit2;

interface

type
  TUsuario = class
  private
    FOID: string;
    FNome: string;
  public
    property OID: string read FOID write FOID;
    property Nome: string read FNome write FNome;
  end;

implementation

end.
