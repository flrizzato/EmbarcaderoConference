unit uFrmCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB, Datasnap.DBClient, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TForm5 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtNome: TEdit;
    btnBuscarcliente: TButton;
    edtCodigo: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtNome2: TEdit;
    Button1: TButton;
    edtCodigo2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtSexo: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtDataNascimento: TEdit;
    Label10: TLabel;
    edtCidade: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edtCodFinal: TEdit;
    Button2: TButton;
    edtCodInicial: TEdit;
    DBGrid1: TDBGrid;
    cdsListaClientes: TClientDataSet;
    dsListaClientes: TDataSource;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure btnBuscarclienteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses untIDelphiConference;

procedure TForm5.btnBuscarclienteClick(Sender: TObject);
var
  FDelphiConference : IDelphiConference;
begin
  try
    FDelphiConference       := GetIDelphiConference();
    edtNome.Text            := FDelphiConference.GetNomeCliente(StrToInt(edtCodigo.Text));
  finally
    FDelphiConference       := nil;
  end;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
  FDelphiConference : IDelphiConference;
  FCliente          : TCliente;
begin
  try
    try
      FDelphiConference       := GetIDelphiConference();
      FCliente                := FDelphiConference.GetCliente(StrToInt(edtCodigo2.Text));
      edtNome2.Text           := FCliente.Nome;
      edtSexo.Text            := FCliente.Sexo;
      edtDataNascimento.Text  := FCliente.DataNascimento;
      edtCidade.Text          := FCliente.Cidade;
    except
      edtNome.Text      := 'Dados inválidos, verifique!!!!';
    end;
  finally
    FCliente          := nil;
    FDelphiConference := nil;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  FDelphiConference : IDelphiConference;
  FBuffer           : string;
  FStream           : TStringStream;
begin
  try
    FDelphiConference       := GetIDelphiConference();
    FBuffer                 := FDelphiConference.GetIntervaloClientes(StrToInt(edtCodInicial.Text),
                                                                     StrToInt(edtCodFinal.Text));
    FStream                 := TStringStream.Create(FBuffer);
    cdsListaClientes.LoadFromStream(FStream);
  finally
    FreeAndNil(FStream);
    FDelphiConference := nil;
  end;

end;

end.
