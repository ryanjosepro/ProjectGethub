unit Git;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.StrUtils, ShellAPI;

type
  TGit = class
  public
    class procedure Add;
    class procedure Commit;
    class procedure Checkout;
    class procedure Push;
  end;

implementation

{ TGit }

class procedure TGit.Add;
begin
  ShellExecute(0, nil, 'cmd.exe', '/C cd C:\Program Files\Git\Bin && git add .', nil, 3);
end;

class procedure TGit.Commit;
begin

end;

class procedure TGit.Checkout;
begin

end;

class procedure TGit.Push;
begin

end;

end.
