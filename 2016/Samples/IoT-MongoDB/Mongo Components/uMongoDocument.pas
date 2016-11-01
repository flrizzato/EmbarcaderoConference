unit uMongoDocument;

interface

uses
  System.SysUtils, System.Classes, mongoWire, bsonDoc, FMX.Forms,
  System.Generics.Collections, JSON, bsonUtils, uMongo_Tipificacoes, System.Variants;

type
  TKeys = Record
    Key : String;
    Value : OleVariant;
    Tipo : TCampo;
  End;

type
  TDocument = Record
    Key : String;
    Values : TList<TKeys>;
  End;

type
  TMongoDocument = class
    private
      FKeys : TList<TKeys>;
      FDocuments : TList<TDocument>;
      FCampoChave : TKeys;
    public
      constructor Create;
      Destructor  Destroy;
      procedure addKey(Key : String; Value : OleVariant; Tipo : TCampo);
      procedure addCampoChave(Key : String; Value : OleVariant; Tipo : TCampo);
      procedure addDocument(Key : String; Values : TList<TKeys>);
      procedure convertBSON(var DOCBSON : IBSONDocument);
      procedure convertCampoChave(var dChave : IBSONDocument);
    published
      property CampoChave : TKeys read FCampoChave write FCampoChave;
      property Keys : TList<TKeys> read FKeys write FKeys;
      property Documents : TList<TDocument> read FDocuments write FDocuments;
  end;

implementation

constructor TMongoDocument.Create;
begin
  FKeys := TList<TKeys>.Create;
  FDocuments := TList<TDocument>.Create;
end;

destructor TMongoDocument.Destroy;
begin
  FKeys.Free;
  FDocuments.Free;
end;

procedure TMongoDocument.addKey(Key: string; Value: OleVariant; Tipo : TCampo);
var
  newKey : TKeys;
begin
  newKey.Key := Key;
  newKey.Value := Value;
  newKey.Tipo := Tipo;
  Keys.Add(newKey);
end;

procedure TMongoDocument.addCampoChave(Key: string; Value: OleVariant; Tipo : TCampo);
begin
  FCampoChave.Key := Key;
  FCampoChave.Value := Value;
  FCampoChave.Tipo := Tipo;
end;

procedure TMongoDocument.addDocument(Key: string; Values: TList<uMongoDocument.TKeys>);
var
  newDocument : TDocument;
begin
  newDocument.Key := Key;
  newDocument.Values := Values;
  FDocuments.Add(newDocument);
end;

procedure TMongoDocument.convertBSON(var DOCBSON : IBSONDocument);
var
   JA : Array of TJSONObject;
   I : Integer;
   K1, K2 : TKeys;
   Doc1, Doc2 : TDocument;
   doc : IBSONDocument;
   Aux : OleVariant;
   ds : TJSONValue;
begin
   SetLength(JA, Self.FDocuments.Count + 1);
   I := 1;
   JA[0] := TJSONObject.Create;
   try
    //Adicionando as K1
    for K1 in Self.FKeys do
    begin
      case K1.Tipo of
        Texto :
          begin
            JA[0].AddPair(K1.Key, TJSONString.Create(K1.Value));
          end;
        Numerico :
          begin
            JA[0].AddPair(K1.Key, TJSONNumber.Create(K1.Value));
          end;
        Moeda :
          begin
            JA[0].AddPair(K1.Key, TJSONNumber.Create(K1.Value));
          end;
        DataHora:
          begin
            JA[0].AddPair(K1.Key, TJSONString.Create(K1.Value));
          end;
      end;
    end;

    //Adicionando Objetos Embedados
    for Doc1 in Self.FDocuments do
    begin
      try
        JA[I] := TJSONObject.Create;
        for K2 in Doc1.Values do
        begin
          case K1.Tipo of
            Texto :
              begin
                JA[I].AddPair(K2.Key, TJSONString.Create(K2.Value));
              end;
            Numerico :
              begin
                JA[I].AddPair(K2.Key, TJSONNumber.Create(K2.Value));
              end;
            Moeda :
              begin
                JA[I].AddPair(K2.Key, TJSONNumber.Create(K2.Value));
              end;
            DataHora:
              begin
                JA[I].AddPair(K2.Key, TJSONString.Create(K2.Value));
              end;
          end;
        end;
      finally
        JA[0].AddPair(Doc1.Key, JA[I]);
      end;
      I := I + 1;
    end;
    DOCBSON := JsonToBson(JA[0].ToJSON);
   finally
     JA[0].Free;
   end;
end;

procedure TMongoDocument.convertCampoChave(var dChave : IBSONDocument);
var
  J : TJSONObject;
begin
  J := TJSONObject.Create;
  try
    case FCampoChave.Tipo of
      Texto :
        begin
          J.AddPair(FCampoChave.Key, TJSONString.Create(FCampoChave.Value));
        end;
      Numerico :
        begin
          J.AddPair(FCampoChave.Key, TJSONNumber.Create(FCampoChave.Value));
        end;
      Moeda :
        begin
          J.AddPair(FCampoChave.Key, TJSONNumber.Create(FCampoChave.Value));
        end;
      DataHora:
        begin
          J.AddPair(FCampoChave.Key, TJSONString.Create(FCampoChave.Value));
        end;
    end;
    dChave := JsonToBson(J.ToJSON);
  finally
    J.Free;
  end;
end;

end.
