unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.ServiceTypes, System.JSON, REST.Backend.EMSServices,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Backend.EndPoint, REST.Backend.EMSProvider, FMX.StdCtrls, FMX.Layouts,
  FMX.Memo;

type
  TForm1 = class(TForm)
    EMSProvider1: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    Button1: TButton;
    Memo1: TMemo;
    BackendEndpoint2: TBackendEndpoint;
    BackendEndpoint3: TBackendEndpoint;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses REST.Types;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint1.Execute;
  Memo1.Lines.Add(BackendEndpoint1.Response.JSONText);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint2.Execute;
  Memo1.Lines.Add(BackendEndpoint2.Response.JSONText);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint3.ClearBody;
  BackendEndpoint3.AddBody(TJSONObject.Create(TJSONPair.Create('nome', 'Marcelo')));
  BackendEndpoint3.Execute;
  Memo1.Lines.Add(BackendEndpoint3.Response.JSONText);
end;

end.
