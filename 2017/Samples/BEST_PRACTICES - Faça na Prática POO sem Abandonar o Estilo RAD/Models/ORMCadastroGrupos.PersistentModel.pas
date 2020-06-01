{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 19/08/2017 11:09:54                                  //}
{//************************************************************//}

Unit  ORMCadastroGrupos.PersistentModel;


{ MVCBr
  www.tireideletra.com.br
  amarildo lacerda
}

interface
{.$I ..\inc\mvcbr.inc}
uses System.SysUtils,{$ifdef FMX} FMX.Forms,{$else} VCL.Forms,{$endif} System.Classes, MVCBr.Interf, MVCBr.PersistentModel,
   ORMCadastroGrupos.PersistentModel.Interf, //%Interf,
MVCBr.Controller;

Type

  TORMCadastroGruposPersistentModel = class(TPersistentModelFactory,IORMCadastroGruposPersistentModel,    IThisAs<TORMCadastroGruposPersistentModel>)
  protected
  public
    Constructor Create; override;
    Destructor Destroy; override;
    class function new():IORMCadastroGruposPersistentModel; overload;
    class function new(const AController:IController):IORMCadastroGruposPersistentModel;  overload;
    function ThisAs:TORMCadastroGruposPersistentModel;

      // implementaçoes

  end;


Implementation

constructor TORMCadastroGruposPersistentModel.Create;
begin
  inherited;
  ModelTypes := [mtPersistent];
end;

destructor TORMCadastroGruposPersistentModel.Destroy;
begin
  inherited;
end;
function TORMCadastroGruposPersistentModel.ThisAs: TORMCadastroGruposPersistentModel;
begin
  result := self;
end;

class function TORMCadastroGruposPersistentModel.new():IORMCadastroGruposPersistentModel;
begin
     result := new(nil);
end;

class function TORMCadastroGruposPersistentModel.new(const AController:IController):IORMCadastroGruposPersistentModel;
begin
   result :=  TORMCadastroGruposPersistentModel.create;
   result.controller(AController);
end;

Initialization
TMVCRegister.RegisterType<IORMCadastroGruposPersistentModel,TORMCadastroGruposPersistentModel>(TORMCadastroGruposPersistentModel.classname,true);
end.
