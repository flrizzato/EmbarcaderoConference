unit uTestes;

interface

uses
  SysUtils, DUnitX.TestFramework, UExemplo;

type
  [TestFixture]
  TUsuarioTestes = class
  private
    FUsuario: TUsuario;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ValidarMetodoEntrarNoSistema;
  end;

implementation

uses
  Delphi.Mocks;

{ TUsuarioTestes }

procedure TUsuarioTestes.Setup;
begin
  Self.FUsuario := TUsuario.Create;
end;

procedure TUsuarioTestes.TearDown;
begin
  if Assigned(FUsuario) then FUsuario.Free;
end;

procedure TUsuarioTestes.ValidarMetodoEntrarNoSistema;
var
  Mock: TMock<IUsuario>;
begin
  Mock := TMock<IUsuario>.Create;
  Mock.Setup.WillReturn('Demo').When.NomeUsuario; // Aqui basta trocar o usuario aí o teste irá funcionar...
  Assert.IsTrue(FUsuario.EhUsuarioValido(TStub<ILog>.Create, Mock), 'Teste falhou!');
end;


initialization
  TDUnitX.RegisterTestFixture(TUsuarioTestes);

end.

