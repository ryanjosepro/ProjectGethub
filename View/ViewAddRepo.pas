unit ViewAddRepo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList,
  DAO;

type
  TWindowAddRepo = class(TForm)
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
    ActAdd: TAction;
    ActCancel: TAction;
    ActEsc: TAction;
    OpenFile: TFileOpenDialog;
    procedure ActDBFileExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActEscExecute(Sender: TObject);
    procedure ActDBFileHint(var HintStr: string; var CanShow: Boolean);
    procedure TxtChange(Sender: TObject);
  end;

var
  WindowAddRepo: TWindowAddRepo;

implementation

{$R *.dfm}

procedure TWindowAddRepo.ActDBFileExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin
    TxtPath.Text := OpenFile.FileName;
  end;
end;

procedure TWindowAddRepo.ActDBFileHint(var HintStr: string; var CanShow: Boolean);
begin
  if OpenFile.FileName <> '' then
  begin
    HintStr := OpenFile.FileName;
  end;
end;

procedure TWindowAddRepo.ActAddExecute(Sender: TObject);
begin
  TDAO.Insert(TxtLink.Text, TxtPath.Text, TxtName.Text);
end;

procedure TWindowAddRepo.ActCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowAddRepo.ActEscExecute(Sender: TObject);
begin
  Close;
end;

procedure TWindowAddRepo.TxtChange(Sender: TObject);
var
  Link, Path, Name: boolean;
begin
  Link := Trim(TxtLink.Text) <> '';
  Path := Trim(TxtPath.Text) <> '';
  Name := Trim(TxtName.Text) <> '';
  ActAdd.Enabled := Link and Path and Name;
end;

end.