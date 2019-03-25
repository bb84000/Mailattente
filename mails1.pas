// Liste de mails pour le Porgramme MailAttente
// BB95 - Mars 2011

unit mails1;

interface

uses Windows, Dialogs, Messages, SysUtils, Graphics, Classes, OverbyteIcsPop3Prot, OverbyteIcsMimeUtils, ExtCtrls,
JanXMLParser2,  MailUtils;

Type
  // Liste de messages

  TChampsCompare = (cdcNone, cdcAccountName, cdcAccountIndex, cdcMessageNum, cdcMessageSize, cdcMessageUIDL,
                        cdcMessageFrom, cdcMessageTo, cdcMessageSubject, cdcMessageDate, cdcMessageContentType);
  PMail = ^TMail;
  TMail = Record
    AccountName : string;
    AccountIndex: Integer;
    MessageNum: Integer;
    MessageSize: Integer;
    MessageUIDL : string;
    MessageFrom : String;
    FromAddress : String;
    MessageTo : String;
    MessageSubject : String;
    MessageDate : TDateTime;
    MessageContentType: String;
    MessageNew: Boolean;
    MessageToDelete: Boolean;
  end;

 TMailList = class(TList)
  private
    FOnChange: TNotifyEvent;
    FSortType: TChampsCompare;
  public
    Duplicates : TDuplicates;
    procedure Delete (const i : Integer);
    procedure DeleteMulti (j, k : Integer);
    procedure Reset;
    procedure AddMail(Mail : TMail);
    procedure ModifyMail (const i: integer; Mail : TMail);
    function GetItem(const i: Integer): TMail;
    function LoadXML(FileName: String): Integer;
    procedure SaveXML(FileName: String);
    procedure DoSort;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    Property SortType : TChampsCompare read FSortType write FSortType default cdcNone;

  end;

  // Liste de comptes

  PAccount = ^TAccount;
  TAccount= record
     Enabled: Boolean;
     AccountName: String;
     AccountIndex: Integer;
     Protocol: Integer;  // 1=POP3
     Color: TColor;
     MailClient: String;
     Sound: string;
     Interval: Integer;
     LastFire: TDateTime;
     NextFire: TDateTime;
     POP3Cli: TSslPOP3Cli;
     Email: string;
     ReplyEmail: string;
     Timer: TTimer;
     UIDLList: TstringList;
     UIDLToDel: TstringList;
     MsgToDel: TstringList;
     MailList: TMailList;
     LastMessage: String;
     Error: Bool;
     NewMails: Integer;
     Pending: Bool;
     Log: TstringList;
     Elapsed: Integer;
     MsgCount: Integer;
  end;


  TAccountList = class(TList)
  private
    FOnChange: TNotifyEvent;
    FSortType: TChampsCompare;

  public
    Duplicates : TDuplicates;
    function AddAccount(Account : TAccount): Integer;
    procedure Delete (const i : Integer);
    procedure DeleteMulti (j, k : Integer);
    procedure Reset;
    procedure CreateAccountObj (var Account : TAccount);
    procedure FreeAccountObj (var Account : TAccount);
    procedure ModifyAccount (const i: integer; Account : TAccount);
    procedure UpdateAccount (const i: integer; Account : TAccount);
    function GetItem(const i: Integer): TAccount;
    function GetIntAttribute(var inode: TjanXMLNode2; attribute: String) : Integer;

    function LoadXML(FileName: String): Integer;
    procedure SaveXML(FileName: String);
    procedure DoSort;
    procedure Free;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    Property SortType : TChampsCompare read FSortType write FSortType default cdcNone;  
  end;

function CompareMultiM(Item1, Item2: Pointer): Integer;
function CompareMultiA(Item1, Item2: Pointer): Integer;

var
  ClesTri: array[0..10] of TChampsCompare;

implementation

function stringCompare(Item1, Item2: String): Integer;
begin

  result := Comparestr(Item1, Item2);
end;

