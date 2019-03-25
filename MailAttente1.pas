// MailAttente routine principale


unit MailAttente1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,     
  Dialogs, Grids, ComCtrls, ExtCtrls, StdCtrls, Buttons, ImgList, JustOne,
  OverbyteIcsWndControl, OverbyteIcsPop3Prot, OverbyteIcsWSocket, JvTrayIconN,
  WinVer, Menus,  OverbyteIcsSmtpProt, MMSystem, 
  OverbyteIcsMimeDec, OverbyteIcsCharsetUtils, OverbyteIcsMimeUtils, Mails1,
  ShFolder, janXMLParser2, Registry, MailUtils, ComObj,
  bbUtils, VerResU, IniFiles, shellApi, OverbyteIcsHttpProt,
  Ctrl_sup, ChkNewVer, VistaAltFixUnit, ScrollButtons, BitBtnScroll;


 const
   WM_INFO_UPDATE = WM_USER + 101;
   WP_NewVersion = 15;
   
 type
   // Define the classes in this Unit at the very start for clarity
   TFMailAtt = Class;

  // TrayIcon properties record used to update or restore tray icon when explorer crashes
  TrayIconProps = record
     PrActive: Boolean;
     PrAnimated: Boolean;
     PrDelay: Integer;
     PrDropDownMenu: TPopupMenu;
     PrHint: String;
     PrIcon: TIcon;
     PrIconIndex: Integer;
     PrIcons: TCustomImageList;
     PrName: String;
     PrPopupMenu: TPopupMenu;
     PrSnap: Boolean;
     PrTag: Integer;
     PrVisibility: TTrayVisibilities;
     EvOnAnimate: TAnimateEvent;
     EvOnBalloonClick: TNotifyEvent;
     EvOnBalloonHide: TNotifyEvent;
     EvOnBalloonShow: TNotifyEvent;
     EvOnClick: TMouseEvent;
     EvOnContextPopup: TContextPopupEvent;
     EvOnDblClick: TMouseEvent;
     EvOnMinimizeToTray: TNotifyEvent;
     EvOnMouseMove: TMouseMoveEvent;
     EvOnMouseDown: TMouseEvent;
     EvOnMouseUp: TMouseEvent;
  end;

  TFMailAtt = class(TForm)
    Status: TStatusBar;
    Timerg: TTimer;
    PopupMenu1: TPopupMenu;
    PMnuInfo: TMenuItem;
    XJustOne1: TXJustOne;
    PanelRight: TPanel;
    LVMail: TlistView;
    MainMenu: TMainMenu;
    MnuMessages: TMenuItem;
    MnuPrefs: TMenuItem;
    MnuHelp: TMenuItem;
    PanelBottom: TPanel;
    SbMnuAccounts: TMenuItem;
    PanelLeft: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    MnuGetAll: TMenuItem;
    MnuFiles: TMenuItem;
    MnuImport: TMenuItem;
    SbMnuImportOExpress: TMenuItem;
    SbMnuImportIAF: TMenuItem;
    OD1: TOpenDialog;
    WinVersion1: TWinVersion;
    SbMnuImportOEAcc: TMenuItem;
    MnuTray: TPopupMenu;
    PTrayMnuRestore: TMenuItem;
    PTrayMnuMinimize: TMenuItem;
    MnuQuit: TMenuItem;
    PTrayMnuMaximize: TMenuItem;
    PTrayMnuQuit: TMenuItem;
    N1: TMenuItem;
    MnuGetCurrent: TMenuItem;
    ImgTrayPendMail: TImageList;
    ImgAccount: TImageList;
    ImgMsg: TImageList;
    BtnGetAll: TBitBtn;
    BtnLaunchClient: TBitBtn;
    PTrayMnuGetAll: TMenuItem;
    N2: TMenuItem;
    SbMnuImportOutlook: TMenuItem;
    SbMenuOptions: TMenuItem;
    SbMnuImportWLM: TMenuItem;
    SbMnuImportWMail: TMenuItem;
    SslContext1: TSslContext;
    PTrayMnuLaunchClient: TMenuItem;
    N3: TMenuItem;
    MnuLaunchClient: TMenuItem;
    N4: TMenuItem;
    PTrayMnuGetCurrent: TMenuItem;
    MnuDeleteMsg: TMenuItem;
    PTrayMnuAbout: TMenuItem;
    N5: TMenuItem;
    MnuUpdateCheck: TMenuItem;
    MnuAbout: TMenuItem;
    SbMnuHelp: TMenuItem;
    PMnuAnswer: TMenuItem;
    N6: TMenuItem;
    PanelBottomLeft: TPanel;
    GBInfo: TGroupBox;
    LAccountName: TLabel;
    PanelTopLeft: TPanel;
    GBAccounts: TGroupBox;
    LVAccounts: TListView;
    VistaAltFix1: TVistaAltFix;
    MnuClose: TMenuItem;
    BtnShowLog: TBtnScroll;
    BtnGetCurrent: TBtnScroll;
    TrayMailAtt: TJvTrayIconN;
    procedure Pop3CliDisplay(Sender: TObject; const Msg: String);
    procedure Pop3CliRequestDone(Sender: TObject; RqType: TPop3Request;
      Error: Word);
    //procedure Pop3CliMessageEnd(Sender: TObject);
    procedure Pop3Cli1StateChange(Sender: TObject);
    procedure Pop3CliSessionClosed(Sender: TObject; ErrCode: Word);
    procedure Pop3CliSslHandshakeDone(Sender: TObject; ErrCode: Word;
      PeerCert: TX509Base; var Disconnect: Boolean);
    procedure Pop3CliSslVerifyPeer(Sender: TObject; var Ok: Integer;
      Cert: TX509Base);

    procedure FormCreate(Sender: TObject);
    procedure PMnuInfoClick(Sender: TObject);
    procedure LVMailMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TimerTimer(Sender: TObject);
    procedure BtnGetAllClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SbMnuAccountsClick(Sender: TObject);
    procedure SbMnuImportClick(Sender: TObject);
    procedure LVAccountsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PTrayMnuRestoreClick(Sender: TObject);
    procedure PTrayMnuMinimizeClick(Sender: TObject);
    procedure TrayMailAttMinimizeToTray(Sender: TObject);
    //procedure k(Sender: TObject);
    procedure PTrayMnuMaximizeClick(Sender: TObject);
    procedure TrayMailAttDblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnGetCurrentClick(Sender: TObject);
    procedure TimergTimer(Sender: TObject);
    procedure MnuAboutClick(Sender: TObject);
    procedure BtnLaunchClientClick(Sender: TObject);
    procedure SbMenuOptionsClick(Sender: TObject);
    procedure MnuDeleteMsgClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MnuUpdateCheckClick(Sender: TObject);
    procedure SbMnuHelpClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PMnuAnswerClick(Sender: TObject);
    procedure BtnShowClick(Sender: TObject);
    procedure PanelBottomLeftResize(Sender: TObject);
    procedure PTrayMnuQuitClick(Sender: TObject);
    procedure TrayMailAttCreateTaskBar(Sender: TObject);
   // procedure MnuQuitClick(Sender: TObject);
  private
    { Déclarations privées }
    //TrayMailAtt: TJvTrayIconN;
    MouseMsgIndex: Integer;
    WM_TASKBAR_CREATED: DWORD;
    TrayProps: TrayIconProps;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure CreateTrayIcon(properties: TrayIconProps);
    procedure LoadTrayIconProps(properties: TrayIconProps);
    procedure ReadTrayIconProps(var properties: TrayIconProps);

  public
    { Déclarations publiques }
    MailAccounts: TAccountList;
    Appdata, UserProfile, ProgramFiles, ProgramFilesX86, MailAppsData, MyDocs: string;
    //Local
    LastError: String;
    AccountsFile, ConfigFile, StartUpFile: String;
    WLMStoreRoot: String;
    WMailStoreRoot: String;
    First: Bool;
    StartupCheck, SequentialCheck, Pending: Boolean;
    //Reg: TRegistry;
    DefMailClient, CommonMailClient, CommonSound: string;
    GetNext: Bool;
    langue: Integer;
    LangStr: string;
    LangFile: TiniFile;
    LangNums: TStringList;
    CurLang: Integer;
    ABoutBoxCaption, BtnGetCurrentCaption, SelectCaption, version: string;
    ImportIAFCaption, ImportOEAccCaption: string;
    AccountCaption, FromCaption, ToCaption, SubjectCaption, DateCaption, SizeCaption, ByteCaption: string;
    NextCheckCaption, SessionClosedCaption, NewMessagesCaption: String;
    AccountsSetup, AccountsImport: string;
    AccountBusy, CannotModify, CannotDelete: string;
    MnuDeleteMsgCaption, MnuRestoreMsgCaption, MnuDeleteSelMsgCaption: String;
    NoNewMail, DeleteMessages, DeleteMessagesBox: string;
    connecting, Authenticating, SendingUserName, SendingPassword, CountingMessages, ListingMessages, LastMessage: string;
    RetrievingUIDLs, NoMailFound, RetrievingHeaders, GotMessages, DeletingMessage, CurrChecking: string;
    RetrievingCompleted, AbortTimeout : string;
    MailFound, NoAccountFound, FileReadErr, AddedAccount, ChangedAccount, DeletedAccount, LogCreated : string;
    ConnectionError, AuthenticatingError : string;
    MailClientFile, SoundFile: string;
    SelectMailClient, SelectSound: string;
    MailToMissing: string;//ShutDown: Boolean;
    StartWin, StartMini, SavSizePos, SaveLogs, MailClientMini, RestNewMsg, SmoothScroll, WNotif : Boolean;
    WState, UpdateURL, ChkVerURL, UpdateCaption: string;
    NoChkNewVer: Boolean;
    LastUpdChk: TDateTime;
    UpdateAvailable: string;
    NoLongerChkUpdates, LastUpdateSearch : string;
    //FTempScroll: string;
    LabelScroll:TLabelScroll;
    AccountLogCaption: string;
    SelAccount: Integer;
    EmailAddress, ReplyEmailAddress, LastChkCaption, NextChkCaption : string;
    UpdateOnce: Bool;
    procedure WndProc(var Msg: TMessage); override;
    procedure GetMail(Index: Integer);
    procedure PopulateMsgList(Index: Integer);
    procedure PopulateAccountsList(LV : TlistView; Accs: TAccountList);
    function ImportIAF(FileName: string): TAccount;
    function ImportOEAccount (FileName: String) : TAccount;
    procedure ImportOutlook (var Accounts: TAccountList; Prog: String);
    procedure ImportWLM(var Accounts: TAccountList; StoreRoot: string);
    procedure UpdateAccountsList(LV : TlistView; Accs: TAccountList);
    procedure SetAccountEvents(index: Integer);
    procedure GetButtonsEnable (Enable: Bool);
    procedure DrawTheIcon(Bmp: TBitmap; NewCount: integer; CircleColor: TColor);
    procedure FillUIDLList (index: Integer);
    procedure LoadConfig;
    function SaveConfig: Bool;
    procedure OptionsResult(mr: integer);  // Actions après préférences options
    function AccountsResult(mr: integer): Integer; // Actions après préférences comptes
    procedure InitAboutBox;
    procedure ModLangue;
    procedure DeleteMessage(index: integer);
    procedure AddAccountsMenu;
    procedure ChangeMailClient(filename: string);
//    procedure WriteDbg (s: String);
    procedure ChkVersion;
   function ShowAlert(Title, AlertStr, StReplace,  NoShow: String; var Alert: Boolean): Boolean;
    procedure RetrieveUIDL(var Account: TAccount);
    procedure SetConfigParam(var XML: TjanXMLParser2; param, attr, text: string);
    procedure SetWState;
    function GetWState: string;
  end;

const
    SHGFP_TYPE_CURRENT = 0;
    SHGFP_TYPE_DEFAULT = 1;
    CSIDL_PROFILE = $0028;
    CSIDL_PROGRAM_FILESX86 = $002A;
    
var
  FMailAtt: TFMailAtt;
  //  win: hwnd;
const
  sBool: array [0..1] of string = ('False', 'True');
  sProtocol: array [1..2] of string = ('POP3', 'IMAP');

implementation

uses about, log1, Prefs1, Accounts1, Alert;

{$R *.dfm}

// Traitement des messages Windows (menu système, fin de session, forme de recherche de mise à jour)

procedure TFMailAtt.WndProc(var Msg: TMessage);
var
  index: Integer;
  CurVer, NewVer: Int64;
  s: string;

begin
// Explorer cashed and restarted, need to reload tray
 if Msg.Msg = WM_TASKBAR_CREATED then
  begin
     ReadTrayIconProps(TrayProps);
     Application.ProcessMessages;
     CreateTrayIcon(TrayProps);
     Msg.Result:= 1;
  end; 
  // Message de demande de fermeture de session
  // On sauvegarde la config
  if Msg.Msg = WM_QUERYENDSESSION then
  begin
    if MailAccounts.Count > 0 then
    For index:= 0 to MailAccounts.Count-1 do
    try
      MailAccounts.GetItem(index).log.SaveToFile(MailAppsData+'Account'+IntToStr(index)+'.log');
    except
    end;
    If SaveConfig then Msg.Result := 1;
    exit;
  end;
  // la forme de recherche de mise à jour a envoyé un message
  if Msg.Msg = WM_INFO_UPDATE then
    case msg.WParam of
      WP_NewVersion:
        begin
          s:= string(msg.lParam);
          if length(s) > 0 then
          begin
            If UpdateOnce then exit;
            UpdateOnce:= True;
            //version:= '0.8.0.0';    //Pour tester
            CurVer:= VersionToInt(version);
            NewVer:= VersionToInt(s);
            if NewVer > CurVer then
            begin
              AboutBox.LUpdate.Caption:= StringReplace(UpdateAvailable, '%s', s, [rfIgnoreCase]);

              if ShowAlert(Caption, UpdateAvailable, s, NoLongerChkUpdates, NoChkNewVer) then
              MnuAboutClick(self);
            end;
          end;
        end;
    end;
      // Messages du menu système
  if Msg.Msg = WM_SYSCOMMAND then
  begin
    case (msg.WParam  and $FFF0) of
      SC_CLOSE:
          begin
            PTrayMnuMinimizeClick(TObject(FMailAtt));  //Close;
            exit;
          end;
    end;
  end;
  inherited;
end;

// Intercepte les messages de l'application (en barre des tâches)
// Non traités par la routine précédente

procedure TFMailAtt.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
if (Msg.message = WM_SYSCOMMAND) then
  case (Msg.wParam and $FFF0) of
    SC_CLOSE   : begin
                   Msg.wParam:= 0;
                   PTrayMnuMinimizeClick(TObject(FMailAtt));
                 end;
    SC_MINIMIZE: begin
                   Msg.wParam:= 0;
                   PTrayMnuMinimizeClick(self);
                 end;
    SC_RESTORE : begin
                   Msg.wParam:= 0;
                   PTrayMnuRestoreClick(self);
                 end;
    SC_MAXIMIZE: begin
                   Msg.wParam:= 0;
                   PTrayMnuMaximizeClick(self);
                 end;

  end;
end;

// Comme on a besoin de recréer le tray icon en cas de craqsh de l'explorateur,
// on ne peut pas utiliser le composant en mode statique, on va le créer au runtime

procedure TFMailAtt.CreateTrayIcon(properties: TrayIconProps);
begin
  if Assigned(TrayMailAtt) then
  begin
    TrayMailAtt.Free;
    Application.ProcessMessages;
  end;
  TrayMailAtt:= TJvTrayIconN.Create(self);
  LoadTrayIconProps(TrayProps);
end;

// Sauvegarde des propriétés du trayicon

procedure TFMailAtt.ReadTrayIconProps(var properties: TrayIconProps);
begin
  With properties do
  begin
    PrActive:= TrayMailAtt.Active;
    PrAnimated:= TrayMailAtt.Animated;
    PrDelay:= TrayMailAtt.Delay;
    // As Icon property is created from external file at design time, it will be lost
    // if we free the component, so we need to duplicate it before.
    If not Assigned (TrayProps.PrIcon) then TrayProps.PrIcon:= TIcon.Create;
    PrIcon.Handle:= DuplicateIcon(0, TrayMailAtt.Icon.Handle);
    PrIconIndex:= TrayMailAtt.IconIndex;
    PrIcons:= TrayMailAtt.Icons;
    PrHint:= TrayMailAtt.Hint;
    PrPopupMenu:= TrayMailAtt.PopupMenu;
    PrVisibility:= TrayMailAtt.Visibility;
    EvOnDblClick:= TrayMailAtt.OnDblClick;
    EvOnMinimizeToTray:=  TrayMailAtt.OnMinimizeToTray;
  end;
end;

procedure TFMailAtt.LoadTrayIconProps(properties: TrayIconProps);
begin
  With properties do
  begin
    TrayMailAtt.Active:= PrActive;
    TrayMailAtt.Animated:= PrAnimated;
    TrayMailAtt.Delay:= PrDelay;
    TrayMailAtt.Icon:= PrIcon;
    TrayMailAtt.IconIndex:= PrIconIndex;
    TrayMailAtt.Icons:= PrIcons;
    TrayMailAtt.Hint:= PrHint;
    TrayMailAtt.PopupMenu:= PrPopupMenu;
    TrayMailAtt.Visibility:= PrVisibility;
    TrayMailAtt.OnDblClick:= EvOnDblClick;
    TrayMailAtt.OnMinimizeToTray:= EvOnMinimizeToTray;
  end;
end;

// Recherche de nouvelle version (utilise la forme FChkNewVer dans BBComp)

procedure TFMailAtt.ChkVersion;
begin
  //Dernière recherche il y a plus de 7 jours ?
  if (Trunc(Now) > LastUpdChk+7) and (not NoChkNewVer) then
  begin
    LastUpdChk:= Trunc(Now);
    FChkNewVer.GetLastVersion (ChkVerURL, 'mailattente', Handle);
  end;
