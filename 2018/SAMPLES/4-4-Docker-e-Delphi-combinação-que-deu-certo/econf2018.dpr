program econf2018;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse, System.Classes, System.SysUtils;

var
  App: THorse;
begin
  App := THorse.Create(9000);
  App.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc
    )
    begin
      Res.Send('pong');
    end);
  App.Start;

end.
