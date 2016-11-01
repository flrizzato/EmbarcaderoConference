unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types, System.JSON.Readers,
  System.JSON.BSON, System.JSON.Builders, FireDAC.Phys.MongoDBWrapper,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Phys.MongoDBDataSet, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    FDMongoDataSet1: TFDMongoDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
  { Private declarations }
    FConMongo : TMongoConnection;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FConMongo['CONFERENCE']['CRUD'].Insert()
  .Values()
    .Add('NOME', 'Embarcadero')
    .BeginObject('ITEM01')
                  .add('DESCRICAO', 'MACARRAO')
                  .Add('UNIDADE', 'UND')
                  .Add('PRECO', 5)
                .EndObject
    {.BeginArray('ITENS')
                .BeginObject('ITEM01')
                  .add('DESCRICAO', 'MACARRAO')
                  .Add('UNIDADE', 'UND')
                  .Add('PRECO', 5)
                .EndObject
                .BeginObject('ITEM02')
                  .add('DESCRICAO', 'BATATA')
                  .Add('UNIDADE', 'UND')
                  .Add('PRECO', 5)
                .EndObject
        .EndArray   }
  .&End
  .Exec;
  ShowMessage('Inserido com Sucesso');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oCrs : IMongoCursor;
begin
  oCrs := FConMongo['CONFERENCE']['CRUD'].Find()
          {.Match()
            .Add('NOME', 'Embarcadero')
          .&End};
  FDMongoDataSet1.Active := false;
  FDMongoDataSet1.Cursor := oCrs;
  FDMongoDataSet1.Active := true;
 // DataSource2.DataSet := (FDMongoDataSet1.FieldByName('ITENS') as TDataSetField).NestedDataSet;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FConMongo['CONFERENCE']['CRUD'].Update()
  .Match()
    .Add('NOME', 'Conference')
  .&End
  .Modify()
    .&Set()
      .Field('NOME', 'Conference')
    .&End
    .CurrentDate()
      .AsDate('Alteracao')
    .&End
    .AddToSet()
      .Field('Idade', 29)
      .Field('Obs', 'A Palestra está show')
    .&End
  .&End
  .Exec;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FConMongo['CONFERENCE']['CRUD'].Remove()
  .Match()
    .Add('NOME', 'Conference')
  .&End
  .Exec;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDConnection1.Connected := true;
  FConMongo := TMongoConnection(FDConnection1.CliObj);
end;

end.
