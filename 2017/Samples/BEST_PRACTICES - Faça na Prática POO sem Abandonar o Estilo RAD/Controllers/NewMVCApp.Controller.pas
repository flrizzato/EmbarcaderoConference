{ //************************************************************// }
{ //                                                            // }
{ //         Código gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 11/08/2017 10:00:40                                  // }
{ //************************************************************// }

/// <summary>
/// O controller possui as seguintes características:
/// - pode possuir 1 view associado  (GetView)
/// - pode receber 0 ou mais Model   (GetModel<Ixxx>)
/// - se auto registra no application controller
/// - pode localizar controller externos e instanciá-los
/// (resolveController<I..>)
/// </summary>
{ auth }
unit NewMVCApp.Controller;

/// <summary>
/// Object Factory para implementar o Controller
/// </summary>
interface

{ .$I ..\inc\mvcbr.inc }
uses

  System.SysUtils, {$IFDEF LINUX} {$ELSE} {$IFDEF FMX} FMX.Forms, {$ELSE} VCL.Forms, {$ENDIF}{$ENDIF}
  System.Classes, MVCBr.Interf,
  MVCBr.Model, MVCBr.Controller, MVCBr.ApplicationController,
  System.RTTI, NewMVCApp.Controller.Interf,
  NewMVCAppView;

type

  TNewMVCAppController = class(TControllerFactory, INewMVCAppController,
    IThisAs<TNewMVCAppController>)
  protected
  public
    // inicializar os módulos personalizados em CreateModules
    Procedure CreateModules; virtual;
    Constructor Create; override;
    Destructor Destroy; override;
    /// New Cria nova instância para o Controller
    class function New(): IController; overload;
    class function New(const AView: IView; const AModel: IModel)
      : IController; overload;
    class function New(const AModel: IModel): IController; overload;
    function ThisAs: TNewMVCAppController;
    /// Init após criado a instância é chamado para concluir init
    procedure init; override;
    /// ModeAs retornar a própria interface do controller

  end;

implementation

/// Creator para a classe Controller

uses ACBrValidador.Model, WinNotification.Model;

Constructor TNewMVCAppController.Create;
begin
  inherited;
  /// Inicializar as Views...
  // %view View(TNewMVCAppView.New(self));
  add(TWinNotificationModel.New(self));
end;

/// Finaliza o controller
Destructor TNewMVCAppController.Destroy;
begin
  inherited;
end;

/// Classe Function basica para criar o controller
class function TNewMVCAppController.New(): IController;
begin
  result := New(nil, nil);
end;

/// Classe para criar o controller com View e Model criado
class function TNewMVCAppController.New(const AView: IView;
  const AModel: IModel): IController;
var
  vm: IViewModel;
begin
  result := TNewMVCAppController.Create as IController;
  result.View(AView).add(AModel);
  if assigned(AModel) then
    if supports(AModel.This, IViewModel, vm) then
    begin
      vm.View(AView).Controller(result);
    end;
end;

/// Classe para inicializar o Controller com um Modulo inicialz.
class function TNewMVCAppController.New(const AModel: IModel): IController;
begin
  result := New(nil, AModel);
end;

/// Cast para a interface local do controller
function TNewMVCAppController.ThisAs: TNewMVCAppController;
begin
  result := self;
end;

/// Evento INIT chamado apos a inicializacao do controller
procedure TNewMVCAppController.init;
var
  ref: TNewMVCAppView;
begin
  inherited;
  if not assigned(FView) then
  begin
    Application.CreateForm(TNewMVCAppView, ref);
    supports(ref, IView, FView);
{$IFDEF FMX}
    if Application.MainForm = nil then
      Application.RealCreateForms;
{$ENDIF}
  end;
  CreateModules;
  AfterInit;
end;

/// Adicionar os modulos e MODELs personalizados
Procedure TNewMVCAppController.CreateModules;
begin
  // adicionar os seus MODELs aqui
  // exemplo: add( MeuModel.new(self) );

  add(TACBrValidadorModel.New(self));

end;

initialization

/// Inicialização automatica do Controller ao iniciar o APP
// TNewMVCAppController.New(TNewMVCAppView.New,TNewMVCAppViewModel.New)).init();

/// Registrar Interface e ClassFactory para o MVCBr
RegisterInterfacedClass(TNewMVCAppController.ClassName, INewMVCAppController,
  TNewMVCAppController);

finalization

/// Remover o Registro da Interface
unRegisterInterfacedClass(TNewMVCAppController.ClassName);

end.
