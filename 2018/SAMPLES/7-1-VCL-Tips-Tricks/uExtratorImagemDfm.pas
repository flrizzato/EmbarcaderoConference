unit uExtratorImagemDfm;

interface

uses
  Generics.Collections, System.Classes, System.SysUtils, Vcl.Graphics,
  Vcl.Buttons, Vcl.Controls;

type

  TComponentConvert = class
  public
    class function StrToComp(Value: string): TComponent;
    class function CompToStr(Value: TComponent): string;
  end;

  TComponenteUnit = record
    Arquivo: string;
    ComponentText: string;
    procedure SaveToFile(pFileName: string);
    function Component: TComponent;
  end;

  TIdentificadorImagem = class
  public
    class function IdentificarBotoesComImagem(pArquivoDfm: string): TArray<TComponenteUnit>;
    class function IdentificarImageComImagem(pArquivoDfm: string): TArray<TComponenteUnit>;
    class function IdentificarImageList(pArquivoDfm: string): TArray<TComponenteUnit>;
  end;


  TExtratorImagem = class
  public
    class procedure ExtrairImagemDoBotao(pComponenteUnit: TComponenteUnit; pSaveDir: string);
    class procedure ExtrairImagemDoImage(pComponenteUnit: TComponenteUnit; pSaveDir: string);
    class procedure ExtrairImagemDoImageList(pComponenteUnit: TComponenteUnit; pSaveDir: string);
  end;


implementation

uses
  Vcl.ExtCtrls;


class function TIdentificadorImagem.IdentificarBotoesComImagem(pArquivoDfm: string): TArray<TComponenteUnit>;
var
  li, lPos: Integer;
  lLinha: string;
  lComponente, lDfm: TStringList;
  lAchouComponente, lAchouImagem, lAchouCaption : boolean;
  lComponenteUnit: TComponenteUnit;
begin
  lDfm := TStringList.Create;
  lDfm.LoadFromFile(pArquivoDfm);

  lComponente := TStringList.Create;

  lAchouComponente := False;
  lAchouImagem  := False;
  lAchouCaption := False;

  for li := 0 to lDfm.Count - 1 do
  begin
    lLinha := Trim(lDfm[li]);

    if lAchouComponente then
    begin
      if (pos('OnClick =',lLinha) = 1) or
         (pos('OnDblClick =',lLinha) = 1) or
         (pos('OnMouse',lLinha) = 1) then
      begin
        Continue;
      end;

      if (pos('Glyph.Data = {',lLinha) = 1) and (pos('Glyph.Data = {00000000}',lLinha) = 0) then
      begin
        lAchouImagem := True;
      end;

      if pos('=',lLinha) <> 0 then
        lComponente.Add('  '+lLinha)
      else
        lComponente.Add('    '+lLinha);
    end;

    if ((pos('inherited',lLinha) <> 0) or (pos('object',lLinha) <> 0)) and
       ((pos('TSpeedButton',lLinha) <> 0) or
        (pos('TBitBtn',lLinha) <> 0)) then
    begin
      lComponente.Clear;
      lComponente.Add(lLinha);
      lAchouComponente := True;
    end else if lAchouComponente and (lLinha = 'end') then
    begin
      lComponente.Add(lLinha);
      if (lComponente.Text <> '') and lAchouImagem and not lAchouCaption then
      begin
        lComponenteUnit.Arquivo := StringReplace(LowerCase(ExtractFileName(pArquivoDfm)),'.dfm','',[]);
        lComponenteUnit.ComponentText   := lComponente.Text;
        lPos := length(Result);
        SetLength(Result,lPos + 1);
        Result[lPos]:= lComponenteUnit;
      end;
      lAchouImagem := False;
      lAchouCaption := False;
      lAchouComponente := False;
    end;
  end;
  lComponente.Free;
  lDfm.Free;
end;


class function TIdentificadorImagem.IdentificarImageComImagem(pArquivoDfm: string): TArray<TComponenteUnit>;
var
  li, lPos: Integer;
  lLinha: string;
  lComponente, lDfm: TStringList;
  lAchouComponente, lAchouImagem, lAchouCaption : boolean;
  lComponenteUnit: TComponenteUnit;
