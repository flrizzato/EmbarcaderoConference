unit fServerFast;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxServer, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, frxServerStat, frxServerConfig;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    frxReportServer1: TfrxReportServer;
    Timer1: TTimer;
    Edit1: TEdit;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
//  ServerConfig.SetValue('server.http.port', '8809');
//  ServerConfig.SetValue('server.http.port', '8809');

//  ServerConfig.seConfigListToFile(frxReportServer1.ConfigFileName);
  frxReportServer1.Open;
  BitBtn1.Caption := 'Ativo na porta ' + ServerConfig.GetValue('server.http.port');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

//  ETotalSessions.Text := IntToStr(ServerStatistic.TotalSessionsCount);
//  ETotalReports.Text := IntToStr(ServerStatistic.TotalReportsCount);
//  EMaxSessions.Text := IntToStr(ServerStatistic.MaxSessionsCount);
//  EMaxReports.Text := IntToStr(ServerStatistic.MaxReportsCount);
//  EErrors.Text := IntToStr(ServerStatistic.TotalErrors);
//  ECurrentSessions.Text := IntToStr(ServerStatistic.CurrentSessionsCount);
//  ECurrentReports.Text := IntToStr(ServerStatistic.CurrentReportsCount);
//  Uptime.Caption := ServerStatistic.FormatUpTime;
//  Label2.Caption := 'Version: ' + String(Serv.Variables.GetValue('SERVER_SOFTWARE'));

//  end;
end;

end.
