{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 11/08/2017 10:01:53                                  //}
{//************************************************************//}

 /// <summary>
 /// O controller possui as seguintes características:
 ///   - pode possuir 1 view associado  (GetView)
 ///   - pode receber 0 ou mais Model   (GetModel<Ixxx>)
 ///   - se auto registra no application controller
 ///   - pode localizar controller externos e instanciá-los
 ///     (resolveController<I..>)
 /// </summary>
  {auth}
unit View2.Controller;
 /// <summary>
 ///    Object Factory para implementar o Controller
 /// </summary>
interface
{.$I ..\inc\mvcbr.inc}
uses

System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}  VCL.Forms,{$endif}{$endif}
System.Classes, MVCBr.Interf,
MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
System.RTTI, View2.Controller.interf,
View2View;

type

  TView2Controller = class(TControllerFactory,
    IView2Controller,
    IThisAs<TView2Controller>)
  protected
  public
    // inicializar os módulos personalizados em CreateModules
    Procedure CreateModules;virtual;
    Constructor Create;override;
    Destructor Destroy; override;
 /// New Cria nova instância para o Controller
    class function New(): IController; overload;
    class function New(const AView: IView; const AModel: IModel)
      : IController; overload;
    class function New(const AModel: IModel): IController; overload;
    function ThisAs: TView2Controller;
 /// Init após criado a instância é chamado para concluir init
    procedure init;override;
  end;

implementation
///  Creator para a classe Controller
Constructor TView2Controller.Create;
begin
 inherited;
  ///  Inicializar as Views...
    View(TView2View.New(self));
end;
///  Finaliza o controller
Destructor TView2Controller.destroy;
begin
  inherited;
end;
///  Classe Function basica para criar o controller
class function TView2Controller.New(): IController;
begin
 result := new(nil,nil);
end;
///  Classe para criar o controller com View e Model criado
class function TView2Controller.New(const AView: IView;
   const AModel: IModel) : IController;
var
  vm: IViewModel;
begin
  result := TView2Controller.create as IController;
  result.View(AView).Add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
      begin
        vm.View(AView).Controller( result );
      end;
end;
///  Classe para inicializar o Controller com um Modulo inicialz.
class function TView2Controller.New(
   const AModel: IModel): IController;
begin
  result := new(nil,AModel);
end;
///  Cast para a interface local do controller
function TView2Controller.ThisAs: TView2Controller;
begin
   result := self;
end;
///  Evento INIT chamado apos a inicializacao do controller
procedure TView2Controller.init;
var ref:TView2View;
begin
  inherited;
 if not assigned(FView) then
 begin
   Application.CreateForm( TView2View, ref );
   supports(ref,IView,FView);
  {$ifdef FMX}
    if Application.MainForm=nil then
      Application.RealCreateForms;
  {$endif}
 end;
 CreateModules; //< criar os modulos persolnizados

 AfterInit;
end;
/// Adicionar os modulos e MODELs personalizados
Procedure TView2Controller.CreateModules;
begin
   // adicionar os seus MODELs aqui
   // exemplo: add( MeuModel.new(self) );
end;

initialization
///  Inicialização automatica do Controller ao iniciar o APP
//TView2Controller.New(TView2View.New,TView2ViewModel.New)).init();

///  Registrar Interface e ClassFactory para o MVCBr
  RegisterInterfacedClass(TView2Controller.ClassName,IView2Controller,TView2Controller);

finalization
///  Remover o Registro da Interface
  unRegisterInterfacedClass(TView2Controller.ClassName);

end.