function NumericCompare(Item1, Item2: Double): Integer;
begin
  if Item1 > Item2 then result := 1
  else
  if Item1 = Item2 then result := 0
  else result := -1;
end;

function CompareMultiM(Item1, Item2: Pointer): Integer;
var
 Entry1, Entry2: PMail;
 R, J: integer;
 ResComp: array[TChampsCompare] of integer;
begin
 Entry1:= PMail(Item1);
 Entry2:= PMail(Item2);
 ResComp[cdcNone]  := 0;
 ResComp[cdcAccountName]  := StringCompare(Entry1^.AccountName, Entry2^.AccountName);
 ResComp[cdcAccountIndex]:= NumericCompare(Entry1.AccountIndex, Entry2.AccountIndex);
 ResComp[cdcMessageNum]:= NumericCompare(Entry1.MessageNum, Entry2.MessageNum);
 ResComp[cdcMessageSize]:= NumericCompare(Entry1.MessageSize, Entry2.MessageSize);
 ResComp[cdcMessageUIDL]:= StringCompare(Entry1^.MessageUIDL, Entry2^.MessageUIDL);
 ResComp[cdcMessageFrom]:= StringCompare(Entry1^.MessageFrom, Entry2^.MessageFrom);
 ResComp[cdcMessageTo]:= StringCompare(Entry1^.MessageTo, Entry2^.MessageTo);
 ResComp[cdcMessageSubject] := StringCompare(Entry1^.MessageSubject, Entry2^.MessageSubject);
 ResComp[cdcMessageDate]:= NumericCompare(Entry1^.MessageDate, Entry2^.MessageDate);
 ResComp[cdcMessageContentType]:=  StringCompare(Entry1^.MessageContentType, Entry2^.MessageContentType);
 R := 0;
 for J := 0 to 10 do
 begin
   if ResComp[ClesTri[J]] <> 0 then
    begin
      R := ResComp[ClesTri[J]];
      break;
    end;
 end;
 result :=  R;
end;

function CompareMultiA(Item1, Item2: Pointer): Integer;
var
 Entry1, Entry2: PAccount;
 R, J: integer;
 ResComp: array[TChampsCompare] of integer;
begin
 Entry1:= PAccount(Item1);
 Entry2:= PAccount(Item2);
 ResComp[cdcNone]  := 0;
 ResComp[cdcAccountName]  := StringCompare(Entry1^.AccountName, Entry2^.AccountName);
 ResComp[cdcAccountIndex]:= NumericCompare(Entry1.AccountIndex, Entry2.AccountIndex);
 R := 0;
 for J := 0 to 2 do
 begin
   if ResComp[ClesTri[J]] <> 0 then
    begin
      R := ResComp[ClesTri[J]];
      break;
    end;
 end;
 result :=  R;
end;

procedure TMailList.DoSort;
begin
  if FSortType <> cdcNone then
  begin
    ClesTri[1] := FSortType;
    //ClesTri[2] := cdcName;
    //ClesTri[3] := cdcDur;
    sort(comparemultiM);
  end;
end;

procedure TMailList.AddMail(Mail : TMail);
var
 K: PMail;
begin
  new(K);
  K^.AccountName := Mail.AccountName;
  K^.AccountIndex:= Mail.AccountIndex;
  K^.MessageNum  := Mail.MessageNum;
  K^.MessageSize := Mail.MessageSize;
  K^.MessageUIDL := Mail.MessageUIDL;
  K^.MessageFrom := Mail.MessageFrom;
  K^.FromAddress := Mail.FromAddress;
  K^.MessageTo   := Mail.MessageTo;
  K^.MessageSubject := Mail.MessageSubject;
  K^.Messagedate := Mail.Messagedate;
  K^.MessageContentType:= Mail.MessageContentType;
  K^.MessageNew  := Mail.MessageNew;
  K^.MessageToDelete:= Mail.MessageToDelete;
  add(K);
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TMailList.ModifyMail (const i: integer; Mail : TMail);
begin
  TMail(Items[i]^).AccountName := Mail.AccountName;
  TMail(Items[i]^).AccountIndex:= Mail.AccountIndex;
  TMail(Items[i]^).MessageNum  := Mail.MessageNum;
  TMail(Items[i]^).MessageSize := Mail.MessageSize;
  TMail(Items[i]^).MessageUIDL := Mail.MessageUIDL;
  TMail(Items[i]^).MessageFrom := Mail.MessageFrom;
  TMail(Items[i]^).FromAddress := Mail.FromAddress;
  TMail(Items[i]^).MessageTo   := Mail.MessageTo;
  TMail(Items[i]^).MessageSubject := Mail.MessageSubject;
  TMail(Items[i]^).Messagedate := Mail.Messagedate;
  TMail(Items[i]^).MessageContentType:= Mail.MessageContentType;
  TMail(Items[i]^).MessageNew  := Mail.MessageNew;
  TMail(Items[i]^).MessageToDelete:= Mail.MessageToDelete;
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;


