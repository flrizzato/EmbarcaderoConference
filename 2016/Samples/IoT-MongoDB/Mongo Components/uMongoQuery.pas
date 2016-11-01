unit uMongoQuery;

interface

uses
  System.SysUtils, System.Classes, mongoWire, bsonDoc, bsonUtils, FMX.Forms,
  uEditMongo, uMongoDocument, System.Generics.Collections, FMX.Layouts, uConexaoMongo,
  FMX.ListBox, uMongo_Tipificacoes, System.Variants, DataSnap.DBClient, Data.DB,
  Generics.Collections;

type
  TMongoQuery = class(TComponent)
    private
      FMongoConexao : TMongoConexao;
      FAtivar : Boolean;
      FCollection : String;
      FMongoQuery : TMongoWireQuery;
      FDataSet : TClientDataSet;
      procedure setAtivar(const Value: boolean);
      procedure preencherMongoDoc(Layout : TLayout; var MongoDoc : TMongoDocument);
      procedure criarDataSetLayout(Layout : TLayout);
      procedure criarDataSetLista(Lista : TList<String>);
    public
       FMongoWireQuery : TMongoWireQuery;
       constructor Create(AOwner: TComponent); override;
       function InserirLayout(Layout : TLayout) : Boolean;
       function UpdateLayout(Layout : TLayout) : Boolean;
       function DeleteLayout(Layout : TLayout) : Boolean;
       function SelectLayout(Layout : TLayout) : Boolean;
       function SelectEditLayout(Layout : TLayout) : Boolean;
       procedure buscaFoneticaDataSet(Texto, Index, Campo : String);
       procedure buscaConteudo(Texto, Campo : String);
    published
      property MongoConexao : TMongoConexao read FMongoConexao write FMongoConexao;
      property Ativar : Boolean read FAtivar write setAtivar;
      property Collection : String read FCollection write FCollection;
      property MongoQuery : TMongoWireQuery read FMongoQuery write FMongoQuery;
      property DataSet : TClientDataSet read FDataSet write FDataSet;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TMongoQuery]);
end;

constructor TMongoQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCollection := 'MinhaCollection';
end;

procedure TMongoQuery.setAtivar(const Value: boolean);
begin
  FAtivar := Value;
end;

