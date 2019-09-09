unit ViewEditRepo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList,
  DAO;

type
  TWindowEditRepo = class(TForm)
    LblName: TLabel;
    LblPath: TLabel;
    LblLink: TLabel;
    TxtLink: TEdit;
    TxtPath: TEdit;
    TxtName: TEdit;
    BtnSave: TSpeedButton;
    BtnDiscard: TSpeedButton;
    BtnDBFile: TSpeedButton;
    Images: TImageList;
    Actions: TActionList;
    ActDBFile: TAction;
    ActSave: TAction;
    ActCancel: TAction;
    ActEsc: TAction;
    OpenFile: TFileOpenDialog;
    procedure ActDBFileExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActEscExecute(Sender: TObject);
    procedure ActDBFileHint(var HintStr: string; var CanShow: Boolean);
    procedure TxtChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    procedure Changed;
    procedure Done;
  end;

var
  WindowEditRepo: TWindowEditRepo;
  DidChange: boolean;

implementation

{$R *.dfm}

procedure TWindowEditRepo.FormActivate(Sender: TObject);
begin
  TxtLink.Text := TDAO.GetField('Link');
  TxtPath.Text := TDAO.GetField('Path');
  TxtName.Text := TDAO.GetField('Name');
end;

procedure TWindowEditRepo.ActDBFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TxtPath.Text := OpenFile.FileName;
  end;
end;

procedure TWindowEditRepo.ActDBFileHint(var HintStr: string; var CanShow: Boolean);
begin
  if OpenFile.FileName <> '' then
  begin
    HintStr := OpenFile.FileName;
  end;
end;

procedure TWindowEditRepo.ActSaveExecute(Sender: TObject);
begin
  TDAO.Insert(TxtLink.Text, TxtPath.Text, TxtName.Text);
end;

procedure TWindowEditRepo.ActCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowEditRepo.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowEditRepo.TxtChange(Sender: TObject);
var
  Link, Path, Name: boolean;
begin
  Changed;
end;

procedure TWindowEditRepo.Changed;
begin
  DidChange := true;
  ActSave.Enabled := true;
end;

procedure TWindowEditRepo.Done;
begin
  DidChange := false;
  ActSave.Enabled := false;
end;

end.