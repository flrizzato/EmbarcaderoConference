unit Unt_Tela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Unt_ThreadComEvent;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
  private
    FThread: TExemploThread;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AfterConstruction;
begin
  inherited;
  Self.FThread := TExemploThread.Create(True);
  Self.FThread.Memo := Self.Memo1;
  Self.FThread.Start;
end;

procedure TForm1.BeforeDestruction;
begin
  inherited;
  Self.FThread.Terminate;
  Self.FThread.WaitFor;
  Self.FThread.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Self.FThread.SinalizarThread;
end;

end.
