unit EC2015_JSON.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Rtti,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.jpeg;

type

  TPessoa = class
  private
    FNome : string;
    FIdade: Integer;
  published
    property Nome : string read FNome write FNome;
    property Idade: Integer read FIdade write FIdade;
  end;

  TfPrincipal = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mJSON: TMemo;
    Panel2: TPanel;
    Button1: TButton;
    Panel3: TPanel;
    PageControl2: TPageControl;
    JSON: TTabSheet;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Edit1: TEdit;
    Informações: TTabSheet;
    TabSheet3: TTabSheet;
    Panel4: TPanel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    Memo3: TMemo;
    LinkLabel2: TLinkLabel;
    Memo4: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    LinkLabel3: TLinkLabel;
    Button7: TButton;
    TabSheet4: TTabSheet;
    Image1: TImage;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LinkLabel1: TLinkLabel;
    Panel6: TPanel;
    mLog: TMemo;
    Memo2: TMemo;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure LinkLabel2LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
    procedure Button7Click(Sender: TObject);
  private
    FBufferBSON: TArray<Byte>;
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

uses
  Diagnostics,
  TypInfo,
  Shellapi,
  System.JSON,
  System.JSON.BSON,
  System.JSON.Builders,
  System.JSON.Readers,
  System.JSON.Writers,
  System.JSON.Utils,
  System.JSON.Types,
  System.JSONConsts,
  REST.JSON,
  EC2015_JSON.InstagramApiREST;

{$R *.dfm}

procedure TfPrincipal.Button1Click(Sender: TObject);
var
  oJSON: System.JSON.TJSONValue;
begin
  { *
    Para criar um objeto JSON à partir de uma string no format JSON
    A classe TJSONObject possui o método de classe ParseJSONValue
    que resolve um JSON, gerando uma instância de classe adequado:

    * TJSONObject
    * TJSONNull
    * TJSONTrue
    * etc ...
    * }
  oJSON := System.JSON.TJSONObject.ParseJSONValue(Trim(Self.mJSON.Text));

  // Se a string for válida o objeto é criado
  if Assigned(oJSON) then
  begin
    ShowMessage(oJSON.ClassName);
    oJSON.Free;
  end
  else
  begin
    ShowMessage('Não é um JSON Válido!');
  end;
end;