end;


// Création de la forme

procedure TFMailAtt.FormCreate(Sender: TObject);
var
  FBuffer: array[0..MAX_PATH] of Char;
  MyKey: string;
  MyAccount: TAccount;
  i: Integer;
  Index: Integer;
  Reg: TRegistry;
begin
  Inherited;
  First:= True;
  //Obtain message value when task bar created
  WM_TASKBAR_CREATED:= RegisterWindowMessage('TaskBarCreated');
  // Boucle de messages de l'application
  Application.OnMessage := AppMessage;
  //win := handle;
  langue:= Lo(GetUserDefaultLangID);
  //langue:=  LANG_ITALIAN;
  If length(LangStr)= 0 then LangStr:= IntToStr(langue);
  // Chargement des chaînes de langue...
  LangFile:= TIniFile.create(ExtractFilePath(paramStr(0))+'MailAttente.lng');
  LangNums:= TStringList.Create;
  // Dossier application utilisateur
  SHGetFolderPath(0,CSIDL_APPDATA,0,SHGFP_TYPE_CURRENT,FBuffer) ;
  AppData:= string(FBuffer);             // Dossier  Application Data
  SHGetFolderPath(0,CSIDL_PROFILE,0,SHGFP_TYPE_CURRENT,FBuffer) ;
  UserProfile:= string(FBuffer);           // Dossier UserProfile
  SHGetFolderPath(0,CSIDL_PROGRAM_FILES,0,SHGFP_TYPE_CURRENT,FBuffer) ;
  ProgramFiles:= string(FBuffer);          // Dossier Program Files
  SHGetFolderPath(0,CSIDL_PROGRAM_FILESX86,0,SHGFP_TYPE_CURRENT,FBuffer) ;
  ProgramFilesX86:= string(FBuffer);          // Dossier Program Files (X86)
  SHGetFolderPath(0,CSIDL_PERSONAL,0,SHGFP_TYPE_CURRENT,FBuffer) ;
  MyDocs:= string(FBuffer);          // Dossier Mes Documents
  // Dossier data de MailAttente
  MailAppsData:= AppData+'\MailAttente\';
  if not DirectoryExists (MailAppsData) then
  begin
    CreateDir(MailAppsData);
  end;
  // Récupère le client mail par défaut
  Reg:= TRegistry.Create;
  // D'abord dans HKCU, sinon dans HKLM
  Reg.RootKey := HKEY_CURRENT_USER;
  MyKey:= 'Software\Clients\Mail';
  if Reg.KeyExists(MyKey) then
  begin
    Reg.OpenKeyReadOnly(MyKey);
    MyKey:= MyKey+'\'+ Reg.ReadString('')+'\shell\open\command';
    Reg.CloseKey;
    if not (Reg.KeyExists(MyKey)) then Reg.RootKey := HKEY_LOCAL_MACHINE;
  end else Reg.RootKey :=HKEY_LOCAL_MACHINE;
  MyKey:= 'Software\Clients\Mail';
  if Reg.KeyExists(MyKey) then
  begin
    Reg.OpenKeyReadOnly(MyKey);
    MyKey:= MyKey+'\'+ Reg.ReadString('')+'\shell\open\command';
    Reg.CloseKey;
    if Reg.KeyExists(MyKey) then
    begin
      Reg.OpenKeyReadOnly(MyKey);
      DefMailClient:= Reg.ReadString('');
      Reg.CloseKey;
    end;
  end;
  if length(DefMailClient) > 0 then
  begin
    // On retire les délimiteurs
    DefMailClient:= StringReplace(DefMailClient, '"', '', [rfReplaceAll]);
    // ON cherche la position de .exe
    i:= rPos('.EXE', uppercase(DefMailClient));
    if i > 0 then DefMailClient:= copy(DefMailClient, 1, i+3);
    // Chaînes d'environnement
    If Pos('%PROGRAMFILES%', uppercase(DefMailClient))> 0 
    then DefMailClient:= StringReplace(DefMailClient, '%ProgramFiles%', ProgramFiles, [rfIgnoreCase]);
    If Pos('%PROGRAMFILES(X86)%', uppercase(DefMailClient))> 0
    then DefMailClient:= StringReplace(DefMailClient, '%ProgramFiles(X86)%', ProgramFiles, [rfIgnoreCase]);
  end;
  CommonMailClient:= DefMailClient;
  Reg.Free;
  ConfigFile:= MailAppsData+'config.xml';
  AccountsFile:= MailAppsData+'accounts.xml';

  //Ouverture fichier des comptes
  MailAccounts:= TAccountList.Create;
  If FileExists(AccountsFile) then MailAccounts.LoadXML(AccountsFile);

  if (not FileExists(AccountsFile)) or (MailAccounts.count= 0) then 
  begin
    MyAccount.Enabled:= True;
    MyAccount.AccountName:= 'Sample';
    MyAccount.AccountIndex:= 0;
    MyAccount.Protocol:= 1;
    MyAccount.Color:= 0;
    MyAccount.MailClient:= DefMailClient;
    MyAccount.Sound:= '';
    MyAccount.Interval:= 0;
    Index:= MailAccounts.AddAccount(MyAccount);
    // propriétés du client POP3
    MailAccounts.GetItem(Index).POP3Cli.Host:= 'mail.server.com';
    MailAccounts.GetItem(Index).POP3Cli.Port:= '110';
    MailAccounts.GetItem(Index).POP3Cli.UserName:= 'user@server.com';
    MailAccounts.GetItem(Index).POP3Cli.Password:= 'Password';
    MailAccounts.GetItem(index).POP3Cli.Tag:= Index;
    MailAccounts.GetItem(index).POP3Cli.Name:= 'POP3Cli'+IntToStr(Index);
    MailAccounts.GetItem(index).POP3Cli.AuthType:= popAuthLogin;
    MailAccounts.GetItem(index).POP3Cli.SslType:= pop3TlsNone;
    MailAccounts.GetItem(index).POP3Cli.MultiThreaded:= True;
    // Propriétés du timer
    MailAccounts.GetItem(index).Timer.Tag:= Index;
    MailAccounts.GetItem(index).Timer.Name:= 'Timer'+IntToStr(Index);
    MailAccounts.GetItem(index).Timer.Interval:= 1000;
    MailAccounts.GetItem(index).Timer.Enabled:= True;
    MailAccounts.SaveXML(AccountsFile);
  end;
end;

//Activation de la forme

procedure TFMailAtt.FormActivate(Sender: TObject);
var
  Reg: TRegistry;
  LangFound: Bool;
  i, j: Integer;
  SysMenu: Hmenu;
  MenuItemInf: TMenuItemInfo;
  Buffer: array[0..255] of Char;
  r : Trect;
