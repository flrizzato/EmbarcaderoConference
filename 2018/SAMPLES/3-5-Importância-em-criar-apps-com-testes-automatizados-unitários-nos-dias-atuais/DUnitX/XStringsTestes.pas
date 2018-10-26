unit XStringsTestes;

interface

uses
  DUnitX.TestFramework, XStrings;

type

  [TestFixture]
  TXStringsTestes = class(TObject)
  private
    FXStrings: TXStrings;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ValidarSomenteNumeros;
//    [Test]
//    [TestCase('Caso 1', 'A0-245%4$38&86893,024543886893')]
//    [TestCase('Caso 2', '111.111.111-11,11111111111')]
//    procedure ValidarSomenteNumeros(AStringASerValidada: String; AResultadoEsperado: String);

//    [Test]
//    procedure ValidarOExceptionDoMetodoExemploMetodoComExcecao;
  end;

implementation

procedure TXStringsTestes.Setup;
begin
  FXStrings := TXStrings.Create;
end;

procedure TXStringsTestes.TearDown;
begin
  if Assigned(FXStrings) then FXStrings.Free;
end;

procedure TXStringsTestes.ValidarSomenteNumeros;
var
  Aux: String;
begin
  Aux := FXStrings.SomenteNumeros('A0-2,45%4$38&¨8689.3');

  Assert.IsTrue(Aux = '024543886893', 'String de entrada A0-2,45%4$38&¨8689.3 deveria retornar 024543886893 mas retornou ' + Aux);
end;

//procedure TXStringsTestes.ValidarSomenteNumeros(AStringASerValidada: String; AResultadoEsperado: String);
//var
//  Aux: String;
//begin
//  Aux := FXStrings.SomenteNumeros(AStringASerValidada);
//
//  Assert.IsTrue(Aux = AResultadoEsperado, 'String de entrada ' + AStringASerValidada + ' deveria retornar ' + AResultadoEsperado + ' mas retornou ' + Aux);
//end;

//procedure TXStringsTestes.ValidarOExceptionDoMetodoExemploMetodoComExcecao;
//begin
//  Assert.WillRaise(FXStrings.ExemploMetodoComExcecao, nil, 'Exceção do método ExemploMetodoComExcecao não aconteceu!');
//end;

initialization
  TDUnitX.RegisterTestFixture(TXStringsTestes);
end.
