unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.DBGrids,
  ViewConfigs, ViewAddRepo, ViewEditRepo, Config, MyUtils, MyDialogs, Git, DAO, Datas;

type
  TWindowMain = class(TForm)
    Actions: TActionList;
    Images: TImageList;
    ActAddRepository: TAction;
    ActEdit: TAction;
    ActDel: TAction;
    ActCommit: TAction;
    ActPush: TAction;
    ActAdd: TAction;
    ActConfigAccount: TAction;
    ActCheckout: TAction;
    LblLogo: TLabel;
    BtnConfigAccount: TSpeedButton;
    BtnEdit: TSpeedButton;
    BtnDel: TSpeedButton;
    BtnAddRepository: TSpeedButton;
    BtnAdd: TSpeedButton;
    BtnCommit: TSpeedButton;
    BtnCheckout: TSpeedButton;
    BtnPush: TSpeedButton;
    OpenFile: TFileOpenDialog;
    BarStatus: TProgressBar;
    CheckSelect: TDBCheckBox;
    Source: TDataSource;
    GridRepositories: TDBGrid;
    ActEsc: TAction;
    SpeedButton1: TSpeedButton;
    ActPull: TAction;
    CheckAll: TCheckBox;
    ActStatus: TAction;
    SpeedButton2: TSpeedButton;
    procedure ActConfigAccountExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActDelExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure ActCommitExecute(Sender: TObject);
    procedure ActCheckoutExecute(Sender: TObject);
    procedure ActPushExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridRepositoriesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridRepositoriesColExit(Sender: TObject);
    procedure GridRepositoriesKeyPress(Sender: TObject; var Key: Char);
    procedure ActAddRepositoryExecute(Sender: TObject);
    procedure ActEscExecute(Sender: TObject);
    procedure GridRepositoriesMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure CheckSelectClick(Sender: TObject);
    procedure ActPullExecute(Sender: TObject);
    procedure CheckAllClick(Sender: TObject);
    procedure ActStatusExecute(Sender: TObject);
  private
    procedure UpdateButtons;
  end;

var
  WindowMain: TWindowMain;
{
TO DO

-Permitir marcar uma checkbox na grid mesmo se a linha n�o estiver selecionada
-Pegar o retorno do cmd para utilizar no status do reposit�rio

}
implementation

{$R *.dfm}

procedure TWindowMain.FormActivate(Sender: TObject);
begin
  TDAO.Load;
  Source.DataSet := TDAO.Table;
  TGit.Config;
  UpdateButtons;
end;

//GRID DRAWN

procedure TWindowMain.GridRepositoriesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  IsChecked : array[Boolean] of Integer =(DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  if (gdFocused in State) then
  begin
      CheckSelect.Visible := true;
      CheckSelect.Left := 13 + GridRepositories.Left + 2;
      CheckSelect.Top := Rect.Top + GridRepositories.top + 2;
      CheckSelect.Width := 15;
      CheckSelect.Height := Rect.Bottom - Rect.Top;
  end
  else
  begin
    if (Column.Field.FieldName = CheckSelect.DataField) then
    begin
      DrawRect:=Rect;
      InflateRect(DrawRect,-1,-1);
      DrawState := ISChecked[Column.Field.AsBoolean];
      GridRepositories.Canvas.FillRect(Rect);
      DrawFrameControl(GridRepositories.Canvas.Handle, DrawRect, DFC_BUTTON, DrawState);
    end;
  end;
end;

procedure TWindowMain.GridRepositoriesColExit(Sender: TObject);
begin
  if GridRepositories.SelectedField.FieldName = CheckSelect.DataField then
  begin
    CheckSelect.Visible := False;
  end;
end;

procedure TWindowMain.GridRepositoriesKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = Chr(9)) then
  begin
    Exit;
  end;
  if (GridRepositories.SelectedField.FieldName = CheckSelect.DataField) then
  begin
    CheckSelect.SetFocus;
    SendMessage(CheckSelect.Handle, WM_Char, word(Key), 0);
  end;
end;

