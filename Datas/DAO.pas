unit DAO;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.StrUtils, FireDAC.Comp.Client,
  Vcl.Forms, FireDAC.Stan.Intf, Vcl.Dialogs,
  Arrays, MyUtils, Datas;

type
  TDAO = class
  public
    class function Table: TFDMemTable;
    class procedure Load;
    class procedure Save;

    class function GetField(Field: string): variant;
    class procedure SetField(Field: string; Value: variant);

    class procedure Insert(Link, Path, Name: string);
    class procedure Edit(Link, Path, Name: string);
    class procedure Delete;

    class procedure SelectAll(Checked: boolean = true);
    class function GetCheckeds(Field: string): TStringList;
    class function ValueExists(Field: string; Value: Variant; ConsiderCurrent: boolean = true): boolean;

    class function Count: integer;
    class function GetIndex: integer;
    class procedure SetIndex(Index: integer);

    class procedure Refresh;
  end;

implementation

{ TDAO }

class function TDAO.Table: TFDMemTable;
begin
  Result := DataFactory.Table;
end;

class procedure TDAO.Load;
begin
  Table.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Repositories.json', sfJSON);

  Table.DisableControls;

  Table.First;
  while not Table.Eof do
  begin
    SetField(' ', false);
    SetField('Status', '');
    SetField('Msg', '');
    Table.Next;
  end;
  Table.First;

  Table.EnableControls;
end;

class procedure TDAO.Save;
var
  Index: integer;
begin
  Index := GetIndex;

  Table.DisableControls;

  Table.First;
  while not Table.Eof do
  begin
    SetField(' ', false);
    SetField('Status', '');
    SetField('Msg', '');
    Table.Next;
  end;

  Table.SaveToFile(ExtractFilePath(Application.ExeName) + 'Repositories.json', sfJSON);

  SetIndex(Index);

  Table.EnableControls;
end;

class function TDAO.GetField(Field: string): variant;
begin
  Result := Table.FieldByName(Field).AsVariant;
end;

class procedure TDAO.SetField(Field: string; Value: variant);
begin
  Table.Edit;
  Table.FieldByName(Field).AsVariant := Value;
  Table.Post;
end;

class procedure TDAO.Insert(Link, Path, Name: string);
begin
  Table.UpdateOptions.EnableInsert := true;
  Table.Insert;
  Table.FieldByName(' ').AsVariant := false;
  Table.FieldByName('Link').AsVariant := Link;
  Table.FieldByName('Path').AsVariant := Path;
  Table.FieldByName('Name').AsVariant := Name;
  Table.Post;
  Save;
  Table.UpdateOptions.EnableInsert := false;
end;

class procedure TDAO.Edit(Link, Path, Name: string);
begin
  Table.Edit;
  Table.FieldByName('Link').AsVariant := Link;
  Table.FieldByName('Path').AsVariant := Path;
  Table.FieldByName('Name').AsVariant := Name;
  Table.Post;
  Save;
end;

class procedure TDAO.Delete;
begin
  Table.Delete;
  Save;
end;

class procedure TDAO.SelectAll(Checked: boolean = true);
var
  Index: integer;
begin
  Index := GetIndex;

  Table.DisableControls;

  Table.First;

  while not Table.Eof do
  begin
    SetField(' ', Checked);
    Table.Next;
  end;

  SetIndex(Index);

  Table.EnableControls;
end;

class function TDAO.GetCheckeds(Field: string): TStringList;
var
  Index, Cont: integer;
begin
  Index := GetIndex;

  Result := TStringList.Create;

  Table.DisableControls;

  Table.First;
  while not Table.Eof do
  begin
    if GetField(' ') = true then
    begin
      Result.Add(GetField(Field));
    end;
    Table.Next;
  end;

  SetIndex(Index);

  Table.EnableControls;
end;

class function TDAO.ValueExists(Field: string; Value: Variant; ConsiderCurrent: boolean = true): boolean;
var
  Index, Cont: integer;
begin
  Index := GetIndex;

  Result := false;

  Table.DisableControls;

  Cont := 0;

  Table.First;

  while not Table.Eof do
  begin
    if ConsiderCurrent then
    begin
      Result := Result or (Table.FieldByName(Field).AsVariant = Value);
    end
    else
    begin
      if Cont <> Index then
      begin
        Result := Result or (Table.FieldByName(Field).AsVariant = Value);
      end;
    end;

    Inc(Cont, 1);
    Table.Next;
  end;

  SetIndex(Index);

  Table.EnableControls;
end;

class function TDAO.Count: integer;
begin
  Result := Table.RecordCount;
end;

class function TDAO.GetIndex: integer;
var
  Name: string;
begin
  Name := Table.FieldByName('Name').AsString;

  Result := 0;

  Table.DisableControls;

  Table.First;

  while not (Table.FieldByName('Name').AsString = Name) do
  begin
    Inc(Result, 1);
    Table.Next;
  end;

  Table.EnableControls;

end;

class procedure TDAO.SetIndex(Index: integer);
var
  Cont: integer;
begin
  Cont := 0;

  Table.DisableControls;

  Table.First;

  while Cont < Index do
  begin
    Inc(Cont, 1);
    Table.Next;
  end;

  Table.EnableControls;
end;

class procedure TDAO.Refresh;
begin
  Table.Refresh;
end;

end.
