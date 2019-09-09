unit Datas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON;

type
  TDataFactory = class(TDataModule)
    Table: TFDMemTable;
    TableCheck: TBooleanField;
    TableLink: TStringField;
    TablePath: TStringField;
    TableName: TStringField;
    TableStatus: TStringField;
    TableMsg: TStringField;
    JSON: TFDStanStorageJSONLink;
  end;

var
  DataFactory: TDataFactory;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.