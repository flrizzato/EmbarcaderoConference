unit UntPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.TabControl, FMX.Effects, FMX.Controls.Presentation,
  FMX.StdCtrls, UntCadCli, System.Actions, FMX.ActnList;

type
  TfrmPrincipal = class(TForm)
    imgSuperior: TImage;
    tbctrlPrincipal: TTabControl;
    tbitemMenu: TTabItem;
    tbitemAuxiliar: TTabItem;
    lytInferior: TLayout;
    recInferior: TRectangle;
    imgInferior: TImage;
    grdMenu: TGridLayout;
    lytBotao1: TLayout;
    rndBotao1: TRoundRect;
    imgBotao1: TImage;
    lytLblBotao1: TLayout;
    lblBotao1: TLabel;
    lblCapBotao1: TLabel;
    ShadowEffect1: TShadowEffect;
    lytBotao2: TLayout;
    rndBotao2: TRoundRect;
    imgBotao2: TImage;
    lytCapBotao2: TLayout;
    lblBotao2: TLabel;
    lblCapBotao2: TLabel;
    ShadowEffect2: TShadowEffect;
    lytBotao3: TLayout;
    RoundRect2: TRoundRect;
    imgBotao3: TImage;
    lytCapBotao3: TLayout;
    lblBotao3: TLabel;
    lblCapBotao3: TLabel;
    ShadowEffect3: TShadowEffect;
    lytBotao4: TLayout;
    rndBotao4: TRoundRect;
    imgBotao4: TImage;
    lytCapBotao4: TLayout;
    lblBotao4: TLabel;
    lblCapBotao4: TLabel;
    ShadowEffect4: TShadowEffect;
    imgFundo: TImage;
    lytPrincipal: TLayout;
    ActionList1: TActionList;
    actMudarAba: TChangeTabAction;
    procedure FormCreate(Sender: TObject);
    procedure imgBotao1Click(Sender: TObject);
  private
    FActiveForm: TForm;
    procedure MostrarForm(AFormClass: TComponentClass);
    procedure AjustarLayout;
  public
    { Public declarations }
    procedure MudarAba(ATabItem: TTabItem; Sender: TObject);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

{ TForm1 }

procedure TfrmPrincipal.AjustarLayout;
var
  iWidth : Integer;
begin
  iWidth            := Self.ClientWidth - 20;
  grdMenu.ItemWidth := iWidth;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  tbctrlPrincipal.TabPosition := TTabPosition.None;
  tbctrlPrincipal.ActiveTab   := tbitemMenu;

  AjustarLayout;
end;

procedure TfrmPrincipal.imgBotao1Click(Sender: TObject);
begin
  MostrarForm(TfrmCadCli);
  MudarAba(tbitemAuxiliar, Sender);
end;

procedure TfrmPrincipal.MostrarForm(AFormClass: TComponentClass);
var
  LayoutBase : TComponent;
  BotaoMenu  : TComponent;
begin
  if Assigned(FActiveForm) then
  begin
    if FActiveForm.ClassType = AFormClass then
      exit
    else
    begin
      FActiveForm.DisposeOf;
      FActiveForm := nil;
    end;
  end;

  Application.CreateForm(aFormClass, FActiveForm);

  LayoutBase := FActiveForm.FindComponent('lytBase');
  if Assigned(LayoutBase) then
    lytPrincipal.AddObject(TLayout(LayoutBase));
end;

procedure TfrmPrincipal.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actMudarAba.Tab := ATabItem;
  actMudarAba.ExecuteTarget(Sender);
end;

end.
