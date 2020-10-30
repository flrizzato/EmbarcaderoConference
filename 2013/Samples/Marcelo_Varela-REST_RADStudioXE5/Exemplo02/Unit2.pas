unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Button1: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses REST.Json, Data.DBXJSON;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  url: string;
begin
  url := Format('http://maps.googleapis.com/maps/api/distancematrix/json?origins=%s&destinations=%s&language=pt-BR&sensor=false', [LabeledEdit1.Text, LabeledEdit2.Text]);
  RESTClient1.BaseURL := url;
  RESTRequest1.Execute;
end;

procedure TForm2.RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
var
  jObjRoot, jObjElements, jObjRows, jObjDirection, jObjDuration: TJSONObject;
  jArrRows, jArrElements: TJSONArray;
begin
  Memo1.Clear;
  StatusBar1.Panels[0].Text := 'Tempo: ' +  IntToStr(Sender.ExecutionPerformance.TotalExecutionTime) + 'ms';

  if assigned(RESTResponse1.JSONValue) then
  begin
    Memo1.Lines.Text := TJson.Format(RESTResponse1.JSONValue);
    jObjRoot := RESTResponse1.JSONValue as TJSONObject;
    jArrRows := jObjRoot.GetValue('rows') as TJSONArray;
    jObjRows := jArrRows.Get(0) as TJSONObject;
    jArrElements := jObjRows.GetValue('elements') as TJSONArray;

    jObjElements := jArrElements.Get(0) as TJSONObject;

    jObjDirection := jObjElements.Get(0).JsonValue AS TJSONObject;
    LabeledEdit3.Text := jObjDirection.GetValue('text').Value;

    jObjDuration := jObjElements.Get(1).JsonValue AS TJSONObject;
    LabeledEdit4.Text := jObjDuration.GetValue('text').Value;
  end
  else
  begin
    Memo1.Lines.Add(RESTResponse1.Content);
  end;
end;

end.
