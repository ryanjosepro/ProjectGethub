unit ViewAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList,
  Config, MyDialogs;

type
  TWindowAccount = class(TForm)
    Logo: TImage;
    LblEmail: TLabel;
    LblName: TLabel;
    BtnDBFile: TSpeedButton;
    TxtUserName: TEdit;
    TxtEmail: TEdit;
    BtnSave: TSpeedButton;
    BtnDiscard: TSpeedButton;
    Actions: TActionList;
    ActDiscard: TAction;
    ActEsc: TAction;
    ActSave: TAction;
    procedure ActEscExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActDiscardExecute(Sender: TObject);
    procedure TxtChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    procedure Changed;
    procedure Done;
  end;

var
  WindowAccount: TWindowAccount;
  DidChange: boolean;

implementation

{$R *.dfm}

procedure TWindowAccount.FormActivate(Sender: TObject);
begin
  TxtUserName.Text := TConfig.GetConfig('ACCOUNT', 'UserName', '');
  TxtEmail.Text := TConfig.GetConfig('ACCOUNT', 'Email', '');
  Done;
end;

procedure TWindowAccount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DidChange then
  begin
    case TDialogs.YesNoCancel('Deseja salvar as alterações?') of
    mrYes:
      ActSave.Execute;
    mrCancel:
      Action := caNone;
    end;
  end
  else
  begin
    Close;
  end;
end;

procedure TWindowAccount.ActSaveExecute(Sender: TObject);
begin
  TConfig.SetConfig('ACCOUNT', 'UserName', Trim(TxtUserName.Text));
  TConfig.SetConfig('ACCOUNT', 'Email', Trim(TxtEmail.Text));
  Close;
end;

procedure TWindowAccount.ActDiscardExecute(Sender: TObject);
begin
  if DidChange then
  begin
    if TDialogs.YesNo('Tem certeza que deseja descartar as alterações?', mbNo) = mrYes then
    begin
      Close;
    end;
  end
  else
  begin
    Close;
  end;
end;

procedure TWindowAccount.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowAccount.TxtChange(Sender: TObject);
var
  UserName, Email: boolean;
begin
  Changed;
end;

procedure TWindowAccount.Changed;
begin
  DidChange := true;
  ActSave.Enabled := true;
end;

procedure TWindowAccount.Done;
begin
  DidChange := false;
  ActSave.Enabled := false;
end;

end.
