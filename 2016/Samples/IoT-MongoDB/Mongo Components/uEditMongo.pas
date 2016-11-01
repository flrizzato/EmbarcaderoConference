unit uEditMongo;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, uMongo_Tipificacoes, VCL.Controls, VCL.Forms;

type
  TEditMongo = class(TEdit)
  private
    FMongoCampo: String;
    FMongoTipoCampo: TCampo;
    FAutoInc: Boolean;
    FCampoChave: Boolean;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    function toNumerico : Integer;
    function toMoeda : Currency;
    function toDataHora : TDateTime;

  published
    property MongoTipoCampo : TCampo  read FMongoTipoCampo write FMongoTipoCampo default TCampo.Texto;
    property MongoCampo : String read FMongoCampo write FMongoCampo;
    property AutoInc : Boolean read FAutoInc write FAutoInc;
    property CampoChave : Boolean read FCampoChave write FCampoChave;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mongo Components', [TEditMongo]);
end;

{ TEditMongo }

constructor TEditMongo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TEditMongo.toDataHora: TDateTime;
var
  aux : TDateTime;
begin
  if TryStrToDateTime(Self.Text, aux) then
    Result := StrToDateTime(Self.Text)
  else
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
end;

function TEditMongo.toMoeda: Currency;
var
  aux : Currency;
begin
  if (Pos('.', Self.Text) > 0) and (Pos(',', Self.Text) > 0) then
    Self.Text := StringReplace(Self.Text, '.', '', [rfReplaceAll, rfIgnoreCase])
  else
    Self.Text := StringReplace(Self.Text, '.', ',', [rfReplaceAll, rfIgnoreCase]);

  if TryStrToCurr(Self.Text, aux) then
    Result := StrToCurr(Self.Text)
  else
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
end;

function TEditMongo.toNumerico: Integer;
var
  aux : Integer;
begin
  if TryStrToInt(Self.Text, aux) then
    Result := StrToInt(Self.Text)
  else
    raise Exception.Create('O Valor do Campo ' + Self.FMongoCampo + ' é Inválido');
end;

end.