procedure TfPrincipal.Button2Click(Sender: TObject);
const
  C_LINK = '<a href="%s">Abrir Imagem no Navegador</a>';

  function _Find(const APath: string): string;
  var
    oTexto     : TStringReader; // O texto JSON será iterado por esta classe
    oLeitor    : TJsonTextReader; // A interpretação do JSON será feito por esta classe
    oAnalisador: TJSONIterator; // O JSONPath é viabilizada por esta classe
    bRet       : Boolean;
  begin
    { *
      Instanciando as classes necessárias para interpretar o JSON
      * }
    oTexto := TStringReader.Create(DataModule1.RESTResponse1.JSONText);
    oLeitor := TJsonTextReader.Create(oTexto);
    oAnalisador := TJSONIterator.Create(oLeitor);
    try
      { *
        O método Find() da classe TJSONIterator executa o JSONPath
        Retorna verdadeiro em caso de sucesso
        * }
      bRet := oAnalisador.Find(APath);
      if bRet then
      begin
        { *
          Em caso de sucesso várias propriedades são preenchidas e dai
          usamos aquelas que são úteis para o nosso objetivo.
          Neste exemplo -didático- sabemos que se trata de uma string,
          por isso retornamos a propriedade AsString
          * }
        Result := oAnalisador.AsString;
      end;
    finally
      oLeitor.Free;
      oAnalisador.Free;
      oTexto.Free;
    end;
  end;

  procedure _Likes;
  var
    oTexto     : TStringReader; // O texto JSON será iterado por esta classe
    oLeitor    : TJsonTextReader; // A interpretação do JSON será feito por esta classe
    oAnalisador: TJSONIterator; // O JSONPath é viabilizada por esta classe
    bRet       : Boolean;
  begin
    Self.Memo4.Clear;

    { *
      Instanciando as classes necessárias para interpretar o JSON
      * }
    oTexto := TStringReader.Create(DataModule1.RESTResponse1.JSONText);
    oLeitor := TJsonTextReader.Create(oTexto);
    oAnalisador := TJSONIterator.Create(oLeitor);

    try
      { *
        O método Find() da classe TJSONIterator executa o JSONPath
        Retorna verdadeiro em caso de sucesso
        * }
      bRet := oAnalisador.Find('data[0].likes.data');
      if bRet then
      begin
        { *
          Sabemos que o para data do objeto like é um array.
          O IF abaixo é -didático- para evidenciar a funcionalidade
          da propriedade InRecurse: saber se o elemento é iterável: array ou objeto
          * }
        if oAnalisador.InRecurse then
        begin
          { *
            O método Recurse inicia a iteração do objeto JSON ou array JSON
            Isso não significa que estamos no primeiro elemento.
            * }
          oAnalisador.Recurse;

          { *
            O método Next() vai para o próximo elemento do objeto iterável
            * }
          while oAnalisador.Next() do
          begin
            { *
              Como sabemos que um item deste array é um objeto invocamos
              o método Recurse().

              Observe:
              =======

              O objeto *oAnalisador*, da classe TJSONIterator esta referenciando
              o item atual do array
              * }
            oAnalisador.Recurse;

            { *
              Neste ponto verificamos se conseguimos recuperar o par
              full_name do objeto, preenchendo o Memo4 da tela
              * }
            if oAnalisador.Next('full_name') then
            begin
              Memo4.Lines.Add(oAnalisador.AsString);
            end;

            { *
              Neste ponto, então, voltamos ao array (no caso deste exemplo)
              * }
            oAnalisador.Return;
          end; // while oAnalisador.Next() do
        end;
      end;
    finally
      oLeitor.Free;
      oAnalisador.Free;
      oTexto.Free;
    end;
  end;

begin
  { *
    Na linha abaixo estamos preenchendo um parâmetro para a requisição REST
    ao Instagram com a hashtag desejada
    * }
  DataModule1.RESTRequest1.Params.Items[0].Value := Self.Edit1.Text;

  // Executando a chamada de forma sincrona
  DataModule1.RESTRequest1.Execute;

  // Mostrando o resultado na tela
  Self.Memo1.Text := DataModule1.RESTResponse1.JSONText;

  // Buscando o par full_name do objeto user do item zero do array data
  Self.Label1.Caption := _Find('data[0].user.full_name');

  // Buscando o par text do objeto caption do item zero do array data
  Self.Memo3.Text := _Find('data[0].caption.text');

  // Buscando o par url do objeto standard_resolution do objeto images do item zero do array data
  Self.LinkLabel2.Caption := Format(C_LINK, [_Find('data[0].images.standard_resolution.url')]);

  // Listando os usuários que deram like na foto
  _Likes;

  Self.PageControl2.ActivePageIndex := 1;
  Application.ProcessMessages;
end;

procedure TfPrincipal.Button3Click(Sender: TObject);
begin
  DataModule1.PedirAutorizacao(Self.LabeledEdit1.Text, Self.LabeledEdit2.Text);
end;

procedure TfPrincipal.Button4Click(Sender: TObject);
var
  oEscritor: TJsonObjectWriter; // Classe que facilita a escrita de um  JSON
