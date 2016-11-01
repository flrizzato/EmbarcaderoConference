unit uMongoDataSetPersonal;

interface

uses
  FireDAC.Phys.MongoDBWrapper, FireDAC.Phys.MongoDBDataSet, System.Classes, UMongoCursor;

  type
    TMongoDataSetPersonal = class(TFDMongoDataSet)
    private
    FAtivarCursor: Boolean;
    Focrs: TMongoCursor;
    procedure setAtivarCursor(const Value: Boolean);
    published
         property ocrs : TMongoCursor read Focrs write Focrs;
         property AtivarCursor : Boolean read FAtivarCursor write setAtivarCursor;
    end;

     procedure Register;

implementation

procedure Register;
  begin
    RegisterComponents('Mongo Components', [TMongoDataSetPersonal]);
  end;

{ TMongoDataSetPersonal }

procedure TMongoDataSetPersonal.setAtivarCursor(const Value: Boolean);
begin
  FAtivarCursor := Value;
  if FAtivarCursor then
  begin
    Self.Focrs.Active := true;
    Self.Cursor := Self.Focrs.Cursor;
  end;
end;

end.
