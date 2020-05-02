unit MyUtils;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.StrUtils,
  ShellAPI, Vcl.Forms, Windows, IOUtils, ClipBrd, Vcl.Dialogs;

type
  TStringArray = array of string;

  TUtils = class
  public
    class function Iif(Cond: boolean; V1, V2: variant): variant;
    class function IfLess(Value, Value2: integer): integer;
    class function IfEmpty(Value, Replace: string): string;
    class function IfZero(Value, Replace: integer): integer;

    class function IifLess(Cond: boolean; V1, V2: integer): integer;
    class function IifEmpty(Cond: boolean; V1, V2: string): string;
    class function IifZero(Cond: boolean; V1, V2: integer): integer;

    class function Cut(Text, Separator: string): TStringArray;

    class function ArrayToStr(StrArray: array of string; Separator: string): string; overload;
    class function ArrayToStr(StrArray: System.TArray<System.string>; Separator: string): string; overload;

    class function ExtractStringList(StrList: TStringList; Starts, Count: integer): TStringList;

    class procedure ExecCmd(Comand: string; ShowCmd: boolean = true);
    class function ExecDos(CommandLine: string; Work: string = 'C:\'): string;
    class procedure ExecBat(FileName: string; Commands: TStringList);
    class procedure OpenOnExplorer(Path: string);
    class procedure CopyToClipboard(Text: string);

    class procedure DeleteIfExistsDir(Dir: string);
    class procedure DeleteIfExistsFile(FileName: string);
    class procedure CreateIfNotExistsDir(Dir: string);
    class procedure CreateIfNotExistsFile(FileName: string);
    class function GetLastFolder(Dir: String): String;
    class function AppPath: string;

    class function BreakLine: string;

    class function Temp: string;

    class procedure AddFirewallPort(RuleName, Port: string);

    class procedure DeleteFirewallPort(RuleName, Port: string);
  end;

implementation

//M�todo para usar operador tern�rio
class function TUtils.Iif(Cond: boolean; V1, V2: variant): variant;
begin
  if Cond then
  begin
    Result := V1;
  end
  else
  begin
    Result := V2;
  end;
end;

//Retorna o menor valor
class function TUtils.IfLess(Value, Value2: integer): integer;
begin
  Result := Iif(Value < Value2, Value, Value2);
end;

//Retorna um substituto se o valor for vazio
class function TUtils.IfEmpty(Value, Replace: string): string;
begin
  Result := Iif(Value.Trim = '', Replace, Value);
end;

//Retorna um substituto se o valor for zero
class function TUtils.IfZero(Value, Replace: integer): integer;
begin
  Result := Iif(Value = 0, Replace, Value);
end;

//Iif e IfLess juntos num m�todo s�
class function TUtils.IifLess(Cond: boolean; V1, V2: integer): integer;
begin
  Result := Iif(Cond, V1, IfLess(V2, V1));
end;

//Iif e IfEmpty juntos num m�todo s�
class function TUtils.IifEmpty(Cond: boolean; V1, V2: string): string;
begin
  Result := Iif(Cond, V1, IfEmpty(V2, V1));
end;

//Iif e IfZero juntos num m�todo s�
class function TUtils.IifZero(Cond: boolean; V1, V2: integer): integer;
begin
  Result := Iif(Cond, V1, IfZero(V2, V1));
end;

//Divide uma string em array baseando-se no separador
class function TUtils.Cut(Text, Separator: string): TStringArray;
var
  StrArray: TStringDynArray;
  Cont: integer;
begin
  SetLength(StrArray, Length(SplitString(Text, Separator)));
  StrArray := SplitString(Text, Separator);
  SetLength(Result, Length(StrArray));
  for Cont := 0 to Length(StrArray) - 1 do
  begin
    Result[Cont] := StrArray[Cont];
  end;
end;

//Transforma um array em uma string
class function TUtils.ArrayToStr(StrArray: array of string; Separator: string): string;
var
  Cont: integer;
begin
  Result := '';
  for Cont := 0 to Length(StrArray) - 1 do
  begin
    Result := Result + StrArray[Cont] + Iif(Cont <> Length(StrArray) - 1, Separator, '');
  end;
end;

class function TUtils.ArrayToStr(StrArray: System.TArray<System.string>; Separator: string): string;
var
  Cont: integer;
begin
  Result := '';
  for Cont := 0 to Length(StrArray) - 1 do
  begin
    Result := Result + StrArray[Cont] + Iif(Cont <> Length(StrArray) - 1, Separator, '');
  end;
end;

//Extrai uma parte de uma StringList
class function TUtils.ExtractStringList(StrList: TStringList; Starts, Count: integer): TStringList;
var
  Cont: integer;
begin
  Result := TStringList.Create;

  for Cont := Starts to Starts + Count - 1 do
  begin
    Result.Add(StrList[Cont]);
  end;
end;

//Executa um comando cmd - async
// /C -> Executa os comandos e fecha
// /K -> Executa os comandos e continua aberto
class procedure TUtils.ExecCmd(Comand: string; ShowCmd: boolean);
begin
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, Iif(ShowCmd, 1, 0));
end;