function TMailList.LoadXML(FileName: String): Integer;
Const
  Bools: String=('     False True');
var
  MailXML: TjanXMLParser2;
  iNode : TjanXMLNode2;
  i: Integer;
  index: Integer;
  NewMail: TMail;
begin
  Reset;
  Result:= 0;
  MailXML:= TjanXMLParser2.create;
  if not FileExists (FileName) then exit;
  MailXML.LoadXML (FileName);
  iNode := MailXML.FirstChild;
  i:= 0;
  while iNode <> nil do
  begin
    NewMail.AccountName:= Entity2String(iNode.Attribute['accountname']);
    NewMail.AccountIndex:= StrToInt(iNode.Attribute['accountindex']);
    NewMail.MessageNum:= StrToInt(iNode.Attribute['messagenum']);
    NewMail.MessageSize:= StrToInt(iNode.Attribute['messagesize']);
    NewMail.MessageUIDL:= iNode.Attribute['messageUIDL'];
    NewMail.MessageFrom:= Entity2String(iNode.Attribute['messagefrom']);
    NewMail.FromAddress:= iNode.Attribute['fromaddress'];
    NewMail.MessageTo:= Entity2String(iNode.Attribute['messageto']);
    NewMail.MessageSubject:= Entity2String(iNode.Attribute['messagesubject']);
    NewMail.MessageDate:= StrToDateTime(iNode.Attribute['messagedate']);
    NewMail.MessageContentType:= Entity2String(iNode.Attribute['messagecontenttype']);
    NewMail.MessageNew:= Boolean(Pos(iNode.Attribute['messagenew'], Bools) div 6 -1);
    NewMail.MessageToDelete:= Boolean(Pos(iNode.Attribute['messagetodelete'], Bools) div 6 -1);   
    AddMail(NewMail);
    Inc(i) ;
    iNode := iNode.NextSibling;
    //if Assigned(FOnChange) then FOnChange(Self);
  end;
  MailXML.Free;
  Result:= Count;
end;



procedure TMailList.SaveXML(FileName: String);
const
  sBool: array [0..1] of string = ('False', 'True');

var
  MailXML: TjanXMLParser2;
  iNode : TjanXMLNode2;
  i: Integer;
  s, FilNamWoExt: String;
