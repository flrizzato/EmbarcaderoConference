{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 19/08/2017 11:11:22                                  //}
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
unit CadastroGrupo.Controller;
 /// <summary>
 ///    Object Factory para implementar o Controller
 /// </summary>
interface
{.$I ..\inc\mvcbr.inc}
uses

System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}  VCL.Forms,{$endif}{$endif}
System.Classes, MVCBr.Interf,
MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
System.RTTI, CadastroGrupo.Controller.interf,
CadastroGrupoView;

type

  TCadastroGrupoController = class(TControllerFactory,
    ICadastroGrupoController,
    IThisAs<TCadastroGrupoController>)
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
    function ThisAs: TCadastroGrupoController;
 /// Init após criado a instância é chamado para concluir init
    procedure init;override;
  end;

implementation
///  Creator para a classe Controller
Constructor TCadastroGrupoController.Create;
begin
 inherited;
  ///  Inicializar as Views...
    View(TCadastroGrupoView.New(self));
end;
///  Finaliza o controller
Destructor TCadastroGrupoController.destroy;
begin
  inherited;
end;
///  Classe Function basica para criar o controller
class function TCadastroGrupoController.New(): IController;
begin
 result := new(nil,nil);
end;
///  Classe para criar o controller com View e Model criado
class function TCadastroGrupoController.New(const AView: IView;
   const AModel: IModel) : IController;
var
  vm: IViewModel;
begin
  result := TCadastroGrupoController.create as IController;
  result.View(AView).Add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
      begin
        vm.View(AView).Controller( result );
      end;
end;
///  Classe para inicializar o Controller com um Modulo inicialz.
class function TCadastroGrupoController.New(
   const AModel: IModel): IController;
begin
  result := new(nil,AModel);
end;
///  Cast para a interface local do controller
function TCadastroGrupoController.ThisAs: TCadastroGrupoController;
begin
   result := self;
end;
///  Evento INIT chamado apos a inicializacao do controller
procedure TCadastroGrupoController.init;
var ref:TCadastroGrupoView;
begin
  inherited;
 if not assigned(FView) then
 begin
   Application.CreateForm( TCadastroGrupoView, ref );
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
Procedure TCadastroGrupoController.CreateModules;
begin
   // adicionar os seus MODELs aqui
   // exemplo: add( MeuModel.new(self) );
end;

initialization
///  Inicialização automatica do Controller ao iniciar o APP
//TCadastroGrupoController.New(TCadastroGrupoView.New,TCadastroGrupoViewModel.New)).init();

///  Registrar Interface e ClassFactory para o MVCBr
  RegisterInterfacedClass(TCadastroGrupoController.ClassName,ICadastroGrupoController,TCadastroGrupoController);

finalization
///  Remover o Registro da Interface
  unRegisterInterfacedClass(TCadastroGrupoController.ClassName);

end.
