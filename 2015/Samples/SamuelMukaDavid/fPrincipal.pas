unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fExecutaExemplos4,
  fExecutaExemplos5, fExecutaExemplos6, fExecutaExemplos7;

type
  TForm1 = class(TForm)
    BtnExemplo6: TButton;
    BtnExemplo7: TButton;
    BtnExemplo4: TButton;
    BtnExemplo5: TButton;
    procedure BtnExemplo6Click(Sender: TObject);
    procedure BtnExemplo4Click(Sender: TObject);
    procedure BtnExemplo5Click(Sender: TObject);
    procedure BtnExemplo7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnExemplo4Click(Sender: TObject);
begin
  TfrmExecutaExemplos4.Create(Self).Show;
end;

procedure TForm1.BtnExemplo5Click(Sender: TObject);
begin
  TfrmExecutaExemplos5.Create(Self).Show;
end;

procedure TForm1.BtnExemplo6Click(Sender: TObject);
begin
  TfrmExecutaExemplos6.Create(Self).Show;
end;

procedure TForm1.BtnExemplo7Click(Sender: TObject);
begin
  TfrmExecutaExemplos7.Create(Self).Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

end.
