{ //************************************************************// }
{ //                                                            // }
{ //         Código gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 11/08/2017 10:01:53                                  // }
{ //************************************************************// }

/// <summary>
/// Uma View representa a camada de apresentação ao usuário
/// deve esta associado a um controller onde ocorrerá
/// a troca de informações e comunicação com os Models
/// </summary>
unit View2View;

interface

uses
{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}
  System.SysUtils, System.Classes, MVCBr.Interf, System.JSON,
  MVCBr.View, MVCBr.FormView, MVCBr.Controller, VCL.StdCtrls, VCL.Controls;

type
  /// Interface para a VIEW
  IView2View = interface(IView)
    ['{0F45BA65-BCF2-483F-B716-B94AFAB01B4B}']
    // incluir especializacoes aqui
  end;

  /// Object Factory que implementa a interface da VIEW
  TView2View = class(TFormFactory { TFORM } , IView, IThisAs<TView2View>,
    IView2View, IViewAs<IView2View>)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FInited: boolean;
  protected
    function Controller(const aController: IController): IView; override;
  public
    { Public declarations }
    class function New(aController: IController): IView;
    function ThisAs: TView2View;
    function ViewAs: IView2View;
    function ShowView(const AProc: TProc<IView>): integer; override;
  end;

Implementation

{$R *.DFM}

uses MVCBr.Observable;

function TView2View.ViewAs: IView2View;
begin
  result := self;
end;

class function TView2View.New(aController: IController): IView;
begin
  result := TView2View.create(nil);
  result.Controller(aController);
end;

procedure TView2View.Button1Click(Sender: TObject);
var
  h: boolean;
begin
  ApplicationController.ViewEvent(edit1.text, h)
end;

procedure TView2View.Button2Click(Sender: TObject);
var js:TJsonObject;
begin
    js := TJsonObject.create as TJsonObject;
    js.addpair('message',edit1.text);
    TMVCBrObservable.Notify('notify',js);
end;

function TView2View.Controller(const aController: IController): IView;
begin
  result := inherited Controller(aController);
  if not FInited then
  begin
    init;
    FInited := true;
  end;
end;

function TView2View.ThisAs: TView2View;
begin
  result := self;
end;

function TView2View.ShowView(const AProc: TProc<IView>): integer;
begin
  inherited;
end;

end.