begin
  oEscritor := TJsonObjectWriter.Create(True);
  try
{$REGION 'Explica'}
    (*
      Inicia um o objeto JSON

      {

 *)
{$ENDREGION}
    oEscritor.WriteStartObject;

{$REGION 'Explica'}
    (*
      Escreve o primeiro par:

      {
          "nome" : "Mário Guedes" ,

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('nome');
    oEscritor.WriteValue('Mário Guedes');

{$REGION 'Explica'}
    (*
      Escreve o segundo par:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('idade');
    oEscritor.WriteValue(38);

{$REGION 'Explica'}
    (*
      Inicia o par filhos, que será um array:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" :

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('filhos');

{$REGION 'Explica'}
    (*
      Inicia um array:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [

 *)
{$ENDREGION}
    oEscritor.WriteStartArray;

{$REGION 'Explica'}
    (*

      Escreve o primeiro objeto do array:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,

 *)
{$ENDREGION}
    oEscritor.WriteStartObject;
    oEscritor.WritePropertyName('nome');
    oEscritor.WriteValue('Júlio Guedes');
    oEscritor.WritePropertyName('idade');
    oEscritor.WriteValue(11);
    oEscritor.WriteEndObject;

{$REGION 'Explica'}
    (*

      Escreve o primeiro objeto do array:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              } ,

 *)
{$ENDREGION}
    oEscritor.WriteStartObject;
    oEscritor.WritePropertyName('nome');
    oEscritor.WriteValue('Fernanda Guedes');
    oEscritor.WritePropertyName('idade');
    oEscritor.WriteValue(8);
    oEscritor.WriteEndObject;

{$REGION 'Explica'}
    (*

      Por fim finalizamos o array filhos:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              }
          ] ,

 *)
{$ENDREGION}
    oEscritor.WriteEndArray;

{$REGION 'Explica'}
    (*

      Escrevemos mais um par no objeto raiz, com valor nulo:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              }
          ] ,
          "animal_estimacao" : null ,

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('animal_estimacao');
    oEscritor.WriteNull;

{$REGION 'Explica'}
(*

      E mais dois pares no objeto raiz:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              }
          ] ,
          "animal_estimacao" : null ,
          "carro" : true ,
          "moto" : false ,

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('carro');
    oEscritor.WriteValue(True);
    oEscritor.WritePropertyName('moto');
    oEscritor.WriteValue(False);

{$REGION 'Explica'}
(*

      Um último par no objeto raiz, com o detalhe de haveer quebra de linha:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              }
          ] ,
          "animal_estimacao" : null ,
          "carro" : true ,
          "moto" : false ,
          "observações" : "linha 1\nlinha 2" ,

 *)
{$ENDREGION}
    oEscritor.WritePropertyName('observacoes');
    oEscritor.WriteValue('linha 1'#13#10'linha 2');

{$REGION 'Explica'}
(*

      E finalmente encerramos o objeto raiz:

      {
          "nome" : "Mário Guedes" ,
          "idade" : 38 ,
          "filhos" : [
              {
                  "nome" : "Júlio Guedes" ,
                  "idade" : 11
              } ,
              {
                  "nome" : "Fernanda Guedes" ,
                  "idade" : 8
              }
          ] ,
          "animal_estimacao" : null ,
          "carro" : true ,
          "moto" : false ,
          "observações" : "linha 1\nlinha 2" [
      }

 *)
{$ENDREGION}
    oEscritor.WriteEndObject;

  finally
    Self.mLog.Lines.Insert(0, Format('JSON | Tamanho do conteúdo: %d', [oEscritor.JSON.ToJSON.Length]));
    Self.Memo2.Text := oEscritor.JSON.ToJSON;
    oEscritor.Free;
  end;
end;

procedure TfPrincipal.Button5Click(Sender: TObject);
var
  oAuxiliar: TStringReader; // Stream de aramazenamento do texto JSON
  oLeitor  : TJsonTextReader; // Classe para a leitura da estrutura JSON
  sBuffer  : string; // Saída do resultado
  sLastPath: string; // Buffer de controle
  crono    : TStopwatch; // Controle de tempo
begin
  crono := TStopwatch.StartNew;

  sBuffer := #13#10#13#10'--'#13#10;
  oAuxiliar := TStringReader.Create(Trim(Self.Memo2.Text)); // Instancia o TStringReader com o texto a ser analisado
  oLeitor := TJsonTextReader.Create(oAuxiliar); // Instancia o leitor TJsonTextReader com o stream do texto

  try
    sLastPath := '';

    // Enquanto houver dados para ler ...
    while oLeitor.Read do
    begin
      if sLastPath <> oLeitor.Path then
      begin
        // A propriedade Path possui o caminho do elemento atual
        sLastPath := oLeitor.Path;
        sBuffer := sBuffer + #13#10#13#10' --> CAMINHO: ' + oLeitor.Path;
      end;

      // Já a propriedade TokenType indica do que se trata o elemento
      case oLeitor.TokenType of

        // Aqui por exemplo vemos se é o nome de uma propriedade
        // Por ser um exemplo -didático- simplificou-se o exemplo
        TJsonToken.PropertyName:
          begin
            // O método ReadAsString() devolve o valor no formato string.
            // Logo, utilzamos outros métodos conforme o tipo do valor.
            sBuffer := sBuffer + #13#10 + '    Propriedade: ' + oLeitor.Value.AsString;
          end;

      // Se for qualquer outra coisa estamos simplesmente informando o tipo do elemento JSON
      else
        sBuffer := sBuffer + #13#10 + '    Token: ' + GetEnumName(TypeInfo(TJsonToken), Ord(oLeitor.TokenType))
      end;
    end; // while oLeitor.Read do

  finally
    crono.Stop;
    Self.mLog.Lines.Insert(0, Format('TJsonTextReader - Tempo transcorrido: %d ticks', [crono.ElapsedTicks]));
    Self.Memo2.Lines.Add(sBuffer);

    oLeitor.Close;
    oLeitor.Free;
    oAuxiliar.Free;
  end;
end;

procedure TfPrincipal.Button6Click(Sender: TObject);
var
  oSaida : TBytesStream; // Fluxo de bytes onde será armazenado o BSON durante a escrita
  oBSON  : TBsonWriter; // Classe que provê a escrita em BSON
  sBuffer: string;
  i      : Integer;
begin

  (*

    O comportamento do TBsonWriter é muito similar ao TJsonObjectWriter
    Para uma explicação sobre cada método estude o método:

        TfPrincipal.Button4Click()

 *)

  oSaida := TBytesStream.Create();
  oBSON := TBsonWriter.Create(oSaida);
  try
    oBSON.WriteStartObject;

    oBSON.WritePropertyName('nome');
    oBSON.WriteValue('Mário Guedes');

    oBSON.WritePropertyName('idade');
    oBSON.WriteValue(38);

    oBSON.WritePropertyName('filhos');
    oBSON.WriteStartArray;
    oBSON.WriteStartObject;
    oBSON.WritePropertyName('nome');
    oBSON.WriteValue('Júlio Guedes');
    oBSON.WritePropertyName('idade');
    oBSON.WriteValue(11);
    oBSON.WriteEndObject;

    oBSON.WriteStartObject;
    oBSON.WritePropertyName('nome');
    oBSON.WriteValue('Fernanda Guedes');
    oBSON.WritePropertyName('idade');
    oBSON.WriteValue(8);
    oBSON.WriteEndObject;

    oBSON.WriteEndArray;

    oBSON.WritePropertyName('animal_estimacao');
    oBSON.WriteNull;

    oBSON.WritePropertyName('carro');
    oBSON.WriteValue(True);

    oBSON.WritePropertyName('moto');
    oBSON.WriteValue(False);

    oBSON.WritePropertyName('observacoes');
    oBSON.WriteValue('linha 1'#13#10'linha 2');

    oBSON.WriteEndObject;

  finally
    Self.FBufferBSON := oSaida.Bytes;
    SetLength(Self.FBufferBSON, oSaida.Size);
    sBuffer := '';
    for i := Low(Self.FBufferBSON) to High(Self.FBufferBSON) do
    begin
      sBuffer := sBuffer + '[' + IntToHex(Self.FBufferBSON[i], 2) + '] ';
    end;

    Self.mLog.Lines.Insert(0, Format('BSON | Tamanho do conteúdo: %d', [oSaida.Size]));
    Self.Memo2.Text := sBuffer;
    oBSON.Free;
    oSaida.Free;
  end;
end;

procedure TfPrincipal.Button7Click(Sender: TObject);
var
  oEntrada : TBytesStream; // Stream de bytses com o conteúdo a ser interpretado
  oLeitor  : TBsonReader; // Leitor BSON
  sLastPath: string; // Buffer de controle
  sBuffer  : string; // Buffer
  crono    : TStopwatch; // Temporizador
begin
  crono := TStopwatch.StartNew;

  sBuffer := #13#10#13#10'--'#13#10;
  oEntrada := TBytesStream.Create(Self.FBufferBSON); // Instancia o stream de bytes com o conteúdo a ser interpretado
  oLeitor := TBsonReader.Create(oEntrada); // Instancia o leitor BSON com o strem de bytes
  try
    sLastPath := '';

    // Enquanto houver dados para ler ...
    while oLeitor.Read do
    begin
      if sLastPath <> oLeitor.Path then
      begin
        // A propriedade Path possui o caminho do elemento atual
        sLastPath := oLeitor.Path;
        sBuffer := sBuffer + #13#10#13#10' --> CAMINHO: ' + oLeitor.Path;
      end;

      // Já a propriedade TokenType indica do que se trata o elemento
      case oLeitor.TokenType of
        // Aqui por exemplo vemos se é o nome de uma propriedade
        // Por ser um exemplo -didático- simplificou-se o exemplo
        TJsonToken.PropertyName:
          begin
            // O método ReadAsString() devolve o valor no formato string.
            // Logo, utilzamos outros métodos conforme o tipo do valor.
            sBuffer := sBuffer + #13#10 + '    Propriedade: ' + oLeitor.Value.AsString;
          end;

      else
        sBuffer := sBuffer + #13#10 + '    Token: ' + GetEnumName(TypeInfo(TJsonToken), Ord(oLeitor.TokenType))
      end;
    end; // while oLeitor.Read do
  finally
    crono.Stop;
    Self.mLog.Lines.Insert(0, Format('TBsonReader - Tempo transcorrido: %d ticks', [crono.ElapsedTicks]));
    Self.Memo2.Lines.Add(sBuffer);

    oEntrada.Free;
    oLeitor.Free;
  end;
end;

procedure TfPrincipal.Button8Click(Sender: TObject);
var
  oPessoa: TPessoa;
begin
 (*
   Aqui verificamos uma forma rápida de seriação de um objeto Delphi para JSON
 *)
  oPessoa := TPessoa.Create;
  oPessoa.Nome := 'Mário Guedes';
  oPessoa.Idade := 38;
  try
    Self.Memo2.Text := REST.JSON.TJson.ObjectToJsonString(oPessoa);
  finally
    oPessoa.Free;
  end;
end;

procedure TfPrincipal.Button9Click(Sender: TObject);
var
  oPessoa: TPessoa;
begin
  (*
  Aqui verificamos uma forma de deserializar um JSON em um objeto Delphi.

  Precisamos saber previamente o nome da classe
 *)
  oPessoa := REST.JSON.TJson.JsonToObject<TPessoa>(Self.Memo2.Text);
  if Assigned(oPessoa) then
  begin
    ShowMessageFmt('Nome: %s'#13#10'Idade: %d', [oPessoa.Nome, oPessoa.Idade]);
    oPessoa.Free;
  end;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  Self.PageControl1.ActivePageIndex := 0;
  Self.PageControl2.ActivePageIndex := 0;
end;

procedure TfPrincipal.LinkLabel1LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  Shellapi.ShellExecute(0, 'Open', PChar(Link), '', '', SW_SHOWNORMAL);
end;

procedure TfPrincipal.LinkLabel2LinkClick(Sender: TObject; const Link: string; LinkType: TSysLinkType);
begin
  Shellapi.ShellExecute(0, 'Open', PChar(Link), '', '', SW_SHOWNORMAL);
end;

end.
