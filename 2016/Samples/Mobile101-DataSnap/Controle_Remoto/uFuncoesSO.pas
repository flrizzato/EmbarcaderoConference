unit uFuncoesSO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

    function SysComputerName: string;
    function SysWinDir: string;
    function SysSystemDir: string;
    function SysTempDir: string;
    function SysUserName: string;
    function SysVersionStr: string;

implementation
//Retorna o nome do computador na rede
function SysComputerName: string;
var
  I: DWord;
begin
  I := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, I);
  Windows.GetComputerName(PChar(Result), I);
  Result := string(PChar(Result));
end;

//Retorna o diretório de instalação do Windows
function SysWinDir: string;
begin
  SetLength(Result, MAX_PATH);
  Windows.GetWindowsDirectory(PChar(Result), MAX_PATH);
  Result := string(PChar(Result));
end;

//Retorna o diretório System do Windows
function SysSystemDir: string;
begin
  SetLength(Result, MAX_PATH);
  if GetSystemDirectory(PChar(Result), MAX_PATH) > 0 then
  Result := string(PChar(Result))
  else
  Result := '';
end;


//Retorna o diretório Temp do Windows
function SysTempDir: string;
begin
  SetLength(Result, MAX_PATH);
  if GetTempPath(MAX_PATH, PChar(Result)) > 0 then
  Result := string(PChar(Result))
  else
  Result := '';
end;

//Retorna o nome do usuário logado no Windows
function SysUserName: string;
var
  I: DWord;
begin
  I := 255;
  SetLength(Result, I);
  Windows.GetUserName(PChar(Result), I);
  Result := string(PChar(Result));
end;

//Retorna uma string contendo a versão do Windows
function SysVersionStr: string;
var
  Ver: _OSVERSIONINFOA;
begin
//  if SysVersion (Ver) then
  Result := {Ver.dwPlatformId + } IntToStr(Ver.dwMajorVersion) + '.' +
  IntToStr(Ver.dwMinorVersion);
//  else
//  Result := '';
end;

end.