//  List: PPropList;
//   PropInfo: PPropInfo;
begin
  Inherited;
  GetNext:= False;
  if not First then exit;
  First:= False;
  // Uniquement au premier lancement !!

  // Ces personnalisations ne fonctionnent que lorsque tous les composants de l'application ont été créés
  // On récupère les noms du menu système pour le menu tray
  SysMenu:= GetSystemMenu (Handle, False);
  MenuItemInf.cbSize := SizeOf(MenuItemInf);
  MenuItemInf.fMask := MIIM_TYPE;
  MenuItemInf.dwTypeData := Buffer;
  MenuItemInf.cch := SizeOf(Buffer);
  GetMenuItemInfo(SysMenu,SC_MINIMIZE ,False, MenuItemInf);
  PTrayMnuMinimize.Caption:= Copy(Buffer, 1, MenuItemInf.cch);
  MenuItemInf.cch := SizeOf(Buffer);
  GetMenuItemInfo(SysMenu,SC_MAXIMIZE ,False, MenuItemInf);
  PTrayMnuMaximize.Caption:= Copy(Buffer, 1, MenuItemInf.cch);
  MenuItemInf.cch := SizeOf(Buffer);
  GetMenuItemInfo(SysMenu,SC_RESTORE ,False, MenuItemInf);
  PTrayMnuRestore.Caption:= Copy(Buffer, 1, MenuItemInf.cch);

  // Initialisation des menus du tray
  PTrayMnuMaximize.Enabled:= True;
  PTrayMnuMinimize.Enabled:= True;
  PTrayMnuRestore.Enabled:= False;
  // Boutons défilants graphiques par défaut
  SmoothScroll:= True;
  // premier compte par défaut
  SelAccount:= 0;
  // Chargement de la configuration
  If FileExists(ConfigFile) then LoadConfig else
  begin
    StartMini:= False;
    StartWin:= False;
    SaveConfig;
  end;
  //Récupère la taille du bureau pour éviter une mauvaise position de la fenêtre
  SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
  if Left < r.Left then Left:= r.left;
  if Top < r.Top then Top:= r.Top;
  if Width > r.Right-r.Left then Width:= r.Right-r.Left;
  if Height > r.Bottom-r.Top then Height:= r.Bottom-r.Top;
  // Icone client mail dans le bouton et les menus
  ChangeMailClient(DefMailClient);
  // Outlook express n'est pas installé après XP/2003, on désactive l'import Outlook express
  If WinVersion1.VerTyp  > 10 then SbMnuImportOExpress.Visible:= False;
  // Windows Mail seulement sur Vista
  Reg:= TRegistry.Create;
  SbMnuImportWMail.visible:= False;
  WMailStoreRoot:= '';
  If WinVersion1.VerTyp  =11 then
  begin
    Reg.RootKey:= HKEY_CURRENT_USER;
    if Reg.OpenKeyReadOnly('Software\Microsoft\Windows Mail') then
    try
      WMailStoreRoot:= Reg.ReadString('Store Root');
      WMailStoreRoot:= StringReplace(WMailStoreRoot,'%USERPROFILE%', UserProfile, [rfIgnoreCase]);
      SbMnuImportWMail.visible:= True;
     except
      SbMnuImportWMail.visible:= False;
    end;
    Reg.CloseKey;
  end;
  // Windows Live mail
  WLMStoreRoot:= '';
  Reg.RootKey:= HKEY_CURRENT_USER;
  if Reg.OpenKeyReadOnly('Software\Microsoft\Windows Live Mail') then
  try
    WLMStoreRoot:= Reg.ReadString('Store Root');
    WLMStoreRoot:= StringReplace(WLMStoreRoot,'%USERPROFILE%', UserProfile, [rfIgnoreCase]);
    SbMnuImportWLM.visible:= True;
  except
    SbMnuImportWLM.visible:= False;
    WLMStoreRoot:= '';
  end;
  FreeAndNil(Reg);
  Flog.RichEdit1.Clear;
  LVMail.Clear;
  PopulateAccountsList (LVAccounts, MailAccounts);

  AddAccountsMenu;
  // Détermination de la langue
  LangFound:= False;
  LangFile.ReadSections(LangNums);
  if LangNums.Count > 1 then
    For i:= 0 to LangNums.Count-1 do
    begin
      FPrefs.CBLangue.Items.Add (LangFile.ReadString(LangNums.Strings[i],'Language', 'Aucune'));
      If LangNums.Strings[i] = LangStr then LangFound:= True;
    end;
  // Si la langue n'est pas traduite, alors on passe en Anglais
  If not LangFound then
  begin
    langue:= LANG_ENGLISH;
    LangStr:= IntToStr(langue);
  end;
  CurLang:= LangNums.IndexOf(LangStr);
  Modlangue;
  InitAboutBox;
  ChkVersion;
  GetButtonsEnable (True);
  if SmoothScroll then
  begin
    BtnShowLog.ScrollGraph:= True;
    BtnShowLog.ScrollInterval:= 35;
    BtnGetCurrent.ScrollGraph:= True;
    BtnGetCurrent.ScrollInterval:= 35;
  end else
  begin
    BtnShowLog.ScrollGraph:= False;
    BtnShowLog.ScrollInterval:= 180;
    BtnGetCurrent.ScrollGraph:= False;
    BtnGetCurrent.ScrollInterval:= 180;
  end;
  // Assignation des événements et ouverture des fichiers log
  if MailAccounts.Count > 0 then
  for i:= 0 to MailAccounts.Count-1 do
  begin
    SetAccountEvents(i);
    // Vérification au démarrage ? si non, on ajoute l'intervalle à l'heure courante
    if not StartupCheck then
    TAccount(MailAccounts.Items[i]^).NextFire:= now+MailAccounts.GetItem(i).Interval/1440;
    //Charge courriers sauvegardés;
    if FileExists (MailAppsData+'Mail'+IntToStr(i)+'.xml') then
    begin
      MailAccounts.GetItem(i).MailList.LoadXML(MailAppsData+'Mail'+IntToStr(i)+'.xml');
      TAccount(MailAccounts.Items[i]^).MsgCount:= MailAccounts.GetItem(i).MailList.Count;
      if MailAccounts.GetItem(i).MailList.Count > 0 then
      begin
        for j:= 0 to  MailAccounts.GetItem(i).MailList.Count -1 do
        begin
          MailAccounts.GetItem(i).UIDLList.Add(MailAccounts.GetItem(i).MailList.GetItem(j).MessageUIDL)
        end;
      end;
      UpdateAccountsList(LVAccounts, MailAccounts);
    end;
  end;
  LVAccounts.ItemIndex:= SelAccount;
  LVAccountsSelectItem(Sender, LVAccounts.Items[SelAccount], True);
  LVAccounts.SetFocus;

  // Restaure taille et position précédentes
  if SavSizePos then SetWState;
  // On regarde si le programme a été lancé minimisé
  if (CompareText(ParamStr(1), 'MINI') = 0) and IsWindowVisible(handle) then
    PostMessage (handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
end;

// Change l'icone du mail client
procedure TFMailAtt.ChangeMailClient(filename: string);
var
  Image: TImage;
begin
  if length(filename) > 0 then
  begin
    Image:= TImage.Create(self);
    Image.Height := 16;
    Image.Width  := 16;
    Image.Transparent:= True;
    if DrawIconEx(Image.Canvas.Handle, 0, 0,
          ExtractIcon(handle,pchar(filename),0),  16, 16, 0, 0, DI_IMAGE) then
    begin
      BtnLaunchClient.Glyph.Assign (Image.Picture);
      PTrayMnuLaunchClient.Bitmap.Assign(Image.Picture  );
      MnuLaunchClient.Bitmap.Assign(Image.Picture  );
    end;
    FreeAndNil(Image);
  end;
end;

procedure TFMailAtt.SetWState;
var
  i: Integer;
begin
  Try
    WindowState:= TWindowState(StrToInt('$'+Copy(WState,1,4)));
    Top:= StrToInt('$'+Copy(WState,5,4));
    Left:= StrToInt('$'+Copy(WState,9,4));
    Height:= StrToInt('$'+Copy(WState,13,4));
    Width:= StrToInt('$'+Copy(WState,17,4)) ;
    PanelLeft.Width:= StrToInt('$'+Copy(WState,21,4)) ;
    For i:= 0 to 4 do LVMail.Columns[i].Width:= StrToInt('$'+Copy(WState,25+(i*4),4)) ;;
    if WNotif then PostMessage (handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
  except
  end;
end;

function TFMailAtt.GetWState: string;
var
  i: Integer;
  WinPos: array [0..10] of Integer;
begin
  Result:= '';
  // Windowstate jamains minimisé car interception de la routine
  // On utilise visible à la place
  WinPos[0]:=   LongInt(WindowState);
  if Top < 0 then WinPos[1]:= 0 else WinPos[1]:= Top;
  if Left < 0 then WinPos[2]:= 0 else WinPos[2]:= Left;
  WinPos[3]:= Height;
  WinPos[4]:= Width;
  WinPos[5]:= PanelLeft.Width;
  For i:= 0 to 4 do WinPos[i+6]:= LVMail.Columns[i].Width;
  For i:= 0 to 10 do Result:=Result+IntToHex(WinPos[i], 4);
end;



procedure TFMailAtt.LoadConfig;
var
  CfgXML: TjanXMLParser2;
  iNode: TjanXMLNode2;
  Reg: Tregistry;
  s: string;
  VersionInfo : TVerInfoObj;

begin
  VersionInfo:= TVerInfoObj.Create (hInstance);
  Version:= VersionInfo.Values ['FileVersion'];
  VersionInfo.Free;
  //version:= '0.8.0.0';
  UpdateUrl:= 'http://www.sdtp.com/versions/version.php?program=mailattente&version=';
  ChkVerURL:= 'http://www.sdtp.com/versions/versions.csv';

  CfgXML:= TjanXMLParser2.create;
  CfgXML.LoadXML(ConfigFile);
  iNode := CfgXML.FirstChild;
  s:= '';
  while iNode <> nil do
  try
    if UpperCase(iNode.name) = UpperCase('LastUpdChk') then LastUpdChk:= Str2Date(iNode.text,'yyyy/MM/dd');
    if UpperCase(iNode.name) = UpperCase('Version') then
    begin
      if VersionToInt(version) > VersionToInt(iNode.text) then LastUpdChk:= trunc(now());
    end;
    if UpperCase(iNode.name) = UpperCase('StartWin') then  StartWin:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('StartMini') then StartMini:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('SavSizePos') then SavSizePos:=Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('WState') then WState:= iNode.text;
    if UpperCase(iNode.name) = UpperCase('WNotif') then WNotif:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('SaveLogs') then SaveLogs:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('MailClientMini') then MailClientMini:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('RestNewMsg') then RestNewMsg:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('CommonMailClient') then CommonMailClient:= iNode.text;
    if UpperCase(iNode.name) = UpperCase('CommonSound') then CommonSound:= iNode.text;
    if UpperCase(iNode.name) = UpperCase('LangStr') then LangStr:= iNode.text;
    if UpperCase(iNode.name) = UpperCase('NoChkNewVer') then NoChkNewVer:= Bool(StrToInt(iNode.text));
    if UpperCase(iNode.name) = UpperCase('StartupCheck') then StartupCheck:= Bool(StrToInt(iNode.text));
    If UpperCase(iNode.name) = UpperCase('SequentialCheck') then SequentialCheck:= Bool(StrToInt(iNode.text));
    If UpperCase(iNode.name) = UpperCase('SmoothScroll') then SmoothScroll:= Bool(StrToInt(iNode.text));
    If UpperCase(iNode.name) = UpperCase('SelAccount') then SelAccount:= StrToInt(iNode.text);

  finally
    inode:=  inode.NextSibling;
  end;
  If length(CommonMailClient)= 0 then CommonMailClient:= DefMailClient;

  FreeAndNil(CfgXML);
  //On vérifie que ces valeurs sont bien dans le registre
  Reg:= TRegistry.Create;
  Reg.RootKey:= HKEY_CURRENT_USER;
  Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
  if StartMini then  s:= ' MINI' else s:= '' ;
  if StartWin  then  // Démarrage avec Windows coché
  begin
    if not Reg.ValueExists('MailAttente') then
    Reg.WriteString('MailAttente','"'+ParamStr(0)+'"'+s);
    Reg.CloseKey;
  end else if Reg.ValueExists('MailAttente') then
  begin
    Reg.DeleteValue('MailAttente');
    Reg.CloseKey;
  end;
  Reg.Free;   
end;

procedure TFMailAtt.SetConfigParam(var XML: TjanXMLParser2; param, attr, text: string);
var
  iNode: TjanXMLNode2;
begin
  iNode:= XML.getChildByName(param,True);
  if iNode = nil then
  begin
    iNode:= XML.addChildByName(param);
    iNode.attribute['type']:= attr;
  end;
  iNode.text:= text;
end;

function TFMailAtt.SaveConfig: Bool;
var
  CfgXML: TjanXMLParser2;
  Reg: Tregistry;
  s: string;
begin

  CfgXML:= TjanXMLParser2.create;
  if FileExists(ConfigFile) then CfgXML.LoadXML(ConfigFile);
  // Mauvais XML, on le vide
  if CfgXML.name<>'config' then CfgXML.xml:='';
  CfgXML.name:= 'config';
  // Version
  SetConfigParam(CfgXML, 'Version', 'String', Version);
  // Démarrage avec Windows
  SetConfigParam(CfgXML, 'StartWin', 'Bool', IntToStr(Integer(StartWin)));
  // Démarrage minimisé
  SetConfigParam(CfgXML, 'StartMini', 'Bool', IntToStr(Integer(StartMini)));
  // Sauvegarde Position et taille fenêtre
  SetConfigParam(CfgXML, 'SavSizePos','Bool', IntToStr(Integer(SavSizePos)));
  // Minimise quand on lance le client mail
  SetConfigParam(CfgXML, 'MailClientMini','Bool', IntToStr(Integer(MailClientMini)));
  // Restaure à l'arrivée de nouveaux messages
  SetConfigParam(CfgXML, 'RestNewMsg','Bool', IntToStr(Integer(RestNewMsg)));
  // Défilement des boutons
  SetConfigParam(CfgXML, 'SmoothScroll', 'Bool', IntToStr(Integer(SmoothScroll)));
  // Position fenêtre
  WState:= GetWState;
  SetConfigParam(CfgXML, 'WState','HexString', WState);
  WNotif:= not IsWindowVisible(Handle);
  SetConfigParam(CfgXML, 'WNotif','Bool', IntToStr(Integer(WNotif)));
  // On conserve les logs
  SetConfigParam(CfgXML, 'SaveLogs','Bool', IntToStr(Integer(SaveLogs)));
  // Mémorisation du client mail
  SetConfigParam(CfgXML, 'CommonMailClient','String', CommonMailClient);
  // Son nouveau message
  SetConfigParam(CfgXML, 'CommonSound','String', CommonSound);
  // Langue
  SetConfigParam(CfgXML, 'LangStr','String', LangStr);
  // Recherche de nouvelle version
  SetConfigParam(CfgXML, 'NoChkNewVer','Bool', IntToStr(Integer(NoChkNewVer)));
  // Dernière recherche de mise à jour
  SetConfigParam(CfgXML, 'LastUpdChk','String', FormatDateTime ('yyyy/MM/dd', LastUpdChk));
  // Vérification simultanée
  SetConfigParam(CfgXML, 'SequentialCheck','Bool', IntToStr(Integer(SequentialCheck)));
  // Vérification au démarrage
  SetConfigParam(CfgXML, 'StartupCheck','Bool', IntToStr(Integer(StartupCheck)));
  SetConfigParam(CfgXML, 'SelAccount','Integer', IntToStr(LVAccounts.ItemIndex));
  CfgXML.SaveXML (ConfigFile);
  FreeAndNil(CfgXML);
  // Démarrage au départ de Windows ?
  Reg:= TRegistry.Create;
  Reg.RootKey:= HKEY_CURRENT_USER;
  Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
  if StartMini then  s:= ' MINI' else s:= '' ;
  if StartWin  then  // Démarrage avec Windows coché
  begin
    Reg.WriteString('MailAttente','"'+ParamStr(0)+'"'+s);
    Reg.CloseKey;
  end else if Reg.ValueExists('MailAttente') then
  begin
    Reg.DeleteValue('MailAttente');
    Reg.CloseKey;
  end;
  Reg.Free;
  Result:= True;
end;

// Crée les divers événements nécessaires au client POP3

procedure TFMailAtt.SetAccountEvents(index: Integer);
var
  s: string;
begin
  if index < MailAccounts.Count then
  begin
    MailAccounts.GetItem(index).POP3Cli.OnRequestDone:= Pop3CliRequestDone;
    MailAccounts.GetItem(index).POP3Cli.OnDisplay:= Pop3CliDisplay;
    MailAccounts.GetItem(index).POP3Cli.OnMessageBegin:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnMessageEnd:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnMessageLine:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnListBegin:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnListEnd:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnListLine:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnUidlBegin:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnUidlEnd:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnUidlLine:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnHeaderEnd:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnStateChange:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnResponse:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSessionConnected:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSessionClosed:= Pop3CliSessionClosed;
    MailAccounts.GetItem(index).POP3Cli.OnBgException:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSslVerifyPeer:= Pop3CliSslVerifyPeer;
    MailAccounts.GetItem(index).POP3Cli.OnSslCliGetSession:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSslCliNewSession:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSslHandshakeDone:= nil;
    MailAccounts.GetItem(index).POP3Cli.OnSslCliCertRequest:= nil;
    MailAccounts.GetItem(index).POP3Cli.SslContext:= SslContext1;
    MailAccounts.GetItem(index).POP3Cli.MultiThreaded:= True;
    MailAccounts.GetItem(index).Timer.OnTimer:= TimerTimer;
    // On récupère le contenu du log en cours, puis on efface le log
    s:= MailAccounts.GetItem(index).log.Text;
    MailAccounts.GetItem(index).log.Clear;
    If FileExists (MailAppsData+'\Account'+IntToStr(index)+'.log') then
    begin
      if SaveLogs then MailAccounts.GetItem(index).log.LoadFromFile(MailAppsData+'Account'+IntToStr(index)+'.log')
      else MailAccounts.GetItem(index).log.Add(Formatte(LogCreated, [DateTimeToStr(now)]));
      MailAccounts.GetItem(index).log.Add(s);
    end else
    begin
      MailAccounts.GetItem(index).log.Add(Formatte(LogCreated, [DateTimeToStr(now)]));
      MailAccounts.GetItem(index).log.Add(s);
    end;
   MailAccounts.GetItem(index).log.SaveToFile(MailAppsData+'Account'+IntToStr(index)+'.log');
  end;
end;

procedure TFMailAtt.InitAboutBox;
begin
  With AboutBox do
  begin
   // visible:= False;
    //Version:= '0.8.0.0';
    LUpdate.Caption:= UpdateCaption;
    LastUpdate:= LastUpdChk;
    LUpdate.Hint:=  LastUpdateSearch+': '+DateToStr(LastUpdate);
    UrlUPdate:= UpdateURl+Version  ;
  end;
end;

procedure TFMailAtt.GetButtonsEnable (Enable: Bool);
begin
  BtnGetCurrent.Enabled:= Enable;
  MnuGetCurrent.Enabled:= Enable;
  PTrayMnuGetCurrent.Enabled:= Enable;
  BtnGetAll.Enabled:= Enable;
  MnuGetAll.Enabled:= Enable;
  PTrayMnuGetAll.Enabled:= Enable;
  MnuImport.Enabled:= Enable;
  SbMnuAccounts.Enabled:= Enable;
end;

// Remplit les menus de relevé des comptes

procedure TFMailAtt.AddAccountsMenu;
Var
  i: Integer;
  NwItem: TMenuItem;
  Bmp: TBitmap;
Begin
   if MailAccounts.Count < 1 then exit;
   Bmp:= TBitmap.Create;
   Bmp.LoadFromResourceName(HInstance, 'USER');
   Bmp.Canvas.Brush.Style := bsSolid;
   Bmp.Transparent:= True;

   MnuGetCurrent.Clear;
   PTrayMnuGetCurrent.Clear;
   For i:= 0 to MailAccounts.Count-1 do
   begin
     // Ajout du sous menu principal
     Bmp.Canvas.Brush.Color := MailAccounts.GetItem(i).Color;
     // Meme couleur que le masque
     If Bmp.Canvas.Brush.Color = $FF00FF then Bmp.Canvas.Brush.Color:= $FF03FF;
     Bmp.Canvas.Ellipse(6,1,16,11);
     NwItem:= TMenuItem.Create(self);
     NwItem.Caption:= MailAccounts.GetItem(i).AccountName;
     NwItem.Bitmap:= Bmp;
     NwItem.Name:= 'SbMnuGetAcc'+IntToStr(i);
     NwItem.Tag:= i;
     NwItem.OnClick:= BtnGetCurrentClick;
     MnuGetCurrent.Add(NwItem);
    // Ajout dans le tray
     NwItem:= TMenuItem.Create(self);
     NwItem.Caption:= MailAccounts.GetItem(i).AccountName;
     NwItem.Bitmap:= Bmp;
     NwItem.Name:= 'TrayMnuGetAcc'+IntToStr(i);
     NwItem.Tag:= i;
     NwItem.OnClick:= BtnGetCurrentClick;
     PTrayMnuGetCurrent.Add(NwItem);
  end;
  Bmp.Free;
End;

procedure TFMailAtt.UpdateAccountsList (LV: TListView; Accs: TAccountList);
var
  Listitem: TlistItem;
  i,j, n: Integer;
  idx: Integer;
  s: string;
  TrayBmp, AccBmp: TBitmap;
  error, pend: Bool;
begin
  if Accs.count= 0 then exit;
  idx:= LV.ItemIndex;
  if idx < 0 then idx:= 0;
  TrayBmp:= TBitmap.Create;
  AccBmp:= TBitmap.Create;
  TrayBmp.LoadFromResourceName (HInstance, 'MAIN');
  AccBmp.LoadFromResourceName (HInstance, 'USER');
  LV.Clear;
  LV.SmallImages.Clear;
  s:='';
  n:= 0;
  Error:= False;
  Pend:= False;
  TrayMailAtt.Icons.Clear;
  ImgAccount.Clear;
  TrayMailAtt.Icons.AddMasked(TrayBmp, $FF00FF);
  for i := 0 to Accs.count-1 do
  Begin
    ListItem := LV.items.add;  // prépare l'ajout
    if Accs.GetItem(i).MailList.Count > 0 then
    begin
      DrawTheIcon(AccBmp, Accs.GetItem(i).MailList.Count, Accs.GetItem(i).Color);
      // Icone dans la liste des comptes
      LV.SmallImages.AddMasked(AccBmp,$FF00FF);
      // Puis dans le tray
      DrawTheIcon(TrayBmp, Accs.GetItem(i).MailList.Count, Accs.GetItem(i).Color);
      TrayMailAtt.Icons.AddMasked(TrayBmp, $FF00FF);
      TrayMailAtt.Delay:= 1500;
      s:= s+Accs.GetItem(i).AccountName+': '+ IntToStr(Accs.GetItem(i).MailList.Count)+' message(s)'+#10#13;
    end else
    begin
      if Accs.GetItem(i).Error then
      begin
        // Icone dans la liste des comptes
        DrawTheIcon(AccBmp, -1, Accs.GetItem(i).Color);
        LV.SmallImages.AddMasked(AccBmp,$FF00FF);
        // Icone dans le tray
        DrawTheIcon(TrayBmp, -1, Accs.GetItem(i).Color);
        TrayMailAtt.Icons.AddMasked(TrayBmp, $FF00FF);
        TrayMailAtt.Delay:= 1500;
        error:= True;
      end else
      begin
        if Accs.GetItem(i).Pending then
        begin
          // Icone dans la liste des comptes
          DrawTheIcon(AccBmp, -2, Accs.GetItem(i).Color);
          LV.SmallImages.AddMasked(AccBmp,$FF00FF);
          // Icone dans le tray
          DrawTheIcon(TrayBmp, -2, Accs.GetItem(i).Color);
          TrayMailAtt.Icons.AddMasked(TrayBmp, $FF00FF);
          TrayMailAtt.Delay:= 1500;
          Pend:= True;
        end else
        begin
          AccBmp.LoadFromResourceName (HInstance, 'USER');
          LV.SmallImages.AddMasked(AccBmp, $FF00FF);
        end;
      end;
    end;
     Listitem.Caption :=  Accs.GetItem(i).AccountName;
     ListItem.ImageIndex:= i;
     n:= n+Accs.GetItem(i).MailList.Count;
  end;
  LV.ItemIndex:= idx;
  if n = 0 then
  begin
    TrayMailAtt.Hint:= NoNewMail;
    if Error or Pend then
    begin
      TrayMailAtt.Animated:= True;
    end else
    begin
      TrayMailAtt.IconIndex:= 0;
      TrayMailAtt.Animated:= False;
    end;
  end else
  begin
    // Supprime dernier RC+SL
    j:= Rpos(#10#13, s);
    if j > 0 then s:= Copy(s, 1, j-1);
    TrayMailAtt.Hint:= s;
    TrayMailAtt.Animated:= True;
  end;
  TrayBmp.Free;
  AccBmp.Free;
end;

procedure TFMailAtt.PopulateAccountsList (LV: TListView; Accs: TAccountList);
var
  Listitem: TlistItem;
  i: Integer;
  Bmp: TBitmap;
Begin
  if Accs.Count = 0 then exit;
  Bmp:= TbitMap.Create;
  Bmp.LoadFromResourceName(HInstance, 'USER');
  LV.Clear;

  if Assigned(LV.SmallImages) then
  begin
    LV.SmallImages.Clear;
    LV.SmallImages.AddMasked(Bmp,$FF00FF);
  end;
  for i := 0 to Accs.Count-1 do
  //Begin
  Try
    ListItem := LV.items.add;  // prépare l'ajout
    Listitem.Caption :=  Accs.GetItem(i).AccountName;    // ajoute le nom
  Except
  end;
  LV.ItemIndex:= 0;
  Bmp.Free;
end;

procedure TFMailAtt.MnuDeleteMsgClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  s: string;
begin
  j:= 0;
  with LVMail do
  begin
    if SelCount = 0 then exit;
    for i :=Items.Count-1 downto 0 do
    begin
      if Items[i].Selected then
      DeleteMessage(i) ;
      if MailAccounts.GetItem(LVAccounts.ItemIndex).MailList.GetItem(i).MessageToDelete then inc(j);
    end;
    PopulateMsgList(LVAccounts.ItemIndex);
    //
    Case j of
      0: s:='';
      1: s:= StringReplace(DeleteMessagesBox, '$s', '',[rfReplaceAll]) ;
      else s:= StringReplace(DeleteMessagesBox, '$s', 's',[rfReplaceAll]);
    end;
    if length (s) > 0 then
      if Application.MessageBox (PChar(Formatte(s, [#10#13])), PChar(DeleteMessages),
                                MB_YESNO) =  IDYES	then GetMail(LVAccounts.ItemIndex);


  end;
end;



procedure TFMailAtt.DeleteMessage(index: integer);
var
 i: Integer;
 sUIDL: string;
begin
  sUIDL:= MailAccounts.GetItem(LVAccounts.ItemIndex).MailList.GetItem(index).MessageUIDL;
  i:= MailAccounts.GetItem(LVAccounts.ItemIndex).UIDLToDel.IndexOf(sUIDL);
  if i >= 0 then   //Message déjà marqué pour effacement
  begin
    MailAccounts.GetItem(LVAccounts.ItemIndex).UIDLToDel.Delete(i);
    TMail(MailAccounts.GetItem(LVAccounts.ItemIndex).MailList[Index]^).MessageToDelete:= False;
  end else
  begin
    MailAccounts.GetItem(LVAccounts.ItemIndex).UIDLToDel.Add(MailAccounts.GetItem(LVAccounts.ItemIndex).MailList.GetItem(Index).MessageUIDL);
    TMail(MailAccounts.GetItem(LVAccounts.ItemIndex).MailList[Index]^).MessageToDelete:= True;
  end;
end;

procedure TFMailAtt.GetMail (Index: Integer);
var
  i: Integer;
  TrayIcon: TIcon;
begin
  // ON est déjà en train de relever du courrier !
  if Ord(MailAccounts.GetItem(Index).POP3Cli.SslType) > 1 then
  begin
    //Memo1.Lines.Add(MailAccounts.GetItem(Index).AccountName+': SSL explicite pas encore implémenté');
    exit;
  end;
  // Test
  If (MailAccounts.GetItem(Index).Pending or Pending) then
  begin
    exit;
  end else
  begin
    TAccount(MailAccounts.Items[Index]^).Pending:= True;
    Pending:= SequentialCheck and True;
  end;
  MailAccounts.GetItem(Index).MsgToDel.Clear;
  TrayMailAtt.Icons.Clear;
  TAccount(MailAccounts.Items[Index]^).NewMails:= 0;
  TAccount(MailAccounts.Items[Index]^).LastMessage:= '';
  TAccount(MailAccounts.Items[Index]^).Error:= False;
  TrayIcon:= TIcon.Create;
  For i:= 0 to 5 do
  begin
    TrayIcon.Handle := LoadIcon(hInstance, PChar('XATT'+IntToStr(i)));
    TrayMailAtt.Icons.AddIcon (TrayIcon);
  end;
  TrayMailAtt.Delay:= 75;
  TrayMailAtt.Animated:= True;
  MailAccounts.GetItem(Index).MailList.Clear;
  Status.Panels[0].Text:= Formatte(Connecting, [MailAccounts.GetItem(Index).AccountName]) ;
  MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
  MailAccounts.GetItem(Index).POP3Cli.Connect;
  FreeAndNil(TrayIcon);
end;


// Evenements du POP3Cli
// Résultat d'une requete

procedure TFMailAtt.Pop3CliRequestDone(Sender: TObject;
  RqType: TPop3Request; Error: Word);
var
  Index, i: Integer;
  s, s1: string;
  charset: string;
  MyMail: TMail;
  //UIDL: String;
begin
  Index:= TPOP3Cli(Sender).Tag;
  LastError:= '';
  case RqType of
    pop3Connect: If Error = 0 then
                 begin
                   Status.Panels[0].Text:= Formatte (Authenticating, [MailAccounts.GetItem(Index).AccountName]);
                   TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                   TAccount(MailAccounts.Items[Index]^).Error:= False;
                   TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                   MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                   MailAccounts.GetItem(Index).Timer.Enabled:= True;
                   if MailAccounts.GetItem(Index).POP3Cli.AuthType = popAuthLogin then
                   MailAccounts.GetItem(Index).POP3Cli.Auth else MailAccounts.GetItem(Index).POP3Cli.User;
                 end else
                 begin
                   Status.Panels[0].Text:= ConnectionError;
                   TAccount(MailAccounts.Items[Index]^).LastMessage:= ConnectionError +' ('+DateTimeToStr(now)+')';
                   TAccount(MailAccounts.Items[Index]^).Error:= True;
                   MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+ConnectionError);
                   MailAccounts.GetItem(Index).Timer.Enabled:= True;
                   Pop3CliSessionClosed(Sender, 0);
                 end;
    pop3Auth : if Error > 0 then   //Si AUTH réusi, c'est la requete PASS qui reçoit la notification
               Begin
                  // Auth non accepted
                  if Error = 500 then
                  begin
                    Status.Panels[0].Text:= Formatte (SendingUserName, [MailAccounts.GetItem(Index).AccountName]);
                    TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                    TAccount(MailAccounts.Items[Index]^).Error:= False;
                    TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                    MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                    MailAccounts.GetItem(Index).Pop3Cli.User;
                  end else
                  Begin
                    Status.Panels[0].Text:= AuthenticatingError;
                    TAccount(MailAccounts.Items[Index]^).LastMessage:= AuthenticatingError;
                    TAccount(MailAccounts.Items[Index]^).Error:= True;
                    MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+AuthenticatingError);
                    MailAccounts.GetItem(Index).Pop3Cli.Quit;
                  end;
               end;
    pop3user : If Error = 0 then
               Begin
                 Status.Panels[0].Text:= Formatte (SendingPassword, [MailAccounts.GetItem(Index).AccountName]);
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 MailAccounts.GetItem(Index).Pop3Cli.Pass;
               end else
               Begin
                  Status.Panels[0].Text:= AuthenticatingError;
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= AuthenticatingError;
                 TAccount(MailAccounts.Items[Index]^).Error:= True;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+AuthenticatingError);
                 MailAccounts.GetItem(Index).Pop3Cli.Quit;
               end;
    pop3pass : If Error = 0 then
               Begin
                 Status.Panels[0].Text:= Formatte (CountingMessages, [MailAccounts.GetItem(Index).AccountName]);
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 0;
                 TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                 MailAccounts.GetItem(Index).Pop3Cli.Stat;
                end else
               Begin
                 //TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
                 Status.Panels[0].Text:= AuthenticatingError;
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= AuthenticatingError;
                 TAccount(MailAccounts.Items[Index]^).Error:= True;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+AuthenticatingError);
                 MailAccounts.GetItem(Index).Pop3Cli.Quit;
               end;
   Pop3Stat: If Error = 0 then
             begin
               // Il y a des messages
               TAccount(MailAccounts.Items[Index]^).MsgCount:= MailAccounts.GetItem(Index).Pop3Cli.MsgCount;
               if MailAccounts.GetItem(Index).MsgCount > 0 then
               begin
                 Status.Panels[0].Text:= Formatte(MailFound, [MailAccounts.GetItem(Index).MsgCount, MailAccounts.GetItem(Index).AccountName]);
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 Status.Panels[0].Text:= Formatte(ListingMessages, [1, MailAccounts.GetItem(Index).AccountName]);
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 1;
                 MailAccounts.GetItem(Index).Pop3Cli.List;
               end else // Pas de messages
               begin      
                 Status.Panels[0].Text:= Formatte (NoMailFound, [MailAccounts.GetItem(Index).AccountName]) ;
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 MailAccounts.GetItem(Index).Pop3Cli.Quit;
               end;
             end else
             begin
               TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
               TAccount(MailAccounts.Items[Index]^).Error:= True;
               MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
               MailAccounts.GetItem(Index).Pop3Cli.Quit;
             end;

   Pop3List: If Error = 0 then
             Begin
               if MailAccounts.GetItem(Index).Pop3Cli.MsgNum > 0 then
               begin
                 MyMail.AccountName:= MailAccounts.GetItem(Index).AccountName;
                 MyMail.MessageNum:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum;
                 MyMail.MessageSize:= MailAccounts.GetItem(Index).Pop3Cli.MsgSize;
                 MailAccounts.GetItem(Index).MailList.AddMail(MyMail);
               end;
               // Il reste des messages ?
               if MailAccounts.GetItem(Index).Pop3Cli.MsgNum < MailAccounts.GetItem(Index).MsgCount then
               Begin
                 Status.Panels[0].Text:= Formatte (ListingMessages,
                    [MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1, MailAccounts.GetItem(Index).AccountName]);
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                 MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1;
                 MailAccounts.GetItem(Index).Pop3Cli.List;
               end else
               begin
                 Status.Panels[0].Text:= Formatte (RetrievingUIDLs,[1, MailAccounts.GetItem(Index).AccountName]) ;
                 MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                 TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                 TAccount(MailAccounts.Items[Index]^).Error:= False;
                 TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                 MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 1;
                 MailAccounts.GetItem(Index).Pop3Cli.Uidl;
               end;
             end else
             Begin
               TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
               TAccount(MailAccounts.Items[Index]^).Error:= True;
               MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
               MailAccounts.GetItem(Index).Pop3Cli.Quit;
             end;
    pop3Uidl: if Error = 0 then
                Begin
                  //  On récupère d'abord l'UIDL
                  //i:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1;
                  //if i in [0..MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1]
                  if MailAccounts.GetItem(Index).Pop3Cli.MsgNum > 0 then
                  begin
                    RetrieveUIDL( TAccount(MailAccounts.Items[Index]^));
                    {UIDL:= MailAccounts.GetItem(Index).Pop3Cli.MsgUidl;
                    i:= MailAccounts.GetItem(Index).UIDLToDel.IndexOf(UIDL);
                    if i >= 0 then
                    begin
                      MailAccounts.GetItem(Index).MsgToDel.Add(IntToStr(MailAccounts.GetItem(Index).Pop3Cli.MsgNum));
                      MailAccounts.GetItem(Index).UIDLToDel.Delete(i);
                    end else
                    begin
                      TMail(MailAccounts.GetItem(Index).MailList.Items[MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1]^).MessageUIDL:= UIDL;
                      i:= MailAccounts.GetItem(Index).UIDLList.IndexOf(MailAccounts.GetItem(Index).Pop3Cli.MsgUidl);
                      if i >= 0 then
                      begin
                        TMail(MailAccounts.GetItem(Index).MailList.Items[MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1]^).MessageNew:= False;
                      end else
                      begin
                        Inc(TAccount(MailAccounts.Items[Index]^).NewMails);
                        TMail(MailAccounts.GetItem(Index).MailList.Items[MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1]^).MessageNew:= True;
                      end;
                    end;    }
                  end;
                  // Il reste des messages
                  if MailAccounts.GetItem(Index).Pop3Cli.MsgNum < MailAccounts.GetItem(Index).MsgCount then
                  Begin
                    Status.Panels[0].Text:= Formatte (RetrievingUIDLs,
                      [MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1, MailAccounts.GetItem(Index).AccountName]);
                    TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                    TAccount(MailAccounts.Items[Index]^).Error:= False;
                    TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                    //MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 1;
                    MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1;
                    MailAccounts.GetItem(Index).Pop3Cli.MsgLines:= 0;
                    MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                    MailAccounts.GetItem(Index).Pop3Cli.UIDL;
                  end else
                  begin
                    // Des messages à effacer ?
                    if MailAccounts.GetItem(Index).MsgToDel.Count > 0 then
                    begin
                      i:= StrToInt(MailAccounts.GetItem(Index).MsgToDel[0]);
                      Status.Panels[0].Text:= Formatte(DeletingMessage,
                          [MailAccounts.GetItem(Index).MsgToDel[0],MailAccounts.GetItem(Index).AccountName]) ;
                      TAccount(MailAccounts.Items[Index]^).Error:= False;
                      TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                      MailAccounts.GetItem(Index).MsgToDel.Delete(0);
                      MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= i;
                      MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                      MailAccounts.GetItem(Index).Pop3Cli.Dele;
                    end else
                    begin
                      If MailAccounts.GetItem(Index).MailList.Count > 0 then
                      Begin
                        Status.Panels[0].Text:= Formatte (RetrievingHeaders,[1, MailAccounts.GetItem(Index).AccountName]);
                        TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                        TAccount(MailAccounts.Items[Index]^).Error:= False;
                        TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                        MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 1;
                        MailAccounts.GetItem(Index).Pop3Cli.MsgLines:= 0;
                        MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                        MailAccounts.GetItem(Index).Pop3Cli.Top;
                      end else MailAccounts.GetItem(Index).Pop3Cli.Quit;
                    end;
                  end;
                end else
                Begin
                  TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
                  TAccount(MailAccounts.Items[Index]^).Error:= True;
                  TAccount(MailAccounts.Items[Index]^).NewMails:= 0;
                  MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
                  MailAccounts.GetItem(Index).MailList.Clear;
                  MailAccounts.GetItem(Index).Pop3Cli.Quit;
                end;
    pop3Dele: if Error = 0 then
                begin
                    // Encore un message à effacer
                    if MailAccounts.GetItem(Index).MsgToDel.Count > 0 then
                     begin
                       i:= StrToInt(MailAccounts.GetItem(Index).MsgToDel[0]);
                       Status.Panels[0].Text:= 'Mark Message to delete: '+IntToStr(i);
                       MailAccounts.GetItem(Index).MsgToDel.Delete(0);
                       TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                       TAccount(MailAccounts.Items[Index]^).Error:= False;
                       MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text);
                       MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= i;
                       MailAccounts.GetItem(Index).Pop3Cli.Dele;
                    end else
                    // PLus de messages à effacer
                    begin
                      MailAccounts.GetItem(Index).MailList.Clear;
                      TAccount(MailAccounts.Items[Index]^).Error:= False;
                      MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= 0;
                      TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                      TAccount(MailAccounts.Items[Index]^).LastMessage:= 'DELETED';
                      MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+'DELETED DONE');
                      MailAccounts.GetItem(Index).Pop3Cli.Quit;

                    end;
                end else
                Begin
                  TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
                  TAccount(MailAccounts.Items[Index]^).Error:= True;
                  MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
                  MailAccounts.GetItem(Index).Pop3Cli.Quit;
                end;
    pop3Top: if Error = 0 then
                begin
                  //  On récupère d'abord l'entete
                  i:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1;
                 // if i in [0..MailAccounts.GetItem(Index).Pop3Cli.MsgNum-1] then
                  if i >= 0 then
                  begin
                    //On filtre les jeux de caractères non ASCII
                    s:= DecodeMimeInlineValueEx (MailAccounts.GetItem(Index).Pop3Cli.HeaderFrom, Charset);
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageFrom:= s;
                    s:= ParseEmail(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageFrom,s1);
                    // On récupère l'adresse email propre en cas d'envoi
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).FromAddress:= s;
                    s:= DecodeMimeInlineValueEx(MailAccounts.GetItem(Index).Pop3Cli.HeaderTo, Charset);
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageTo:= s;
                    s:= DecodeMimeInlineValueEx(MailAccounts.GetItem(Index).Pop3Cli.HeaderSubject, Charset);
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageSubject:= s;
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).Messagedate:= RF822ToDateTime(MailAccounts.GetItem(Index).Pop3Cli.HeaderDate, True);
                    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageContentType:= MailAccounts.GetItem(Index).Pop3Cli.HeaderContentType;
                  end;
                  // Il reste des messages, on demande l'entete suivant
                  //if MailAccounts.GetItem(Index).Pop3Cli.MsgNum < MailAccounts.GetItem(Index).MailList.Count then
                  if MailAccounts.GetItem(Index).Pop3Cli.MsgNum < MailAccounts.GetItem(Index).MsgCount then
                  Begin
                    Status.Panels[0].Text:= Formatte (RetrievingHeaders,
                      [MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1, MailAccounts.GetItem(Index).AccountName]);
                    MailAccounts.GetItem(Index).Pop3Cli.MsgNum:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum+1;
                    MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text) ;
                    TAccount(MailAccounts.Items[Index]^).Error:= False;
                    MailAccounts.GetItem(Index).Pop3Cli.MsgLines:= 0;
                    TAccount(MailAccounts.Items[Index]^).Elapsed:= 0;
                    MailAccounts.GetItem(Index).Pop3Cli.Top;
                  end else
                  // Plus de messages
                  begin
                    Status.Panels[0].Text:= RetrievingCompleted;
                    TAccount(MailAccounts.Items[Index]^).LastMessage:= Status.Panels[0].Text;
                    TAccount(MailAccounts.Items[Index]^).Error:= False;
                    MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+Status.Panels[0].Text) ;
                    MailAccounts.GetItem(Index).Pop3Cli.Quit;
                  end;
                end else
                Begin
                  TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
                  TAccount(MailAccounts.Items[Index]^).Error:= True;
                  MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
                  // On efface les messages "vides"
                  if MailAccounts.GetItem(Index).Pop3Cli.MsgNum > 0 then
                  begin
                    if MailAccounts.GetItem(Index).MailList.Count > MailAccounts.GetItem(Index).Pop3Cli.MsgNum then
                    begin
                      //For i:= MailAccounts.GetItem(Index).Pop3Cli.MsgNum to MailAccounts.GetItem(Index).MailList.Count-1 do
                      For i:= MailAccounts.GetItem(Index).MailList.Count-1 downto MailAccounts.GetItem(Index).Pop3Cli.MsgNum do
                         MailAccounts.GetItem(Index).MailList.Delete(i);
                    end;
                  end else
                  begin
                    MailAccounts.GetItem(Index).MailList.Clear;
                    TAccount(MailAccounts.Items[Index]^).NewMails:= 0;
                  end;
                  MailAccounts.GetItem(Index).Pop3Cli.Quit;
                end;
    pop3Quit: Begin
                If Error = 0 then
                begin
                  // tester plutôt si Error est à True ?
                  if not MailAccounts.GetItem(Index).Error then
                  begin
                    If not (MailAccounts.GetItem(Index).LastMessage= 'DELETED') then
                    begin
                      TAccount(MailAccounts.Items[Index]^).LastMessage:= Formatte(GotMessages,
                        [MailAccounts.GetItem(Index).MailList.Count, MailAccounts.GetItem(Index).AccountName, DateTimeToStr(now)]);
                    end ;
                     // TAccount(MailAccounts.Items[Index]^).LastMessage:= 'Quit Mailbox';

                      MailAccounts.GetItem(Index).Log.Add(MailAccounts.GetItem(Index).LastMessage);
                      // Pour être sur de déconnecter !!!
                      MailAccounts.GetItem(Index).Pop3Cli.Abort;
                      //Pop3CliSessionClosed(Sender, 0);

                  end;
                end else
                begin
                  TAccount(MailAccounts.Items[Index]^).LastMessage:= MailAccounts.GetItem(Index).Pop3Cli.ErrorMessage;
                  TAccount(MailAccounts.Items[Index]^).Error:= True;
                  MailAccounts.GetItem(Index).Log.Add(DateTimeToStr(now())+': '+MailAccounts.GetItem(Index).LastMessage);
                  MailAccounts.GetItem(Index).Pop3Cli.Abort;
                  //Pop3CliSessionClosed(Sender, 1);
                end;
              end;
  end;
