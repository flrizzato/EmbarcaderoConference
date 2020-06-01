{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 11/08/2017 10:00:41                                  //}
{//************************************************************//}

unit NewMVCApp.Controller.Interf;
 ///
 /// <summary>
 ///  INewMVCAppController
 ///     Interaface de acesso ao object factory do controller
 /// </summary>
 {auth}
interface
uses
System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}VCL.Forms,{$endif} {$endif}
System.Classes, MVCBr.Interf;
type
  INewMVCAppController = interface(IController)
         ['{654E93C4-6DAF-42EB-AA80-FD10BDA7C2C3}']
         // incluir especializações aqui
  end;
Implementation
end.
