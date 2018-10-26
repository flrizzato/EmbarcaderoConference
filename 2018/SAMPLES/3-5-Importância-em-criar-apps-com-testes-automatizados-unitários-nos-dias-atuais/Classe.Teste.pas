unit Classe.Teste;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TClasseTeste = class(TObject)
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure Test1;
    // Test com TestCase Attribute para suprimir os parâmetros.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

procedure TClasseTeste.Setup;
begin
end;

procedure TClasseTeste.TearDown;
begin
end;

procedure TClasseTeste.Test1;
begin
end;

procedure TClasseTeste.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin
end;

initialization
  TDUnitX.RegisterTestFixture(TClasseTeste);
end.