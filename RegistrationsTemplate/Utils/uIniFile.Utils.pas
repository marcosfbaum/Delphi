unit uIniFile.Utils;

interface

uses
  System.IniFiles, System.SysUtils,
  Vcl.Forms;

type
  TIniFileUtils = class
    class procedure Write(const aFileName, aSection, aIdent, aValue: string; aDefault: string= '');
    class function Read(const aFileName, aSection, aIdent: string; aDefault: string = ''): string;
  end;

implementation

{ TIniFileUtils }

class function TIniFileUtils.Read(const aFileName, aSection, aIdent: string; aDefault: string): string;
var
  aIni: TIniFile;
begin
  Result := aDefault;

  aIni := TIniFile.Create(Concat(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)), aFileName));
  try
    if aIni.SectionExists(aSection) then
      Result := aIni.ReadString(aSection, aIdent, aDefault);
  finally
    aIni.Free;
  end;
end;

class procedure TIniFileUtils.Write(const aFileName, aSection, aIdent, aValue: string; aDefault: string);
var
  aIni: TIniFile;
begin
  aIni := TIniFile.Create(Concat(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)), aFileName));
  try
    if (not (aValue.Trim.IsEmpty)) then
      aIni.WriteString(aSection, aIdent, aValue)
    else
      aIni.WriteString(aSection, aIdent, aDefault);
  finally
    aIni.Free;
  end;
end;

end.
