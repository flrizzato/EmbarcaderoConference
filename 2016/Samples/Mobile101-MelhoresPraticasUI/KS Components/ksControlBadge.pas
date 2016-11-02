{*******************************************************************************
*                                                                              *
*  TksControlBadge - iOS style badge used by other controls                    *
*                                                                              *
*  https://github.com/gmurt/KernowSoftwareFMX                                  *
*                                                                              *
*  Copyright 2015 Graham Murt                                                  *
*                                                                              *
*  email: graham@kernow-software.co.uk                                         *
*                                                                              *
*  Licensed under the Apache License, Version 2.0 (the "License");             *
*  you may not use this file except in compliance with the License.            *
*  You may obtain a copy of the License at                                     *
*                                                                              *
*    http://www.apache.org/licenses/LICENSE-2.0                                *
*                                                                              *
*  Unless required by applicable law or agreed to in writing, software         *
*  distributed under the License is distributed on an "AS IS" BASIS,           *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    *
*  See the License for the specific language governing permissions and         *
*  limitations under the License.                                              *
*                                                                              *
*******************************************************************************}

unit ksControlBadge;

interface

{$I ksComponents.inc}


uses FMX.Controls, Classes, FMX.StdCtrls, FMX.Objects, FMX.Effects, ksTypes;

type
  TksControlBadge = class;

  TksBadgeProperties = class(TPersistent)
  private
    FOwner: TksControlBadge;
    FValue: Integer;
    FShadow: Boolean;
    procedure Changed;
    procedure SetValue(const Value: integer);
    procedure SetShadow(const Value: Boolean);
  public
    constructor Create(AOwner: TksControlBadge); virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property Value: integer read FValue write SetValue default 0;
    property Shadow: Boolean read FShadow write SetShadow default True;
  end;


  TksControlBadge = class(TksRoundRect)
  private
    FLabel: TLabel;
    FProperties: TksBadgeProperties;
    FShadowEffect: TShadowEffect;
    procedure DoChanged;
    procedure SetProperties(const Value: TksBadgeProperties);
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Properties: TksBadgeProperties read FProperties write SetProperties;
  end;


implementation

uses FMX.Types, System.UIConsts, FMX.Graphics, SysUtils, Math;


{ TksBadgeProperties }

procedure TksBadgeProperties.Assign(Source: TPersistent);
begin
  inherited;
  FValue := (Source as TksBadgeProperties).Value;
  FShadow := (Source as TksBadgeProperties).Shadow;
end;

procedure TksBadgeProperties.Changed;
begin
  FOwner.DoChanged;
end;

constructor TksBadgeProperties.Create(AOwner: TksControlBadge);
begin
  inherited Create;
  FOwner := AOwner;
  FValue := 0;
  FShadow := True;
end;

procedure TksBadgeProperties.SetShadow(const Value: Boolean);
begin
  FShadow := Value;
  Changed;
end;

procedure TksBadgeProperties.SetValue(const Value: integer);
begin
  FValue := Value;
  Changed;
end;

{ TksControlBadge }

constructor TksControlBadge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProperties := TksBadgeProperties.Create(Self);
  FLabel := TLabel.Create(Self);
  FShadowEffect := TShadowEffect.Create(Self);
  HitTest := False;
  Locked := True;
  FLabel.TextSettings.Font.Size := 10;
  FLabel.TextSettings.FontColor := claWhite;
  FLabel.StyledSettings := [];
  FLabel.VertTextAlign := TTextAlign.Center;
  FLabel.TextAlign := TTextAlign.Center;
  Stroke.Kind := TBrushKind.None;
  Fill.Color := claRed;
  Height := 16;
  Stored := False;
  Width := 16;
  Position.Y := -8;
  Visible := False;
  FShadowEffect.Distance := 0.8;
  FShadowEffect.Softness := 0.08;
  AddObject(FLabel);
  AddObject(FShadowEffect);

  FLabel.Locked := True;
  FLabel.HitTest := False;
end;

destructor TksControlBadge.Destroy;
begin
  FreeAndNil(FProperties);
  {$IFDEF NEXTGEN}
  FLabel.DisposeOf;
  FShadowEffect.DisposeOf;
  {$ELSE}
  FLabel.Free;
  FShadowEffect.Free;
  {$ENDIF}
  inherited;
end;

procedure TksControlBadge.Assign(Source: TPersistent);
begin
  inherited;

end;

procedure TksControlBadge.DoChanged;
begin
  Visible := FProperties.Value > 0;
  Resize;
  FLabel.Text := IntToStr(FProperties.Value);
  FShadowEffect.Enabled := FProperties.Shadow;
  (Owner as TControl).RecalcSize;
end;



procedure TksControlBadge.Resize;
begin
  inherited;
  if Canvas <> nil then
    Width := Max(16,(Canvas.TextWidth(IntToStr(FProperties.Value)))+4);
  FLabel.Position.X := 0;
  FLabel.Position.Y := 0;
  FLabel.Size.Width := Width;
  FLabel.Size.Height := Height-1;
  Repaint;
end;

procedure TksControlBadge.SetProperties(const Value: TksBadgeProperties);
begin
  FProperties.Assign(Value);
end;

initialization

  Classes.RegisterClass(TksBadgeProperties);
  Classes.RegisterClass(TksControlBadge);

end.
