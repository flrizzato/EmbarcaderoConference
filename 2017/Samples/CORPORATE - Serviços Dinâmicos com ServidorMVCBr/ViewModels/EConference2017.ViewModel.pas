{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 13/06/2017 23:41:39                                  //}
{//************************************************************//}
unit EConference2017.ViewModel;
interface
{.$I ..\inc\mvcbr.inc}
uses MVCBr.Interf, MVCBr.ViewModel, EConference2017.ViewModel.Interf;
Type
///  Object Factory para o ViewModel
    TEConference2017ViewModel=class(TViewModelFactory,
      IEConference2017ViewModel, IViewModelAs<IEConference2017ViewModel>)
    public
      function ViewModelAs:IEConference2017ViewModel;
      class function new():IEConference2017ViewModel;overload;
      class function new(const AController:IController):IEConference2017ViewModel; overload;
      procedure AfterInit;override;
    end;
implementation
function TEConference2017ViewModel.ViewModelAs:IEConference2017ViewModel;
begin
  result := self;
end;
class function TEConference2017ViewModel.new():IEConference2017ViewModel;
begin
  result := new(nil);
end;
/// <summary>
///   New cria uma nova instância para o ViewModel
/// </summary>
/// <param name="AController">
///   AController é o controller ao qual o ViewModel esta
///   ligado
/// </param>
class function TEConference2017ViewModel.new(const AController:IController):IEConference2017ViewModel;
begin
  result := TEConference2017ViewModel.create;
  result.controller(AController);
end;
procedure TEConference2017ViewModel.AfterInit;
begin
    // evento disparado apos a definicao do Controller;
end;
end.