//Executa um comando cmd - sync
class function TUtils.ExecDos(CommandLine: string; Work: string = 'C:\'): string;
var
  SecAtrrs: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  pCommandLine: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SecAtrrs do begin
    nLength := SizeOf(SecAtrrs);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SecAtrrs, 0);
  try
    with StartupInfo do
    begin
      FillChar(StartupInfo, SizeOf(StartupInfo), 0);
      cb := SizeOf(StartupInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), StartupInfo, ProcessInfo);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := windows.ReadFile(StdOutPipeRead, pCommandLine, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            pCommandLine[BytesRead] := #0;
            Result := Result + pCommandLine;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      finally
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

class procedure TUtils.ExecBat(FileName: string; Commands: TStringList);
var
  Arq: TextFile;
  Command: string;
begin
  AssignFile(Arq, FileName);
  Rewrite(Arq);

  for Command in Commands do
  begin
    Writeln(Arq, Command);
  end;

  CloseFile(Arq);

  ShellExecute(0, nil, PWideChar(FileName), nil, nil, SW_SHOWNORMAL);
end;

class procedure TUtils.OpenOnExplorer(Path: string);
begin
  ShellExecute(0, PWideChar('explore'), PWideChar(Path), nil, nil, SW_SHOWNORMAL);
end;

class procedure TUtils.CopyToClipboard(Text: string);
begin
  Clipboard.AsText := Text;
end;

//M�todos para gerenciar arquivos e diret�rios
class procedure TUtils.DeleteIfExistsDir(Dir: string);
begin
  if TDirectory.Exists(Dir) then
    TDirectory.Delete(Dir, true);
end;

class procedure TUtils.DeleteIfExistsFile(FileName: string);
begin
  if FileExists(FileName) then
    TFile.Delete(FileName);
end;

class procedure TUtils.CreateIfNotExistsDir(Dir: string);
begin
  if not TDirectory.Exists(Dir) then
    TDirectory.CreateDirectory(Dir);
end;

class procedure TUtils.CreateIfNotExistsFile(FileName: string);
begin
  if not FileExists(FileName) then
    TFile.Create(FileName);
end;

class function TUtils.GetLastFolder(Dir: String): String;
var
  sa: TStringDynArray;
begin
  sa := SplitString(Dir, PathDelim);
  Result := sa[High(sa)];
end;

class function TUtils.AppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

//Retorna uma quebra de linha
class function TUtils.BreakLine: string;
begin
  Result := #13#10;
end;

//Retorna o diret�rio temp
class function TUtils.Temp: string;
begin
  Result := GetEnvironmentVariable('TEMP');
end;

class procedure TUtils.AddFirewallPort(RuleName, Port: string);
begin
  ExecDos('netsh advfirewall firewall add rule name="' + RuleName + '" dir=in action=allow protocol=TCP localport=' + Port);
  ExecDos('netsh advfirewall firewall add rule name="' + RuleName + '" dir=out action=allow protocol=TCP localport=' + Port);
end;

class procedure TUtils.DeleteFirewallPort(RuleName, Port: string);
begin
  ExecDos('netsh advfirewall firewall delete rule name="' + RuleName + '" protocol=TCP localport=' + Port);
end;

end.
