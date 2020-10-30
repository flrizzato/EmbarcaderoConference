unit Unt_FrontEnd;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Unt_ClasseLista,
  Unt_ClassesLinhas,
  Unt_ClasseLinhaBase;

type
  TfFrondEnd = class(TForm)
    mResultado: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Panel2: TPanel;
    LinkLabel1: TLinkLabel;
    LinkLabel2: TLinkLabel;
    LinkLabel3: TLinkLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    FGeradorDocumento: TGeradorDocumento;
    procedure ExecutarExemplo;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  fFrondEnd: TfFrondEnd;

implementation

uses
  ShellApi;

{$R *.dfm}

procedure TfFrondEnd.AfterConstruction;
begin
  inherited;
  Self.FGeradorDocumento := TGeradorDocumento.Create;
end;

procedure TfFrondEnd.BeforeDestruction;
begin
  inherited;
  Self.FGeradorDocumento.Free;
end;

procedure TfFrondEnd.Button1Click(Sender: TObject);
begin
  Self.ExecutarExemplo;

  Self.FGeradorDocumento.Clear;
end;

procedure TfFrondEnd.Button2Click(Sender: TObject);
var
oItem : TLinha000;
begin
  oItem := TLinha000.Create;
  oItem.DataGeracao := Now;

  Self.FGeradorDocumento.Add(oItem);
end;

procedure TfFrondEnd.Button3Click(Sender: TObject);
var
oItem : TLinha001;
begin
  oItem := TLinha001.Create;
  oItem.NomeContador := 'MONTEIRO LOBATO';
  oItem.CRCCOntador := '123456';

  Self.FGeradorDocumento.Add(oItem);
end;

procedure TfFrondEnd.Button4Click(Sender: TObject);
var
oItem : TLinha002;
begin
  oItem := TLinha002.Create;
  oItem.NomeEmpresa := 'EMBARCADERO DO BRASIL';
  oItem.CNPJ := '99999999999999';

  Self.FGeradorDocumento.Add(oItem);
end;

procedure TfFrondEnd.Button5Click(Sender: TObject);
var
oItem : TLinha003;
begin
  oItem := TLinha003.Create;
  oItem.DataVenda := Now;
  oItem.NomeCliente := 'JOSE MARIO SILVA GUEDES';
  oItem.ValorCompra := 1500.45;

  Self.FGeradorDocumento.Add(oItem);
end;

procedure TfFrondEnd.Button6Click(Sender: TObject);
begin
  Self.FGeradorDocumento.Add(TLinha999.Create);
end;

procedure TfFrondEnd.ExecutarExemplo;
begin
  Screen.Cursor := crHourGlass;

  try
    Self.mResultado.Clear;
    Self.mResultado.Text := Self.FGeradorDocumento.GerarDocumento;
  finally
    Application.ProcessMessages;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfFrondEnd.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
 ShellExecute(0, nil, PChar(Link), nil, nil, 1);
end;

end.
