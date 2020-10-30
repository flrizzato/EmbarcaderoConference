{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 13/06/2017 23:41:37                                  //}
{//************************************************************//}
 /// <summary>
 /// O controller possui as seguintes características:
 ///   - pode possuir 1 view associado  (GetView)
 ///   - pode receber 0 ou mais Model   (GetModel<Ixxx>)
 ///   - se auto registra no application controller
 ///   - pode localizar controller externos e instanciá-los
 ///     (resolveController<I..>)
 /// </summary>
unit EConference2017.Controller;
 /// <summary>
 ///    Object Factory para implementar o Controller
 /// </summary>
interface
{.$I ..\inc\mvcbr.inc}
uses
System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}  VCL.Forms,{$endif}{$endif}
System.Classes, MVCBr.Interf,
MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
System.RTTI, EConference2017.Controller.interf;

type
  TEConference2017Controller = class(TControllerFactory,
    IEConference2017Controller,
    IThisAs<TEConference2017Controller>, IModelAs<IEConference2017ViewModel>)
  protected
    Procedure DoCommand(ACommand: string;
        const AArgs: array of TValue); override;
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
    function ThisAs: TEConference2017Controller;
 /// Init após criado a instância é chamado para concluir init
    procedure init;override;
 /// ModeAs retornar a própria interface do controller
    function ModelAs: IEConference2017ViewModel;
  end;
implementation
///  Creator para a classe Controller
Constructor TEConference2017Controller.Create;
begin
 inherited;
  ///  Inicializar as Views...
  //%view View(TLiveSRV1View.New(self));
  add(TEConference2017ViewModel.New(self).ID('{EConference2017.ViewModel}'));  ///  Inicializar os modulos
 CreateModules; //< criar os modulos persolnizados
end;
///  Finaliza o controller
Destructor TEConference2017Controller.destroy;
begin
  inherited;
end;
///  Classe Function basica para criar o controller
class function TEConference2017Controller.New(): IController;
begin
 result := new(nil,nil);
end;
///  Classe para criar o controller com View e Model criado
class function TEConference2017Controller.New(const AView: IView;
   const AModel: IModel) : IController;
var
  vm: IViewModel;
begin
  result := TEConference2017Controller.create as IController;
  result.View(AView).Add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
      begin
        vm.View(AView).Controller( result );
      end;
end;
///  Classe para inicializar o Controller com um Modulo inicialz.
class function TEConference2017Controller.New(
   const AModel: IModel): IController;
begin
  result := new(nil,AModel);
end;
///  Cast para a interface local do controller
function TEConference2017Controller.ThisAs: TEConference2017Controller;
begin
   result := self;
end;
///  Cast para o ViewModel local do controller
function TEConference2017Controller.ModelAs: IEConference2017ViewModel;
begin
 if count>=0 then
  supports(GetModelByType(mtViewModel), IEConference2017ViewModel, result);
end;
///  Executar algum comando customizavel
Procedure TEConference2017Controller.DoCommand(ACommand: string;
   const AArgs:Array of TValue);
begin
    inherited;
end;
///  Evento INIT chamado apos a inicializacao do controller
procedure TEConference2017Controller.init;
var ref:TEConference2017View;
begin
  inherited;
 if not assigned(FView) then
 begin
   Application.CreateForm( TEConference2017View, ref );
   supports(ref,IView,FView);
  {$ifdef FMX}
    if Application.MainForm=nil then
      Application.RealCreateForms;
  {$endif}
 end;
 CreateModules;
 AfterInit;
end;
/// Adicionar os modulos e MODELs personalizados
Procedure TEConference2017Controller.CreateModules;
begin
   // adicionar os seus MODELs aqui
   // exemplo: add( MeuModel.new(self) );
end;
initialization
///  Inicialização automatica do Controller ao iniciar o APP
//TLiveSRV1Controller.New(TLiveSRV1View.New,TLiveSRV1ViewModel.New)).init();
///  Registrar Interface e ClassFactory para o MVCBr
  RegisterInterfacedClass(TEConference2017Controller.ClassName,IEConference2017Controller,TEConference2017Controller);
finalization
///  Remover o Registro da Interface
  unRegisterInterfacedClass(TEConference2017Controller.ClassName);
end.
