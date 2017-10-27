unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Viewport3D,
  System.Math.Vectors, FMX.MaterialSources, FMX.Controls3D, FMX.Objects3D,
  FMX.Ani, FMX.Objects;

type
  TForm4 = class(TForm)
    Button3: TButton;
    ListBox1: TListBox;
    IdUDPClient1: TIdUDPClient;
    edHost: TEdit;
    Switch1: TSwitch;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    Image2: TImage;
    procedure Button3Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses IdStack;

{$R *.fmx}

procedure TForm4.Button3Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TForm4.Switch1Click(Sender: TObject);
var
  s: string;
begin
  IdUDPClient1.Host := edHost.Text;
  //IdUDPClient1.Connect;
  Image1.Visible := not Switch1.IsChecked;
  Image2.Visible := Switch1.IsChecked;
  if Switch1.IsChecked then
  begin
    IdUDPClient1.Send('H');
  end
  else
  begin
    IdUDPClient1.Send('L');
  end;
  try
    try
      IdUDPClient1.ReceiveTimeout := 3000; // 3s
      s := IdUDPClient1.ReceiveString();
      if s = 'H' then
      begin
        ListBox1.Items.Add('Lâmpada ligada');
      end
      else
      begin
        ListBox1.Items.Add('Lâmpada desligada');
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
