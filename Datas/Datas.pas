unit Datas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON, FireDAC.Phys.SQLiteVDataSet,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TDataFactory = class(TDataModule)
    JSON: TFDStanStorageJSONLink;
    Table: TFDMemTable;
    TableBooleanField: TBooleanField;
    TableLink: TStringField;
    TablePath: TStringField;
    TableName: TStringField;
    TableMsg: TStringField;
    TableLastAct: TStringField;
  end;

var
  DataFactory: TDataFactory;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
