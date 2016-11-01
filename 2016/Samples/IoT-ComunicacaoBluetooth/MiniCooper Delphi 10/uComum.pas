unit uComum;
{$SCOPEDENUMS ON}

interface

uses
  Cromis.Multitouch.Custom, Androidapi.JNI.JavaTypes;

type
  TComando = (PararFrente = 0, Frente = 1, PararRe = 2, Re = 3, AlinharEsuqerda = 4, Esquerda = 5,
    AlinharDireita = 6, Direita = 7);
  TComandos = set of TComando;
  TTouchPoints = array of TTouchPoint;

  function DoConnect(MACAddress: String; out istream: JInputstream; out ostream: JOutputStream): Boolean;

implementation

uses
  Androidapi.JNI.BluetoothAdapter, Android.JNI.Toast, System.SysUtils,
  Androidapi.Helpers;

function DoConnect(MACAddress: String; out istream: JInputstream; out ostream: JOutputStream): Boolean;
var
  uid: JUUID;
  targetMAC: string;
  Adapter: JBluetoothAdapter;
  remoteDevice: JBluetoothDevice;
  Sock: JBluetoothSocket;
begin
  uid := TJUUID.JavaClass.fromString(stringtojstring('00001101-0000-1000-8000-00805F9B34FB'));
  targetMAC := MACAddress;
  Adapter := TJBluetoothAdapter.JavaClass.getDefaultAdapter;
  remoteDevice := Adapter.getRemoteDevice(stringtojstring(targetMAC));
  Toast('Conectando com ' + targetMAC);
  Sock := remoteDevice.createRfcommSocketToServiceRecord(uid);
  try
    Sock.connect;
  except
    Toast('O serviço não noi criado!');
    Exit(False);
  end;
  if not Sock.isConnected then
  begin
    Toast('Faha ao conectar com ' + targetMAC + '! Tente novamente...');
    Exit(False);
  end;
  Toast('Conectado!');
  ostream := Sock.getOutputStream; // record io streams
  istream := Sock.getInputStream;

  // Application.ProcessMessages;

  ostream.write(ord(255)); //
  ostream.write(ord(255)); // get device id   (nur Chitanda)
  Sleep(200);
  Result := True;
end;

end.
