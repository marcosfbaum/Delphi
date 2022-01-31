unit uPeople;

interface

uses
  System.Classes, System.SysUtils,
  uAddress;

type
  TPeople = class(TPersistent)
  private
    FName: string;
    FAge: Integer;
    FAddress: TAddress;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function AgeStr: string;
    procedure Assign(const aSource: TPeople); overload;
  published
    property Name: string read FName write FName;
    property Age: Integer read FAge write FAge;
    property Address: TAddress read FAddress write FAddress;
  end;

implementation

{ TPeople }

procedure TPeople.Assign(const aSource: TPeople);
begin
  if not Assigned(aSource) then
    inherited Assign(aSource);

  FName := aSource.Name;
  FAge  := aSource.Age;
  FAddress.Assign(aSource.Address)
end;

constructor TPeople.Create(AOwner: TComponent);
begin
  inherited Create;
  FAddress := TAddress.Create(aowner);
end;

destructor TPeople.Destroy;
begin
  if Assigned(FAddress) then
    FAddress.Free;

  inherited;
end;

function TPeople.AgeStr(): string;
begin
  Result := IntToStr(Age);
end;

end.
