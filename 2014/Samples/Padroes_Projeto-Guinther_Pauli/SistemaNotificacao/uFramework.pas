{
Sobre o autor:
Guinther Pauli
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#, ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
}

unit uFramework;

interface

uses
  Vcl.Dialogs;

type
  TMessage = class
  public
    Mensagem: string;
    Data: TDateTime;
  end;

  TNotificacao = class
  public
    procedure Enviar(mensagem: TMessage); virtual;
  end;

  TSMS = class(TNotificacao)
    procedure Enviar(mensagem: TMessage); override;
  end;

  TVoiceMail = class(TNotificacao)
    procedure Enviar(mensagem: TMessage); override;
  end;

  TEmail = class(TNotificacao)
    procedure Enviar(mensagem: TMessage); override;
  end;

  TFax = class(TNotificacao)
    procedure Enviar(mensagem: TMessage); override;
  end;

  TContext = class
  private
    FNotificacao: TNotificacao;
  public
    procedure Enviar(mensagem: TMessage);
    constructor Create(ANotificao: TNotificacao);
  end;

  TFormaNotificacao = (fnEmail = 0, fnSMS = 1, fnVoiceMail = 2, fnFax = 3);

  TFabrica = class
    class function CreateInstance(forma: TFormaNotificacao): TNotificacao;
  end;

implementation

{ TEmail }

procedure TEmail.Enviar(mensagem: TMessage);
begin
  inherited;
  ShowMessage('Email enviado: ' + mensagem.Mensagem);
end;

{ TVoiceMail }

procedure TVoiceMail.Enviar(mensagem: TMessage);
begin
  inherited;
  ShowMessage('VoiceMail enviado: ' + mensagem.Mensagem);
end;

{ TSMS }

procedure TSMS.Enviar(mensagem: TMessage);
begin
  inherited;
  ShowMessage('SMS enviado: ' + mensagem.Mensagem);
end;

procedure TNotificacao.Enviar(mensagem: TMessage);
begin
 ShowMessage('Enviando...');
end;

{ TContext }

constructor TContext.Create(ANotificao: TNotificacao);
begin
  FNotificacao := ANotificao;
end;

procedure TContext.Enviar(mensagem: TMessage);
begin
  // delegação polimórfica
  FNotificacao.Enviar(mensagem);
end;

{ TFabrica }

class function TFabrica.CreateInstance(forma: TFormaNotificacao): TNotificacao;
begin
  case forma of
    fnEmail: Result := TEmail.Create();
    fnSMS: Result := TSMS.Create();
    fnVoiceMail: Result := TVoiceMail.Create();
    fnFax : Result := TFax.Create();
  end;
end;

{ TFax }

procedure TFax.Enviar(mensagem: TMessage);
begin
   inherited;
  ShowMessage('FAX enviado: ' + mensagem.Mensagem);
end;

end.
