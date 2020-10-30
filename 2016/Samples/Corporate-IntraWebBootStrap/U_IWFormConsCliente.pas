unit U_IWFormConsCliente;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWCompGrids,
  IWDBGrids, Vcl.Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompButton, Data.DB, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML;

type
  TIWFormConsCliente = class(TIWAppForm)
    IWButtonPesquisar: TIWButton;
    IWButtonIncluir: TIWButton;
    IWButtonAlterar: TIWButton;
    IWButtonExcluir: TIWButton;
    IWButtonImprimir: TIWButton;
    IWDBGridConsulta: TIWDBGrid;
    IWButtonPrimeiro: TIWButton;
    IWButtonAnterior: TIWButton;
    IWButtonProximo: TIWButton;
    IWButtonUltimo: TIWButton;
    IWButtonVoltar: TIWButton;
    DSConsCliente: TDataSource;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWButtonPesquisarAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonPrimeiroAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonAnteriorAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonProximoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWButtonUltimoAsyncClick(Sender: TObject;
      EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

uses ServerController, U_DM;



procedure TIWFormConsCliente.IWAppFormCreate(Sender: TObject);
begin
   DSConsCliente.DataSet:=UserSession.DM.CDSConsCliente;
end;

procedure TIWFormConsCliente.IWButtonAnteriorAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
   UserSession.DM.CDSConsCliente.MoveBy(- IWDBGridConsulta.RowLimit);
   IWDBGridConsulta.RepaintControl;
end;

procedure TIWFormConsCliente.IWButtonPesquisarAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
   UserSession.DM.CDSConsCliente.Close;
   UserSession.DM.CDSConsCliente.Open;
   IWDBGridConsulta.RepaintControl;
end;

procedure TIWFormConsCliente.IWButtonPrimeiroAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
   UserSession.DM.CDSConsCliente.First;
   IWDBGridConsulta.RepaintControl;
end;

procedure TIWFormConsCliente.IWButtonProximoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
   UserSession.DM.CDSConsCliente.MoveBy(+ IWDBGridConsulta.RowLimit);
   IWDBGridConsulta.RepaintControl;
end;

procedure TIWFormConsCliente.IWButtonUltimoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
   UserSession.DM.CDSConsCliente.Last;
   IWDBGridConsulta.RepaintControl;
end;

initialization
  TIWFormConsCliente.SetAsMainForm;

end.
