unit UFilterCustomizado;

interface

uses DBXTransport,IdCoderMIME,SysUtils;

type
  TTDSFilterDelphiConference = class(TTransportFilter)
  public
    function ProcessInput(const Data: TBytes):
    TBytes; override;
    function ProcessOutput(const Data: TBytes):
    TBytes; override;
    function Id: string; override;
  end;
const FFilterName = 'TDSFilterDelphiConference';

implementation

{ TDataSnapCustomFilter }

function TTDSFilterDelphiConference.Id: string;
begin
  result := FFilterName;
end;

function TTDSFilterDelphiConference.ProcessInput(const Data: TBytes): TBytes;
var script: string;
begin
  script := TIdEncoderMIME.EncodeBytes(data);
  result := BytesOf(script);
end;

function TTDSFilterDelphiConference.ProcessOutput(const Data: TBytes): TBytes;
var sdecript: string;
begin
  sdecript := StringOf(Data);
  result   := TIdDecoderMIME.DecodeBytes(sdecript);
end;

initialization
  TTransportFilterFactory.RegisterFilter(FFilterName,TTDSFilterDelphiConference);
finalization
  TTransportFilterFactory.UnregisterFilter(TTDSFilterDelphiConference);

end.
