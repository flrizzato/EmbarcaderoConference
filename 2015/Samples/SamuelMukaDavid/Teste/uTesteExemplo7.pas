unit uTesteExemplo7;

interface
uses
  DUnitX.TestFramework, Exemplo7_2, Exemplo7, Exemplo7_1, RTTI,
  System.SysUtils, System.TypInfo;

type

  TestFabricaExportaFichaUsuarioAttribute = class(TestCaseAttribute)
  public
    constructor Create(const pTestName: String; const pTipoFicha: TTipoFicha; const pFichaUsuarioClass: TClass); overload;
  end;


  [TestFixture]
  TEmbConf2015Test = class(TObject)
  private

  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    // Test with TestCase Atribute to supply parameters.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);

    [Test]
    procedure TesteFactoryFichaUsuarioXml;

    [TestFabricaExportaFichaUsuario('Teste Txt', tfTexto, TExportadorFichaUsuarioTxt)]
    [TestFabricaExportaFichaUsuario('Teste Xml', tfXml,   TExportadorFichaUsuarioXML)]
    [TestFabricaExportaFichaUsuario('Teste Json',tfJson,  TExportadorFichaUsuarioJson)]
    procedure TesteMuka(const pTipoFicha: TTipoFicha; const pFichaUsuarioClass: TClass);

  end;

implementation

uses
  System.Classes;

procedure TEmbConf2015Test.Setup;
begin
end;

procedure TEmbConf2015Test.TearDown;
begin
end;

procedure TEmbConf2015Test.Test1;
begin
end;

procedure TEmbConf2015Test.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin
end;

procedure TEmbConf2015Test.TesteFactoryFichaUsuarioXml;
var
  lExportaFichaUsuario: IExportadorFichaUsuario;
begin
  lExportaFichaUsuario := TExportaFichaUsuarioFactory.ObterExportador(tfXml);
  Assert.AreEqual(TObject(lExportaFichaUsuario).ClassType,TExportadorFichaUsuarioTxt,'esperando classe TExportaFichaUsuarioXML');
end;

procedure TEmbConf2015Test.TesteMuka(const pTipoFicha: TTipoFicha; const pFichaUsuarioClass: TClass);
var
  lExportaFichaUsuario: IExportadorFichaUsuario;
begin
  lExportaFichaUsuario := TExportaFichaUsuarioFactory.ObterExportador(pTipoFicha);
  Assert.AreEqual(TObject(lExportaFichaUsuario).ClassType,pFichaUsuarioClass);
end;

{ TestMuka }

constructor TestFabricaExportaFichaUsuarioAttribute.Create(const pTestName: String; const pTipoFicha: TTipoFicha; const pFichaUsuarioClass: TClass);
begin
  FCaseInfo.Name := pTestName;
  SetLength(FCaseInfo.Values,2);
  FCaseInfo.Values[0] := Ord(pTipoFicha);
  FCaseInfo.Values[1] := pFichaUsuarioClass;
end;

initialization
  TDUnitX.RegisterTestFixture(TEmbConf2015Test);
end.
