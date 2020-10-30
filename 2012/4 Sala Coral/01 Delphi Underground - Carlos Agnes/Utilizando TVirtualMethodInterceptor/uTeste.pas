unit uTeste;

interface

type
  TTeste = class
  public
    procedure Teste; virtual;
  end;

implementation

uses
  FMX.Dialogs;

{ TTeste }

procedure TTeste.Teste;
begin
  ShowMessage('Execução de TTeste.Teste');
end;

end.
