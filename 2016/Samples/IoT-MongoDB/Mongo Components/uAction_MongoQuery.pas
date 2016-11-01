unit uAction_MongoQuery;

interface

uses
  FMX.ActnList, System.Actions, System.SysUtils, uMongoQuery, FMX.Forms, FMX.Layouts, FMX.Dialogs;

type
  TMongoInsert = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoUpdate = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoDelete = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoSelect = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;

type
  TMongoSelectEdit = class(TAction)
  private
    FMongoQuery : TMongoQuery;
    FLayout : TLayout;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  published
    property MongoQuery : TMongoQuery read FMongoQuery write FMongoQuery;
    property Layout : TLayout read FLayout write FLayout;
  end;


  procedure Register;

implementation

{TMongoInsert}

procedure TMongoInsert.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.InserirLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoInsert.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoInsert.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoUpdate}

procedure TMongoUpdate.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.UpdateLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoUpdate.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoUpdate.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoDelete}

procedure TMongoDelete.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.DeleteLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;

end;

function TMongoDelete.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoDelete.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;


{TMongoSelect}

procedure TMongoSelect.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.SelectLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TMongoSelect.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoSelect.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

{TMongoSelectEdit}

procedure TMongoSelectEdit.ExecuteTarget(Target: TObject);
begin
  try
    MongoQuery.SelectEditLayout(FLayout);
  Except
    on E : Exception do
      ShowMessage(E.Message);
  end;
end;

function TMongoSelectEdit.HandlesTarget(Target: TObject): Boolean;
begin
  Result := true;
  if not Result then
    Enabled := False;
end;

procedure TMongoSelectEdit.UpdateTarget(Target: TObject);
begin
  Enabled := true;
end;

procedure Register;
begin
  RegisterActions('Mongo Components', [TMongoInsert,
                                       TMongoUpdate,
                                       TMongoDelete,
                                       TMongoSelect,
                                       TMongoSelectEdit],
                                       nil);
end;

end.


