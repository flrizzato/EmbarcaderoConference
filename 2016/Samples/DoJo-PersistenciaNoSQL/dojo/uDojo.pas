unit uDojo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Redis.Client, Redis.Commons,
  Redis.NetLib.Indy, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnConecta: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure btnConectaClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    lConexaoRedis:IRedisClient;
    { Private declarations }
    function pesquisa( APalavra:string ):TStrings;
  public
    { Public declarations }
   // procedure Add(const aText: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnConectaClick(Sender: TObject);
begin
   lConexaoRedis:=NewRedisClient('newton-mbp');
   if Assigned( lConexaoRedis) then
   showmessage('OK');
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  ARetorno: TStrings;
begin
  ARetorno := Self.pesquisa(Self.Edit1.Text);

 Memo1.Lines.Assign(ARetorno);
end;



function TForm1.pesquisa( APalavra:string ):TStrings;
var
  lPalavras:TArray<string>;
  lRank:Int64;
  s:string;
begin
  if lConexaoRedis.ZRANK('words', APalavra, lRank) then
  begin
    result.clear;
    lPalavras := lConexaoRedis.ZRANGE('words', lRank, lRank + 100);
    for s in lPalavras do
    begin
      if s.EndsWith('*') and (s.StartsWith(Apalavra)) then
        Result.Add(s.SubString(0, s.Length - 1));
    end;
  end;
end;

(*
procedure Tfo
Rtm1.aDD;
begin
  end;
*)

//end;


end.
