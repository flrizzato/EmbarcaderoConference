unit uFramework;

interface

type
  TMailFormat = class
  end;

  THTMLFormat = class(TMailFormat)
  end;

  TTXTFormat = class(TMailFormat)
  end;

  TMailMessage = class
  private
    FMensagem: string;
    FFormat: TMailFormat;
  public
    property Mensagem: string read FMensagem write FMensagem;
    constructor Create(AMensagem: string; AFormat: TMailFormat);
  end;

  TSmtpSettings = class
  private
    FServerName: string;
    FUserName: string;
    FPassword: string;
   public
    property ServerName: string read FServerName write FServerName;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
  end;

  TMail = class
  private
    FConf: TSmtpSettings;
  public
    constructor Create(AConf: TSmtpSettings);
    procedure Send(AMensagem: TMailMessage);
  end;

  // Façade
  TEmailHelper = class
  private
    FMail: TMail;
    FFormat: TMailFormat;
    FConf: TSmtpSettings;
    FMsg: TMailMessage;
  public
    constructor Create();
    procedure Enviar(AMensagem: string);
  end;

implementation

{ MailMessage }

constructor TMailMessage.Create(AMensagem: string; AFormat: TMailFormat);
begin
  // formatar mensagem aqui...
  self.FMensagem := AMensagem;
  self.FFormat := AFormat;
end;

{ Mail }

constructor TMail.Create(AConf: TSmtpSettings);
begin
  self.FConf := AConf;
end;

procedure TMail.Send(AMensagem: TMailMessage);
begin
  // usando configurações SMTP
  WriteLn('Enviando mensagem...');
  WriteLn(AMensagem.Mensagem);
end;

{ Email }

constructor TEmailHelper.Create();
begin
  self.FConf := TSmtpSettings.Create();
  self.FConf.ServerName := 'smtp.gmail.com';
  self.FConf.Password := '123';
  self.FConf.UserName := 'admin';
  self.FMail := TMail.Create(FConf);
  self.FFormat := TTXTFormat.Create();
  self.FMsg := TMailMessage.Create('',FFormat);
end;

procedure TEmailHelper.Enviar(AMensagem: string);
begin
  FMsg.Mensagem := AMensagem;
  FMail.Send(FMsg);
end;

end.

