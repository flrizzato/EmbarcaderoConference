unit Form.Tela.ERP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, Data.DB,
  Vcl.ExtCtrls, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, VCLTee.Series;

type
  TfrmTelaERP = class(TForm)
    PanelControles: TPanel;
    PanelInfoCliente: TPanel;
    PanelCliente: TPanel;
    PanelPesquisa: TPanel;
    PanelFiltroPesquisa: TPanel;
    PanelGrafico: TPanel;
    LabelCotacao: TLabel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    DBGridCliente: TDBGrid;
    DBGridCompras: TDBGrid;
    DBGrid2: TDBGrid;
    Splitter5: TSplitter;
    ButtonEnviarEmail: TBitBtn;
    ButtonGeraPedido: TBitBtn;
    ButtonAprovarPedido: TBitBtn;
    Label1: TLabel;
    EditPesquisa: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ButtonCarregarTela: TButton;
    dtsCliente: TDataSource;
    dtsCotacao: TDataSource;
    DBChart1: TDBChart;
    Series1: TLineSeries;
    TimerOpen: TTimer;
    ButtonCarregarTh: TButton;
    dtsCompras: TDataSource;
    dtsProjetos: TDataSource;
    procedure ButtonCarregarTelaClick(Sender: TObject);
    procedure ButtonCarregarThClick(Sender: TObject);
    procedure TimerOpenTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Data.Tela.ERP, Classe.ExecutorTh;

procedure TfrmTelaERP.ButtonCarregarThClick(Sender: TObject);
var
  lMetodo: TMetodo;
  lProcExec: TProc;
  lProcOk: TProc;
  lProcErro: TProc;
begin
  ///  ! Atenção !
  ///  Reparar que o Connection não é ThreadSafe
  ///  Espe modelo de Produtor/Consumidor apenas tem valia se a aplicação não executar nenhuma
  ///  consulta em paralelo pelo mesmo connection
  ///  Caso seja necessário realizar outras consultas enquanto a Thread está operando
  ///  Melhor criar uma nova conexção exclusiva para a Thread executora

  // Carregar Clientes
  lProcExec :=
    procedure
    begin
      dmdTelaERP.CarregaClientes;
    end;

  lProcOk :=
    procedure
    begin
      ShowMessage('Clientes carregados');
    end;

  lProcErro :=
    procedure
    begin
      ShowMessage('Algo deu errado - Cliente');
    end;

  lMetodo := TMetodo.Create(lProcExec, lProcOk, lProcErro);
  TExecutor.AddMetodo(lMetodo);

  // Carregar Compras
  lProcExec :=
    procedure
    begin
      dmdTelaERP.CarregaCompras;
    end;

  lProcOk :=
    procedure
    begin
      ShowMessage('Compras carregados');
    end;

  lProcErro :=
    procedure
    begin
      ShowMessage('Algo deu errado - Compras');
    end;

  lMetodo := TMetodo.Create(lProcExec, lProcOk, lProcErro);
  TExecutor.AddMetodo(lMetodo);

  // Carregar Projetos
  lProcExec :=
    procedure
    begin
      dmdTelaERP.CarregaProjetos;
    end;

  lProcOk :=
    procedure
    begin
      ShowMessage('Projetos carregados');
    end;

  lProcErro :=
    procedure
    begin
      ShowMessage('Algo deu errado - Projetos');
    end;

  lMetodo := TMetodo.Create(lProcExec, lProcOk, lProcErro);
  TExecutor.AddMetodo(lMetodo);


  // Carregar cotações
  lProcExec :=
    procedure
    begin
      dmdTelaERP.CarregaCotacoes;
    end;

  lProcOk :=
    procedure
    begin
      ShowMessage('Dados de cotação carregados');
    end;

  lProcErro :=
    procedure
    begin
      ShowMessage('Algo deu errado - Cotações');
    end;

  lMetodo := TMetodo.Create(lProcExec, lProcOk, lProcErro);
  TExecutor.AddMetodo(lMetodo);
end;

procedure TfrmTelaERP.TimerOpenTimer(Sender: TObject);
begin
  // On Show
  // TimerOpen.Enabled := True;

  TimerOpen.Enabled := False;
  dmdTelaERP.CarregaClientes;
  dmdTelaERP.CarregaProjetos;
  dmdTelaERP.CarregaCompras;
  dmdTelaERP.CarregaCotacoes;
end;

procedure TfrmTelaERP.ButtonCarregarTelaClick(Sender: TObject);
begin
  dmdTelaERP.CarregaClientes;
  dmdTelaERP.CarregaProjetos;
  dmdTelaERP.CarregaCompras;
  dmdTelaERP.CarregaCotacoes;
end;

end.