function TMongoQuery.InserirLayout(Layout: TLayout) : Boolean;
var
  d : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertBSON(d);
      FMongoConexao.FMongoWire.Insert(FCollection, d);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.UpdateLayout(Layout: TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertBSON(d);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Update(FCollection, dChave, d);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.DeleteLayout(Layout: TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
begin
  Result := True;
  d := nil;
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertCampoChave(dChave);
      FMongoConexao.FMongoWire.Delete(FCollection, dChave);
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;
end;

function TMongoQuery.SelectEditLayout(Layout : TLayout) : Boolean;
var
  d, dChave : IBSONDocument;
  MongoDoc : TMongoDocument;
  i : Integer;
  Edit : TEditMongo;
begin
  MongoDoc := TMongoDocument.Create;
  try
    try
      preencherMongoDoc(Layout, MongoDoc);
      MongoDoc.convertCampoChave(dChave);
      d:=FMongoConexao.FMongoWire.Get(FCollection,dChave);
      for i:= 0 to Pred(Layout.ControlsCount) do
      begin
        if (Layout.Controls[i] is TEditMongo) then
        begin
          Edit := TEditMongo(Layout.Controls[i]);
          Edit.Text := VarToStr(d[Edit.MongoCampo]);
        end;
      end;
    except
      Result := False;
    end;
  finally
    MongoDoc.Free;
  end;

end;

function TMongoQuery.SelectLayout(Layout: TLayout) : Boolean;
var
  d : IBSONDocument;
  i : Integer;
  Edit : TEditMongo;
begin
  Result := True;
  d:=BSON;
  try
    FMongoWireQuery := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
    FMongoWireQuery.Query(FCollection, nil);
    criarDataSetLayout(Layout);
    while FMongoWireQuery.Next(d) do
    begin
      FDataSet.Append;
      for i:= 0 to Pred(Layout.ControlsCount) do
      begin
        if (Layout.Controls[i] is TEditMongo) then
        begin
          Edit := TEditMongo(Layout.Controls[i]);
          FDataSet.FieldByName(Edit.MongoCampo).AsVariant := d[Edit.MongoCampo];
        end;
      end;
      FDataSet.Post;
    end;
    FDataSet.Open;
  except
    Result := False;
  end;
end;

procedure TMongoQuery.criarDataSetLayout(Layout : TLayout);
var
  i : Integer;
  Edit : TEditMongo;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.Clear;
  for i:= 0 to Pred(Layout.ControlsCount) do
  begin
    if (Layout.Controls[i] is TEditMongo) then
    begin
      Edit := TEditMongo(Layout.Controls[i]);
      case Edit.MongoTipoCampo of
        Texto: FDataSet.FieldDefs.add(Edit.MongoCampo, ftString, 255);
        Numerico: FDataSet.FieldDefs.add(Edit.MongoCampo, ftInteger);
        Moeda : FDataSet.FieldDefs.add(Edit.MongoCampo, ftFloat);
        DataHora : FDataSet.FieldDefs.add(Edit.MongoCampo, ftString, 50);
      end;
    end;
  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.criarDataSetLista(Lista : TList<String>);
var
  I : Integer;
begin
  FDataSet.Close;
  FDataSet.FieldDefs.Clear;
  for I := 0 to Lista.Count -1 do
  begin
    FDataSet.FieldDefs.add(Lista[I], ftString, 255);
  end;
  FDataSet.CreateDataSet;
end;

procedure TMongoQuery.preencherMongoDoc(Layout: TLayout; var MongoDoc: TMongoDocument);
var
  i : Integer;
begin
  for i:= 0 to Pred(Layout.ControlsCount) do
  begin
    if (Layout.Controls[i] is TEditMongo) then
    begin

      if TEditMongo(Layout.Controls[i]).CampoChave then
      begin
        MongoDoc.addCampoChave(TEditMongo(Layout.Controls[i]).MongoCampo,TEditMongo(Layout.Controls[i]).Text, TEditMongo(Layout.Controls[i]).MongoTipoCampo);
      end;

      case TEditMongo(Layout.Controls[i]).MongoTipoCampo of
        Texto :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).Text, Texto);
          end;
        Numerico :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toNumerico, Numerico);
          end;
        Moeda :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toMoeda, Moeda);
          end;
        DataHora :
          begin
            MongoDoc.addKey(TEditMongo(Layout.Controls[i]).MongoCampo, TEditMongo(Layout.Controls[i]).toDataHora, DataHora);
          end;
      end;
    end;
  end;
end;


procedure TMongoQuery.buscaFoneticaDataSet(Texto, Index, Campo : String);
var
  d : IBSONDocument;
  q : TMongoWireQuery;
  Lista : TList<String>;
begin
   d := BSON;
   q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
   Lista := TList<String>.Create;
   try
     //O index já deve vir com '$'
     Lista.Add(Campo);
     criarDataSetLista(Lista);
     q.Query(FCollection,BSON([Index, BSON(['$search', Texto])]));
     FDataSet.Append;
     while q.Next(d) do
     begin
       FDataSet.FieldByName(Campo).AsVariant := d[Campo];
     end;
     FDataSet.Post;
   finally
    q.Destroy;
    Lista.Destroy;
   end;
end;

procedure TMongoQuery.buscaConteudo(Texto, Campo : String);
var
  d : IBSONDocument;
  q : TMongoWireQuery;
  Lista : TList<String>;
begin
   d := BSON;
   q := TMongoWireQuery.Create(FMongoConexao.FMongoWire);
   Lista := TList<String>.Create;
   try
     Lista.Add(Campo);
     criarDataSetLista(Lista);
     q.Query(FCollection,BSON([Campo, BSON(['$regex', bsonRegExPrefix+'/^'+Texto, '$options' , 'm'])]));

     FDataSet.DisableControls;
     while q.Next(d) do
     begin
       FDataSet.Append;
       FDataSet.FieldByName(Campo).AsVariant := d[Campo];
       FDataSet.Post;
     end;
     FDataSet.EnableControls;;
   finally
    q.Destroy;
    Lista.Destroy;
   end;

end;


end.
