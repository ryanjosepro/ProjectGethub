unit ViewConfigs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.Types,
  Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  Config, MyUtils, MyDialogs, Git;

type
  TWindowConfigs = class(TForm)
    LblEmail: TLabel;
    LblName: TLabel;
    BtnDBFile: TSpeedButton;
    TxtUserName: TEdit;
    TxtEmail: TEdit;
    BtnSave: TSpeedButton;
    BtnDiscard: TSpeedButton;
    Actions: TActionList;
    ActCancel: TAction;
    ActEsc: TAction;
    ActSave: TAction;
    PageConfigs: TPageControl;
    TabConta: TTabSheet;
    TabSistema: TTabSheet;
    Op��es: TTabSheet;
    BtnGitBin: TSpeedButton;
    TxtGitBin: TEdit;
    LblPath: TLabel;
    ActGitBin: TAction;
    Images: TImageList;
    OpenFile: TFileOpenDialog;
    CheckCloseCmd: TCheckBox;
    CheckCloseStatus: TCheckBox;
    TxtCloseTime: TEdit;
    LblCloseSeconds: TLabel;
    PanelCloseCmd: TPanel;
    PanelExecTime: TPanel;
    LblExecTime: TLabel;
    LblSeconds: TLabel;
    LblMiliseconds: TLabel;
    TxtExecTime: TEdit;
    procedure ActEscExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ConfigChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActGitBinExecute(Sender: TObject);
  public
    procedure LoadConfigs;
    procedure Changed;
    procedure Done;
  end;

var
  WindowConfigs: TWindowConfigs;
  DidChange: boolean;

implementation

{$R *.dfm}

procedure TWindowConfigs.FormActivate(Sender: TObject);
begin
  LoadConfigs;
  Done;
end;

procedure TWindowConfigs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DidChange then
  begin
    case TDialogs.YesNoCancel('Deseja salvar as altera��es?') of
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

procedure TWindowConfigs.LoadConfigs;
begin
  TxtUserName.Text := TConfig.GetConfig('ACCOUNT', 'Name');
  TxtEmail.Text := TConfig.GetConfig('ACCOUNT', 'Email');
  TxtGitBin.Text := TConfig.GetConfig('SYSTEM', 'GitBin');
  CheckCloseCmd.Checked := TConfig.GetConfig('OPTIONS', 'CloseCmd') = '1';
  CheckCloseStatus.Checked := TConfig.GetConfig('OPTIONS', 'CloseStatus') = '1';
  TxtCloseTime.Text := TConfig.GetConfig('OPTIONS', 'CloseTime');
  TxtExecTime.Text := TConfig.GetConfig('OPTIONS', 'ExecTime');
end;

procedure TWindowConfigs.ActSaveExecute(Sender: TObject);
begin
  TConfig.SetConfig('ACCOUNT', 'Name', Trim(TxtUserName.Text));
  TConfig.SetConfig('ACCOUNT', 'Email', Trim(TxtEmail.Text));
  TConfig.SetConfig('SYSTEM', 'GitBin', Trim(TxtGitBin.Text));
  TConfig.SetConfig('OPTIONS', 'CloseCmd', TUtils.Iif(CheckCloseCmd.Checked, '1', '0'));
  TConfig.SetConfig('OPTIONS', 'CloseStatus', TUtils.Iif(CheckCloseStatus.Checked, '1', '0'));
  TConfig.SetConfig('OPTIONS', 'CloseTime', TxtCloseTime.Text);
  TConfig.SetConfig('OPTIONS', 'ExecTime', TxtExecTime.Text);

  TConfig.SetGlobalGitAccount;

  Done;

  Close;
end;

procedure TWindowConfigs.ActCancelExecute(Sender: TObject);
begin
  if DidChange then
  begin
    if TDialogs.YesNo('Tem certeza que deseja descartar as altera��es?', mbNo) = mrYes then
    begin
      Done;
      Close;
    end;
  end
  else
  begin
    Close;
  end;
end;

procedure TWindowConfigs.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowConfigs.ActGitBinExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TxtGitBin.Text := OpenFile.FileName;
  end;
end;

procedure TWindowConfigs.ConfigChange(Sender: TObject);
begin
  Changed;
end;

procedure TWindowConfigs.Changed;
begin
  DidChange := true;
  ActSave.Enabled := true;

  CheckCloseStatus.Enabled := CheckCloseCmd.Checked;

  LblCloseSeconds.Enabled := CheckCloseCmd.Checked;

  TxtCloseTime.Enabled := CheckCloseCmd.Checked;
end;

procedure TWindowConfigs.Done;
begin
  DidChange := false;
  ActSave.Enabled := false;
end;

end.
