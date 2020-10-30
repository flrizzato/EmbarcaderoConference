unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, AqDrop.DB.FD.SQLite, AqDrop.DB.ORM.Manager, uProduto,
  FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI,
  System.Generics.Collections, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.GenData, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.ObjectScope, Data.Bind.Components, FMX.Edit, FMX.ListView;

type
  TForm3 = class(TForm)
    Button1: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Edit1: TEdit;
    Edit2: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    AdapterBindSource1: TAdapterBindSource;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdapterBindSource1CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button2Click(Sender: TObject);
  private
    FConnection: TAqFDSQLiteConnection;
    FManager: TAqDBORMManager;
    FClienteProdutos: TProdutos;
    FListaProdutos: TList<TProduto>;
    FAdapter: TListBindSourceAdapter<TProduto>;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

uses
  AqDrop.Core.Collections.Intf, AqDrop.DB.Types;

procedure TForm3.AdapterBindSource1CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
begin
  FListaProdutos := TList<TProduto>.Create;
  FAdapter := TListBindSourceAdapter<TProduto>.Create(Self, FListaProdutos, True);
  ABindSourceAdapter := FAdapter;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  lListaProdutos: IAqResultList<TProduto>;
begin
  if FClienteProdutos.Get(lListaProdutos) then
  begin
    FListaProdutos.Clear;
    lListaProdutos.ExtractAllTo(FListaProdutos);
    AdapterBindSource1.Refresh;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  AdapterBindSource1.Refresh;
  FListaProdutos[FAdapter.CurrentIndex].Save;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  lReader: IAqDBReader;
begin
  FConnection := TAqFDSQLiteConnection.Create;
  FConnection.DataBase := 'c:\temp\ec2017.sqlite3';
  FConnection.Connect;

// rotinas para criar uma base para o usuário do exemplo
  FConnection.ExecuteCommand(
    'create table if not exists produto (id integer primary key autoincrement, nome text, valor real)');
  FConnection.ExecuteCommand(
    'delete from produto');
  lReader := FConnection.OpenQuery('select id from produto limit 1');

  if not lReader.Next then
  begin
    FConnection.ExecuteCommand(
      'insert into produto (nome, valor) values (''iPhone X'', 7990)');
    FConnection.ExecuteCommand(
      'insert into produto (nome, valor) values (''Galaxy Note 8'', 4320)');
    FConnection.ExecuteCommand(
      'insert into produto (nome, valor) values (''Moto Z 2'', 1830)');
  end;


  FManager := TAqDBORMManager.Create(FConnection);

  FClienteProdutos := FManager.GetClient<TProdutos>;
end;

end.
