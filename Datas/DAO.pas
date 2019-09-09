unit DAO;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Variants, System.StrUtils, FireDAC.Comp.Client, Vcl.Forms,
  FireDAC.Stan.Intf,
  Datas;

type
  TDAO = class
  public
    class function Table: TFDMemTable;
    class procedure Load;
    class procedure Save;
    class function GetField(Name: string): variant;
    class procedure SetField(Name: string; Value: variant);
    class procedure Insert(Link, Path, Name: string);
    class procedure Delete(Name: string);
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
end;

class procedure TDAO.Save;
begin
  Table.SaveToFile(ExtractFilePath(Application.ExeName) + 'Repositories.json', sfJSON);
end;

class function TDAO.GetField(Name: string): variant;
begin
  Result := Table.FieldByName(Name).AsVariant;
end;

class procedure TDAO.SetField(Name: string; Value: variant);
begin
  Table.Edit;
  Table.FieldByName(Name).AsVariant := Value;
  Table.Post;
end;

class procedure TDAO.Insert(Link, Path, Name: string);
begin
  Table.Insert;
  Table.FieldByName(' ').AsVariant := false;
  Table.FieldByName('Link').AsVariant := Link;
  Table.FieldByName('Path').AsVariant := Path;
  Table.FieldByName('Name').AsVariant := Name;
  Table.Post;
  Save;
end;

class procedure TDAO.Delete(Name: string);
begin
  Table.FieldByName('Name').AsString := Name;
end;

end.