begin
  MailXML:= TjanXMLParser2.create;
  MailXML.xml:= '';
  MailXML.name:= 'mails';
  For i:= 0 to Count-1 do
  begin
    iNode:= TjanXMLNode2.create;
    iNode.name:= 'mail';
    //ShowMessage(IntToStr());
    iNode.Attribute ['accountname']:= String2Entity(GetItem(i).AccountName);
    iNode.Attribute ['accountindex']:= IntToStr(GetItem(i).AccountIndex);
    iNode.Attribute ['messagenum']:= IntToStr(GetItem(i).MessageNum);
    iNode.Attribute ['messagesize']:= IntToStr(GetItem(i).MessageSize);
    iNode.Attribute ['messageUIDL']:= GetItem(i).MessageUIDL;
    iNode.Attribute ['messagefrom']:= String2Entity(GetItem(i).MessageFrom);
    iNode.Attribute ['fromaddress']:= GetItem(i).FromAddress;
    iNode.Attribute ['messageto']:= String2Entity(GetItem(i).MessageTo);
    iNode.Attribute ['messagesubject']:= String2Entity(GetItem(i).MessageSubject);
    iNode.Attribute ['messagedate']:= DateTimeToStr(GetItem(i).MessageDate);
    iNode.Attribute ['messagecontenttype']:= String2Entity(GetItem(i).MessageContentType);
    iNode.Attribute ['messagenew']:= sBool[Integer(GetItem(i).MessageNew)];
    iNode.Attribute ['messagetodelete']:= sBool[Integer(GetItem(i).MessageToDelete)]; 
    MailXML.addNode (iNode);
  end;
  if FileExists (FileName)
    then  DeleteFile(FileName);
    // Et on sauvegarde la nouvelle liste

  MailXML.SaveXML (FileName);
  MailXML.Free;
end;


procedure TMailList.Delete(const i: Integer);
begin
inherited delete(i);
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TMailList.DeleteMulti(j, k : Integer);
var
  i : Integer;
begin
  // On commence par le dernier, ajouter des sécurités
  For i:= k downto j do
  begin
     inherited delete(i);
  end;
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TMailList.GetItem(const i: Integer): TMail;
begin
 Result := TMail(Items[i]^);
end;

procedure TMailList.Reset;
var
 i: Integer;
begin
 for i := 0 to Count-1 do
  if Items[i] <> nil then Dispose(Items[i]);
 Clear;
end;


// TAccountList

procedure TAccountList.CreateAccountObj(var Account : TAccount);
begin
    // Crée timer, pop3 et stringlist
  Account.Timer:= TTimer.Create(nil);
  Account.POP3Cli:= TSslpop3cli.Create (nil);
  //Account.POP3Cli.SslContext:= TSslContext.Create;
  Account.UIDLList:= TstringList.Create;
  Account.UIDLToDel:= TstringList.Create;
  Account.MsgToDel:= TstringList.Create;
  Account.Log:= TstringList.Create;
  Account.MailList:= TMailList.Create;

end;

function TAccountList.GetIntAttribute(var inode: TjanXMLNode2; attribute: String) : Integer ;
begin
try
 result:= StrToInt(iNode.Attribute[attribute]);
except
result:= 0;
end;
end;


function TAccountList.LoadXML(FileName: String): Integer;
Const
  Bools: String=('     False True');
  Prots: String=('    POP3 IMAP');
var
  AccXML: TjanXMLParser2;
  iNode : TjanXMLNode2;
  i: Integer;
  index: Integer;
  NewAcc: TAccount;
