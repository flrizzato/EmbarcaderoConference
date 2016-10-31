unit uBotaoSeguro;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.StdCtrls;

type
  TBotaoSeguro = class(TButton)
  private
    { Private declarations }
    FClicando: Boolean;
    FConfirma: Boolean;
    FMensagem: String;
    procedure SetConfirma(const Value: Boolean);
    procedure SetMensagem(const Value: String);
    function GetConfirma: Boolean;
  protected
    { Protected declarations }
    procedure Click; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Confirma: Boolean read GetConfirma write SetConfirma default True;
    property Mensagem: String read FMensagem write SetMensagem;
  end;

procedure Register;

implementation

uses
  FMX.Dialogs, System.UITypes;

procedure Register;
begin
  RegisterComponents('Samples', [TBotaoSeguro]);
end;

{ TBotaoSeguro }

procedure TBotaoSeguro.Click;
var
  aExecuta: Boolean;
begin
  if FClicando then
    Exit;

  FClicando := True;
  try
    if Confirma then
      aExecuta := MessageDlg(Mensagem, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0 ) = IDYes
    else
      aExecuta := True;

    if aExecuta then
      inherited;
  finally
    FClicando := False;
  end;
end;

constructor TBotaoSeguro.Create(AOwner: TComponent);
begin
  inherited;
  FClicando := False;
  FConfirma := True;
  FMensagem := 'Confirma ?';
end;

function TBotaoSeguro.GetConfirma: Boolean;
begin
  Result := FConfirma and (Mensagem <> '');
end;

procedure TBotaoSeguro.SetConfirma(const Value: Boolean);
var
  aTerminaComRetic: Boolean;
begin
  FConfirma := Value;

  aTerminaComRetic := Copy(Text,Length(Text)-2,3) = '...';

  if FConfirma and not aTerminaComRetic then
    Text := Text + '...'
  else if (not FConfirma) and (aTerminaComRetic) then
    Text := Copy(Text,1,Length(Text)-3);
end;

procedure TBotaoSeguro.SetMensagem(const Value: String);
begin
  FMensagem := Value;
  if Value = '' then
    Confirma := False;
end;

end.
