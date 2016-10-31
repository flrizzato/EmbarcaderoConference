unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Memo;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses REST.Json, UsuarioUnit, Data.DBXJSON;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  usuario: TUsuario;
begin
  usuario := TUsuario.Create;
  usuario.Nome := Edit1.Text;
  usuario.Email := Edit2.Text;
  usuario.Idade := Edit3.Text.ToInteger;
  usuario.Endereco.Cidade := Edit5.Text;
  usuario.Endereco.Estado := Edit4.Text;

  Memo1.Lines.Text := TJson.Format(TJson.ObjectToJsonObject(usuario));

  usuario.Free;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  usuario: TUsuario;
begin
  usuario := TJson.JsonToObject<TUsuario>(Memo1.Lines.Text);

  Edit1.Text := usuario.Nome ;
  Edit2.Text := usuario.Email;
  Edit3.Text := usuario.Idade.ToString;
  Edit5.Text := usuario.Endereco.Cidade;
  Edit4.Text := usuario.Endereco.Estado;

  usuario.Free;
end;

end.
