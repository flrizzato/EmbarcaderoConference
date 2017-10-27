{ //************************************************************// }
{ //                                                            // }
{ //         Código gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 11/08/2017 10:01:53                                  // }
{ //************************************************************// }

unit View2.Controller.Interf;

///
/// <summary>
/// IView2Controller
/// Interaface de acesso ao object factory do controller
/// </summary>
{ auth }
interface

uses
  System.SysUtils, {$IFDEF LINUX} {$ELSE} {$IFDEF FMX} FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF} {$ENDIF}
  System.Classes, MVCBr.Interf;

type
  IView2Controller = interface(IController)
    ['{B8F5200C-365A-4148-9985-51A9EA1CAF30}']
    // incluir especializações aqui
  end;

Implementation

end.