begin
  lDfm := TStringList.Create;
  lDfm.LoadFromFile(pArquivoDfm);

  lComponente := TStringList.Create;

  lAchouComponente := False;
  lAchouImagem  := False;
  lAchouCaption := False;

  for li := 0 to lDfm.Count - 1 do
  begin
    lLinha := trim(lDfm[li]);

    if lAchouComponente then
    begin
      if (pos('OnClick =',lLinha) = 1) or
         (pos('OnDblClick =',lLinha) = 1) or
         (pos('OnMouse',lLinha) = 1) then
      begin
        Continue;
      end;

      if (pos('Picture.Data = {',lLinha) = 1) and (pos('Picture.Data = {00000000}',lLinha) = 0) then
      begin
        lAchouImagem := True;
      end;

      if pos('=',lLinha) <> 0 then
        lComponente.Add('  '+lLinha)
      else
        lComponente.Add('    '+lLinha);
    end;

    if ((pos('inherited',lLinha) <> 0) or (pos('object',lLinha) <> 0)) and
       (pos('TImage',lLinha) <> 0) then
    begin
      lComponente.Clear;
      lComponente.Add(lLinha);
      lAchouComponente := True;
    end else if lAchouComponente and (lLinha = 'end') then
    begin
      lComponente.Add(lLinha);
      if (lComponente.Text <> '') and lAchouImagem and not lAchouCaption then
      begin
        lComponenteUnit.Arquivo := StringReplace(LowerCase(ExtractFileName(pArquivoDfm)),'.dfm','',[]);
        lComponenteUnit.ComponentText   := lComponente.Text;
        lPos := length(Result);
        SetLength(Result,lPos + 1);
        Result[lPos]:= lComponenteUnit;
      end;
      lAchouImagem := False;
      lAchouCaption := False;
      lAchouComponente := False;
    end;
  end;
  lComponente.Free;
  lDfm.Free;
end;


class function TIdentificadorImagem.IdentificarImageList(pArquivoDfm: string): TArray<TComponenteUnit>;
var
  li, lPos: Integer;
  lLinha: string;
  lComponente, lDfm: TStringList;
  lAchouComponente, lAchouImagem, lAchouCaption : boolean;
  lComponenteUnit: TComponenteUnit;
begin
  lDfm := TStringList.Create;
  lDfm.LoadFromFile(pArquivoDfm);

  lComponente := TStringList.Create;

  lAchouComponente := False;
  lAchouImagem  := False;
  lAchouCaption := False;

  for li := 0 to lDfm.Count - 1 do
  begin
    lLinha := trim(lDfm[li]);

    if lAchouComponente then
    begin
      if (pos('OnClick =',lLinha) = 1) or
         (pos('OnDblClick =',lLinha) = 1) or
         (pos('OnMouse',lLinha) = 1) then
      begin
        Continue;
      end;

      if (pos('Bitmap = {',lLinha) = 1) then
      begin
        lAchouImagem := True;
      end;

      if pos('=',lLinha) <> 0 then
        lComponente.Add('  '+lLinha)
      else
        lComponente.Add('    '+lLinha);
    end;

    if ((pos('inherited',lLinha) <> 0) or (pos('object',lLinha) <> 0)) and
       (pos('TImageList',lLinha) <> 0) then
    begin
      lComponente.Clear;
      lComponente.Add(lLinha);
      lAchouComponente := True;
    end else if lAchouComponente and (lLinha = 'end') then
    begin
      lComponente.Add(lLinha);
      if (lComponente.Text <> '') and lAchouImagem and not lAchouCaption then
      begin
        lComponenteUnit.Arquivo := StringReplace(LowerCase(ExtractFileName(pArquivoDfm)),'.dfm','',[]);
        lComponenteUnit.ComponentText   := lComponente.Text;
        lPos := length(Result);
        SetLength(Result,lPos + 1);
        Result[lPos]:= lComponenteUnit;
      end;
      lAchouImagem := False;
      lAchouCaption := False;
      lAchouComponente := False;
    end;
  end;
  lComponente.Free;
  lDfm.Free;
end;

{ TComponentConvert }

class function TComponentConvert.CompToStr(Value: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Value);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;


class function TComponentConvert.StrToComp(Value: string): TComponent;
var
  StrStream: TStringStream;
  BinStream: TMemoryStream;
