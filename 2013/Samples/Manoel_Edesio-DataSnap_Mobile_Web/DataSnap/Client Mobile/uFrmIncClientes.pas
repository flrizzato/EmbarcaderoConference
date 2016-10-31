unit uFrmIncClientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  Data.DB, Datasnap.DBClient, Datasnap.DSConnect, FMX.Edit;

type
  TfrmIncClientes = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    DSProviderConnection1: TDSProviderConnection;
    cdsInclusao: TClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    edtID: TEdit;
    ClearEditButton1: TClearEditButton;
    edtNome: TEdit;
    ClearEditButton2: TClearEditButton;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncClientes: TfrmIncClientes;

implementation

{$R *.fmx}

uses uFrmClientes, uDMDados;

procedure TfrmIncClientes.SpeedButton1Click(Sender: TObject);
begin
   try
     cdsinclusao.Close;
     cdsInclusao.CommandText := Format('INSERT INTO CLIENTE(ID,NOME) VALUES (%d,%s)',
     [StrToInt(edtID.Text),Quotedstr(edtNome.Text)]);
     cdsInclusao.Execute;
     Self.Hide;
     Frmclientes.Show;
   except
   On E:Exception do
    Label1.Text := e.Message;

   end;
end;

procedure TfrmIncClientes.SpeedButton2Click(Sender: TObject);
begin
  Self.Hide;
  frmClientes.Show;
end;

end.
