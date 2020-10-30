unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, XData.Server.Module,
  Sparkle.Comp.Server, Sparkle.Comp.HttpSysDispatcher, XData.Comp.Server,
  Sparkle.Comp.CorsMiddleware;

type
  TForm4 = class(TForm)
    XDataServer1: TXDataServer;
    SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher;
    XDataServer1CORS: TSparkleCorsMiddleware;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

end.
