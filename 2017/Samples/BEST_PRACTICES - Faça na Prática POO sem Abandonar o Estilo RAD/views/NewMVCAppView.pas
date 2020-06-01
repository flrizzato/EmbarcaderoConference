{ //************************************************************// }
{ //                                                            // }
{ //         Código gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 11/08/2017 10:00:41                                  // }
{ //************************************************************// }

/// <summary>
/// Uma View representa a camada de apresentação ao usuário
/// deve esta associado a um controller onde ocorrerá
/// a troca de informações e comunicação com os Models
/// </summary>
unit NewMVCAppView;

interface

uses
{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}
  System.SysUtils, System.Classes, MVCBr.Interf, System.JSON,
  MVCBr.View, MVCBr.FormView, MVCBr.Controller, VCL.StdCtrls, VCL.Controls,
  VCL.ComCtrls, MVCBr.Component, MVCBr.PageView, MVCBr.VCL.PageView,
  Vcl.ExtCtrls;

type

  /// Interface para a VIEW
  INewMVCAppView = interface(IView)
    ['{BEE9B09E-4CF2-4281-8FC9-1BE7B1526BB5}']
    // incluir especializacoes aqui
  end;

  /// Object Factory que implementa a interface da VIEW
  TNewMVCAppView = class(TFormFactory { TFORM } , IView,
    IThisAs<TNewMVCAppView>, INewMVCAppView, IViewAs<INewMVCAppView>)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    PageViewAdapter: TVCLPageViewManager;
    Panel1: TPanel;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel2: TPanel;
    Edit1: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormFactoryViewEvent(AMessage: TJSONValue; var AHandled: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure FormFactoryCreate(Sender: TObject);
    procedure FormFactoryDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FInited: Boolean;
    procedure WindowsNotificacao(ATitle, ATexto: string);
  protected
    function Controller(const aController: IController): IView; override;
  public
    { Public declarations }
    class function New(aController: IController): IView;
    function ThisAs: TNewMVCAppView;
    function ViewAs: INewMVCAppView;
    function ShowView(const AProc: TProc<IView>): integer; override;
  end;

Implementation

{$R *.DFM}

uses Dialogs, View2.Controller.Interf, ACBrValidador.Model.Interf,
  MVCBr.Observable, System.JSON.Helper,
  WinNotification.Model.Interf, CadastroGrupo.Controller.Interf;

function TNewMVCAppView.ViewAs: INewMVCAppView;
begin
  result := self;
end;

class function TNewMVCAppView.New(aController: IController): IView;
begin
  result := TNewMVCAppView.create(nil);
  result.Controller(aController);
end;

procedure TNewMVCAppView.Button1Click(Sender: TObject);
begin
  resolveController<IView2Controller>.ShowView(nil, false);
end;

procedure TNewMVCAppView.WindowsNotificacao(ATitle: string; ATexto: string);
var
  ANf: IWinNotificationModel;
begin
  ANf := GetModel<IWinNotificationModel>;
  ANf.Send(ATitle, 'MVCBr Delphi Build 2017', ATexto);

end;

procedure TNewMVCAppView.Button2Click(Sender: TObject);
var
  rt: string;
begin
  rt := GetModel<IACBrValidadorModel>.ValidarCNPJouCPF(Edit1.text);
  if rt = '' then
    showMessage('ok')
  else
    showMessage(rt);
end;

procedure TNewMVCAppView.Button3Click(Sender: TObject);
begin
  PageViewAdapter.AddView(IView2Controller);
end;

procedure TNewMVCAppView.Button4Click(Sender: TObject);
begin
  PageViewAdapter.addView(ICadastroGrupoController);
end;

function TNewMVCAppView.Controller(const aController: IController): IView;
begin
  result := inherited Controller(aController);
  if not FInited then
  begin
    init;
    FInited := true;
  end;
end;

procedure TNewMVCAppView.FormFactoryCreate(Sender: TObject);
begin

  TMVCBrObservable.subscribe(self, 'notify',
    procedure(JSON: TJSONValue)
    begin
      WindowsNotificacao('Delphi MVCBr 2017', JSON.s('message'));
      Memo1.lines.add('Mensagem recebida: '+ JSON.ToJson);
    end);

end;

procedure TNewMVCAppView.FormFactoryDestroy(Sender: TObject);
begin
  TMVCBrObservable.Unsubscribe(self);
end;

procedure TNewMVCAppView.FormFactoryViewEvent(AMessage: TJSONValue;
var AHandled: Boolean);
begin
  Memo1.lines.add(AMessage.ToJson);
end;

function TNewMVCAppView.ThisAs: TNewMVCAppView;
begin
  result := self;
end;

function TNewMVCAppView.ShowView(const AProc: TProc<IView>): integer;
begin
  inherited;
end;

end.
