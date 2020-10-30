unit fPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Rtti, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Edit, System.Actions, FMX.ActnList, FMX.ExtCtrls;

type
  TDiaSemana = (dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado, dsDomingo);

  TDiaSemanaHelper = record helper for TDiaSemana
    function AsString: string;
  end;

  TDoubleHelper = record helper for Double
  public
    function AsString: string;
  end;

  TDateTimeHelper = record helper for TDateTime
    function AsString: string;
  end;

  TDateHelper = record helper for TDate
    function AsString: string;
  end;

  TIntegerHelper = record helper for Integer
    function AsString: string;
  end;

  TStringHelper = record helper for string
    function Length: Integer;
  end;

  TSingleHelper = record helper for Single
    function Trunc: Integer;
    function AsString: string;
  end;

  TfrmPrincipal = class(TForm)
    spbDiaDaSemana: TSpinBox;
    btnDiaDaSemana: TButton;
    cleDateToString: TCalendarEdit;
    btnDateToString: TButton;
    edtTexto: TEdit;
    btnLength: TButton;
    procedure btnDiaDaSemanaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDateToStringClick(Sender: TObject);
    procedure btnLengthClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

{ TDoubleHelper }

function TDoubleHelper.AsString: string;
begin
  Result := System.SysUtils.FloatToStr(Self);
end;

{ TDateTimeHelper }

function TDateTimeHelper.AsString: string;
begin
  Result := System.SysUtils.DateTimeToStr(Self);
end;

{ TIntegerHelper }

function TIntegerHelper.AsString: string;
begin
  Result := System.SysUtils.IntToStr(Self);
end;

{ TStringHelper }

function TStringHelper.Length: Integer;
begin
  Result := System.Length(Self);
end;

{ TDiaSemanaHelper }

function TDiaSemanaHelper.AsString: string;
begin
  case Self of
    dsSegunda:
      Result := 'segunda-feira';
    dsTerca:
      Result := 'terça-feira';
    dsQuarta:
      Result := 'quarta-feira';
    dsQuinta:
      Result := 'quinta-feira';
    dsSexta:
      Result := 'sexta-feira';
    dsSabado:
      Result := 'sábado';
    dsDomingo:
      Result := 'domingo';
  else
    raise Exception.Create('Dia da semana incorreto.');
  end;
end;

{ TSingleHelper }

function TSingleHelper.AsString: string;
begin
  Result := System.SysUtils.FloatToStr(Self);
end;

function TSingleHelper.Trunc: Integer;
begin
  Result := System.Trunc(Self);
end;

procedure TfrmPrincipal.btnDateToStringClick(Sender: TObject);
begin
  ShowMessage(cleDateToString.Date.AsString);
end;

procedure TfrmPrincipal.btnDiaDaSemanaClick(Sender: TObject);
begin
  ShowMessage(TDiaSemana(spbDiaDaSemana.Value.Trunc).AsString);
end;

procedure TfrmPrincipal.btnLengthClick(Sender: TObject);
begin
  ShowMessage(edtTexto.Text.Length.AsString);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Randomize;
  spbDiaDaSemana.Value := Random(Integer(High(TDiaSemana)));
  cleDateToString.Date := Date;
end;

{ TDateHelper }

function TDateHelper.AsString: string;
begin
  Result := System.SysUtils.DateToStr(Self);
end;

end.
