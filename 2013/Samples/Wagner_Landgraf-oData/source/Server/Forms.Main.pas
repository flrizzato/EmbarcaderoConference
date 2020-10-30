unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList,
  ServerUnit;

type
  TMainForm = class(TForm)
    btStart: TButton;
    btStop: TButton;
    ActionList1: TActionList;
    StartAction: TAction;
    StopAction: TAction;
    procedure StartActionExecute(Sender: TObject);
    procedure StopActionExecute(Sender: TObject);
    procedure StartActionUpdate(Sender: TObject);
    procedure StopActionUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FServerModule: TServerModule;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  StartAction.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FServerModule := TServerModule.Create(nil);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FServerModule.Free;
end;

procedure TMainForm.StartActionExecute(Sender: TObject);
begin
  FServerModule.HttpServer.Start;
end;

procedure TMainForm.StartActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not FServerModule.HttpServer.IsRunning;
end;

procedure TMainForm.StopActionExecute(Sender: TObject);
begin
  FServerModule.HttpServer.Stop;
end;

procedure TMainForm.StopActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FServerModule.HttpServer.IsRunning;
end;

end.