end;



// Affichage d'un message d'état du client

procedure TFMailAtt.Pop3CliDisplay(Sender: TObject; const Msg: String);
var
  i: integer;
  AccNum: Integer;
begin
   AccNum:= TPOP3Cli(Sender).Tag;
   i:= Pos('PASS ', Msg);
   if i > 0 then MailAccounts.GetItem(AccNum).Log.Add(copy(Msg, 1, i+4)+' ******')
   else
   MailAccounts.GetItem(AccNum).Log.add(Msg);
end;

// Fin de la session

procedure TFMailAtt.Pop3CliSessionClosed(Sender: TObject; ErrCode: Word);
var
  Index: Integer;
begin
  Index:= TPOP3Cli(Sender).Tag;
  TAccount(MailAccounts.Items[Index]^).Pending:= False;
  TAccount(MailAccounts.Items[Index]^).LastFire:= now();
  TAccount(MailAccounts.Items[Index]^).NextFire:= now()+ MailAccounts.GetItem(Index).Interval/1440;

  //Test
  Pending:= False;
  //
  if  GetNext and (Index < MailAccounts.Count - 1) then
  begin
    GetMail(Index+1);
  end else
  begin
    GetNext:= False;
  end;
  MailAccounts.GetItem(Index).log.Add(Formatte(SessionClosedCaption, [DateTimeToStr(now()),MailAccounts.GetItem(Index).AccountName]));
  If not (MailAccounts.GetItem(Index).LastMessage= 'DELETED') then
  MailAccounts.GetItem(Index).Log.Add(Formatte(NextCheckCaption, [DateTimeTostr(MailAccounts.GetItem(Index).NextFire)]));
  //MailAccounts.GetItem(Index).Timer.Enabled:= True;