begin
  Reset;
  Result:= 0;
  AccXML:= TjanXMLParser2.create;
  if not FileExists (FileName) then exit;
  AccXML.LoadXML (FileName);

  iNode := AccXML.FirstChild;
  i:= 0;
  while iNode <> nil do
  begin
    NewAcc.Enabled := Boolean(Pos(iNode.Attribute['enabled'], Bools) div 6 -1);
    NewAcc.AccountName:= iNode.Attribute['accountname'];
    NewAcc.AccountIndex:= i;
    NewAcc.Protocol:= Pos(iNode.Attribute['protocol'], Prots)div 5;  // POP3
    if length(iNode.Attribute['color']) > 0 then
    NewAcc.Color:=  StrToInt('$'+iNode.Attribute['color']);
    NewAcc.MailClient:= iNode.Attribute['mailclient'];
    NewAcc.Sound:= iNode.Attribute['sound'];
    NewAcc.Interval:= GetIntAttribute(iNode, 'interval');
    NewAcc.Pending:= False;
    Index:= AddAccount(NewAcc);
    // propriétés du client POP3
    TAccount(Items[Index]^).POP3Cli.Host:= iNode.Attribute['host'];
    TAccount(Items[Index]^).POP3Cli.Port:= iNode.Attribute['port'];
    TAccount(Items[Index]^).POP3Cli.UserName:= iNode.Attribute['username'];
    TAccount(Items[Index]^).POP3Cli.PassWord:= Decrypt(iNode.Attribute['password']);
    TAccount(Items[Index]^).POP3Cli.AuthType:= TPop3AuthType(StrToInt(iNode.Attribute['auth'])); //popAuthLogin;
    TAccount(Items[Index]^).POP3Cli.SslType:= TPop3SslType(GetIntAttribute(iNode, 'ssltype'));
    TAccount(Items[Index]^).POP3Cli.Tag:= i;
    TAccount(Items[Index]^).POP3Cli.Name:= 'POP3Cli'+IntToStr(i);
    TAccount(Items[Index]^).POP3Cli.MultiThreaded:= True;
    TAccount(Items[Index]^).Email:= iNode.Attribute['email'];
    TAccount(Items[Index]^).ReplyEmail:= iNode.Attribute['replyemail'];
    // Propriétés du timer
    TAccount(Items[Index]^).Timer.Tag:= i;
    TAccount(Items[Index]^).Timer.Name:= 'Timer'+IntToStr(i);
    TAccount(Items[Index]^).Timer.Interval:= 1000;
    TAccount(Items[Index]^).Timer.Enabled:= False;     
    Inc(i) ;
    iNode := iNode.NextSibling;
    //if Assigned(FOnChange) then FOnChange(Self);
  end;
  AccXML.Free;
  Result:= Count;
end;

procedure TAccountList.SaveXML(FileName: String);
const
  sBool: array [0..1] of string = ('False', 'True');
  sProtocol: array [1..2] of string = ('POP3', 'IMAP');
var
  AccXML: TjanXMLParser2;
  iNode : TjanXMLNode2;
  i: Integer;
  s, FilNamWoExt: String;
begin
  AccXML:= TjanXMLParser2.create;
  AccXML.xml:= '';
  AccXML.name:= 'accounts';
  //ShowMessage(IntToStr(AccountsCount));
  For i:= 0 to Count-1 do
  begin
    iNode:= TjanXMLNode2.create;
    iNode.name:= 'account';
    //ShowMessage(IntToStr());
    iNode.Attribute ['enabled']:= sBool[Integer(GetItem(i).enabled)];
    iNode.Attribute ['accountname']:= GetItem(i).AccountName;
    iNode.Attribute ['accountindex']:= IntToStr(GetItem(i).AccountIndex);
    iNode.Attribute ['host']:= GetItem(i).POP3Cli.Host;
    iNode.Attribute ['port']:= GetItem(i).POP3Cli.Port;
    iNode.Attribute ['protocol']:= sProtocol[GetItem(i).Protocol];
    iNode.Attribute ['username']:= GetItem(i).POP3Cli.UserName ;
    iNode.Attribute ['password']:= Encrypt(GetItem(i).POP3Cli.PassWord) ;
    iNode.Attribute ['auth']:= IntToStr(ord(GetItem(i).POP3Cli.AuthType));
    iNode.Attribute ['ssltype']:= IntToStr(ord(GetItem(i).POP3Cli.SslType));
    iNode.Attribute ['color']:= IntToHex(GetItem(i).Color, 8);
    iNode.Attribute ['mailclient']:= GetItem(i).MailClient;
    iNode.Attribute ['sound']:= GetItem(i).Sound;
    iNode.Attribute ['interval']:= IntToStr(GetItem(i).Interval);
    iNode.Attribute ['email']:= GetItem(i).Email;
    iNode.Attribute ['replyemail']:= GetItem(i).ReplyEmail;

    AccXML.addNode (iNode);
  end;
  // Si nécessaire on fait des sauvegardes
  s:= ExtractFileExt(FileName);
  FilNamWoExt:= Copy (FileName, 1, length(FileName)-length(s));
  if FileExists (FilNamWoExt+'.bk5')                   // Efface la plus ancienne
    then  DeleteFile(FilNamWoExt+'.bk5');                // si elle existe
    For i:= 4 downto 0
    do if FileExists (FilNamWoExt+'.bk'+IntToStr(i))     // Renomme les précédentes si elles existent
       then  RenameFile(FilNamWoExt+'.bk'+IntToStr(i), FilNamWoExt+'.bk'+IntToStr(i+1));
    if FileExists (FileName)
    then  RenameFile(FileName, FilNamWoExt+'.bk0');
    // Et on sauvegarde la nouvelle liste

  AccXML.SaveXML (FileName);
  AccXML.Free;
