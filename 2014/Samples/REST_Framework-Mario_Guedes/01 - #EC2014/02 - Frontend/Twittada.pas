unit Twittada;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrame1 = class(TFrame)
    Image1: TImage;
    Label1: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; const AUserName: string; const ATwitter: string; APicture: TStringStream; APictureType: string);
  end;

implementation

uses
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  System.RegularExpressions;

{$R *.dfm}
{ TFrame1 }

constructor TFrame1.Create(AOwner: TComponent; const AUserName, ATwitter: string; APicture: TStringStream; APictureType: string);

  procedure _DefinirCorFrame;
  var
    _match: TMatch;
  begin
    _match := TRegEx.Match(ATwitter, 'cl\w+', [roIgnoreCase]);
    if _match.Success then
    begin
      try
        Self.Color := StringToColor(_match.Value);
      except
        on E: Exception do
        begin
          Self.Color := clSilver;
        end;
      end;
    end;
  end;

  procedure _CarregarImagem;
  var
    oImagem: TGraphic;
  label
    DEU_CERTO;
  begin
    oImagem := TJPEGImage.Create;
    try
      APictureType := AnsiLowerCase(APictureType);
      if (APictureType = 'image/jpeg') or (APictureType = 'image/jpg') then
      begin
        oImagem := TJPEGImage.Create;
        goto DEU_CERTO;
      end;

      if (APictureType = 'image/png') then
      begin
        oImagem := TPngImage.Create;
        goto DEU_CERTO;
      end;

      Exit;

      DEU_CERTO:
      if (Assigned(APicture)) then
      begin
        APicture.Seek(0, 0);
        oImagem.LoadFromStream(APicture);
        Self.Image1.Picture.Assign(oImagem);
      end;
    finally
      oImagem.Free;
    end;

  end;

begin
  inherited Create(AOwner);
  _DefinirCorFrame;
  _CarregarImagem;
  Self.Label1.Caption := '@' + AUserName;
  Self.Memo1.Text := ATwitter;
end;

procedure TFrame1.Timer1Timer(Sender: TObject);
begin
  Self.Timer1.Enabled := False;
  Self.Free;
end;

end.
