unit MailUtils;

interface

uses
  Windows, SysUtils, Types, Classes, Graphics, OverByteIcsMimeUtils, ComObj, ShlObj, ActiveX;

// RF822
function RF822ToDateTime (RF822Date: String; Local: Bool):tDateTime;

// encryption
function StringEncrypt(const S: String; Key: DWord): string;
function StringDecrypt(const S: String; Key: DWord): string;
function Encrypt(password : string) : string;
function Decrypt(password : string) : string;
function Entity2String (text: string): string;
function String2Entity (text: string): string;

// Colors

function DarkColor(col : TColor) : Boolean;

// Shortcut

procedure CreateLink(const PathObj, PathLink, Desc, Param: string);

const
  C1 = 34419;
  C2 = 23602;
  
implementation

// Utils
// Convert RFC822 date string to DateTime structure
// Set Local to True to get local time, False to UTC time

function RF822ToDateTime (RF822Date: String; Local: Bool):tDateTime;
  {-Parse an Internet standard date time (RFC 822) into a LOCAL date time that
    can be used for computations in delphi.}
CONST
  monthes: String=('    JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC');
  DaysToMinutes = 24 * 60;
  MinutesToDays = 1 / DaysToMinutes;
VAR
  DayDigit, MonthName, YearDigit, Hour, Zone : String;
  DayNum,MonthNum,YearNum : Integer;
  //TempConvertStr : String;
  IX : Integer;
  REs : Integer;
  TZI : tTimezoneinformation;
  AdjustedBias : LongInt;
  TempDate, TempTime: tDateTime;
  sHourPart, sMinPart : String;
  iHourPart, iMinPart : Integer;
BEGIN
  // Remove the day of week if included
  if Pos(',',RF822Date) > 0 then Delete(RF822Date,1,Pos(',',RF822Date)+1);
  RF822Date := Trim(RF822Date); // Trim off any spaces
  DayDigit := Copy(RF822Date,1,Pos(' ',RF822Date)-1);  // Grab the Day of the month
  Delete(RF822Date,1,Pos(' ',RF822Date));
  MonthName := UpperCase(Copy(RF822Date,1,Pos(' ',RF822Date)-1)); // Grab the month
  MonthNum:=  Pos(MonthName, monthes) div 4 ;
  Delete(RF822Date,1,Pos(' ',RF822Date));
  YearDigit := Copy(RF822Date,1,Pos(' ',RF822Date)-1); // Grab the year
  Delete(RF822Date,1,Pos(' ',RF822Date));
  Hour := Copy(RF822Date,1,Pos(' ',RF822Date)-1); // Grab the time
  Delete(RF822Date,1,Pos(' ',RF822Date));

  DayNum := StrToInt(DayDigit);
  YearNum := STrToInt(YearDigit);
  TempDate := EncodeDate(YearNum,MonthNum,DayNum);  // encode to a tdatetime rec
  TempTime := StrToTime(Hour);  // convert the time string to a tdatetime rec
  Result := TempDate + TempTime; // return the combined date and time
  // Grab the timezone portion
  IX:= Pos(' ',RF822Date);
  If IX > 0 then Zone := Uppercase(Copy(RF822Date,1, IX-1)) else Zone := Uppercase(RF822Date);
  // Ecart local avec GMT en minutes
  RES := GetTimezoneINformation(TZI);
  AdjustedBias := tzi.Bias;
  // Heure d'hiver ou d'été
  if (res = 1) then // adjust if local is standard time
    AdjustedBias := AdjustedBias + tzi.StandardBias
  else if (Res = 2) then // adjust if local is daylight savings time
    AdjustedBias := AdjustedBias + tzi.DaylightBias;
  // On applique l'ajustement local
  if Local then Result:= Result- (AdjustedBias * MinutesToDays);
  //Zones horaires
  if (Zone = 'GMT') or (Zone = 'UT') or (Zone = 'Z') then // Adjust for GMT time
    RESULT := RESULT //-(AdjustedBias * MinutesToDays)
  else if (Zone = 'EDT') then // adjust for Eastern Daylight Savings -4 GMT
    RESULT := RESULT - (240 * MinutesToDays)
  else if (Zone = 'EST') or (Zone = 'CDT') then // Adjust for EST or CDT -5 GMT
    RESULT := RESULT - (300 * MinutesToDays)
  else if (Zone = 'CST') or (ZONE = 'MDT') then // Adjust for CST or MDT -6 GMT
    Result := REsult - (360 * MinutesToDays)
  else if (Zone = 'MST') or (Zone = 'PDT') then // Adjust for MST or PDT -7 GMT
    Result := Result - (420 * MinutesToDays)
  else if (Zone = 'PST') then // Adjust for PST -8 GMT
    Result := Result - (480 * MinutesToDays)
  else if (Zone = 'M') then // Adjust for -12 GMT
    Result := Result - (720 * MinutesToDays)
  else if (Zone = 'A') then // Adjust for -1 GMT
    Result := Result - (60 * MinutesToDays)
  else if (Zone = 'N') then // Adjust for +1 GMT
    Result := Result + (60 * MinutesToDays)
  else if (Zone = 'Y') then // Adjust for +12 GMT
    Result := Result + (720 * MinutesToDays)
  else if (Length(Zone)=5) and (Zone[1] in ['-','+']) then
    BEGIN
      sHourPart := Copy(Zone,2,2);
      sMinPart := Copy(Zone,4,2);
      iHourPart := StrToInt(sHourPart);
      iMinPart := StrToInt(sMinPart);
      if Zone[1] = '+' then
        Result := Result - (((iHourPart * 60)+iMinPart) * MInutesToDays)
      else
        Result := Result + (((iHourPart * 60)+iMinPart) * MInutesToDays);
    END;
