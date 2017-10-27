unit uApp;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  uDMAPP,
  System.Rtti,
  FMX.Grid.Style,
  Data.Bind.EngExt,
  FMX.Bind.DBEngExt,
  FMX.Bind.Grid,
  System.Bindings.Outputs,
  FMX.Bind.Editors,
  Data.Bind.Components,
  Data.Bind.Grid,
  Data.Bind.DBScope,
  FMX.ScrollBox,
  FMX.Grid,
  FMX.Memo,
  FMX.Objects,
  RestRequest,
  REST.Json;

type
  TMesa = class
  strict private
    FMesa: integer;
    FStatus: Boolean;
    FValor: Extended;
  public
    property mesa: integer read FMesa write FMesa;
    property status: Boolean read FStatus write FStatus;
    property valor: Extended read FValor write FValor;
  end;

  TForm2 = class(TForm)
    tbrCabecalho: TToolBar;
    tbrRodape: TToolBar;
    lytMain: TLayout;
    lblTituloAPP: TLabel;
    SpeedButton1: TSpeedButton;
    GridPanelLayout1: TGridPanelLayout;
    rctMesa1: TRectangle;
    lblMesa1: TLabel;
    lblStatusMesa1: TLabel;
    lblValorMesa1: TLabel;
    rctMesa2: TRectangle;
    lblMesa2: TLabel;
    lblstatusmesa2: TLabel;
    lblvalormesa2: TLabel;
    rctMesa3: TRectangle;
    lblmesa3: TLabel;
    lblstatusmesa3: TLabel;
    lblvalormesa3: TLabel;
    rctmesa4: TRectangle;
    lblmesa4: TLabel;
    lblstatusmesa4: TLabel;
    lblvalormesa4: TLabel;
    rctmesa5: TRectangle;
    lblmesa5: TLabel;
    lblstatusmesa5: TLabel;
    lblvalormesa5: TLabel;
    rctmesa6: TRectangle;
    lblmesa6: TLabel;
    lblstatusmesa6: TLabel;
    lblvalormesa6: TLabel;
    rctmesa7: TRectangle;
    lblmesa7: TLabel;
    lblstatusmesa7: TLabel;
    lblvalormesa7: TLabel;
    rctmesa8: TRectangle;
    lblmesa8: TLabel;
    lblstatusmesa8: TLabel;
    lblvalormesa8: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
  private
    function consultaDS(uri: string; param: array of string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.iPhone55in.fmx IOS}

function TForm2.consultaDS(uri: string; param: array of string): string;
var
  RestReq: TRestRequest;
  RestResp: THttpResponse;
begin
  try
    RestReq := nil;
    try
      RestReq := TRestRequest.Create().Domain('192.168.25.12:8080').Path('datasnap').Path('rest').Path('tpos').Path(uri).Path(param[0]);
      RestResp := RestReq.Get();
    finally
      RestReq.Free;
    end;
  except
  end;
  result := RestResp.ResponseStr;
  result := Copy(result, 13, result.Length);
  result := Copy(result, 1, result.Length - 3);
  result := result.replace('\', '');
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
var
  param: array [0 .. 1] of string;
  Json: string;
  mesa: TMesa;
  m: integer;
begin
  for m := 1 to 8 do
  begin
    param[0] := m.ToString();
    Json := consultaDS('statusmesa', param[0]);

    try
      mesa := TMesa.Create();
      mesa := TJson.JsonToObject<TMesa>(Json);

      case mesa.mesa of
        1:
          begin
            if mesa.status then
            begin
              lblStatusMesa1.Text := 'OCUPADA';
              rctMesa1.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblStatusMesa1.Text := 'LIVRE';
              rctMesa1.Fill.Color := TAlphaColorRec.White;
            end;
            lblValorMesa1.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);

          end;
        2:
          begin
            if mesa.status then
            begin
              lblstatusmesa2.Text := 'OCUPADA';
              rctMesa2.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa2.Text := 'LIVRE';
              rctMesa2.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa2.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;
        3:
          begin
            if mesa.status then
            begin
              lblstatusmesa3.Text := 'OCUPADA';
              rctMesa3.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa3.Text := 'LIVRE';
              rctMesa3.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa3.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;
        4:
          begin
            if mesa.status then
            begin
              lblstatusmesa4.Text := 'OCUPADA';
              rctmesa4.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa4.Text := 'LIVRE';
              rctmesa4.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa4.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;
        5:
          begin
            if mesa.status then
            begin
              lblstatusmesa5.Text := 'OCUPADA';
              rctmesa5.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa5.Text := 'LIVRE';
              rctmesa5.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa5.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;
        6:
          begin
            if mesa.status then
            begin
              lblstatusmesa6.Text := 'OCUPADA';
              rctmesa6.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa6.Text := 'LIVRE';
              rctmesa6.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa6.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;

        7:
          begin
            if mesa.status then
            begin
              lblstatusmesa7.Text := 'OCUPADA';
              rctmesa7.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa7.Text := 'LIVRE';
              rctmesa7.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa7.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;
        8:
          begin
            if mesa.status then
            begin
              lblstatusmesa8.Text := 'OCUPADA';
              rctmesa8.Fill.Color := TAlphaColorRec.Red;
            end
            else
            begin
              lblstatusmesa8.Text := 'LIVRE';
              rctmesa8.Fill.Color := TAlphaColorRec.White;
            end;
            lblvalormesa8.Text := 'R$ ' + FormatFloat('#,0.00', mesa.valor);
          end;

      end;

    finally
      mesa.Free;
    end;

  end;
end;

end.