procedure TWindowMain.GridRepositoriesMouseWheel(Sender: TObject;Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  //
end;

//REPOSITORIES MANAGEMENT

procedure TWindowMain.ActAddRepositoryExecute(Sender: TObject);
begin
  WindowAddRepo.ShowModal;
  TDAO.Table.Refresh;
  UpdateButtons;
end;

procedure TWindowMain.ActConfigAccountExecute(Sender: TObject);
begin
  WindowConfigs.ShowModal;
end;

procedure TWindowMain.ActEditExecute(Sender: TObject);
begin
  WindowEditRepo.ShowModal;
end;

procedure TWindowMain.ActDelExecute(Sender: TObject);
begin
  if TDialogs.YesNo('Tem certeza que deseja deletar este reposit�rio?', mbYes) = mrYes then
  begin
    TDAO.Delete;
    UpdateButtons;
  end;
end;

//GITHUB COMMANDS

procedure TWindowMain.ActStatusExecute(Sender: TObject);
var
  Cont: integer;
  Paths: TStringList;
begin
  Paths := TDAO.GetCheckeds('Path');
  for Cont := 0 to Paths.Count - 1 do
  begin
    TGit.Status(Paths[Cont]);
  end;
end;

procedure TWindowMain.ActPullExecute(Sender: TObject);
var
  Cont: integer;
  Paths: TStringList;
begin
  Paths := TDAO.GetCheckeds('Path');
  for Cont := 0 to Paths.Count - 1 do
  begin
    TGit.Pull(Paths[Cont]);
  end;
end;

procedure TWindowMain.ActAddExecute(Sender: TObject);
var
  Cont: integer;
  Paths: TStringList;
begin
  Paths := TDAO.GetCheckeds('Path');
  for Cont := 0 to Paths.Count - 1 do
  begin
    TGit.Add(Paths[Cont]);
  end;
end;

procedure TWindowMain.ActCommitExecute(Sender: TObject);
var
  Cont: integer;
  Names, Paths, Msgs: TStringList;
begin
  Names := TDAO.GetCheckeds('Name');
  Paths := TDAO.GetCheckeds('Path');
  Msgs := TDAO.GetCheckeds('Msg');

  for Cont := 0 to Paths.Count - 1 do
  begin
    if Trim(Msgs[Cont]) = '' then
    begin
      ShowMessage('Digite uma mensagem de commit para o reposit�rio ' + Names[Cont]);
    end
    else
    begin
      TGit.Commit(Paths[Cont], Msgs[Cont]);
    end;
  end;
end;

procedure TWindowMain.ActCheckoutExecute(Sender: TObject);
var
  Cont: integer;
  Paths: TStringList;
begin
  Paths := TDAO.GetCheckeds('Path');
  for Cont := 0 to Paths.Count - 1 do
  begin
    TGit.Checkout(Paths[Cont]);
  end;
end;

procedure TWindowMain.ActPushExecute(Sender: TObject);
var
  Cont: integer;
  Paths: TStringList;
begin
  Paths := TDAO.GetCheckeds('Path');
  for Cont := 0 to Paths.Count - 1 do
  begin
    TGit.Push(Paths[Cont]);
  end;
end;

//OTHERS

procedure TWindowMain.CheckAllClick(Sender: TObject);
begin
  TDAO.SelectAll(CheckAll.Checked);
end;

procedure TWindowMain.CheckSelectClick(Sender: TObject);
begin
  if Active then
  begin
    GridRepositories.SetFocus;
  end;
end;

procedure TWindowMain.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowMain.UpdateButtons;
begin
  if TDAO.Count <= 0 then
  begin
    ActEdit.Enabled := false;
    ActDel.Enabled := false;
    ActStatus.Enabled := false;
    ActPull.Enabled := false;
    ActAdd.Enabled := false;
    ActCommit.Enabled := false;
    ActCheckout.Enabled := false;
    ActPush.Enabled := false;
  end
  else
  begin
    ActEdit.Enabled := true;
    ActDel.Enabled := true;
    ActStatus.Enabled := true;
    ActPull.Enabled := true;
    ActAdd.Enabled := true;
    ActCommit.Enabled := true;
    ActCheckout.Enabled := true;
    ActPush.Enabled := true;
  end;
end;

end.