begin
  try
    StrStream := TStringStream.Create(Value);
    try
      BinStream := TMemoryStream.Create;
      try
        ObjectTextToBinary(StrStream, BinStream);
        BinStream.Seek(0, soFromBeginning);
        Result := BinStream.ReadComponent(nil);
      finally
        BinStream.Free;
      end;
    finally
      StrStream.Free;
    end;
  except
    Result := nil;
  end;
end;



class procedure TExtratorImagem.ExtrairImagemDoBotao(pComponenteUnit: TComponenteUnit; pSaveDir: string);
var
  lComponent: TComponent;
  lBitmap: TBitmap;
begin
  RegisterClass(TSpeedButton);
  RegisterClass(TBitBtn);

  lComponent := pComponenteUnit.Component;
  pComponenteUnit.SaveToFile(pSaveDir+pComponenteUnit.Arquivo+'_'+lComponent.ClassName+'_'+lComponent.Name+'.txt');

  lBitmap := nil;

  if lComponent is TSpeedButton then
    lBitmap := TSpeedButton(lComponent).Glyph;

  if lComponent is TBitBtn then
    lBitmap := TBitBtn(lComponent).Glyph;


  if lBitmap <> nil then
  begin
    ForceDirectories(pSaveDir);
    lBitmap.SaveToFile(pSaveDir+pComponenteUnit.Arquivo+'_'+lComponent.ClassName+'_'+lComponent.Name+'.bmp');
  end;
end;


class procedure TExtratorImagem.ExtrairImagemDoImage(pComponenteUnit: TComponenteUnit; pSaveDir: string);
var
  lComponent: TComponent;
  lBitmap: TBitmap;
begin
  RegisterClass(TImage);

  lComponent := pComponenteUnit.Component;
  pComponenteUnit.SaveToFile(pSaveDir+pComponenteUnit.Arquivo+'_'+lComponent.ClassName+'_'+lComponent.Name+'.txt');

  lBitmap := nil;

  if lComponent is TImage then
    lBitmap := TImage(lComponent).Picture.Bitmap;

  if (lBitmap <> nil) then
  begin
    ForceDirectories(pSaveDir);
    lBitmap.SaveToFile(pSaveDir+pComponenteUnit.Arquivo+'_'+lComponent.ClassName+'_'+lComponent.Name+'.bmp');
  end;
end;

class procedure TExtratorImagem.ExtrairImagemDoImageList(pComponenteUnit: TComponenteUnit; pSaveDir: string);
var
  li: Integer;
  lBitmap: TBitmap;
  lComponent: TComponent;
  lImageList: TImageList;
  lx: Integer;
  lStlText: TStringList;
begin
  RegisterClass(TImageList);

  lComponent := pComponenteUnit.Component;
  pComponenteUnit.SaveToFile(pSaveDir+pComponenteUnit.Arquivo+'_'+lComponent.ClassName+'_'+lComponent.Name+'.txt');

  if lComponent is TImageList then
  begin
    lImageList := TImageList(lComponent);
    for lx := 0 to lImageList.Count - 1 do
    begin
      lBitmap := TBitmap.Create;
      lBitmap.Width  := lImageList.Width;
      lBitmap.Height := lImageList.Height;
      lBitmap.PixelFormat := pf32bit;
      lBitmap.AlphaFormat := afIgnored;
      lBitmap.Canvas.Brush.Style := bsClear;
      lBitmap.Canvas.Brush.Color := clWhite;
      lBitmap.Canvas.FillRect(Rect(0, 0, lImageList.Width, lImageList.Height));
      lImageList.GetBitmap(lx, lBitmap);
      lBitmap.SaveToFile(pSaveDir+pComponenteUnit.Arquivo +'_'+lImageList.ClassName+'_'+ lImageList.Name +'_'+ FormatFloat('0000',lx)+'.bmp');
      lBitmap.Free;
    end;
  end;

  lComponent.Free;

end;


{ TComponenteUnit }

function TComponenteUnit.Component: TComponent;
begin
  result := TComponentConvert.StrToComp(self.ComponentText);
end;

procedure TComponenteUnit.SaveToFile(pFileName: string);
var
  lArquivo: TStringList;
begin
  try
    lArquivo := TStringList.Create;
    lArquivo.Text := Self.ComponentText;
    lArquivo.SaveToFile(pFileName);
  finally
    lArquivo.Free;
  end;
end;

end.
