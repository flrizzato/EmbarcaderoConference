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

type

  MailFormat = class

  end;

  HTMLFormat = class(MailFormat)
  end;

  TXTFormat = class(MailFormat)
  end;

  MailMessage = class
    private _mensagem: string;
    private _format: MailFormat;
    public property Mensagem: string read _mensagem write _mensagem;
    public constructor Create(mensagem: string; format: MailFormat);
  end;

  SmtpSettings = class
    private _serverName: string;
    private _userName: string;
    private _password: string;
    public property ServerName: string read _serverName write _serverName;
    public property UserName: string read _userName write _userName;
    public property Password: string read _password write _password;
  end;

  Mail = class
    private _conf: SMTPSettings;
    public constructor Create(conf: SMTPSettings);
    public procedure Send(Mensagem: MailMessage);
  end;

  Email = class
    private _mail: Mail;
    private _format: MailFormat;
    private _conf: SMTPSettings;
    private _msg: MailMessage;
    public constructor Create();
    public procedure Enviar(aMensagem: string);
  end;

implementation

{ MailMessage }

constructor MailMessage.Create(mensagem: string; format: MailFormat);
begin
  // formatar mensagem aqui...
  self._mensagem := mensagem;
  self._format := format;
end;

{ Mail }

constructor Mail.Create(conf: SMTPSettings);
begin
  self._conf := conf;
end;

procedure Mail.Send(Mensagem: MailMessage);
begin
  // usando configurações SMTP
  WriteLn('Enviando mensagem...');
  WriteLn(Mensagem.Mensagem);
end;

{ Email }

constructor Email.Create();
begin
  self._conf := SMTPSettings.Create();
  self._conf.ServerName := 'smtp.gmail.com';
  self._conf.Password := '123';
  self._conf.UserName := 'admin';
  self._mail := Mail.Create(_conf);
  self._format := TXTFormat.Create();
  self._msg := MailMessage.Create('',_format);
 end;

procedure Email.Enviar(aMensagem: string);
begin
  _msg.Mensagem := AMensagem;
  _mail.Send(_msg);
end;

end.
