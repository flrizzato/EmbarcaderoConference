unit uMain2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.TimeSpan,
  FMX.Types, FMX.Forms, FMX.Dialogs, FMX.Ani, FMX.Controls, FMX.Objects, FMX.Effects, FMX.Filter.Effects, FMX.Menus, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    ColorAnimation1: TColorAnimation;
    Button1: TButton;
    StyleBook1: TStyleBook;
    Button2: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure AdicionaItem(aListBox: TListBox; const aNome,aMatricula,aFoto: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DateUtils;

{$R *.fmx}

const
{$IFDEF MACOS}
  kPATH = '/Users/FabioGrandi/Downloads/';
{$ELSE}
  kPATH = '..\..\';
{$ENDIF}


procedure TForm1.AdicionaItem(aListBox: TListBox; const aNome,aMatricula,aFoto: String);
var
  aBase: TFmxObject;
  aItem: TListBoxItem;
  aCor: TAlphaColor;
begin
  aListBox.ItemHeight := 202;

  aItem := TListBoxItem.Create(nil);
  aItem.Parent := aListBox;
  aItem.StyleLookup := 'carteira';
  aBase := aItem.FindStyleResource('Foto');
  // O executável fica no diretório  .\$(Platform)\$(Config)  e os fontes dois diretórios acima
  if aBase is TImage then
    TImage(aBase).Bitmap.LoadFromFile(kPATH + aFoto);

//  ShowMessage(ExpandFileName(kPATH + aFoto));

  TText(aItem.FindStyleResource('Nome')).Text := aNome;
  TText(aItem.FindStyleResource('Matricula')).Text := aMatricula;
  TText(aItem.FindStyleResource('CodBarras')).Text := '*' + aMatricula + '*';
  //  Se a matrícula começar com '01' é do time do mal
  if Copy(aMatricula, 1, 2) = '01' then
    aCor := TAlphaColorRec.Red
  else
    aCor := TAlphaColorRec.Blue;
  TGlowEffect(aItem.FindStyleResource('EfeitoFoto')).GlowColor := aCor;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  kDados: array[0..6,0..2] of string =
    ( ('Darth Vader',   '010001-0', 'P1.JPG'),
      ('Luke Skywalker','020001-9', 'P2.JPG'),
      ('Leia Organa',   '020002-7', 'P3.JPG'),
      ('R2-D2',         '020003-5', 'P4.JPG'),
      ('C-3PO',         '020004-3', 'P5.JPG'),
      ('Chewbacca',     '020005-1', 'P6.JPG'),
      ('Han Solo',      '020006-8', 'P7.JPG') );

var
  i: Integer;
begin
  for i := 0 to 6 do
    AdicionaItem(ListBox1,kDados[i,0],kDados[i,1],kDados[i,2]);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
  aStart: TDateTime;
  aFile: String;
begin
  ListBox2.ItemHeight := 202;

  aStart := Now;
  for i := 0 to 99 do
  begin
    if Odd(i) then
      aFile := 'P0.JPG'
    else
      aFile := 'P00.JPG';

    AdicionaItem(ListBox2,'Nome '+IntToStr(i),'Carteira '+IntToStr(i),aFile);
  end;

  ShowMessage(format('Tempo: %d ms',[MilliSecondsBetween(Now,aStart)]));
end;

end.
