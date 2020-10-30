unit UntMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.IBBase,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Data.Bind.Components, Data.Bind.DBScope, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.TabControl, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, MultiDetailAppearanceU,
  Fmx.Bind.Editors, FMX.ListView,

  System.IOUtils, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs;

type
  TForm1 = class(TForm)
    fdcIBLite: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    qryUsuarios: TFDQuery;
    qryUsuariosNOME: TStringField;
    qryUsuariosSENHA: TStringField;
    qryUsuariosNOMECOMPLETO: TStringField;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar1: TToolBar;
    Button1: TButton;
    Label1: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    fdcSQLite: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qryUsuarioSQLite: TFDQuery;
    qryUsuarioSQLiteNOME: TStringField;
    qryUsuarioSQLiteSENHA: TStringField;
    qryUsuarioSQLiteNOMECOMPLETO: TStringField;
    ListView2: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    ToolBar2: TToolBar;
    Button2: TButton;
    Label2: TLabel;
    procedure fdcIBLiteBeforeConnect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure fdcSQLiteBeforeConnect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  qryUsuarios.Active := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  qryUsuarioSQLite.Active := True;
end;

procedure TForm1.fdcIBLiteBeforeConnect(Sender: TObject);
begin
  {$IFNDEF MSWINDOWS} //ANDROID E iOS
    fdcIBLite.Params.Values['Protocol'] := 'Local';
    fdcIBLite.Params.Values['Server']   := '';
    fdcIBLite.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'DEMO.IB');
  {$ELSE}             //Windows
    fdcIBLite.Params.Values['Protocol'] := 'TCPIP';
    fdcIBLite.Params.Values['Server']   := 'localhost';
    fdcIBLite.Params.Values['Database'] := 'C:\Projetos\embarcadero-conference-2016\database-mobile-demo\database\DEMO.IB';
  {$ENDIF}
end;

procedure TForm1.fdcSQLiteBeforeConnect(Sender: TObject);
begin
  {$IFNDEF MSWINDOWS} //ANDROID E iOS
    fdcSQLite.Params.Values['OpenMode'] := 'ReadWrite';
    fdcSQLite.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'DEMO.s3db');
  {$ELSE}             //Windows
    fdcSQLite.Params.Values['Database'] := 'C:\Projetos\embarcadero-conference-2016\database-mobile-demo\database\DEMO.s3db';
  {$ENDIF}
end;

end.
