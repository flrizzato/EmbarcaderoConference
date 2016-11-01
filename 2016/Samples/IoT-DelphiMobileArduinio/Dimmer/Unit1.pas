unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListBox;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    IdUDPClient1: TIdUDPClient;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Button5: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure VerificaStatusI_O;
    procedure conexao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  port: integer;
  retorno: string;

implementation

{$R *.fmx}

procedure TForm1.VerificaStatusI_O;
begin
 IdUDPClient1.Send('DR'+intToStr(port));
 retorno := IdUDPClient1.ReceiveString(700);
 if retorno = 'LOW' then
 begin
   Button1.TextSettings.FontColor := TColorRec.White;
   Button2.TextSettings.FontColor := TColorRec.Green;
 end
 else if retorno = 'HIGH' then
 begin
   Button1.TextSettings.FontColor := TColorRec.Green;
   Button2.TextSettings.FontColor := TColorRec.White;
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var v: string;
begin
 //VerificaStatusI_O;
 IdUDPClient1.Send('DW'+FormatFloat('00', port)+'H');
end;

procedure TForm1.Button2Click(Sender: TObject);
var v: string;
begin
 //VerificaStatusI_O;
 IdUDPClient1.Send('DW'+FormatFloat('00', port)+'L');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  conexao;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 IdUDPClient1.Send('DW'+FormatFloat('00', port)+'+');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 IdUDPClient1.Send('DW'+FormatFloat('00', port)+'-');
end;

procedure TForm1.conexao;
begin
  IdUDPClient1.Host := edit1.Text;
  IdUDPClient1.Port := strToInt(edit2.Text);
  IdUDPClient1.Connect;
  if IdUDPClient1.Connected = true then
  begin
    IdUDPClient1.Send('TC', nil);
    retorno := IdUDPClient1.ReceiveString(80);
    if retorno = 'TCOK' then
      label4.Text := 'Conectado'
    else
      label4.Text := 'Desconectado';
  end
  else
  begin
    label4.Text := 'Desconectado';
  end;

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  port := strToInt(Copy(ComboBox1.Selected.Text, 0, 2));
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  GroupBox1.Size.Height := 120;
end;

end.
