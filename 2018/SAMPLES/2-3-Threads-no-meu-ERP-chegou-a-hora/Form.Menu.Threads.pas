unit Form.Menu.Threads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmMenu = class(TForm)
    ImageLogo: TImage;
    PanelControles: TPanel;
    ButtonMessages: TButton;
    ButtonSerealize: TButton;
    ButtonExternas: TButton;
    ButtonTelaERP: TButton;
    procedure ButtonMessagesClick(Sender: TObject);
    procedure ButtonSerealizeClick(Sender: TObject);
    procedure ButtonTelaERPClick(Sender: TObject);
    procedure ButtonExternasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses Form.Mensagens, Form.Sync, Form.Tela.ERP, Form.Externos;

procedure TfrmMenu.ButtonSerealizeClick(Sender: TObject);
begin
  TfrmSyncWays.Create(Self).Show;
end;

procedure TfrmMenu.ButtonTelaERPClick(Sender: TObject);
begin
  TfrmTelaERP.Create(Self).Show;
end;

procedure TfrmMenu.ButtonExternasClick(Sender: TObject);
begin
  TfrmExternos.Create(Self).Show;
end;

procedure TfrmMenu.ButtonMessagesClick(Sender: TObject);
begin
  TfrmMensagens.Create(Self).Show;
end;

end.
