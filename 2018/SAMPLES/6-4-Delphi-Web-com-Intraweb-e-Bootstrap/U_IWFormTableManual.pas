unit U_IWFormTableManual;

interface

uses
  Classes, SysUtils, System.Math, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompEdit, IWCompListbox, IWCompLabel, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  Data.DB, IWDBStdCtrls;

type
  TIWFormTableManual = class(TIWAppForm)
    IWBTNINCLUIR: TIWButton;
    Paginacao: TIWLabel;
    BotaoPagina: TIWButton;
    ItensPagina: TIWComboBox;
    IWBtnFiltro: TIWButton;
    IWBtnConfirmaFiltro: TIWButton;
    Codigo: TIWEdit;
    Descricao: TIWEdit;
    Adicionais: TIWEdit;
    Ordenacao: TIWComboBox;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWBTNACAO: TIWButton;
    IWACAO: TIWEdit;
    IWBtnLimpaFiltro: TIWButton;
    IWBTNALTERAR: TIWButton;
    IWBTNEXCLUIR: TIWButton;
    dsFDQProdutos: TDataSource;
    COD_PRODUTO: TIWDBEdit;
    PROD_DESCRICAO: TIWDBEdit;
    PROD_INFO_ADICIONAIS: TIWDBEdit;
    BtnGravar: TIWButton;
    GridManual: TIWLabel;
    TituloModal: TIWLabel;
    BTNCancelar: TIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure IWBtnConfirmaFiltroClick(Sender: TObject);
    procedure MontaSQL(Pagina : integer);
    procedure MontaTable();
    procedure IWBtnFiltroAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWBtnLimpaFiltroClick(Sender: TObject);
    procedure IWBTNACAOClick(Sender: TObject);
    procedure ItensPaginaChange(Sender: TObject);
    procedure BotaoPaginaClick(Sender: TObject);
    procedure IWBTNEXCLUIRClick(Sender: TObject);
    procedure IWBTNINCLUIRAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnGravarClick(Sender: TObject);
    procedure IWBTNALTERARAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BTNCancelarClick(Sender: TObject);
  public

  private
    QtdeRegistros,
    PaginaAtual,
    TotalPaginas    : Integer;

    GridHTML : String;

  end;

implementation

{$R *.dfm}

uses ServerController, UserSessionUnit;


procedure TIWFormTableManual.BotaoPaginaClick(Sender: TObject);
var
  Pagina : String;
begin
  if Sender is TIWButton then begin
    Pagina := TIWButton(Sender).GetSubmitParam;

    if Pagina = 'I' then // Volta ao Inicio da Tabela
    begin
      PaginaAtual := 1;
    end;

    if Pagina = 'A' then // Volta ao Inicio da Tabela
    begin
      PaginaAtual := PaginaAtual - 1;
    end;

    if Pagina = 'P' then // Volta ao Inicio da Tabela
    begin
      PaginaAtual := PaginaAtual + 1;
    end;

    if Pagina = 'U' then // Volta ao Inicio da Tabela
    begin
      PaginaAtual := TotalPaginas;
    end;

    MontaSQL(PaginaAtual);
    MontaTable;

    GridManual.Caption := GridHTML;
  end;
end;

procedure TIWFormTableManual.BTNCancelarClick(Sender: TObject);
begin
  Controller.FDQProdutos.Cancel;
end;

procedure TIWFormTableManual.BtnGravarClick(Sender: TObject);
begin
  //
  // GRAVA RESGISTRO
  //
  if Controller.GLBPK <=0 then
    Controller.FDQProdutosCod_Produto.AsInteger := Controller.FB_ReturnNextCOD_ByGenerator('GEN_PRODUTO_ID');

  try
    Controller.FDQProdutos.Post;

    if Controller.GLBCrud = 'Alteração' then
      WebApplication.ShowMessage('Alteração realizada com sucesso !')
    else
      WebApplication.ShowMessage('Cadastro realizado com sucesso !');

  except
    WebApplication.ShowMessage('ATENÇÃO!!! Ocorreu um erro na gravação do registro !');
  end;

  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable;

  GridManual.Caption := GridHTML;
end;

procedure TIWFormTableManual.ItensPaginaChange(Sender: TObject);
begin
  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable;

  GridManual.Caption := GridHTML;
end;

procedure TIWFormTableManual.IWAppFormCreate(Sender: TObject);
begin
  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable;

  GridManual.Caption := GridHTML;
end;

procedure TIWFormTableManual.MontaSQL(Pagina : integer);
var
  xWhere : String;
