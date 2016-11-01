unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Redis.Client, Redis.Commons,
  Redis.NetLib.Indy, System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TForm7 = class(TForm)
    edtWord: TEdit;
    ListBox1: TListBox;
    Label1: TLabel;
    procedure Action1Execute(Sender: TObject);
    procedure edtWordChange(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}
procedure TForm7.edtWordChange(Sender: TObject);
var
  lRedis: IRedisClient;
  lRank: Int64;
  lWords: TArray<string>;
  s, lWord: string;
  lWordLen: Integer;
begin
  lWord := edtWord.Text;
  lWordLen := Length(lWord);
  if lWordLen = 0 then
  begin
    ListBox1.Clear;
    ListBox1.Visible := False;
    Exit;
  end;

  ListBox1.Clear;
  if lWord <> '' then
  begin
    lRedis := NewRedisClient('newton-mbp');
    if lRedis.ZRANK('words', lWord, lRank) then
    begin
      lWords := lRedis.ZRANGE('words', lRank, lRank + 100);
      for s in lWords do
      begin
        if s.EndsWith('*') and (s.StartsWith(lWord)) then
          ListBox1.Items.Add(s.SubString(0, s.Length - 1));
      end;
    end;
  end;
  ListBox1.Visible := ListBox1.Items.Count > 0;
end;

procedure TForm7.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    edtWord.Text := ListBox1.Items[ListBox1.ItemIndex];
    ListBox1.Clear;
    ListBox1.Visible := False;
    edtWord.SetFocus;
  end;
end;

end.
