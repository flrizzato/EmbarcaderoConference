{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 19/08/2017 11:11:21                                  //}
{//************************************************************//}

unit CadastroGrupo.Controller.Interf;
 ///
 /// <summary>
 ///  ICadastroGrupoController
 ///     Interaface de acesso ao object factory do controller
 /// </summary>
 {auth}
interface
uses
System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}VCL.Forms,{$endif} {$endif}
System.Classes, MVCBr.Interf;
type
  ICadastroGrupoController = interface(IController)
         ['{59754283-4186-488C-84E5-5040D5088619}']
         // incluir especializações aqui
  end;
Implementation
end.
