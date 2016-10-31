unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  FireDac.dApt, uCadPedidos, FMX.Objects, uDmDados, uCidades, uCadCidades;


type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Image1: TImage;
    Cidades: TMenuItem;
    StyleBook1: TStyleBook;
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure CidadesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses uCadClientes;

procedure TfrmPrincipal.CidadesClick(Sender: TObject);
var
  FormCid: TFrmCadCidades;
begin
 try
  FormCid := TFrmCadCidades.Create(Self);
  FormCid.ShowModal
 finally
  FormCid.Free;
 end;
end;

procedure TfrmPrincipal.MenuItem2Click(Sender: TObject);
var
  FormCli: TFrmCadClientes;
begin
 try
  FormCli := TFrmCadClientes.Create(Self);
  FormCli.ShowModal
 finally
  FormCli.Free;
 end;
end;

procedure TfrmPrincipal.MenuItem3Click(Sender: TObject);
var
  FormItens: TFrmItens;
begin
 try
  FormItens := TFrmItens.Create(Self);
  FormItens.ShowModal
 finally
  FormItens.Free;
 end;
end;

end.