end;



// Récupération d'un UIDL

procedure TFMailAtt.RetrieveUIDL(var Account: TAccount);
var
  i: Integer;
  UIDL: String;
begin
  UIDL:= Account.Pop3Cli.MsgUidl;
  i:= Account.UIDLToDel.IndexOf(UIDL);
  if i >= 0 then
  begin
     Account.MsgToDel.Add(IntToStr(Account.Pop3Cli.MsgNum));
     Account.UIDLToDel.Delete(i);
     exit;
  end;
  TMail(Account.MailList.Items[Account.Pop3Cli.MsgNum-1]^).MessageUIDL:= UIDL;
  i:= Account.UIDLList.IndexOf(Account.Pop3Cli.MsgUidl);
  if i >= 0 then
  begin
    TMail(Account.MailList.Items[Account.Pop3Cli.MsgNum-1]^).MessageNew:= False;
  end else
  begin
    Inc(Account.NewMails);
    TMail(Account.MailList.Items[Account.Pop3Cli.MsgNum-1]^).MessageNew:= True;
  end;
end;

procedure TFMailAtt.Pop3CliSslHandshakeDone(Sender: TObject;
  ErrCode: Word; PeerCert: TX509Base; var Disconnect: Boolean);
var
  Index: integer;
begin
  Index:= TPOP3Cli(Sender).Tag;
  if (ErrCode = 0) then
    if PeerCert.PostConnectionCheck(TSslPop3Cli(Sender).Host) then
    begin
       TAccount(MailAccounts.Items[Index]^).LastMessage:='! Post connection check ok';
       TAccount(MailAccounts.Items[Index]^).Error:= False;
       //Memo1.Lines.Add('! Post connection check ok');
    end else
    begin
      Status.Panels[0].Text:= 'SSL Handshake failed';
      TAccount(MailAccounts.Items[Index]^).LastMessage:= 'SSL Handshake failed on '+DateTimeToStr(now);
      TAccount(MailAccounts.Items[Index]^).Error:= True;
      Pop3CliSessionClosed(Sender, 0);
      //Memo1.Lines.Add('! Post connection check **failed** - ' +
      //                            'Hostname "' + TSslPop3Cli(Sender).Host +
      //                            '" not found in peer certificate');
      //Disconnect := TRUE;
    end;
    MailAccounts.GetItem(Index).Log.Add(MailAccounts.GetItem(Index).LastMessage);
end;


procedure TFMailAtt.PopulateMsgList(Index: Integer);
var
  liste : TListItems;
  i, j: Integer;
  s, s1: String;
Begin
  LVMail.Clear;
  if MailAccounts.GetItem(Index).Pending then
  Status.Panels[0].Text:= CurrChecking else
  Status.Panels[0].Text:= MailAccounts.GetItem(Index).LastMessage;
  if MailAccounts.GetItem(Index).MailList.Count = 0 then exit;
  liste := LVMail.Items;

  for i := 0 to MailAccounts.GetItem(Index).MailList.Count - 1 do
  //begin
  Try
    liste.Add;
    if MailAccounts.GetItem(Index).MailList.GetItem(i).MessageNew then j:= 1
    else j:= 0;
    // Attachment ?
    if Pos ('multipart', MailAccounts.GetItem(Index).MailList.GetItem(i).MessageContentType) >0 then
     j:= j+2;
    if MailAccounts.GetItem(Index).MailList.GetItem(i).MessageToDelete then  j:= 4;
    Liste.Item[i].ImageIndex:= j;
    s:= ParseEmail(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageFrom,s1);
    if length(s1)>0 then s:= s1;
    liste.Item[i].Caption := s;
    s:= ParseEmail(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageTo,s1);
    if length(s1)>0 then s:= s1;
    liste.Item[i].SubItems.Add(s);
    liste.Item[i].SubItems.Add(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageSubject);
    liste.Item[i].SubItems.Add(DateTimeToStr(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageDate));
    liste.Item[i].SubItems.Add(IntToStr(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageSize)+' '+ByteCaption);
{    s:= DecodeMimeInlineValueEx (MailAccounts.GetItem(Index).MailList.GetItem(i).MessageFrom, Charset);
    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageFrom:= s;
    s:= ParseEmail(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageFrom,s1);
    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).FromAddress:= s;
    if length(s1)>0 then s:= s1;
    liste.Item[i].Caption := s;
    s:= DecodeMimeInlineValueEx(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageTo, Charset);
    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageTo:= s;
    s:= ParseEmail(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageFrom,s1);
    if length(s1)>0 then s:= s1;
    liste.Item[i].SubItems.Add(s);
    s:= DecodeMimeInlineValueEx(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageSubject, Charset);
    TMail(MailAccounts.GetItem(Index).MailList.Items[i]^).MessageSubject:= s;
    liste.Item[i].SubItems.Add(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageSubject);
    liste.Item[i].SubItems.Add(DateTimeToStr(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageDate));
    liste.Item[i].SubItems.Add(IntToStr(MailAccounts.GetItem(Index).MailList.GetItem(i).MessageSize)+' '+ByteCaption);}
  except
  end;
end;



procedure TFMailAtt.PMnuInfoClick(Sender: TObject);
var
  ts: TStrings;

  index: Integer;
Begin
  ts:= TStringList.Create;
  index:= LVAccounts.ItemIndex;
  if MouseMsgIndex < 0 then exit;
  if MailAccounts.GetItem(Index).MailList.count=0 then exit;
  With MailAccounts.GetItem(Index).MailList.GetItem(MouseMsgIndex) do
  begin
    ts.Add(AccountCaption+': '+AccountName);
    ts.Add('#'+IntToStr(MessageNum));
    ts.Add('UIDL: '+MessageUIDL);
    ts.Add(FromCaption+': '+MessageFrom);
    ts.Add(ToCaption+': '+MessageTo);
    ts.Add(SubjectCaption+': '+MessageSubject);
    ts.Add(DateCaption+': '+DateTimeToStr(Messagedate));
    ts.Add(SizeCaption+': '+IntToStr(MessageSize)+' '+ByteCaption);
    ts.Add('Content-Type:'+MessageContentType) ;
  end;
  ShowMessage(ts.text);
  FReeAndNil(ts);
end;

procedure TFMailAtt.LVMailMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
 CurItem: TlistItem;
Begin
  CurItem:= TlistView(Sender).GetItemAt(X, Y);
  TListView(Sender).PopupMenu.AutoPopup:= False;
  try
    MouseMsgIndex:=  CurItem.Index;
    TListView(Sender).PopupMenu.AutoPopup:= True;

  except
    MouseMsgIndex:= -1;
  end;
end;

procedure TFMailAtt.PopupMenu1Popup(Sender: TObject);
var
  stodel: string;
  stores: string;
  sd, sr: string;
  id, ir: integer;
  i: integer;
begin
  id:= 0;
  ir:= 0;
  sd:= '';
  sr:= '';
  with LVMail do
  begin
    if SelCount = 0 then
    begin
      MnuDeleteMsg.Enabled:= False;
      //BtnDeleteMsg.Caption:= MnuDeleteSelMsgCaption;
    end else
    begin
      MnuDeleteMsg.Enabled:= True;
      for i :=0 to Items.Count-1 do
      begin
        if Items[i].Selected then
        begin
          if MailAccounts.GetItem(LVAccounts.ItemIndex).MailList.GetItem(i).MessageToDelete
          then begin
            stores:=stores+IntToStr(i+1)+', ';
            Inc(ir);
          end else
          begin
            stodel:=stodel+IntToStr(i+1)+', ';
            Inc(id);
          end;
        end;
      end;
      Case id of
        0: sd:='';
        1: sd:= StringReplace(MnuDeleteMsgCaption, '$s', '', [rfReplaceAll])+' ';
        else sd:= StringReplace(MnuDeleteMsgCaption, '$s', 's', [rfReplaceAll])+' ';
      end;
      Case ir of
        0: sr:= '';
        1: sr:= StringReplace(MnuRestoreMsgCaption, '$s', '',[rfReplaceAll])+' ' ;
        else sr:= StringReplace(MnuRestoreMsgCaption, '$s', 's',[rfReplaceAll])+' ' ;
      end;
      if length(stores)=0 then
      begin
        stodel:= copy(stodel,1, rPos(',', stodel)-1);
        MnuDeleteMsg.Caption:= sd+stodel;
        exit;
      end;
      if length(stores)> 0 then
      stores:= copy(stores,1, rPos(',', stores)-1) else
      stodel:= copy(stodel,1, rPos(',', stodel)-1);
      MnuDeleteMsg.Caption:= sd+stodel+sr+stores;
    end;
  end;
end;

procedure TFMailAtt.TimergTimer(Sender: TObject);
var
  i: Integer;
begin
  // Toutes les x secondes
  if MailAccounts.Count > 0 then
  begin
    For i:= 0 to MailAccounts.Count-1 do
    if (i >= 0) and BtnGetAll.Enabled then
    begin
      if (not (MailAccounts.GetItem(i).Pending or Pending) and (MailAccounts.GetItem(i).Interval > 0)
          and  (MailAccounts.GetItem(i).NextFire < now))
      then Getmail (i);
    end;
  end;
end;

procedure TFMailAtt.FillUIDLList(index: Integer);
var
  i: integer;
begin
  MailAccounts.GetItem(index).UIDLList.Clear;
  MailAccounts.GetItem(index).UIDLToDel.Clear;
  for i:= 0 to MailAccounts.GetItem(index).MailList.Count-1 do
  begin
    MailAccounts.GetItem(index).UIDLList.Add(MailAccounts.GetItem(index).MailList.GetItem(i).MessageUIDL);
  end;
end;

// ON a recueilli tous les messages
procedure TFMailAtt.TimerTimer(Sender: TObject);
var
  i: Integer;
  s: string;
Begin
  i:= TTimer(Sender).Tag;
  If not (MailAccounts.GetItem(i).Pending) then MailAccounts.GetItem(i).Timer.Enabled:= False
  else
  begin
     If MailAccounts.GetItem(i).Elapsed < 120 then
     begin
       Inc(TAccount(MailAccounts.Items[i]^).Elapsed);
       exit;
     end else
     begin
       MailAccounts.GetItem(i).Timer.Enabled:= False;
       MailAccounts.GetItem(i).Pop3Cli.Abort;
       //MailAccounts.GetItem(i).MailList.Clear;
       MailAccounts.GetItem(i).Log.Add(MailAccounts.GetItem(i).LastMessage);
       TAccount(MailAccounts.Items[i]^).LastMessage:= Formatte(AbortTimeout, [DateTimeToStr(now())]);
       //TAccount(MailAccounts.Items[i]^).NewMails:= 0;
       TAccount(MailAccounts.Items[i]^).Elapsed:= 0;
       TAccount(MailAccounts.Items[i]^).Pending:= False;
     end;
  end;
  if MailAccounts.GetItem(i).NewMails > 0 then
  begin
    s:= Formatte(NewMessagesCaption, [MailAccounts.GetItem(i).NewMails,DateTimeToStr(now)]);
    if RestNewMsg then PTrayMnuRestoreClick(Self);
    if not TrayMailAtt.applicationvisible then
    begin
      if RestNewMsg then PTrayMnuRestoreClick(Self) else
        TrayMailAtt.BalloonHint (MailAccounts.GetItem(i).AccountName, s, btNone, 5000);
    end;
    s:= MailAccounts.GetItem(i).Sound;
    if length(s)= 0 then s:= CommonSound;
    sndPlaySound(PChar(s), SND_NODEFAULT Or SND_ASYNC Or SND_NOSTOP);
  end;
  MailAccounts.GetItem(i).log.Add('');
  MailAccounts.GetItem(i).log.SaveToFile(MailAppsData+'Account'+IntToStr(i)+'.log');
  TrayMailAtt.Icons:= nil;
  ImgTrayPendMail.Clear;
  TrayMailAtt.Icons:= ImgTrayPendMail;
  TrayMailAtt.Animated:= False;
  FillUIDLLIst(i);
  UpdateAccountsList(LVAccounts, MailAccounts);
  PopulateMsgList(LVAccounts.ItemIndex);
  If MailAccounts.GetItem(i).LastMessage= 'DELETED' then
  GetMail(i);
end;

procedure TFMailAtt.BtnGetAllClick(Sender: TObject);
Begin
  GetNext:= True;
//  Timer1.Enabled:= False;
GetMail (0);
end;


procedure TFMailAtt.BtnGetCurrentClick(Sender: TObject);
begin
  GetNext:= False;
  GetMail (TComponent(Sender).Tag);
end;




procedure TFMailAtt.SbMenuOptionsClick(Sender: TObject);
begin
  With FPrefs do
  begin
    CBStartWin.Checked:= StartWin;
    CBStartMini.Checked:= StartMini;
    CBSavSizePos.Checked:= SavSizePos;
    CBSaveLogs.Checked:= SaveLogs;
    CBMailClientMini.Checked:= MailClientMini;
    CBRestNewMsg.Checked:= RestNewMsg;
    EMailCli.Text:= CommonMailClient;
    ESound.Text:= CommonSound;
    CBLangue.ItemIndex:= CurLang;
    CBNoChkNewVer.Checked:= NoChkNewVer;
    CBSequentialCheck.Checked:= SequentialCheck;
    CBStartupCheck.Checked:= StartupCheck;
    CBSmoothScroll.Checked:= SmoothScroll;
    OptionsResult(ShowModal);
  end;
end;

procedure TFMailAtt.OptionsResult(mr: integer);
begin
  With Fprefs Do
  Case mr of
    mrYes:begin
            StartWin:= CBStartWin.Checked;
            StartMini:= CBStartMini.Checked;
            SavSizePos:= CBSavSizePos.Checked;
            SaveLogs:= CBSaveLogs.Checked;
            MailClientMini:= CBMailClientMini.Checked;
            RestNewMsg:= CBRestNewMsg.Checked;
            CommonMailClient:= EMailCli.Text;
            CommonSound:= ESound.Text;
            If length(CommonMailClient)= 0 then CommonMailClient:= DefMailClient;
            If CBLangue.ItemIndex <> CurLang then
            begin
              CurLang:= CBLangue.ItemIndex;
              LangStr:= LangNums[CurLang];
              ModLangue;
            end;
            NoChkNewVer:= CBNoChkNewVer.Checked;
            SequentialCheck:= CBSequentialCheck.Checked;
            StartupCheck:= CBStartupCheck.Checked;
            SmoothScroll:= CBSmoothScroll.Checked ;
            //ChangeMailClient(CommonMailClient);
            SaveConfig;
            if SmoothScroll then
            begin
              BtnShowLog.ScrollGraph:= True;
              BtnShowLog.ScrollInterval:= 35;
              BtnGetCurrent.ScrollGraph:= True;
              BtnGetCurrent.ScrollInterval:= 35;
            end else
            begin
              BtnShowLog.ScrollGraph:= False;
              BtnShowLog.ScrollInterval:= 180;
              BtnGetCurrent.ScrollGraph:= False;
              BtnGetCurrent.ScrollInterval:= 180;
            end;
          end;
    end;
end;

procedure TFMailAtt.SbMnuAccountsClick(Sender: TObject);
Begin
  // Pas de relevé en mode options
  GetButtonsEnable (False);
  With FAccounts do
  begin
    Caption:= AccountsSetup;
    Init(Setup, 0);
    AccountsResult(ShowModal);
  end;
  GetButtonsEnable (True);
end;


Function TFMailAtt.AccountsResult(mr: integer): Integer;
var
  MyAccount: TAccount;
  Index: integer;
  //i: integer;
