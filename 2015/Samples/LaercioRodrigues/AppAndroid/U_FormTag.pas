unit U_FormTag;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Data.DbxHTTPLayer, Data.DB,
  Data.SqlExpr, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    SQLConnection: TSQLConnection;
    ToolBar1: TToolBar;
    Button1: TButton;
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

uses U_Proxy;

procedure TForm1.Button1Click(Sender: TObject);
Var
  Obj : TDSMPalestraClient;
begin
   SQLConnection.Open;
   Obj := TDSMPalestraClient.Create(SQLConnection.DBXConnection);
   Obj.AbrirPorta('CMDATIVAR');
   SQLConnection.Close;
end;

end.
