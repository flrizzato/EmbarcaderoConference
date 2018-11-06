unit Form.Mensagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmMensagens = class(TForm)
    PanelControles: TPanel;
    FlowPanelLabels: TFlowPanel;
    LabelQuantidade: TLabel;
    EditQtdTh: TEdit;
    ButtonExecutar: TButton;
    ButtonExecutarTh: TButton;
    MemoLog: TMemo;
    ButtonLimpar: TButton;
    PanelOption: TPanel;
    RadioButtonSemSync: TRadioButton;
    RadioButtonComSync: TRadioButton;
    RadioButtonNovosTh: TRadioButton;
    procedure EditQtdThKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonExecutarClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure ButtonExecutarThClick(Sender: TObject);
  private
    function CriaLabel: TLabel;
  public
    { Public declarations }
  end;

var
  frmMensagens: TfrmMensagens;

implementation

{$R *.dfm}

procedure TfrmMensagens.ButtonExecutarClick(Sender: TObject);
var
  i: Integer;
  lLbl: TLabel;
begin
//  ButtonExecutar.Enabled := False;
  try
//    ButtonLimpar.Click;
    lLbl := CriaLabel;
    for i := 0 to 3500 do
    begin
      lLbl.Caption := IntToStr(i);
      Application.ProcessMessages;
      Sleep(1);
    end;
  finally
    ButtonExecutar.Enabled := True;
  end;
end;

procedure TfrmMensagens.ButtonExecutarThClick(Sender: TObject);
var
  lThCount: Integer;
  lIndex: Integer;
begin
//  ButtonExecutarTh.Enabled := False;
  try
//    ButtonLimpar.Click;

   lThCount := StrToIntDef(EditQtdTh.Text, 1);
   for lIndex := 0 to lThCount -1 do
   begin
     TThread.CreateAnonymousThread(
       procedure
       var
         i: Integer;
         lLbl: TLabel;
       begin
         lLbl := CriaLabel;
         for i := 0 to 3500 do
         begin
           // Modelo 3:  Nenhum resolve! :/
           if RadioButtonNovosTh.Checked then
           begin
             if (i mod 1000) = 0 then
             begin
               TThread.CreateAnonymousThread(
                 procedure
                 begin
                   TThread.Synchronize(nil,
                     procedure
                     begin
                       lLbl.Caption := IntToStr(i);
                     end);
                 end).Start;
             end;
           end;

           // Modelo 2:
           // Trava a Th, enquanto a atualização de tela é executada
           if RadioButtonComSync.Checked then
           begin
             if (i mod 10) = 0 then
             begin
               TThread.Synchronize(nil,
                 procedure
                 begin
                   lLbl.Caption := IntToStr(i);
                 end);
             end;
           end;

           // Modelo 1:
           // Pode gerar AV, entre outros problemas
           if RadioButtonSemSync.Checked then
           begin
             lLbl.Caption := IntToStr(i);
           end;

           //Application.ProcessMessages;
           Sleep(1);
         end;
       end).Start;
   end;
  finally
    // Nope!
    ButtonExecutarTh.Enabled := True;
  end;
end;

procedure TfrmMensagens.ButtonLimparClick(Sender: TObject);
var
  i: Integer;
begin
  for i := FlowPanelLabels.ControlCount -1 downto 0 do
  begin
    FlowPanelLabels.Controls[i].Free;
  end;
end;

function TfrmMensagens.CriaLabel: TLabel;
begin
  /// Functions são boas para criar TComponent,
  /// Já se não tivesse owner
  /// melhor seria outra técnica, pois o chamador deve liberar o obj da memória
  Result := TLabel.Create(Self);
  Result.AlignWithMargins := True;
  Result.Caption := '0';
  Result.Font.Style := [fsBold];
  Result.Font.Size := 10;
  Result.Parent := FlowPanelLabels;
end;

procedure TfrmMensagens.EditQtdThKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ButtonExecutarTh.Click;
  end;
end;

end.
