unit uBtnDialogo;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TBtnDialogo = class(TStyledControl)
  private
    FBtnSim: String;
    FBtnNao: String;
    FBtnCancel: String;

    function GetBtn(const aNome,aDefault: String): String;
    procedure SetBtn(const aNome,aValor: String);

    function GetBtnCancel: String;
    function GetBtnNao: String;
    function GetBtnSim: String;
    procedure SetBtnCancel(const Value: String);
    procedure SetBtnNao(const Value: String);
    procedure SetBtnSim(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
    function GetStyleObject: TFmxObject; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Align default TAlignLayout.alBottom;
    property BtnSim: String read GetBtnSim write SetBtnSim;
    property BtnNao: String read GetBtnNao write SetBtnNao;
    property BtnCancel: String read GetBtnCancel write SetBtnCancel;
  end;

procedure Register;

implementation

uses
  System.Types, FMX.Styles;

{$IFDEF MACOS}
{$R *.mac.res}
{$ENDIF}
{$IFDEF MSWINDOWS}
{$R *.win.res}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Samples', [TBtnDialogo]);
end;

{ TBtnDialogo }

const
  BtnSimNome = 'DoButton';
  BtnNaoNome = 'DontButton';
  BtnCancelNome = 'CancelButton';

constructor TBtnDialogo.Create(AOwner: TComponent);
begin
  inherited;
  Height := 46;
  Width := 300;
  Align := TAlignLayout.alBottom;
  BtnSim := 'Sim';
  BtnNao := 'Não';
  BtnCancel := 'Cancelar';
end;

function TBtnDialogo.GetBtn(const aNome,aDefault: String): String;
var
  Base: TFmxObject;
begin
  Base := FindStyleResource(aNome);
  if Base is TTextControl then
    Result := TTextControl(Base).Text
  else
    Result := aDefault;
end;

function TBtnDialogo.GetBtnCancel: String;
begin
  Result := GetBtn(BtnCancelNome,FBtnCancel);
end;

function TBtnDialogo.GetBtnNao: String;
begin
  Result := GetBtn(BtnNaoNome,FBtnNao);
end;

function TBtnDialogo.GetBtnSim: String;
begin
  Result := GetBtn(BtnSimNome,FBtnSim);
end;

function TBtnDialogo.GetStyleObject: TFmxObject;
const
  Style = 'BtnDialogoPanelStyle';
begin
  if (StyleLookup = '') then
  begin
    Result := TControl(TStyleManager.LoadFromResource(HInstance, Style, RT_RCDATA));
    Exit;
  end;
  Result := inherited GetStyleObject;
end;

procedure TBtnDialogo.SetBtn(const aNome,aValor: String);
var
  Base: TFmxObject;
begin
  Base := FindStyleResource(aNome);
  if Base is TTextControl then
    TTextControl(Base).Text := AValor;
end;

procedure TBtnDialogo.SetBtnCancel(const Value: String);
begin
  FBtnCancel := Value;
  SetBtn(BtnCancelNome,Value);
end;

procedure TBtnDialogo.SetBtnNao(const Value: String);
begin
  FBtnNao := Value;
  SetBtn(BtnNaoNome,Value);
end;

procedure TBtnDialogo.SetBtnSim(const Value: String);
begin
  FBtnSim := Value;
  SetBtn(BtnSimNome,Value);
end;

end.