end;

procedure TAccountList.FreeAccountObj(var Account : TAccount);
begin
  Account.Timer.OnTimer:= nil;
  FreeAndNil(Account.Timer);
  //FreeAndNil(Account.POP3Cli.SslContext);
  FreeAndNil(Account.POP3Cli);
  FreeAndNil(Account.UIDLList);
  FreeAndNil(Account.MsgToDel);
  FreeAndNil(Account.Log);
  FreeAndNil(Account.MailList);
  FreeAndNil(Account.UIDLToDel);
end;

function TAccountList.AddAccount(Account : TAccount): Integer;
var
 K: PAccount;
begin
  new(K);
  K^.Enabled := Account.Enabled;
  K^.AccountName:= Account.AccountName;
  K^.AccountIndex:= Account.AccountIndex;
  //K^.Server:= Account.Server;
  K^.Protocol:= Account.Protocol;  // 1=POP3
  //K^.Port:= Account.Port;
  //K^.UserName:= Account.UserName;
  //K^.Password:= Account.Password;
  K^.Color:= Account.Color;
  K^.MailClient:= Account.MailClient;
  K^.Sound:= Account.Sound;
  K^.Interval:= Account.Interval;
  K^.NextFire:= Account.NextFire;
  K^.LastFire:= Account.LastFire;
  K^.POP3Cli:= Account.POP3Cli;
  K^.Email:= Account.Email;
  K^.ReplyEmail:= Account.ReplyEmail;
  K^.Timer:= Account.Timer;
  K^.UIDLList:= Account.UIDLList;
  K^.UIDLToDel:= Account.UIDLToDel;
  K^.MsgToDel:= Account.MsgToDel;
  K^.MailList:= Account.MailList;
  K^.LastMessage:= Account.LastMessage;
  K^.Error:= Account.Error;
  K^.NewMails:= Account.NewMails;
  K^.Pending:= Account.Pending;
  K^.Log:= Account.Log;
  K^.Elapsed:= Account.Elapsed;
  K^.MsgCount:= Account.MsgCount;
  result:= add(K);
  // Le nouveau compte a le rang Count-1 avant tri
  CreateAccountObj(TAccount(Items[result]^));
  //DoSort;
  if Assigned(FOnChange) then FOnChange(Self);

end;

procedure TAccountList.Delete(const i: Integer);
begin
  FreeAccountObj(TAccount(Items[i]^));
  inherited delete(i);
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TAccountLIst.DeleteMulti(j, k : Integer);
var
  i : Integer;
begin
  // On commence par le dernier, ajouter des sécurités
  For i:= k downto j do
  begin
     inherited delete(i);
  end;
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TAccountList.Free;
begin
  Reset;
  inherited Free;
end;

procedure TAccountList.Reset;
var
 i: Integer;
begin
 for i := 0 to Count-1 do
  if Items[i] <> nil then
  begin
    // on libère le timer et le pop3
    TAccount(Items[i]^).Timer.OnTimer:= nil;
    FreeAndNil(TAccount(Items[i]^).Timer);
    FreeAndNil(TAccount(Items[i]^).POP3Cli);
    FreeAndNil(TAccount(Items[Count-1]^).UIDLList);
    FreeAndNil(TAccount(Items[Count-1]^).UIDLToDel);
    FreeAndNil(TAccount(Items[Count-1]^).Log);

    Dispose(Items[i]);
  end;
 Clear;
end;

// met à jour les champs "ordinaires" sans toucher au timer et autres