END;

//------------------------------------------------------------------- base64 ---


// Encryption routines to hide  personal info in config files

function StringEncrypt(const S: String; Key: DWord): String;
var
  I: byte;
begin
  SetLength(Result,Length(S));
  for I := 1 to Length(S) do begin
     Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(Result[I]) + Key) * C1 + C2;
  end;
end;

function StringDecrypt(const S: String; Key: DWord): String;
var
  I: byte;
begin

  SetLength(Result,Length(S));
  for I := 1 to Length(S) do begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(S[I]) + Key) * C1 + C2;
  end;
end;

function Encrypt(password : string) : string;
begin
  password := StringEncrypt(password,14235);
  Result := Base64Encode(password);
end;

function Decrypt(password : string) : string;
begin
  password := Base64Decode(password);
  result := StringDecrypt(password,14235);
end;

function DarkColor(col : TColor) : Boolean;
begin
  Result:= False;
  if (col = clBlack) or (col = clMaroon) or (col = clGreen) or
     (col = clOlive) or (col = clNavy) or (col = clPurple) or
     (col = clTeal) or (col = clGray) or (col = clRed) or
     (col = clBlue) or (col = clFuchsia) or (col = clMedGray) or
     (col = $FF03FF) then //dark colors
  begin
    Result := True;
  end
  else begin
    if (col = clSilver) or (col = clLime) or (col = clYellow) or
       (col = clAqua) or  (col = clWhite) or (col = clMoneyGreen) or
       (col = clSkyBlue) or (col = clCream) or (col = $0000F900)   then // light colors
    begin
      Result := False
    end
  end;
end;

procedure CreateLink(const PathObj, PathLink, Desc, Param: string);
var
  IObject: IUnknown;
  SLink: IShellLink;
  PFile: IPersistFile;
begin
  IObject:=CreateComObject(CLSID_ShellLink);
  SLink:=IObject as IShellLink;
  PFile:=IObject as IPersistFile;
  with SLink do
  begin
    SetArguments(PChar(Param));
    SetDescription(PChar(Desc));
    SetPath(PChar(PathObj));
  end;
  PFile.Save(PWChar(WideString(PathLink)), FALSE);
end;

// Convert XML entities to characters

function Entity2String (text: string): string;
var
  s: string;
begin
  s:= StringReplace(text, '&lt;', '<',[rfReplaceAll]);
  s:= StringReplace(s, '&gt;', '>', [rfReplaceAll]);
  s:= StringReplace(s, '&apos;', chr(39), [rfReplaceAll]);
  s:= StringReplace(s, '&quot;', '"', [rfReplaceAll]);
  result:= StringReplace(s, '&amp;', '&', [rfReplaceAll]);
end;

// Convert special characters to XML entities

function String2Entity (text: string): string;
var
  s: string;
begin
  s:= StringReplace(text, '&', '&amp;', [rfReplaceAll]);
  s:= StringReplace(s, '"', '&quot;', [rfReplaceAll]);
  s:= StringReplace(s, chr(39), '&apos;', [rfReplaceAll]);
  s:= StringReplace(s, '<', '&lt;', [rfReplaceAll]);
  result:= StringReplace(s, '>', '&gt;', [rfReplaceAll]);
end;

end.
