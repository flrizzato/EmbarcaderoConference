unit fCommandsInFDConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.PGDef, FireDAC.Phys.PG,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
  TFrmCommandsInFDConnection = class(TForm)
    btnExecSQLScalar: TButton;
    btnExecSQL: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExecSQLClick(Sender: TObject);
    procedure btnExecSQLScalarClick(Sender: TObject);
  private
    FConnection: TFDConnection;
  public
    { Public declarations }
  end;

var
  FrmCommandsInFDConnection: TFrmCommandsInFDConnection;

implementation

{$R *.dfm}

procedure TFrmCommandsInFDConnection.btnExecSQLClick(Sender: TObject);
begin
  FConnection.ExecSQL('INSERT INTO commands (ds_command) VALUES(:ds_command)',
                      [DateTimeToStr(Now) + ' #ECON2018 #FireDAC']);
  ShowMessage('Registro Inserido!');
end;

procedure TFrmCommandsInFDConnection.btnExecSQLScalarClick(Sender: TObject);
var
  Result: Integer;
begin
  Result := FConnection.ExecSQLScalar('SELECT COUNT(*) FROM commands');
  ShowMessage(Result.ToString + ' Registros Encontrados!');
end;

procedure TFrmCommandsInFDConnection.FormCreate(Sender: TObject);
begin
  FConnection := TFDConnection.Create(Self);
  FConnection.Params.Add('Database=C:\ECON2018\7-3-FireDAC-Recursos-que-você-não-conhecia\00 - DB\ECON2018.FDB');
  FConnection.Params.Add('User_Name=SYSDBA');
  FConnection.Params.Add('Password=masterkey');
  FConnection.Params.Add('DriverID=FB');
  FConnection.Connected := True;
end;

procedure TFrmCommandsInFDConnection.FormDestroy(Sender: TObject);
begin
  FConnection.Connected := False;
  FConnection.Free;
end;

end.
