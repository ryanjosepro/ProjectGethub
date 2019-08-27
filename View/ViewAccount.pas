unit ViewAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, System.Actions, Vcl.ActnList;

type
  TWindowAccount = class(TForm)
    Image1: TImage;
    LblEmail: TLabel;
    LblName: TLabel;
    BtnDBFile: TSpeedButton;
    TxtLink: TEdit;
    TxtPath: TEdit;
    BtnSave: TSpeedButton;
    BtnDiscard: TSpeedButton;
    Actions: TActionList;
    ActDiscard: TAction;
    ActEsc: TAction;
    ActSave: TAction;
    procedure ActEscExecute(Sender: TObject);
    procedure ActSaveExecute(Sender: TObject);
    procedure ActDiscardExecute(Sender: TObject);
  end;

var
  WindowAccount: TWindowAccount;

implementation

{$R *.dfm}

procedure TWindowAccount.ActSaveExecute(Sender: TObject);
begin
  //
end;

procedure TWindowAccount.ActDiscardExecute(Sender: TObject);
begin
  //
end;

procedure TWindowAccount.ActEscExecute(Sender: TObject);
begin
  Close;
end;

end.
