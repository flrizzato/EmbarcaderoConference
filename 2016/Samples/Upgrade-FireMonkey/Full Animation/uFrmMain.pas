unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm8 = class(TForm)
    Layout1: TLayout;
    Circle1: TCircle;
    RoundRect1: TRoundRect;
    FloatAnimation1: TFloatAnimation;
    RoundRect3: TRoundRect;
    RoundRect4: TRoundRect;
    RoundRect5: TRoundRect;
    RoundRect7: TRoundRect;
    RoundRect8: TRoundRect;
    RoundRect9: TRoundRect;
    RoundRect11: TRoundRect;
    RoundRect14: TRoundRect;
    RoundRect15: TRoundRect;
    Label1: TLabel;
    Button1: TButton;
    StyleBook1: TStyleBook;
    procedure FloatAnimation1Process(Sender: TObject);
    procedure Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Layout1Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}

procedure TForm8.Button1Click(Sender: TObject);
var
  K: TFmxObject;
begin
  RandSeed := 2837;
  Button1.Visible := False;
  Circle1.TagFloat := 0;
  for K in Layout1.Children do
    if K is TShape then with TShape(K).Position do Point := DefaultValue;
  Circle1.Position.Point := Layout1.BoundsRect.CenterPoint;
  FloatAnimation1.Start;
end;

procedure TForm8.FloatAnimation1Process(Sender: TObject);
var
  K: TFmxObject;
  T: TRectF;
begin
  if FloatAnimation1.Inverse then
  begin
    With Circle1 do T := TRectF.Create(Position.Point,Width, Height);
    if not Layout1.BoundsRect.Contains(T.CenterPoint) then
    begin
      FloatAnimation1.StopAtCurrent;
      Button1.Text := 'Jogar Novamente'+
                      LineFeed+
                      LineFeed+
                      'Pontuação: '+IntToStr(Trunc(Circle1.TagFloat))+
                      LineFeed+
                      'Recorde: '+IntToStr(Trunc(Layout1.TagFloat));
      if Layout1.TagFloat < Circle1.TagFloat then
        Layout1.TagFloat := Circle1.TagFloat;
      Button1.Visible := True;
      Label1.Text := 'Jogos com Delphi Seattle';
    end
    else
    begin
      for K in Layout1.Children do
      begin
        if K is TRoundRect then
          with TRoundRect(K) do
            if PtInRect(TRectF.Create(Position.Point,Width,Height),T.CenterPoint) then
            begin
              FloatAnimation1.Inverse := False;
              if Fill.Color = TAlphaColorRec.Red then
                Circle1.Tag := 1
              else
                Circle1.Tag := 0;
              Fill.Color := TAlphaColorRec.Red;
              Break;
            end;
      end;
    end;
  end;
  if not FloatAnimation1.Inverse and (Circle1.Tag < 1) then
  begin
    with Circle1 do TagFloat := TagFloat + 10 * 0.5;
      Label1.Text := 'Pontos '+IntToStr(Trunc(Circle1.TagFloat));
    for K in Layout1.Children do
      if K is TRoundRect then
        with TRoundRect(K) do
        begin
          Position.Y := Position.Y + Height * 0.5;
          if Position.Y >  Layout1.Height then
          begin
            Position.Y := -Height;
            Position.X := (Layout1.Width - Width) * Random;
            Fill.Color := $FFE0E0E0;
          end;
        end;
  end;

  Layout1.Repaint;
end;

procedure TForm8.FormCreate(Sender: TObject);
var
  K: TFmxObject;
begin
  for K in Layout1.Children do
    if K is TShape then with TShape(K).Position do DefaultValue := Point;
end;

procedure TForm8.Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if FloatAnimation1.Running then Circle1.Position.X := X;
end;

procedure TForm8.Layout1Resize(Sender: TObject);
begin
  FloatAnimation1.StartValue := Layout1.Height + Circle1.Height * 2;
  FloatAnimation1.StopValue := Layout1.Height * 0.5;
end;

end.