begin
  //
  // Para selecionar registros baseados na qtde por pagina e pulando paginas precisamos
  // usar recursos do proprio banco de dados como a seguir:
  // Banco Firebird: SELECT FIRST 10 SKIP 30 * FROM products, vai pegar 10 registros a partir do 30º
  // Banco MySQL: SELECT * FROM products LIMIT 30, 10
  // MSSQL SERVER: Select Top 20 from products  Qtde de registros a pular mais a qtde que quer mostrar

  //
  // Aplicar Filtro
  //
  Controller.FDQQuery.Close;
  Controller.FDQQuery.SQL.Clear;
  Controller.FDQQuery.SQL.Add('SELECT count(*) as TotRegistros FROM Produto ');
  Controller.FDQQuery.SQL.Add('Where Prod_Descricao <> '''' ');

  xWhere := '';
  if Codigo.Text <> '' then
  begin
    xWhere := xWhere + '      and COD_PRODUTO like ''%'+StringReplace(UpperCase(Codigo.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  if Descricao.Text <> '' then
  begin
    xWhere := xWhere + '      and Upper(PROD_DESCRICAO) like ''%'+StringReplace(UpperCase(Descricao.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  if Adicionais.Text <> '' then
  begin
    xWhere := xWhere + '      and Upper(PROD_INFO_ADICIONAIS) like ''%'+StringReplace(UpperCase(Adicionais.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  Controller.FDQQuery.SQL.Add(xWhere);
  Controller.FDQQuery.Open;
  QtdeRegistros := Controller.FDQQuery.FieldByName('TotRegistros').asInteger;
  Controller.FDQQuery.Close;

  //
  // Aplicar Filtro agora dando skip e pegando X itens
  //
  Controller.FDQProdutos2.Close;
  Controller.FDQProdutos2.SQL.Clear;
  Controller.FDQProdutos2.SQL.Add('SELECT FIRST '+ItensPagina.SelectedValue+' SKIP '+IntToStr(ItensPagina.SelectedValue.ToInteger*(Pagina-1))+' * FROM Produto ');
  Controller.FDQProdutos2.SQL.Add('Where Prod_Descricao <> '''' ');

  xWhere := '';
  if Codigo.Text <> '' then
  begin
    xWhere := xWhere + '      and COD_PRODUTO like ''%'+StringReplace(UpperCase(Codigo.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  if Descricao.Text <> '' then
  begin
    xWhere := xWhere + '      and Upper(PROD_DESCRICAO) like ''%'+StringReplace(UpperCase(Descricao.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  if Adicionais.Text <> '' then
  begin
    xWhere := xWhere + '      and Upper(PROD_INFO_ADICIONAIS) like ''%'+StringReplace(UpperCase(Adicionais.Text), ' ', '%', [rfReplaceAll, rfIgnoreCase])+'%'' ';
  end;

  Controller.FDQProdutos2.SQL.Add(xWhere);

  // ORDENACAO
  if Ordenacao.SelectedValue = 'Código Produto' then
    Controller.FDQProdutos2.SQL.Add('Order by COD_PRODUTO ');
  if Ordenacao.SelectedValue = 'Descrição Produto' then
    Controller.FDQProdutos2.SQL.Add('Order by PROD_DESCRICAO ');

  Controller.FDQProdutos2.Open;
  Controller.FDQProdutos2.First;

  TotalPaginas := Ceil(QtdeRegistros / ItensPagina.SelectedValue.ToInteger);

  Paginacao.Text := Controller.MontaPaginacao(PaginaAtual, TotalPaginas, QtdeRegistros);
end;

procedure TIWFormTableManual.MontaTable();
begin
  GridHTML := '<table class="table table-striped table-hover table-condensed table-responsive"> '+#13+#10+
              '    <tr> '+#13+#10+
              '        <td align="center" valign="middle"><b>Cód. Produto</b></td> '+#13+#10+
              '        <td align="left" valign="middle"><b>Descrição do Produto</b></td> '+#13+#10+
              '        <td align="left" valign="middle"><b>Informações Adicionais</b></td> '+#13+#10+
              '        <td align="right" valign="middle"><b>Estoque Atual</b></td> '+#13+#10+
              '        <td valign="middle">&nbsp; </td> '+#13+#10+
              '        <td valign="middle">&nbsp; </td> '+#13+#10+
              '    </tr> '+#13+#10;

  while not Controller.FDQProdutos2.Eof do
  begin
    GridHTML := GridHTML + '    <tr> '+#13+#10;
    GridHTML := GridHTML + '        <td align="center" valign="middle">'+Controller.FDQProdutos2COD_PRODUTO.AsString+'</td> '+#13+#10;
    GridHTML := GridHTML + '        <td align="left" valign="middle">'+Controller.FDQProdutos2PROD_DESCRICAO.AsString+'</td> '+#13+#10;
    GridHTML := GridHTML + '        <td align="left" valign="middle">'+Controller.FDQProdutos2PROD_INFO_ADICIONAIS.AsString+'</td> '+#13+#10;
    GridHTML := GridHTML + '        <td align="right" valign="middle">'+Controller.FDQProdutos2PROD_ESTOQUE.AsString+'</td> '+#13+#10;
    GridHTML := GridHTML + '        <td align="center" style="width: 20px;" valign="middle">'+
                           '            <a href="javascript:SetaAcao(''A'', '+Controller.FDQProdutos2COD_PRODUTO.AsString+');">'+
                           '                <button type="button" class="btn btn-primary btn-xs" title="Editar Registro"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> </button>'+
                           '            </a>'+
                           '        </td> '+#13+#10;
    GridHTML := GridHTML + '        <td align="center" style="width: 20px;" valign="middle">'+
                           '            <a href="javascript:SetaAcao(''E'', '+Controller.FDQProdutos2COD_PRODUTO.AsString+');">'+
                           '                <button type="button" class="btn btn-danger btn-xs" title="Excluir Registro"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> </button>'+
                           '            </a>'+
                           '        </td> '+#13+#10;
    GridHTML := GridHTML + '    </tr> '+#13+#10;

    Controller.FDQProdutos2.Next;
  end;
  GridHTML := GridHTML + '</table> '+#13+#10;

end;

procedure TIWFormTableManual.IWAppFormDestroy(Sender: TObject);
begin
  Controller.FDQProdutos2.Close;
end;

procedure TIWFormTableManual.IWBTNACAOClick(Sender: TObject);
begin
  // Todo clique de menu passa por aqui
  Controller.AcaoMenu(IWACAO.Text);
end;

procedure TIWFormTableManual.IWBTNALTERARAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//  WebApplication.ShowMessage('Cliquei para ALTERAR o registro com código '+IWAcao.Text);

  Controller.FDQProdutos.Close;
  Controller.FDQProdutos.ParamByName('Produto').Value := StrToInt(IWACAO.Text);
  Controller.FDQProdutos.Open;
  Controller.FDQProdutos.Edit;

  Controller.GLBPK := Controller.FDQProdutosCOD_PRODUTO.Value;

  TituloModal.Caption := 'Alteração';

  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#Cadastro'').modal(''show'');');

end;

procedure TIWFormTableManual.IWBtnConfirmaFiltroClick(Sender: TObject);
begin
  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable;

  GridManual.Caption := GridHTML;
end;

procedure TIWFormTableManual.IWBTNEXCLUIRClick(Sender: TObject);
begin
//  WebApplication.ShowMessage('Cliquei para EXCLUIR o registro com código '+IWAcao.Text);

  // Rotina de Exclusao do Registro selecionado

  Controller.FDQQuery.Close;
  Controller.FDQQuery.SQL.Clear;
  Controller.FDQQuery.SQL.Add('Delete from Produto ');
  Controller.FDQQuery.SQL.Add('Where COD_Produto = '+Trim(IWAcao.Text));
  Controller.FDQQuery.ExecSQL;
  Controller.FDQQuery.Close;

  WebApplication.ShowMessage('Código '+Trim(IWAcao.Text)+' excluido com sucesso !!!');

  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable;

  GridManual.Caption := GridHTML;
end;

procedure TIWFormTableManual.IWBtnFiltroAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#ModalFiltro'').modal(''show'');');
end;

procedure TIWFormTableManual.IWBTNINCLUIRAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
//  WebApplication.ShowMessage('Cliquei em Incluir Produto !!!');
  Controller.FDQProdutos.Close;
  Controller.FDQProdutos.Open;
  Controller.FDQProdutos.Insert;

  Controller.GLBPK := -1;
  TituloModal.Caption := 'Inclusão';

  WebApplication.CallBackResponse.AddJavaScriptToExecute('$(''#Cadastro'').modal(''show'');');
end;

procedure TIWFormTableManual.IWBtnLimpaFiltroClick(Sender: TObject);
begin
  Codigo.Text := '';
  Descricao.Text := '';
  Adicionais.Text := '';

  PaginaAtual := 1;
  MontaSQL(PaginaAtual);
  MontaTable();

  GridManual.Caption := GridHTML;
end;

end.
