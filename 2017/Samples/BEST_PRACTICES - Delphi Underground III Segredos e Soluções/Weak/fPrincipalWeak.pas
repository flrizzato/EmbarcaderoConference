unit fPrincipalWeak;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Generics.Collections;

type
  TPessoa = class
  private
    FNome: string;
    FDependentes: TObjectList<TPessoa>;
    [weak]
    FResponsavel: TPessoa;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarDependente;

    property Nome: string read FNome write FNome;
  end;

  TForm3 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

{ TPessoa }

procedure TPessoa.AdicionarDependente;
begin
  FDependentes.Add(TPessoa.Create);
  FDependentes.Last.FResponsavel := Self;
end;

constructor TPessoa.Create;
begin
  FDependentes := TObjectList<TPessoa>.Create;
end;

destructor TPessoa.Destroy;
begin
  Form3.Label1.Text := (Form3.Label1.Text.ToInteger + 1).ToString;

  inherited;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  lPessoa: TPessoa;
begin
  lPessoa := TPessoa.Create;

  lPessoa.Nome := 'Teste ARC';

  ShowMessage(lPessoa.Nome);
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  lPessoa: TPessoa;
begin
  lPessoa := TPessoa.Create;

  lPessoa.Nome := 'Teste ARC';
  lPessoa.AdicionarDependente;

  ShowMessage(lPessoa.Nome);
end;

end.
