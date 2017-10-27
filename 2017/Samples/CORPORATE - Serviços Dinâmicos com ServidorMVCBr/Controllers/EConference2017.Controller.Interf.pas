{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 13/06/2017 23:41:39                                  //}
{//************************************************************//}
unit EConference2017.Controller.Interf;
 ///
 /// <summary>
 ///  ILiveSRV1Controller
 ///     Interaface de acesso ao object factory do controller
 /// </summary>
 ///
interface

uses
System.SysUtils,{$ifdef LINUX} {$else} {$ifdef FMX} FMX.Forms,{$else}VCL.Forms,{$endif} {$endif}
System.Classes, MVCBr.Interf;

type
  IEConference2017Controller = interface(IController)
         ['{570EE622-BF8B-4E93-B28F-D1305484C927}']
         // incluir especializações aqui
  end;

Implementation

end.
