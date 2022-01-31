unit uAddress;

interface

uses
  System.Classes;

type
  TAddress = class(TPersistent)
  private
    FStreet: String;
    FNumber: string;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(aSource: TAddress); overload;
  published
    property Street: String read FStreet write FStreet;
    property Number: string read FNumber write FNumber;
  end;

implementation

{ TAddress }

procedure TAddress.Assign(aSource: TAddress);
begin
  if not Assigned(aSource) then
    inherited Assign(aSource);

  FStreet := aSource.Street;
  FNumber := aSource.Number;
end;

constructor TAddress.Create(AOwner: TComponent);
begin
  inherited Create;
end;

destructor TAddress.Destroy;
begin
  inherited;
end;

end.
