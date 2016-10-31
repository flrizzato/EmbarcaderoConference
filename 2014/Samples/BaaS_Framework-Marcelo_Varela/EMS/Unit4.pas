unit Unit4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.ServiceTypes, System.JSON, REST.Backend.EMSServices,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Backend.EndPoint, REST.Backend.EMSProvider, FMX.Layouts, FMX.Memo,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    EMSProvider1: TEMSProvider;
    BackendEndpoint1: TBackendEndpoint;
    BackendEndpoint2: TBackendEndpoint;
    BackendEndpoint3: TBackendEndpoint;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint1.Execute;
  Memo1.Lines.Add(BackendEndpoint1.Response.JSONText);
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint2.Execute;
  Memo1.Lines.Add(BackendEndpoint2.Response.JSONText);
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  BackendEndpoint3.ClearBody;
  BackendEndpoint3.AddBody(TJSONObject.Create(TJSONPair.Create('nome', Edit1.Text)));
  BackendEndpoint3.Execute;
  Memo1.Lines.Add(BackendEndpoint3.Response.JSONText);
end;

end.
