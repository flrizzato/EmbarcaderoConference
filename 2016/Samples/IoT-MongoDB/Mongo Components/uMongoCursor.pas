unit uMongoCursor;

interface

uses
  System.Classes, System.Generics.Collections, System.JSON.Types, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.DatS,
  FireDAC.Phys.MongoDBWrapper, FireDAC.Phys.MongoDB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
  TMongoCursor = class(TComponent)
  private
    FMongoConnection: TMongoConnection;
    FBanco: String;
    FCollection: String;
    FActive: Boolean;
    FCursor: IMongoCursor;
    FConnection: TFDCustomConnection;
    FDatabaseName: String;
    procedure setActive(const Value: Boolean);
    procedure SetConnection(const Value: TFDCustomConnection);
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property MongoConnection : TMongoConnection read FMongoConnection write FMongoConnection;

    property Connection: TFDCustomConnection read FConnection write SetConnection;


    property Banco : String read FBanco write FBanco;
    property Collection : String read FCollection write FCollection;
    property Active : Boolean read FActive write setActive;
    property Cursor : IMongoCursor read FCursor write FCursor;
  end;

  procedure Register;

  implementation

  uses
  System.Variants, System.SysUtils, System.Math, System.Rtti,
  System.JSON.Readers, System.JSON.Writers, System.JSON.Builders,
  FireDAC.Stan.Util, FireDAC.Stan.Error, FireDAC.Stan.Consts,
    FireDAC.Stan.ResStrs;

  procedure Register;
  begin
    RegisterComponents('Mongo Components', [TMongoCursor]);
  end;
  { TMongoCursor }

constructor TMongoCursor.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TMongoCursor.setActive(const Value: Boolean);
var
  FConMongo : TMongoConnection;
begin
  FActive := Value;
  Self.Connection.Connected := true;
  FConMongo := TMongoConnection(Self.Connection.CliObj);
  Self.Cursor := FConMongo[Self.FBanco][Self.FCollection].Find;
end;

procedure TMongoCursor.SetConnection(const Value: TFDCustomConnection);
begin
  FConnection := Value;
end;

end.
