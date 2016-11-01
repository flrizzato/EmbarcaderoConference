unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  uAction_MongoQuery, System.Actions, FMX.ActnList, FMX.StdCtrls, uMongoQuery,
  uConexaoMongo, FMX.Controls.Presentation, FMX.Edit, uEditMongo, FMX.Layouts,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.ListBox,
  Data.DB, Datasnap.DBClient;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    EditMongo1: TEditMongo;
    EditMongo2: TEditMongo;
    EditMongo3: TEditMongo;
    EditMongo4: TEditMongo;
    MongoConexao1: TMongoConexao;
    MongoQuery1: TMongoQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ActionList1: TActionList;
    MongoInsert1: TMongoInsert;
    MongoUpdate1: TMongoUpdate;
    MongoDelete1: TMongoDelete;
    MongoSelectEdit1: TMongoSelectEdit;
    MongoSelect1: TMongoSelect;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

end.
