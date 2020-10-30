unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPClient, Vcl.WinXCtrls;

type
  TForm2 = class(TForm)
    IdUDPClient1: TIdUDPClient;
    Button1: TButton;
    ListBox1: TListBox;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    Button3: TButton;
    CheckBox1: TCheckBox;
    ToggleSwitch1: TToggleSwitch;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ToggleSwitch1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses IdStack;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  s: string;
begin
  IdUDPClient1.Host := Edit1.Text;
  IdUDPClient1.Connect;
  IdUDPClient1.Send(Edit2.Text);
  try
    try
      if CheckBox1.Checked then
      begin
        IdUDPClient1.ReceiveTimeout := 3000; // 3s
        s := IdUDPClient1.ReceiveString();
        //Edit2.Text := s;
        ListBox1.Items.Add(s);
      end;
    except
      on E: EidSocketError do
      begin
        ListBox1.Items.Add('Erro de socket: ' + E.Message);
      end;
      on E: Exception do
      begin
        ListBox1.Items.Add('Outro erro: ' + E.Message);
      end;
    end;
  finally
    IdUDPClient1.Disconnect;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ListBox1.Clear;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  s: string;
begin
  IdUDPClient1.Host := Edit1.Text;
  IdUDPClient1.Connect;
  IdUDPClient1.Send('C');
  try
    try
      IdUDPClient1.ReceiveTimeout := 3000; // 3s
      s := IdUDPClient1.ReceiveString();
      Edit2.Text := s;
      ListBox1.Items.Add(s);
    except
      on E: EidSocketError do
      begin
        ListBox1.Items.Add('Erro de socket: ' + E.Message);
      end;
      on E: Exception do
      begin
        ListBox1.Items.Add('Outro erro: ' + E.Message);
      end;
    end;
  finally
    IdUDPClient1.Disconnect;
  end;
end;

procedure TForm2.ToggleSwitch1Click(Sender: TObject);
var
  s: string;
begin
  IdUDPClient1.Host := Edit1.Text;
  IdUDPClient1.Connect;
  if ToggleSwitch1.State = TToggleSwitchState.tssOff then
  begin
    Edit2.Text := 'L';
  end
  else
  begin
    Edit2.Text := 'H';
  end;
  IdUDPClient1.Send(Edit2.Text);
  try
    try
      if CheckBox1.Checked then
      begin
        IdUDPClient1.ReceiveTimeout := 3000; // 3s
        s := IdUDPClient1.ReceiveString();
        //Edit2.Text := s;
        ListBox1.Items.Add(s);
      end;
    except
      on E: EidSocketError do
      begin
        ListBox1.Items.Add('Erro de socket: ' + E.Message);
      end;
      on E: Exception do
      begin
        ListBox1.Items.Add('Outro erro: ' + E.Message);
      end;
    end;
  finally
    IdUDPClient1.Disconnect;
  end;
end;

end.
