unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FMX.ListView, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Controls, FMX.Layouts,
  Fmx.Bind.Navigator, Data.Bind.Components, Data.Bind.DBScope,
  FireDAC.Comp.DataSet, FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Comp.UI,
  FireDAC.Stan.StorageBin;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1ID: TFDAutoIncField;
    FDQuery1NOME: TStringField;
    FDQuery1DATA_NASC: TDateField;
    FDQuery1FOTO: TBlobField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    NavigatorBindSourceDB1: TBindNavigator;
    Button1: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
uses System.IOUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    FDQuery1.Open();
  except on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TForm1.FDConnection1AfterConnect(Sender: TObject);
begin
//  FDConnection1.ExecSQL('CREATE TABLE IF NOT EXISTS [personagens](' +
//                        '[ID] INTEGER PRIMARY KEY ASC ON CONFLICT ROLLBACK AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK UNIQUE ON CONFLICT ROLLBACK,' +
//                        '[NOME] VARCHAR2(30) NOT NULL ON CONFLICT ROLLBACK, ' +
//                        '[DATA_NASC] DATE NOT NULL ON CONFLICT ROLLBACK,[FOTO] BLOB)');
end;

procedure TForm1.FDConnection1BeforeConnect(Sender: TObject);
begin
  FDConnection1.Params.DriverID := 'SQLite';
//  FDConnection1.Params.Values['OpenMode'] := 'ReadWrite';
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
    FDConnection1.Params.Values['Database'] :=
      TPath.Combine(TPath.GetDocumentsPath, 'exemplo.db3');
  {$ENDIF}
end;

end.
