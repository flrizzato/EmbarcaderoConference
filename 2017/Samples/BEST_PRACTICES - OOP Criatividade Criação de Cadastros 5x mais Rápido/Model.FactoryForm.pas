unit Model.FactoryForm;

interface

uses
  uFrmAutoForm;


type
  TTipoForm = (tfProduto, tfGrupo, tfFilm, tfcliente);

  TFactoryForm = class
  strict private
    class var FInstance: TFactoryForm;
    constructor Create;
  private
    function CreateFormProduto: TfrmAutoForm;
    function CreateFormGrupo: TfrmAutoForm;
    function CreateFormFilm: TFrmAutoForm;
    function CreateFormCliente: TfrmAutoForm;
  public
    class function GetInstance: TFactoryForm;
    function GetForm(Form: TTipoForm): TfrmAutoForm;
  end;

implementation

constructor TFactoryForm.Create;
begin
  inherited;
end;

function TFactoryForm.CreateFormCliente: TfrmAutoForm;
var
  Form: TfrmAutoForm;
begin
  Form := TfrmAutoForm.Create(nil, 'cliente','Embarcadero Conference 2017','idcliente','');
  form.AddStringField('nome','Informe seu nome aqui',40,'',true);
  Form.AddStringField('endereco','Endereço',50);
  Form.AddStringField('email','E-mail',50);
  Form.AddStringField('telefone','Telefone',30,'(99) 09999-9999;1;_');
  Result := Form;
end;

function TFactoryForm.CreateFormFilm: TFrmAutoForm;
begin

end;

function TFactoryForm.CreateFormGrupo: TfrmAutoForm;
var
  Form: TfrmAutoForm;
begin
  Form := TfrmAutoForm.Create(nil,'GRUPO',
       'Cadastro de Grupo','GRUPOID','');
  Form.AddStringField('DESCRICAO','Descrição',100,'',True);
  Result := Form;
end;

function TFactoryForm.CreateFormProduto: TfrmAutoForm;
var
  Form: TfrmAutoForm;
begin
  Form := TfrmAutoForm.Create(nil,'PRODUTO',
  'Cadastro de Produto','PRODUTOID','');
  Form.AddStringField('DESCRICAO','Descrição',70,'',true);
  Form.AddStringField('FABRICANTE','Fabricante',40);
  Form.AddLookupField('GRUPOID','Grupo','GRUPOID',
  'DESCRICAO','SELECT GRUPOID, DESCRICAO FROM GRUPO',50);
  Result := Form;
end;

function TFactoryForm.GetForm(Form: TTipoForm): TfrmAutoForm;
begin
  case Form of
    tfProduto: Result := CreateFormProduto;
    tfGrupo:   Result := CreateFormGrupo;
    tfFilm: Result := CreateFormFilm;
    tfcliente: Result := CreateFormCliente;
  end;
end;

class function TFactoryForm.GetInstance: TFactoryForm;
begin
  If FInstance = nil Then
  begin
    FInstance := Model.FactoryForm.TFactoryForm.Create();
  end;
  Result := FInstance;
end;

end.
