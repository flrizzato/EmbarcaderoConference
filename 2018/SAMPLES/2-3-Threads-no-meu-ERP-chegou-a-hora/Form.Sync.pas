unit Form.Sync;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.SyncObjs;

type
  TfrmSyncWays = class(TForm)
    PanelInterlock: TPanel;
    ButtonInterlock: TButton;
    CheckBoxInterlock: TCheckBox;
    LabelResultado: TLabel;
    PanelCriticalSec: TPanel;
    ButtonCriticalSec: TButton;
    PanelErros: TPanel;
    ButtonErros: TButton;
    ButtonErrosTentaTrat: TButton;
    procedure ButtonInterlockClick(Sender: TObject);
    procedure LabelResultadoClick(Sender: TObject);
    procedure ButtonCriticalSecClick(Sender: TObject);
    procedure ButtonErrosClick(Sender: TObject);
    procedure ButtonErrosTentaTratClick(Sender: TObject);
  private
    FContadorInterlock: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmSyncWays.ButtonCriticalSecClick(Sender: TObject);
begin
  // Aplicado em: ServerMethodsCotacao
  // https://github.com/diondcm/exemplos-delphi/blob/master/Capitulo7/3.4.Restfull/Server/ServerMethodsCotacao.pas
end;

procedure TfrmSyncWays.ButtonErrosClick(Sender: TObject);
var
  i: Integer;
begin
  ButtonErrosTentaTrat.Visible := True;
  for i := 1 to 5 do
  TThread.CreateAnonymousThread(
    procedure
    begin
      raise Exception.Create('Teste th ' + IntToStr(i));
    end
  ).Start;
end;

procedure TfrmSyncWays.ButtonErrosTentaTratClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to 5 do
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        raise Exception.Create('Erro ocorrido');
      except
        on E: Exception do
        begin
          TThread.Synchronize(nil,
            procedure
            begin
              ShowMessage('Exibe msg: ' + E.Message);

            end);

          // Algumas soluções possíveis:
          // 1) Interlock para incrementar contador de erros
          // >> 2) Critical Section para adicionar em lista de erros
        end;
      end
    end
  ).Start;
end;

procedure TfrmSyncWays.ButtonInterlockClick(Sender: TObject);
var
  i: Integer;
begin
  FContadorInterlock := 0;
  for i := 1 to 30 do
  begin
    TThread.CreateAnonymousThread(
      procedure
      var
        j: Integer;
      begin
        for j := 1 to 500 do
        begin
          if CheckBoxInterlock.Checked then
          begin
            //InterlockedIncrement();
            TInterlocked.Add(FContadorInterlock, 1); // System.SyncObjs
          end else begin
            FContadorInterlock :=  FContadorInterlock + 1;
          end;
          Sleep(1);
        end;
      end
    ).Start;
  end;
end;

procedure TfrmSyncWays.LabelResultadoClick(Sender: TObject);
begin
  LabelResultado.Caption := 'Valor atual: ' + IntToStr(FContadorInterlock);
end;

end.
