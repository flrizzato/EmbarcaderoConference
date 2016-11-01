unit UntServerMain;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Printers,
  IPPeerClient,
  IPPeerServer,

  System.Tether.Manager,
  System.Tether.AppProfile,
  Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    Button2: TButton;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    ComboBox1: TComboBox;
    memTeste: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button2Click(Sender: TObject);
    procedure TetheringManager1RequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);

var
  IMP: TextFile;
  I : Integer;

begin
  try
    memTeste.Lines.Clear;
    memTeste.Lines.LoadFromStream(AResource.Value.AsStream);

    AssignFile(IMP, ComboBox1.Items[ComboBox1.ItemIndex]);
    Rewrite(IMP);

    WriteLn (IMP, #27#15#27#48#27#77);
    for I := 0 to Pred(memTeste.Lines.Count)  do
      WriteLn (IMP, memTeste.Lines[I]);

    CloseFile(IMP);
  except on E:Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TfrmMain.TetheringManager1RequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  Password := '1234';
end;


procedure TfrmMain.Button1Click(Sender: TObject);
var
  IMP: TextFile;
  I : Integer;

begin
  try
    AssignFile(IMP, ComboBox1.Items[ComboBox1.ItemIndex]);
    Rewrite(IMP);

    WriteLn (IMP, #27#15#27#48#27#77);
    for I := 0 to Pred(memTeste.Lines.Count)  do
      WriteLn (IMP, memTeste.Lines[I]);

    CloseFile(IMP);
  except on E:Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  IMP: TextFile;
begin
  AssignFile(IMP, ComboBox1.Items[ComboBox1.ItemIndex]); //Porta da impressora
  Rewrite(IMP);


  WriteLn (IMP, #27#15#27#48#27#77);
  WriteLn (IMP, #30'Impressão de Teste em impressora DR700 Daruma');
  WriteLn (IMP, #30'Impresso através de botão em tela');
  WriteLn (IMP, #30'TDevRocks no Embarcadero Conference 2016');
  WriteLn (IMP, #27#15#27#48#27#77);
  WriteLn (IMP, #27#15#27#48#27#77);
  WriteLn (IMP,'');

  CloseFile(IMP);
end;

end.
