unit Git;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.StrUtils, ShellAPI,
  Config, DAO;

type
  TGit = class
  public
    class function GitFile: string;
    class procedure Config;
    class procedure Pull(Path: string);
    class procedure Add(Path: string);
    class procedure Commit(Path, Msg: string);
    class procedure Checkout(Path: string);
    class procedure Push(Path: string);
  end;

implementation

{ TGit }

class function TGit.GitFile: string;
begin
  Result := TConfig.GetConfig('SYSTEM', 'GitBin', 'C:\Program Files\Git\Bin')
end;

class procedure TGit.Config;
var
  Name, Email, Comand: string;
begin
  Name := TConfig.GetConfig('ACCOUNT', 'Name');
  Email := TConfig.GetConfig('ACCOUNT', 'Email');
  Comand := '/C cd "C:\Program Files\Git\Bin" && git config --global user.name ' + Name + ' && git config --global user.email ' + Email;
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 0);
end;

class procedure TGit.Pull(Path: string);
var
  Comand: string;
begin
  Comand := '/C echo "Pull -> ' + Path + '" && cd C:\Program Files\Git\Bin && git -C "' + Path + '" pull && timeout -t 5';
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 1);
end;

class procedure TGit.Add(Path: string);
var
  Comand: string;
begin
  Comand := '/C echo "Add -> ' + Path + '" && cd C:\Program Files\Git\Bin && git -C "' + Path + '" add . && timeout -t 5';
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 1);
end;

class procedure TGit.Commit(Path, Msg: string);
var
  Comand: string;
begin
  Comand := '/C echo "Commit -> ' + Path + '" && cd C:\Program Files\Git\Bin && git -C "' + Path + '" commit -m "' + Msg + '" && timeout -t 5';
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 1);
end;

class procedure TGit.Checkout(Path: string);
var
  Comand: string;
begin
  Comand := '/C echo "Checkout -> ' + Path + '" && cd C:\Program Files\Git\Bin && git -C "' + Path + '" checkout && timeout -t 5';
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 1);
end;

class procedure TGit.Push(Path: string);
var
  Comand: string;
begin
  Comand := '/C echo "Push -> ' + Path + '" && cd C:\Program Files\Git\Bin && git -C "' + Path + '" push && timeout -t 5';
  ShellExecute(0, nil, 'cmd.exe', PWideChar(Comand), nil, 1);
end;

end.
