unit uEntityAttributes;

interface

{$M+}

type
  TableName = class(TCustomAttribute)
    private
      FName: String;
    public
      constructor Create(const aName: string);
    published
      property Name: String read FName write FName;
  end;

type
  KeyField = class(TCustomAttribute)
    private
      FName: String;
    public
      constructor Create(const aName: string);
    published
      property Name: String read FName write FName;
  end;

type
  FieldName = class(TCustomAttribute)
    private
      FName: String;
    public
      constructor Create(const aName: string);
    published
      property Name: String read FName write FName;
  end;

{$M-}

implementation

{ FieldName }

constructor FieldName.Create(const aName: string);
begin
  FName := aName;
end;

{ KeyField }

constructor KeyField.Create(const aName: string);
begin
  FName := aName;
end;

{ TableName }

constructor TableName.Create(const aName: string);
begin
  FName := aName;
end;

end.
