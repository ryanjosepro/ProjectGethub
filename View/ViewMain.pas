unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  MyUtils, Data.DB, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, Vcl.DBCtrls;

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
    ProgressBar1: TProgressBar;
    Table: TFDMemTable;
    GridRepositories: TDBGrid;
    CheckSelect: TDBCheckBox;
    Source: TDataSource;
    TableCheck: TBooleanField;
    TableNome: TStringField;
    TableStatus: TStringField;
    TableMsg: TStringField;
    TablePath: TStringField;
    procedure ActConfigAccountExecute(Sender: TObject);
    procedure ActAddRepositoryExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActDelExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure ActCommitExecute(Sender: TObject);
    procedure ActCheckoutExecute(Sender: TObject);
    procedure ActPushExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridRepositoriesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure GridRepositoriesColExit(Sender: TObject);
    procedure GridRepositoriesKeyPress(Sender: TObject; var Key: Char);
  private
    procedure AddRepository(Name, Path: string);
  public
    { Public declarations }
  end;

var
  WindowMain: TWindowMain;

implementation

{$R *.dfm}

procedure TWindowMain.FormActivate(Sender: TObject);
begin
  AddRepository('ProjectBooklin', 'C:\Users\Ryan\Documents\Delphi Projects\ProjectBooklin');
  AddRepository('ProjectGethub', 'C:\Users\Ryan\Documents\Delphi Projects\ProjectGethub');
  AddRepository('ProjectMigrator', 'C:\Users\Ryan\Documents\Delphi Projects\ProjectMigrator');
  AddRepository('ProjectReport', 'C:\Users\Ryan\Documents\Delphi Projects\ProjectReport');
end;

procedure TWindowMain.GridRepositoriesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  IsChecked : array[Boolean] of Integer =(DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  if (gdFocused in State) then
  begin
    //if (Column.Field.FieldName = CheckSelect.DataField) then
    //begin
      CheckSelect.Left := 12 {Rect.Left} + GridRepositories.Left + 2;
      CheckSelect.Top := Rect.Top + GridRepositories.top + 2;
      CheckSelect.Width := 15 {Rect.Right - Rect.Left};
      CheckSelect.Height := Rect.Bottom - Rect.Top;
      CheckSelect.Visible := True;
    //end;
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
    CheckSelect.Visible := False
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

procedure TWindowMain.ActConfigAccountExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActAddRepositoryExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActEditExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActDelExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActAddExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActCommitExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActCheckoutExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActPushExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.AddRepository(Name, Path: string);
begin
  Table.Insert;
  TableCheck.AsBoolean := false;
  TableNome.AsString := Name;
  TablePath.AsString := Path;
  TableStatus.AsString := '';
  TableMsg.AsString := '';
  Table.Post;
end;

end.