procedure TAccountList.UpdateAccount (const i: integer; Account : TAccount);
begin
  TAccount(Items[i]^).Enabled := Account.Enabled;
  TAccount(Items[i]^).AccountName:= Account.AccountName;
  TAccount(Items[i]^).AccountIndex:= Account.AccountIndex;
  TAccount(Items[i]^).Protocol:= Account.Protocol;  // 1=POP3
  TAccount(Items[i]^).Color:= Account.Color;
  TAccount(Items[i]^).MailClient:= Account.MailClient;
  TAccount(Items[i]^).Sound:= Account.Sound;
  TAccount(Items[i]^).Interval:= Account.Interval;
  TAccount(Items[i]^).NextFire:= Account.NextFire;
  TAccount(Items[i]^).LastFire:= Account.LastFire;
  TAccount(Items[i]^).Email:= Account.Email;
  TAccount(Items[i]^).ReplyEmail:= Account.ReplyEmail;
  //TAccount(Items[i]^).POP3Cli:= Account.POP3Cli;
  //TAccount(Items[i]^).Timer:= Account.Timer;
  //TAccount(Items[i]^).UIDLList.Text:= Account.UIDLList.Text;
  //TAccount(Items[i]^).MailList:= Account.MailList;
  TAccount(Items[i]^).LastMessage:= Account.LastMessage;
  TAccount(Items[i]^).Error:= Account.Error;
  TAccount(Items[i]^).NewMails:= Account.NewMails;
  TAccount(Items[i]^).Pending:= Account.Pending;
  //TAccount(Items[i]^).Log:= Account.Log;
  TAccount(Items[i]^).MsgCount:= Account.MsgCount;
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TAccountList.ModifyAccount (const i: integer; Account : TAccount);
begin
  // On libère le timer et le pop3 du compte
  FreeAccountObj(TAccount(Items[i]^));
  TAccount(Items[i]^).Enabled := Account.Enabled;
  TAccount(Items[i]^).AccountName:= Account.AccountName;
  TAccount(Items[i]^).AccountIndex:= Account.AccountIndex;
  TAccount(Items[i]^).Protocol:= Account.Protocol;  // 1=POP3
  TAccount(Items[i]^).Color:= Account.Color;
  TAccount(Items[i]^).MailClient:= Account.MailClient;
  TAccount(Items[i]^).Sound:= Account.Sound;
  TAccount(Items[i]^).Interval:= Account.Interval;
  TAccount(Items[i]^).NextFire:= Account.NextFire;
  TAccount(Items[i]^).POP3Cli:= Account.POP3Cli;
  TAccount(Items[i]^).Email:= Account.Email;
  TAccount(Items[i]^).ReplyEmail:= Account.ReplyEmail;
  TAccount(Items[i]^).Timer:= Account.Timer;
  TAccount(Items[i]^).UIDLList:= Account.UIDLList;
  TAccount(Items[i]^).UIDLToDel:= Account.UIDLToDel;
  TAccount(Items[i]^).MsgToDel:= Account.MsgToDel;
  TAccount(Items[i]^).MailList:= Account.MailList;
  TAccount(Items[i]^).LastMessage:= Account.LastMessage;
  TAccount(Items[i]^).Error:= Account.Error;
  TAccount(Items[i]^).NewMails:= Account.NewMails;
  TAccount(Items[i]^).Pending:= Account.Pending;
  TAccount(Items[i]^).Log:= Account.Log;

  TAccount(Items[i]^).Elapsed:= Account.Elapsed;
  TAccount(Items[i]^).MsgCount:= Account.MsgCount;
  // Crée timer et pop3
  CreateAccountObj(TAccount(Items[i]^));
  DoSort;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TAccountList.GetItem(const i: Integer): TAccount;
begin
 Result := TAccount(Items[i]^);
end;




procedure TAccountList.DoSort;
begin
  if FSortType <> cdcNone then
  begin
    ClesTri[1] := FSortType;
    //ClesTri[2] := cdcName;
    //ClesTri[3] := cdcDur;
    sort(comparemultiA);
  end;
end;

end.

