unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListView.Types,
  Data.DB, Datasnap.DBClient, FMX.ListView, FMX.Objects, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Xml.xmldom;

type
  TForm5 = class(TForm)
    cdsListaClientes: TClientDataSet;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    edtCodigo: TEdit;
    edtnome: TEdit;
    btnPesquisar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    TabItem2: TTabItem;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCodigo2: TEdit;
    edtSexo: TEdit;
    edtDataNasc: TEdit;
    edtCidade: TEdit;
    edtNomeCompleto: TEdit;
    TabItem3: TTabItem;
    edtCodInicial: TEdit;
    Label8: TLabel;
    edtCodFinal: TEdit;
    Label9: TLabel;
    Button2: TButton;
    ListView2: TListView;
    cdsListaClientesID_SMS_PESSOA: TIntegerField;
    cdsListaClientesDS_NOME: TStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure btnPesquisarClick(Sender: TObject);
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

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

uses untIDelphiConference;
{$R *.LgXhdpiTb.fmx ANDROID}


procedure TForm5.btnPesquisarClick(Sender: TObject);
var
  FDelphiConference : IDelphiConference;
begin
  try
    FDelphiConference := GetIDelphiConference();
    edtnome.Text      := FDelphiConference.GetNomeCliente(StrToInt(edtCodigo.Text));
  finally
    FDelphiConference:= nil;
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
      edtNomeCompleto.Text    := FCliente.Nome;
      edtSexo.Text            := FCliente.Sexo;
      edtDataNasc.Text        := FCliente.DataNascimento;
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