begin
  Result:= -1;
    With FAccounts Do
    Case mr of
     //{Case ShowModal of
      mrRetry: begin
                 MailAccounts.Assign(FAccounts.CurMailAccs, laCopy);
                 MailAccounts.SaveXML(AccountsFile);
                 UpdateAccountsList(LVAccounts, MailAccounts);
               end;
      mrYes: begin// Add NewAccount
               MyAccount.Enabled:= CBActiveAcc.Checked;
               MyAccount.AccountName:= EName.Text;
               MyAccount.AccountIndex:= MailAccounts.Count;
               MyAccount.Protocol:= 1;
               MyAccount.Color:= CBColorAcc.Selected;
               MyAccount.MailClient:= EMailCli.Text;
               MyAccount.Sound:= ESound.Text;
               MyAccount.Interval:= EInterval.Value;
               MyAccount.Email:= EEmail.Text;
               MyAccount.ReplyEmail:= EReplyEmail.Text;
               Index:= MailAccounts.AddAccount(MyAccount);
               // propriétés du client POP3
               MailAccounts.GetItem(Index).POP3Cli.Host:= EServer.Text;
               MailAccounts.GetItem(Index).POP3Cli.Port:= EPort.Text;
               MailAccounts.GetItem(Index).POP3Cli.UserName:= EUser.Text;
               MailAccounts.GetItem(Index).POP3Cli.Password:= EPass.Text;
               MailAccounts.GetItem(index).POP3Cli.Tag:= Index;
               MailAccounts.GetItem(index).POP3Cli.Name:= 'POP3Cli'+IntToStr(Index);
               MailAccounts.GetItem(index).POP3Cli.AuthType:= TPop3AuthType(Integer(CBAuth.Checked));
               MailAccounts.GetItem(index).POP3Cli.SslType:= TPop3SslType(CBSSL.ItemIndex);
               // Propriétés du timer
               MailAccounts.GetItem(index).Timer.Tag:= Index;
               MailAccounts.GetItem(index).Timer.Name:= 'Timer'+IntToStr(Index);
               MailAccounts.GetItem(index).Timer.Interval:= 1000;
               MailAccounts.GetItem(index).Timer.Enabled:= True;
               MailAccounts.SaveXML(AccountsFile);
               UpdateAccountsList(LVAccounts, MailAccounts);
               AddAccountsMenu;
               MailAccounts.GetItem(index).log.Add(Formatte(AddedAccount,
                             [MailAccounts.GetItem(index).AccountName, DateTimeToStr(now())]));
               SetAccountEvents(index);
               Result:= Index;
             end;
      mrAll: begin// Modify account
               Index:= LVPrefAccs.ItemIndex;
               if MailAccounts.GetItem(Index).Pending then
               begin
                 ShowMessage(AccountBusy+#10#13+CannotModify);
                 Exit;
               end;
               TAccount(MailAccounts.Items[Index]^).Enabled:= CBActiveAcc.Checked;
               //MyAccount.Enabled:= CBActiveAcc.Checked;
               TAccount(MailAccounts.Items[Index]^).AccountName:= EName.Text;
               //MyAccount.AccountName:= EName.Text;
               TAccount(MailAccounts.Items[Index]^).Protocol:= 1;
               //MyAccount.Protocol:= 1;
               TAccount(MailAccounts.Items[Index]^).Color:= CBColorAcc.Selected;
               //MyAccount.Color:= CBColorAcc.Selected;
               TAccount(MailAccounts.Items[Index]^).MailClient:= EMailCli.Text;
               //MyAccount.MailClient:= EMailCli.Text;
               TAccount(MailAccounts.Items[Index]^).Sound:= ESound.Text;
               //MyAccount.Sound:= ESound.Text;
               TAccount(MailAccounts.Items[Index]^).Interval:= EInterval.Value;
               //MyAccount.Interval:= StrToInt(EInterval.Text);
               //MailAccounts.UpdateAccount(Index, MyAccount);
               TAccount(MailAccounts.Items[Index]^).Email:= EEmail.Text;
               TAccount(MailAccounts.Items[Index]^).ReplyEmail:= EReplyEmail.Text;
               MailAccounts.GetItem(Index).POP3Cli.Host:= EServer.Text;
               MailAccounts.GetItem(Index).POP3Cli.Port:= EPort.Text;
               MailAccounts.GetItem(Index).POP3Cli.UserName:= EUser.Text;
               MailAccounts.GetItem(Index).POP3Cli.Password:= EPass.Text;
               MailAccounts.GetItem(Index).POP3Cli.AuthType:= TPop3AuthType(Integer(CBAuth.Checked));
               MailAccounts.GetItem(index).POP3Cli.SslType:= TPop3SslType(CBSSL.ItemIndex);
               MailAccounts.SaveXML(AccountsFile);
               UpdateAccountsList(LVAccounts, MailAccounts);
               AddAccountsMenu;
               MailAccounts.GetItem(index).log.Add(Formatte(ChangedAccount,
                             [MailAccounts.GetItem(index).AccountName, DateTimeToStr(now())]));

               Result:= Index;
             end;
      mrNo: if LVPrefAccs.ItemIndex >= 0 then
            begin
               Index:= LVPrefAccs.ItemIndex;
               // On n'efface pas si le compte est en train de relever son courrier
               if MailAccounts.GetItem(Index).Pending then
               begin
                 ShowMessage(AccountBusy+#10#13+CannotDelete);
                 Exit;
               end;
               MailAccounts.GetItem(index).log.Add(Formatte(DeletedAccount,
                             [MailAccounts.GetItem(index).AccountName, DateTimeToStr(now())]));
               MailAccounts.GetItem(index).log.SaveToFile(MailAppsData+'Account'+IntToStr(index)+'.log');
               MailAccounts.Delete(Index);
               MailAccounts.SaveXML(AccountsFile);;
               PopulateAccountsList(LVAccounts, MailAccounts);
               AddAccountsMenu;
            end;

    end;
end;

function TFMailAtt.ImportIAF(FileName: string): TAccount;
type
  TFieldDesc= record
    Typ, Id : Word;
    length: DWord;
  end;
  IAFHeader= record
    Signature : DWORD;
    Charset: DWord; // high : 5 ANSI, 7 Unicode
    unk1: DWORD
  end;
Const
  Password_seed : array [0..3] of Byte = ($75,$18,$15,$14);
	Password_header : array [0..1] of Byte= ($01,$01);
	Max_field_length = 4096;
  S_Z = $3F0;
  D_WORD = $3E9;
  L_BOOL = $3F5;
  B_INARY = $3F6;
  Account_Name = $1235;
  POP3_Server = $13C4;
  POP3_User_Name = $13C5;
  POP3_Port = $13C9;
  POP3_Use_Sicily = $13C8;
  POP3_Secure_Connection = $13CA;
  SMTP_Email_Address= $1432;
  SMTP_Reply_To_Email_Address= $1433;
var
  IAFStream: TFileStream;
  Buffer: array [0..Max_field_length] of Char;
  BufferW: array [0..Max_field_length] of WideChar;
    Value: Variant;
  i: Integer;
  FieldDesc: TFieldDesc;
  Header: IAFHeader;
  Unicode: Bool;
begin
  Try
    IAFStream:= TFileStream.Create(FileName, fmOpenRead	);
    // Header et infos du premier champ
    IAFStream.Read(Buffer, 12);
    CopyMemory(@Header, @Buffer, 12);
    // Check Header
    If Header.Signature <> $49414D66 then
    begin
      ShowMessage('Not a valid IAF file');
      IAFStream.Free;
      exit;
    end;
    If HiWord(Header.Charset)= 7 then Unicode:= True else Unicode:= False;
    For i:= 0 to 40 do
    begin
      IAFStream.Read(Buffer, SizeOf(TFieldDesc));
      CopyMemory(@FieldDesc, @Buffer,SizeOf(TFieldDesc));
      if FieldDesc.Id = 0 then break;
      IAFStream.Read(Buffer, FieldDesc.length);
      Case FieldDesc.Typ of
      // Zero terminated string
      S_Z : begin
              If Unicode then
              begin
                CopyMemory(@BufferW, @Buffer, FieldDesc.length);
                Value:= WideCharLenToString(BufferW, FieldDesc.length div 2);
              end else  Value:= Copy(Buffer, 1, FieldDesc.length);
      // Integer
            end;
      D_WORD: Value:= Ord(Buffer[0])+Ord(Buffer[1])*256+Ord(Buffer[2])*65536+Ord(Buffer[3])*16777216;
      L_BOOL: Value:= Bool(Ord(Buffer[0])+Ord(Buffer[1])*256+Ord(Buffer[2])*65536+Ord(Buffer[3])*16777216);
    end;
    Case FieldDesc.Id of
      Account_Name : Result.AccountName:= Value;
      POP3_Server: Result.Sound:= Value;        //POP3Cli.Host:= value;
      POP3_User_Name: Result.MailClient:= Value;   //POP3Cli.UserName:= value;
      //331744246: Result.POP3Cli.Password:= value;
      POP3_Port: Result.LastMessage:= value;  //POP3Cli.Port:= Value;
      POP3_Use_Sicily: Result.Pending:= value;  // Pop3Cli Auth
      POP3_Secure_Connection: Result.Interval:= value; // Pop3Cli SSLType
      SMTP_Email_Address: Result.Email:= value;
      SMTP_Reply_To_Email_Address: Result.ReplyEmail:= value;

    end
  end;
  ShowMessage(Result.Email);
  Result.Protocol:= 1;
  Result.Enabled:= True;
  IAFStream.Free;
  Except
    Result.Error:= True;
  end;
end;


function TFMailAtt.ImportOEAccount (FileName: String) : TAccount;
var
  OEAXML: TjanXMLParser2;
  iNode : TjanXMLNode2;
  i: Integer;
  xmlStream: TFileStream;
  Buffer: array [0..$FFFE] of char;
  BufferW: array[0..$FFFE] of WideChar;
begin
  try
  OEAXML:= TjanXMLParser2.create;
  xmlStream:= TFileStream.Create(FileName, fmOpenRead );
  xmlStream.Read(Buffer,xmlStream.size);
  If (Buffer[0]= 'ÿ') and (Buffer[1] = 'þ') then     //Unicode
  begin
    xmlStream.Seek(2, soFromBeginning);
    xmlStream.Read(BufferW, xmlstream.size-2);
    OEAXML.xml:= WideCharLenToString(BufferW, (xmlstream.size-2) div 2);
    //ShowMessage(OEAXML.xml);
  end else OEAXML.xml:= Copy(Buffer, 1, xmlStream.size ) ;
  //ShowMessage(OEAXML.declaration.attribute['encoding']);

  iNode := OEAXML.FirstChild;
 // i:= 0;
  while iNode <> nil do
  begin
  //Result.AccountName:=   OEAXML.getChildByName('Account_Name').text)
    if iNode.name = 'Account_Name' then  Result.AccountName:= iNode.text;
    if iNode.name = 'POP3_Server' then Result.Sound:=  iNode.text;          //POP3Cli.Host
    if iNode.name = 'POP3_User_Name' then Result.MailClient:= iNode.text;  //POP3Cli.UserName
    if iNode.name = 'SMTP_Email_Address' then Result.Email:= iNode.text;
    if iNode.name = 'SMTP_Reply_To_Email_Address' then Result.ReplyEmail:= iNode.text;
    if iNode.name = 'POP3_Use_Sicily' then Result.Pending:= Bool(StrToInt(iNode.text)); //POP3Cli.Auth
    if iNode.name = 'POP3_Secure_Connection' then Result.Interval:= StrToInt(iNode.text);  // SSL
    if iNode.name = 'POP3_Port' then
    begin
      i:= StrToInt('$'+iNode.text);
      Result.LastMessage:= IntToStr(i);      //POP3Cli.Port
    end;
    inode:=  inode.NextSibling;
  end;
  xmlStream.Free;
  OEAXML.Free;
  Result.Enabled:= True;
  except
    Result.Error:= TRue;
  end;
end;

procedure TFMailAtt.ImportOutlook (var Accounts: TAccountList; Prog: String);
var
  Reg: TRegistry;
  Strs: TStringList;
  AccsCount: Integer;
  MyAccount: TAccount;
  i: Integer;
  index: Integer;
  RegKey, MyKey: string;
  s: string;
  ver: integer;
begin
  //    ImportOutlook (OEAccounts, 'Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\Default Outlook Profile\9375CFF0413111d3B88A00104B2A6676');
  try
    Reg := TRegistry.Create;
    Strs:= TstringList.create;
    RegKey:= '';
    if Prog= 'OExpress' then RegKey:='Software\Microsoft\Internet Account Manager\Accounts';
    if Prog= 'Outlook' then
    begin
      Reg.RootKey := HKEY_CLASSES_ROOT;
      Reg.OpenKeyReadOnly('Outlook.Application\CurVer');
      s:= Reg.ReadString('');
      Reg.CloseKey;
      //i:= Pos('Outlook.Application', s);
      //if i > 0 then ver:= StrToInt
      ver:= StrToInt(copy(s,21, length(s)));
      If ver > 9 then RegKey:= 'Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\9375CFF0413111d3B88A00104B2A6676'
      else if ver = 9 then RegKey:= 'Software\Microsoft\Office\Outlook\OMI Account Manager\Accounts';
    end;
    if length(RegKey) = 0 then exit;
    Reg.RootKey := HKEY_CURRENT_USER;
    //RegKey:='Software\Microsoft\Internet Account Manager\Accounts';
    Reg.OpenKeyReadOnly(RegKey) ;
    strs.Clear;
    Reg.GetKeyNames(Strs);
    AccsCount:= 0;
    For i:= 0 to Strs.Count-1 do
    begin
      Reg.CloseKey;
      MyKey:= RegKey+'\'+Strs.strings[i];
      Reg.OpenKeyReadOnly(MyKey);
      if Reg.ValueExists('POP3 Server') then
      begin
        //Memo1.Lines.Add(Reg.ReadString('Account Name'));
        MyAccount.Enabled:= True;
        MyAccount.AccountName:= Reg.ReadString('Account Name');
        MyAccount.AccountIndex:= AccsCount;
        MyAccount.Protocol:= 1;
        MyAccount.MailClient:= DefMailClient;
        if Reg.ValueExists('SMTP Email Address') then
        MyAccount.Email:= Reg.ReadString('SMTP Email Address');
        if Reg.ValueExists('SMTP Reply To Email Address') then
        MyAccount.ReplyEmail:= Reg.ReadString('SMTP Reply To Email Address');
        index:= Accounts.AddAccount(MyAccount);
        Accounts.GetItem(index).POP3Cli.Host:= Reg.ReadString('POP3 Server');
        if Reg.ValueExists('POP3 Port') then
        Accounts.GetItem(index).POP3Cli.Port:= IntToStr(Reg.ReadInteger('POP3 Port'));
        Accounts.GetItem(index).POP3Cli.UserName:= Reg.ReadString('POP3 User Name');
        if Reg.ValueExists('POP3 Use Sicily')then
        Accounts.GetItem(index).POP3Cli.AuthType:= TPop3AuthType(Reg.ReadInteger('POP3 Use Sicily'));
        if Reg.ValueExists('POP3 Secure Connection') then
        Accounts.GetItem(index).POP3Cli.SslType:= TPop3SslType(Reg.ReadInteger('POP3 Secure Connection'));
        Inc(AccsCount);
        end;
      end;
    finally
      //Reg.CloseKey;
      FreeAndNil (strs);
      FreeAndNil(Reg);
    end;
end;

procedure TFMailAtt.ImportWLM(var Accounts: TAccountList; StoreRoot: string);
var
  List: TstringList;
  Rec: TSearchRec;
  Path: String;
  i: integer;
  index: integer;
  MyAccount: TAccount;
begin
  // On parcourt les dossiers de WLMStoreRoot
  List:= TStringList.Create;
  Path := IncludeTrailingPathDelimiter(StoreRoot) ;
  if FindFirst (Path+'*.*', faDirectory, Rec) = 0 then
  try
    repeat
      if (Rec.Attr and faDirectory > 0) then
      List.Add(Path+Rec.Name) ;
    until FindNext(Rec) <> 0;
  finally
    FindClose(Rec) ;
  end;

  For i:= 0 to List.Count-1 do
  begin
    Path := IncludeTrailingPathDelimiter(List.Strings[i]);
    if FindFirst (Path+'*.oeaccount', faAnyfile, Rec) = 0 then
      try
        repeat
           MyAccount:= ImportOEAccount(Path+Rec.Name);
           if length (MyAccount.Sound) > 0 then         // On a trouvé un client pop3 
           begin
             Index:= Accounts.AddAccount(MyAccount);
             Accounts.GetItem(index).POP3Cli.Host:= MyAccount.Sound;
             Accounts.GetItem(index).POP3Cli.Port:= MyAccount.LastMessage;
             Accounts.GetItem(index).POP3Cli.UserName:= MyAccount.MailClient;
             Accounts.GetItem(index).POP3Cli.AuthType:= TPop3AuthType(Integer(Accounts.GetItem(index).Pending));
             Accounts.GetItem(index).POP3Cli.SslType:= TPop3SslType(Accounts.GetItem(index).Interval);
             MyAccount.AccountIndex:= Index;
             MyAccount.Protocol:= 1;
             MyAccount.MailClient:= DefMailClient;
             MyAccount.Sound:= '';
             MyAccount.Interval:= 0;
             MyAccount.LastMessage:= '';
             MyAccount.Pending:= False;
             Accounts.UpdateAccount(index, MyAccount);
           end;
        until FindNext(Rec) <> 0;
      finally
        FindClose(Rec) ;
      end;
  end;

  List.Free;
end;



procedure TFMailAtt.SbMnuImportClick(Sender: TObject);
var
 // Strs: TStringList;
  //MyKey: String;
  index : Integer;
  OEAccounts: TAccountList;
  MyAccount: TAccount;
  s: string;
begin

  OEAccounts:= TAccountLIst.Create;
  GetButtonsEnable (False);
  s:= Copy(TButton(Sender).Name, 12, length(TButton(Sender).Name));
 // Récupération des comptes OE et outlook
 if (s = 'Outlook') or (s = 'OExpress') then
 begin
    ImportOutlook (OEAccounts, s); //'Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\Default Outlook Profile\9375CFF0413111d3B88A00104B2A6676');
    if s = 'OExpress' then s:= 'Outlook Express';
    if OEAccounts.Count = 0 then
    begin
      if s = 'OExpress' then s:= 'Outlook Express';
      ShowMessage(Formatte(NoAccountFound, [s])) ;
      FAccounts.Caption:= AccountsImport+': '+s;
      GetButtonsEnable (True);
      exit;
    end else FAccounts.Caption:= AccountsImport+': '+s;
  end;
  // Récupération Windows Live Mail  ou Windows Mail
  if (s = 'WLM') or (s = 'WMail') then
  begin
    if s = 'WLM' then s:= WLMStoreRoot;
    if s = 'WMail' then s:= WMailStoreRoot;
    ImportWLM (OEAccounts, s );
    if s = 'WLM' then s:= 'Windows Live Mail' else s:= 'Windows Mail';
    if OEAccounts.Count = 0 then
    begin
      ShowMessage(Formatte(NoAccountFound, [s])) ;
      GetButtonsEnable (True);
      exit;
    end else FAccounts.Caption:= AccountsImport+': '+s;
  end;
  // Récupération fichiers IAF
  if  s = 'IAF' then
  begin
    OD1.Title:= StringReplace(MnuImport.Caption, '&', '',[rfReplaceAll])+' '+ImportIAFCaption;
    OD1.InitialDir:= MyDocs;
    OD1.Filter:= ImportIAFCaption+'(*.IAF)|*.IAF';
    if OD1.Execute then
    begin
      MyAccount := ImportIAF(OD1.FileName);
      if MyAccount.Error then
      begin
        ShowMessage (FileReadErr+' '+OD1.FileName);
        GetButtonsEnable (True);
        OEAccounts.Free;
        Exit;
      end;
        FAccounts.Caption:= AccountsImport+': '+ImportIAFCaption;
        MyAccount.AccountIndex:= 0;
        MyAccount.Protocol:= 1;
        Index:= OEAccounts.AddAccount(MyAccount);
        OEAccounts.GetItem(index).POP3Cli.Host:= MyAccount.Sound;
        OEAccounts.GetItem(index).POP3Cli.Port:= MyAccount.LastMessage;
        OEAccounts.GetItem(index).POP3Cli.UserName:= MyAccount.MailClient;
        OEAccounts.GetItem(index).POP3Cli.AuthType:= TPop3AuthType(Integer(OEAccounts.GetItem(index).Pending));
        OEAccounts.GetItem(index).POP3Cli.SslType:= TPop3SslType(OEAccounts.GetItem(index).Interval);
        MyAccount.MailClient:= DefMailClient;
        MyAccount.Sound:= '';
        MyAccount.Interval:= 0;
        MyAccount.LastMessage:= '';
        MyAccount.Pending:= False;
        OEAccounts.UpdateAccount(index, MyAccount);
    end else
    begin
      GetButtonsEnable (True);
      exit;
    end;
  end;
  // Fichiers OEAccounts
  if s = 'OEAcc' then
  begin
      OD1.Title:= StringReplace(MnuImport.Caption, '&', '',[rfReplaceAll])+' '+ImportOEAccCaption;
      OD1.InitialDir:= MyDocs;
      OD1.Filter:= ImportOEAccCaption+'(*.OEAccount)|*.OEAccount';
      if OD1.Execute then
      begin
        MyAccount:= ImportOEAccount (OD1.FileName);
        if MyAccount.Error then
        begin
          ShowMessage (FileReadErr+' '+OD1.FileName);
          GetButtonsEnable (True);
          OEAccounts.Free;
          Exit;
        end;
        FAccounts.Caption:= AccountsImport+': '+ImportOEAccCaption;
        MyAccount.AccountIndex:= 0;
        MyAccount.Protocol:= 1;
        Index:= OEAccounts.AddAccount(MyAccount);
        OEAccounts.GetItem(index).POP3Cli.Host:= MyAccount.Sound;
        OEAccounts.GetItem(index).POP3Cli.Port:= MyAccount.LastMessage;
        OEAccounts.GetItem(index).POP3Cli.UserName:= MyAccount.MailClient;
        OEAccounts.GetItem(index).POP3Cli.AuthType:= TPop3AuthType(Integer(OEAccounts.GetItem(index).Pending));
        MyAccount.MailClient:= DefMailClient;
        MyAccount.Sound:= '';
        MyAccount.LastMessage:= '';
        MyAccount.Pending:= False;
        OEAccounts.UpdateAccount(index, MyAccount);

      end else
    begin
      GetButtonsEnable (True);
      exit;
    end;
  end;

  With FAccounts do
  begin
    Caption:= AccountsImport;
    Init(Import, 0);
    {BtnAdd.Visible:= False;
    BtnDel.Visible:= False;
    BtnApply.Visible:= False;
    BtnCancel.Visible:= True;
    BtnOK.Visible:= True;
    BtnOK.Enabled:= True;
    BtnOK.Caption:= BtnAddCaption;
    BtnOK.ModalResult:=  mrYes;  }
   //PageCtrl.ActivePage:= TSAccounts;
    //BtnDel.Visible:= False;
    PopulateAccountsList (LVPrefAccs, OEAccounts);
    UpdateLV(OEAccounts, OEAccounts.Count);
    //FPrefs.TSOptions.TabVisible:= False;      //LVPrefAccsClick(Sender);
   AccountsResult(ShowModal);
    //BtnDel.Visible:= True;
    //TSOptions.TabVisible:= True;
  end;
  GetButtonsEnable (True);
  OEAccounts.Free;
end;

procedure TFMailAtt.LVAccountsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
  var
    s: string;
  begin
  If LVAccounts.ItemIndex >=0 then
  begin
    PopulateMsgList(LVAccounts.ItemIndex);
    Status.Panels[0].Text:= MailAccounts.GetItem(LVAccounts.ItemIndex).LastMessage;
    LAccountName.Caption:= AccountCaption+': '+MailAccounts.GetItem(LVAccounts.ItemIndex).AccountName;
    If length(MailAccounts.GetItem(LVAccounts.ItemIndex).Email) > 0 then;
    LAccountName.Caption:= LAccountName.Caption+#10#13+
                             EmailAddress+': '+MailAccounts.GetItem(LVAccounts.ItemIndex).Email;
    If length(MailAccounts.GetItem(LVAccounts.ItemIndex).ReplyEmail) > 0 then
    LAccountName.Caption:= LAccountName.Caption+#10#13+
                             ReplyEmailAddress+': '+MailAccounts.GetItem(LVAccounts.ItemIndex).ReplyEmail;
    If MailAccounts.GetItem(LVAccounts.ItemIndex).LastFire > 0 then
    LAccountName.Caption:= LAccountName.Caption+#10#13+
                             LastChkCaption+': '+DateTimeToStr(MailAccounts.GetItem(LVAccounts.ItemIndex).LastFire);
    If MailAccounts.GetItem(LVAccounts.ItemIndex).NextFire > 0 then
    LAccountName.Caption:= LAccountName.Caption+#10#13+
                             NextChkCaption+': '+DateTimeToStr(MailAccounts.GetItem(LVAccounts.ItemIndex).NextFire);
    // Texte des boutons défilants
    s:= Formatte(BtnGetCurrentCaption, [MailAccounts.GetItem(LVAccounts.ItemIndex).AccountName]);
    BtnGetCurrent.Tag:= LVAccounts.ItemIndex;
    BtnGetCurrent.Hint:= s;
    //BtnCurrent.Tag:= BtnGetCurrent.Tag;
    BtnGetCurrent.Caption:= s;
    //BtnCurrent.Hint:= s;
    s:= Formatte(AccountLogCaption, [MailAccounts.GetItem(LVAccounts.ItemIndex).AccountName]);
    BtnShowLog.Hint:= s;
    BtnShowLog.Caption:= s;
    BtnShowLog.Hint:= s;

    s:= MailAccounts.GetItem(LVAccounts.ItemIndex).MailClient;
    if length(s) = 0 then s:= CommonMailClient;
    ChangeMailClient(s);
    //MnuGetCurrent.Caption:= s;
    //PTrayMnuGetCurrent.Caption:= s;
  end;
end;


procedure TFMailAtt.PTrayMnuRestoreClick(Sender: TObject);
begin
  PTrayMnuRestore.Enabled:= False;
  PTrayMnuMinimize.Enabled:= True;
  PTrayMnuMaximize.Enabled:= True;
  TrayMailAtt.ShowApplication;
end;

procedure TFMailAtt.PTrayMnuMinimizeClick(Sender: TObject);
begin
  PTrayMnuRestore.Enabled:= True;
  PTrayMnuMinimize.Enabled:= False;
  PTrayMnuMaximize.Enabled:= True;
  if TrayMailATT.ApplicationVisible then TrayMailATT.HideApplication;
end;

procedure TFMailAtt.TrayMailAttMinimizeToTray(Sender: TObject);
begin
  PTrayMnuRestore.Enabled:= True;
  PTrayMnuMaximize.Enabled:= True;
  PTrayMnuMinimize.Enabled:= False;
end;

procedure TFMailAtt.PTrayMnuMaximizeClick(Sender: TObject);
begin
  PTrayMnuRestore.Enabled:= True;
  PTrayMnuMinimize.Enabled:= True;
  PTrayMnuMaximize.Enabled:= False;
  if not TrayMailAtt.ApplicationVisible then TrayMailATT.ShowApplication;
  WindowState:= wsMaximized;
end;

procedure TFMailAtt.PTrayMnuQuitClick(Sender: TObject);
var
  index: integer;
  MailFileName: String;
begin

  if MailAccounts.Count > 0 then
  For index:= 0 to MailAccounts.Count-1 do
  try
    MailAccounts.GetItem(index).log.SaveToFile(MailAppsData+'Account'+IntToStr(index)+'.log');
    MailFileName:= MailAppsData+'Mail'+IntToStr(index)+'.xml';
    if FileExists (MailFileName) then DeleteFile (MailFileName);
    if MailAccounts.GetItem(index).MailList.Count > 0 then
       MailAccounts.GetItem(index).MailList.SaveXML(MailFileName);
  except
  end;
 if SaveConfig then Close;
end;





procedure TFMailAtt.TrayMailAttDblClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PTrayMnuRestoreClick(Sender);
end;

procedure TFMailAtt.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MailAccounts.Free;
  FreeAndNil(TrayProps.PrIcon);
  FreeAndNil(TrayMailAtt);
  FreeAndNil(langnums);
  FreeAndNil(langfile);
  CanClose:= True;
end;

procedure TFMailAtt.Pop3Cli1StateChange(Sender: TObject);
begin
  //Status.Panels[0].Text:= 'Change';
end;




procedure TFMailAtt.DrawTheIcon(Bmp: TBitmap; NewCount: integer; CircleColor: TColor);
var
  i : integer;
  s: string;
begin

  With Bmp.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := circlecolor;
    // Meme couleur que le masque
    If Brush.Color = $FF00FF then Brush.Color:= $FF03FF;
    Pen.Color := Brush.Color;
    Pen.Width:= 2;
    //Rectangle(ClipRect);
    // envelope
    if NewCount > 9 then Rectangle(3,1,15,12)
    else Ellipse(0,1,12,13);
    // font
    Font.Name := 'Arial';
    Font.Style := [fsBold];
    // Clair ou foncé ?
    if DarkColor(Brush.color) then Font.Color := clWhite
    else Font.Color := clBlack;
    Font.Size := 7;
    Brush.Style := bsClear;
    // number
    Case NewCount of
      -2: begin
            s:= '?';
            Font.Size := 8;
          end;
      -1: begin
            s:= '!';
            Font.Size := 8;
          end;
      else s:= IntToStr(NewCount);
    end;
    i := TextWidth(s) div 2;
    TextOut(6 - i,1,s);
  end;
end;

procedure TFMailAtt.MnuAboutClick(Sender: TObject);
var
 PTMGA, PTMGC, PTMLC, PTMR, PTMMi, PTMMa: Boolean;
begin
   ShowWindow(Application.Handle, SW_SHOW);
   // On désactive toutes les commandes du tray sauf la sortie pendant l'affichage de la boîte
   TrayMailAtt.OnDblClick:= nil;
   PTMGA:= PTrayMnuGetAll.Enabled;
   PTMGC:= PTrayMnuGetCurrent.Enabled;
   PTMLC:= PTrayMnuLaunchClient.Enabled;
   PTMR := PTrayMnuRestore.Enabled;
   PTMMi := PTrayMnuMinimize.Enabled;
   PTMMa := PTrayMnuMaximize.Enabled;
   With AboutBox do
   begin
     PTrayMnuAbout.Enabled:= False;
     PTrayMnuGetAll.Enabled:= False;
     PTrayMnuGetCurrent.Enabled:= False;
     PTrayMnuLaunchClient.Enabled:= False;
     PTrayMnuRestore.Enabled:= False;
     PTrayMnuMinimize.Enabled:= False;
     PTrayMnuMaximize.Enabled:= False;
     LastUpdate:= LastUpdChk;
     LUpdate.Hint:=  LastUpdateSearch+': '+DateToStr(LastUpdChk);
     ShowModal;
     LastUpdChk:= LastUpdate;
     PTrayMnuAbout.Enabled:=True;
     PTrayMnuGetAll.Enabled:= PTMGA;
     PTrayMnuGetCurrent.Enabled:= PTMGC;
     PTrayMnuLaunchClient.Enabled:= PTMLC;
     PTrayMnuRestore.Enabled:= PTMR;
     PTrayMnuMinimize.Enabled:= PTMMi;
     PTrayMnuMaximize.Enabled:= PTMMa;
     TrayMailAtt.OnDblClick:= TrayMailAttDblClick;
   end;
   if IsIconic (Application.handle) then ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TFMailAtt.ModLangue ;
var
  i: Integer;
  ts: TStrings;
begin
With LangFile do
  begin
    // Form
    Caption:= ReadString(LangStr, 'Caption', Caption);
    AboutBoxCaption:= ReadString(LangStr, 'AboutBoxCaption', AboutBox.Caption);
    UpdateCaption:= ReadString(LangStr, 'UpdateCaption', 'Recherche de mise à jour');
    UpdateAvailable:= ReadString(LangStr, 'UpdateAvailable','Nouvelle version %s disponible');

    AboutBox.Caption:= AboutBoxCaption+' '+FMailAtt.Caption;
    AboutBox.LUpdate.Caption:= UpdateCaption;
    AboutBox.ErrorMessage:= ReadString(LangStr, 'AboutBox.ErrorMessage', 'Erreur de lancement de l''URL');
    MnuUpdateCheck.Caption:= UpdateCaption;
    AccountCaption:= ReadString(LangStr, 'AccountCaption', 'Compte');
    LAccountName.Caption:= AccountCaption;
    GBAccounts.Caption:= AccountCaption+'s';
    FromCaption:= ReadString(LangStr, 'FromCaption', 'De');
    LVMail.Columns[0].Caption:= FromCaption;
    ToCaption:= ReadString(LangStr, 'ToCaption', 'A');
    LVMail.Columns[1].Caption:= ToCaption;
    SubjectCaption:= ReadString(LangStr, 'SubjectCaption', 'Objet');
    LVMail.Columns[2].Caption:= SubjectCaption;
    DateCaption:= ReadString(LangStr, 'DateCaption', 'Date');
    LVMail.Columns[3].Caption:= DateCaption;
    SizeCaption:= ReadString(LangStr, 'SizeCaption', 'Taille');
    LVMail.Columns[4].Caption:= SizeCaption;
    ByteCaption:= ReadString(LangStr, 'ByteCaption', 'Octets');
    GBInfo.Caption:= ReadString(LangStr, 'GBInfo.Caption', GBInfo.Caption);
    MnuFiles.Caption:= ReadString(LangStr, 'MnuFiles.Caption', MnuFiles.Caption);
    MnuImport.Caption:= ReadString(LangStr, 'MnuImport.Caption', MnuImport.Caption);
    SbMnuImportOExpress.Caption:= ReadString(LangStr, 'SbMnuImportOExpress.Caption', SbMnuImportOExpress.Caption);
    SbMnuImportOutlook.Caption:= ReadString(LangStr, 'SbMnuImportOutlook.Caption', SbMnuImportOutlook.Caption);
    SbMnuImportWMail.Caption:= ReadString(LangStr, 'SbMnuImportWMail.Caption', SbMnuImportWMail.Caption);
    SbMnuImportWLM.Caption:= ReadString(LangStr, 'SbMnuImportWLM.Caption', SbMnuImportWLM.Caption);
    ImportIAFCaption:= ReadString(LangStr, 'ImportIAFCaption', SbMnuImportIAF.Caption);
    SbMnuImportIAF.Caption:= ImportIAFCaption;
    ImportOEAccCaption:=ReadString(LangStr, 'SbMnuImportOEAcc.Caption', SbMnuImportOEAcc.Caption);
    SbMnuImportOEAcc.Caption:= ImportOEAccCaption;
    MnuClose.Caption:= ReadString(LangStr, 'MnuClose.Caption', MnuClose.Caption);
    MnuQuit.Caption:= ReadString(LangStr, 'MnuQuit.Caption', MnuQuit.Caption);
    PTrayMnuQuit.Caption:= MnuQuit.Caption;
    MnuMessages.Caption:= ReadString(LangStr, 'MnuMessages.Caption', MnuMessages.Caption);
    MnuGetAll.Caption:= ReadString(LangStr, 'MnuGetAll.Caption', MnuGetAll.Caption);
    BtnGetAll.Caption:= MnuGetAll.Caption;
    //BtnShowLog.Caption:= ReadString(LangStr, 'BtnShowLog.Caption', BtnShowLog.Caption);
    PTrayMnuGetAll.Caption:= MnuGetAll.Caption;
    BtnGetCurrentCaption:= ReadString(LangStr, 'BtnGetCurrentCaption', 'Vérifier le compte %s');
    PMnuAnswer.Caption:= ReadString(LangStr, 'PMnuAnswer.Caption', PMnuAnswer.Caption);
    SelectCaption:= ReadString(LangStr, 'SelectCaption', SelectCaption);
    //BtnGetCurrent.Caption:= Format(BtnGetCurrentCaption, [SelectCaption]);
    BtnGetCurrent.Caption:= Formatte(BtnGetCurrentCaption, [SelectCaption]);
    MnuGetCurrent.Caption:= ReadString(LangStr, 'MnuGetCurrent.Caption', MnuGetCurrent.Caption);
    PTrayMnuGetCurrent.Caption:= MnuGetCurrent.Caption;
    MnuDeleteMsgCaption:= ReadString(LangStr, 'MnuDeleteMsgCaption', 'Effacer le$s message$s');
    MnuRestoreMsgCaption:= ReadString(LangStr, 'MnuRestoreMsgCaption', 'Restaurer le$s message$s');
    MnuDeleteSelMsgCaption:= ReadString(LangStr, 'MnuDeleteSelMsgCaption', 'Effacer le message sélectionné');
    MnuDeleteMsg.Caption:= MnuDeleteSelMsgCaption;
    MnuPrefs.Caption:= ReadString(LangStr, 'MnuPrefs.Caption', MnuPrefs.Caption);
    SbMenuOptions.Caption:= ReadString(LangStr, 'SbMenuOptions.Caption', SbMenuOptions.Caption);
    SbMnuAccounts.Caption:= ReadString(LangStr, 'SbMnuAccounts.Caption', SbMnuAccounts.Caption);
    MnuAbout.Caption:= ReadString(LangStr, 'MnuAbout.Caption', MnuAbout.Caption);
    PTrayMnuAbout.Caption:= MnuAbout.Caption;
    MnuLaunchClient.Caption:= ReadString(LangStr, 'MnuLaunchClient.Caption', MnuLaunchClient.Caption);
    BtnLaunchClient.Caption:= MnuLaunchClient.Caption;
    PTrayMnuLaunchClient.Caption:= MnuLaunchClient.Caption;
    MnuHelp.Caption:= ReadString(LangStr, 'MnuHelp.Caption', MnuHelp.Caption);
    EmailAddress:= ReadString(LangStr, 'EmailAddress', 'Adresse mail');
    //LEmail.Caption:= EmailAddress;
    ReplyEmailAddress:= ReadString(LangStr, 'ReplyEmailAddress', 'Adresse de réponse');
    //LReplyEmail.Caption:= ReplyEmailAddress;
    LastChkCaption:= ReadString(LangStr, 'LastChkCaption', 'Dernière vérification');
    //LLastChk.Caption:= LastChkCaption;
    NextChkCaption:= ReadString(LangStr, 'NextChkCaption', 'Prochaine vérification');
    //LNextChk.Caption:= NextChkCaption;

    AccountBusy:= ReadString(LangStr, 'AccountBusy', 'Vérification du courrier en cours');
    CannotModify:= ReadString(LangStr, 'CannotModify', 'modification impossible');
    CannotDelete:= ReadString(LangStr, 'CannotDelete', 'suppression impossible');
    Connecting:= ReadString(LangStr, 'Connecting', 'Connection au serveur de courrier %s...');
    ConnectionError:=  ReadString(LangStr, 'ConnectionError', 'Erreur de connexion');
    Authenticating:= ReadString(LangStr, 'Authenticating', 'Authentification de %s...');
    SendingUserName:= ReadString(LangStr, 'SendingUserName', 'Envoi de l''identifiant de %s');
    SendingPassword:= ReadString(LangStr, 'SendingPassword', 'Envoi du mot de passe de %s');
    AuthenticatingError:= ReadString(LangStr, 'AuthenticatingError', 'Erreur d''authentification');
    CountingMessages:= ReadString(LangStr, 'CountingMessages', 'Compte les messages de %s');
    ListingMessages:= ReadString(LangStr, 'ListingMessages', 'Décompte du message #%u de %s');
    NoMailFound:= ReadString(LangStr, 'NoMailFound', 'Pas de message trouvé sur %s');
    RetrievingUIDLs:= ReadString(LangStr, 'RetrievingUIDLs', 'Récupération de l''UIDL #%u de %s');
    RetrievingHeaders:= ReadString(LangStr, 'RetrievingHeaders', 'Récupération de l''entête de message #%u de %s');
    RetrievingCompleted:= ReadString(LangStr, 'RetrievingCompleted', 'Récupération terminée');

    GotMessages:= ReadString(LangStr, 'GotMessages', 'Trouvé %u message(s) sur le compte %s à %s');
    MailFound:= ReadString(LangStr, 'MailFound','%u message(s) trouvé(s) sur %s');
    DeletingMessage:= ReadString(LangStr, 'DeletingMessage', 'Effacement du message %s de %s');
    CurrChecking:= ReadString(LangStr, 'CurrChecking', 'Vérification en cours');
    AbortTimeout:= ReadString(LangStr, 'AbortTimeout', 'Abandon par dépassement de délai le %s');
    NoNewMail:= ReadString(LangStr, 'NoNewMail', 'Pas de nouveau message') ;
    NextCheckCaption:= ReadString(LangStr, 'NextCheckCaption', 'Prochaine vérification le %s');
    SessionClosedCaption:= ReadString(LangStr, 'SessionClosedCaption', '%s: session %s terminée');
    NewMessagesCaption:= ReadString(LangStr, 'NewMessagesCaption', '%u nouveaux message(s) le %s');
    DeleteMessagesBox:= ReadString(LangStr, 'DeleteMessagesBox',
                         'Cliquez sur Oui pour effacer immédiatement le$s message$s %s'+
                         'ou sur Non pour effacer le$s message$s à la prochaine vérification.');
    DeleteMessages:= ReadString(LangStr, 'DeleteMessages', 'Effacement de message(s)');

    NoAccountFound:= ReadString(LangStr, 'NoAccountFound', 'Pas de comptes %s trouvés');
    FileReadErr:= ReadString(LangStr, 'FileReadErr', 'Erreur de lecture de');
    AddedAccount:=ReadString(LangStr, 'AddedAccount' , 'Ajout du compte %s le %s');
    ChangedAccount:=ReadString(LangStr, 'ChangedAccount' , 'Modification du compte %s le %s');
    DeletedAccount:=ReadString(LangStr, 'DeletedAccount' , 'Suppression du compte %s le %s');
    LogCreated:=ReadString(LangStr, 'LogCreated', 'Log created on %s');
    NoLongerChkUpdates:= ReadString(LangStr, 'NoLongerChkUpdates','Ne plus rechercher les mises à jour');
    LastUpdateSearch:= ReadString(LangStr, 'LastUpdateSearch', 'Dernière recherche de mise à jour');
    MailToMissing:= ReadString(LangStr, 'MailToMissing', 'Protocole Mailto non configuré. Vérifiez la configuration de votre client courrier');
    //FAccounts
    AccountsSetup:= ReadString(LangStr, 'AccountsSetup', 'Configuration des comptes');
    AccountsImport:= ReadString(LangStr, 'AccountsImport', 'Importation de comptes');
    SelectMailClient:= ReadString(LangStr, 'SelectMailClient', 'Choisir le client mail');
    MailClientFile:= ReadString(LangStr, 'MailClientFile', 'Client Mail');
    SoundFile:= ReadString(LangStr, 'SoundFile', 'Fichier son');
    SelectSound:=  ReadString(LangStr, 'SelectSound', 'Choisir le son');
    With FAccounts do
    begin
      BtnAddCaption:= ReadString(LangStr, 'BtnAddCaption', 'Ajouter');
      BtnAdd.Caption:= BtnAddCaption;
      BtnCopyCaption:= ReadString(LangStr, 'BtnCopyCaption', 'Copie');
      BtnApply.Caption:= ReadString(LangStr, 'BtnApply.Caption', BtnApply.Caption);
      BtnDel.Caption:= ReadString(LangStr, 'BtnDel.Caption', BtnDel.Caption);
      BtnCancel.Caption:= ReadString(LangStr, 'BtnCancel.Caption', BtnCancel.Caption);
      CBActiveAcc.Caption:= ReadString(LangStr, 'CBActiveAcc.Caption', CBActiveAcc.Caption);
      LAccName.Caption:= ReadString(LangStr, 'LAccName.Caption', LAccName.Caption);
      PMnuAccsB.Caption:= ReadString(LangStr, 'PMnuAccsB.Caption', PMnuAccsB.Caption);
      PMnuAccsH.Caption:= ReadString(LangStr, 'PMnuAccsH.Caption', PMnuAccsH.Caption);
      PMnuAccsD.Caption:= ReadString(LangStr, 'PMnuAccsD.Caption', PMnuAccsD.Caption);
      CBSSL.Items[0]:= ReadString(LangStr, 'CBSSL.Items[0]', CBSSL.Items[0]);
      CBSSL.Items[1]:= ReadString(LangStr, 'CBSSL.Items[1]', CBSSL.Items[1]);
      CBSSL.Items[2]:= ReadString(LangStr, 'CBSSL.Items[2]', CBSSL.Items[2]);
      LHost.Caption:= ReadString(LangStr, 'LHost.Caption', LHost.Caption);
      LPort.Caption:= ReadString(LangStr, 'LPort.Caption', LPort.Caption);
      LProt.Caption:= ReadString(LangStr, 'LProt.Caption', LProt.Caption);
      CBAuth.Caption:= ReadString(LangStr, 'CBAuth.Caption', CBAuth.Caption);
      LUser.Caption:= ReadString(LangStr, 'LUser.Caption', LUser.Caption);
      LPass.Caption:= ReadString(LangStr, 'LPass.Caption', LPass.Caption);
      LColor.Caption:= ReadString(LangStr, 'LColor.Caption', LColor.Caption);
      LInterval.Caption:= ReadString(LangStr, 'LInterval.Caption', LInterval.Caption);
      LMin.Caption:= ReadString(LangStr, 'LMin.Caption', LMin.Caption);
      LMailCli.Caption:= ReadString(LangStr, 'LMailCli.Caption', LMailCli.Caption);
      LSound.Caption:= ReadString(LangStr, 'LSound.Caption', LSound.Caption);
      IntervalHint0:= ReadString(LangStr, 'IntervalHint0', 'Vérification automatique désactivée');
      IntervalHint1:= ReadString(LangStr, 'IntervalHint1',
                                 'Un intervalle trop faible peut bloquer votre compte.%s'+
                                 'Un minimum de 10 minutes est conseillé%s'+
                                 'Entrez 0 pour désactiver la vérification automatique');
      IntervalHint2:= ReadString(LangStr, 'IntervalHint2', 'Entrez 0 pour désactiver la vérification automatique');
       EInterval.Hint:= IntervalHint2;
      For i:= 0 to CBColorAcc.Items.Count-1 do
      begin
        CBColorAcc.Items[i]:= ReadString(LangStr, CBColorAcc.ColorNames[i], CBColorAcc.ColorNames[i]) ;
      end;
      WarningDelete:= ReadString(LangStr, 'WarningDelete',  'Voulez-vous vraiment effacer le compte %s');
    end;

    // FPrefs
    With FPrefs do
    begin
      Caption:= SbMenuOptions.Caption;
      BtnCancel.Caption:= ReadString(LangStr, 'BtnCancel.Caption', BtnCancel.Caption);
      CBStartWin.Caption:= ReadString(LangStr, 'CBStartWin.Caption', CBStartWin.Caption);
      CBStartMini.Caption:= ReadString(LangStr, 'CBStartMini.Caption', CBStartMini.Caption);
      CBSavSizePos.Caption:= ReadString(LangStr, 'CBSavSizePos.Caption', CBSavSizePos.Caption);
      CBMailClientMini.Caption:=ReadString(LangStr, 'CBMailClientMini.Caption', CBMailClientMini.Caption);
      CBRestNewMsg.Caption:= ReadString(LangStr, 'CBRestNewMsg.Caption', CBRestNewMsg.Caption);
      CBSaveLogs.Caption:= ReadString(LangStr, 'CBSaveLogs.Caption', CBSaveLogs.Caption);
      LMailCli.Caption:= ReadString(LangStr, 'LMailCli.Caption', LMailCli.Caption);
      LSound.Caption:= ReadString(LangStr, 'LSound.Caption', LSound.Caption);
      //SelectMailClient:= ReadString(LangStr, 'SelectMailClient', 'Choisir le client mail');
      //MailClientFile:= ReadString(LangStr, 'MailClientFile', 'Client Mail');
      //SoundFile:= ReadString(LangStr, 'SoundFile', 'Fichier son');
      //SelectSound:=  ReadString(LangStr, 'SelectSound', 'Choisir le son');
      LLanguage.Caption:= ReadString(LangStr, 'LLanguage.Caption', LLanguage.Caption);
      CBNoChkNewVer.Caption:= NoLongerChkUpdates;
      CBStartupCheck.Caption:= ReadString(LangStr, 'CBCheckstart.Caption', CBStartupCheck.Caption);
      CBSequentialCheck.Caption:= ReadString(LangStr, 'CBSequentialCheck.Caption', CBSequentialCheck.Caption);
      CBSmoothScroll.Caption:= ReadString(LangStr, 'CBSmoothScroll.Caption', CBSmoothScroll.Caption);
    end;
    AccountLogCaption:= ReadString(LangStr, 'AccountLogCaption', 'Journal du compte %s');
    //BtnShowLog.Caption:= AccountLogCaption;
    BtnShowLog.Caption:= Formatte(AccountLogCaption, [SelectCaption]);
    //LSBtnCurrent.CaptionScroll:= Formatte(BtnGetCurrentCaption, [SelectCaption]);
    With FLog do
    begin

      PMnuCopy.Caption:= ReadString(LangStr, 'PMnuCopy.Caption', PMnuCopy.Caption);
      PMnuCopyAll.Caption:= ReadString(LangStr, 'PMnuCopyAll.Caption', PMnuCopyAll.Caption);
    end
  end;
end;


procedure TFMailAtt.BtnLaunchClientClick(Sender: TObject);
var
  s: string;
begin
  try
    s:= MailAccounts.GetItem(LVAccounts.ItemIndex).MailClient;
  except
    s:='';
  end;
  //s:= MailAccounts.GetItem(LVAccounts.ItemIndex).MailClient;
  if length (s)= 0 then s:= CommonMailClient;
  if length(s) = 0 then s:= DefMailClient;
  Launch(handle, s, '', 'open') ;
  if MailClientMini then PTrayMnuMinimizeClick(Self);
end;

function TFMailAtt.ShowAlert(Title, AlertStr, StReplace, NoShow: String; var Alert: Boolean): Boolean;
begin
  Result:= False;
  With AlertBox do
  begin
    Caption:= Title;
    Image1.Picture.Icon:= Application.Icon;
    //cfgFile.ReadSection(AlertStr, MAlert.Lines);
    MAlert.Text:= StringReplace(AlertStr, '%s', stReplace, [rfIgnoreCase, rfReplaceAll]);
    //MAlert.Text:= AlertStr+' '+StReplace;
    CBNoShowAlert.Caption:= NoShow;
    CBNoShowAlert.Checked:= Alert;
    if not Alert then
    if ShowModal =mrOk then result:= True;
    Alert:= CBNoShowAlert.Checked;
  end;
end;




procedure TFMailAtt.Pop3CliSslVerifyPeer(Sender: TObject;
  var Ok: Integer; Cert: TX509Base);
begin
 //
end;

procedure TFMailAtt.MnuUpdateCheckClick(Sender: TObject);
begin
  With AboutBox do
  begin
    LUpdateClick(self);
    LastUpdChk:= LastUpdate;
    LUpdate.Hint:=  LastUpdateSearch+': '+DateToStr(LastUpdate);
  end;    
end;

procedure TFMailAtt.SbMnuHelpClick(Sender: TObject);
begin
 Launch(handle, ExtractFilePath(paramStr(0))+'MailAttente.chm','', 'open');
end;

procedure TFMailAtt.FormResize(Sender: TObject);
begin
  BtnGetAll.left:= (PanelBottom.Width div 2) - BtnGetAll.Width - 5;
  BtnGetCurrent.Left:= (PanelBottom.Width div 2) +5;
  BtnLaunchClient.Left:= BtnGetCurrent.Left + BtnGetCurrent.Width + 10;
  BtnShowLog.Left:= BtnGetAll.left - BtnShowLog.Width- 10;
end;



procedure TFMailAtt.Button1Click(Sender: TObject);
var
s : string;
begin
 s:= '0.9.0.4';
 SendMessage(handle, WM_INFO_UPDATE, WP_NewVersion, DWORD(PChar(s)));
end;



procedure TFMailAtt.PMnuAnswerClick(Sender: TObject);
var
  index: integer;
begin

  index:= LVAccounts.ItemIndex;
  if MouseMsgIndex < 0 then exit;
  if MailAccounts.GetItem(Index).MailList.count=0 then exit;
  With MailAccounts.GetItem(Index).MailList.GetItem(MouseMsgIndex) do
  begin
      {ShowAlert ('Réponse au message '+IntToStr(MessageNum), 'Le message va être envoyé avec le client courrier par défaut%s'+
             'Vous pourrez modifier le compte expéditeur si celui-ci ne correspond '+
             'pas à celui auquel le message était destiné.' ,#13#10, 'Test', Alert) ; }

    if not Launch (handle, 'mailto:'+FromAddress+'?Subject=Re:%20'+MessageSubject,'', 'open')
    then ShowMessage(MailToMissing);
    //MailToMissing  'Mailto protocol not set. Please check your mail client settings');

  end;
end;

procedure TFMailAtt.BtnShowClick(Sender: TObject);
begin
  Flog.Caption:= Formatte(AccountLogCaption, [MailAccounts.GetItem(LVAccounts.ItemIndex).AccountName]);
  Flog.RichEdit1.Text:= MailAccounts.GetItem(LVAccounts.ItemIndex).log.Text;
  FLog.ShowModal;
end;

procedure TFMailAtt.PanelBottomLeftResize(Sender: TObject);
begin
  PanelBottomLeft.Constraints.MaxHeight:= PanelLeft.Height-PanelTopLeft.Constraints.MinHeight-Splitter2.Height;
end;

// Explorer cashed and restarted, need to reload tray

procedure TFMailAtt.TrayMailAttCreateTaskBar(Sender: TObject);
begin
  ReadTrayIconProps(TrayProps);
  Application.ProcessMessages;
  CreateTrayIcon(TrayProps);
end;

end.







