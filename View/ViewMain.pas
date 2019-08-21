unit ViewMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  MyUtils, Data.DB, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient;

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
    GridRepositories: TStringGrid;
    OpenFile: TFileOpenDialog;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    procedure ActConfigAccountExecute(Sender: TObject);
    procedure ActAddRepositoryExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActDelExecute(Sender: TObject);
    procedure ActAddExecute(Sender: TObject);
    procedure ActCommitExecute(Sender: TObject);
    procedure ActCheckoutExecute(Sender: TObject);
    procedure ActPushExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
  AddRepository('GetHub', 'C:\Users\Ryan\Documents\Delphi Projects\ProjectGethub');
end;

procedure TWindowMain.ActConfigAccountExecute(Sender: TObject);
begin
  //
end;

procedure TWindowMain.ActAddRepositoryExecute(Sender: TObject);
begin
  if OpenFile.Execute then
  begin

  end;
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
  GridRepositories.RowCount := GridRepositories.RowCount + TUtils.Iif(GridRepositories.RowCount = 1, 0, 1);

  GridRepositories.Rows[GridRepositories.RowCount - 1].Add(Name);
end;

end.
