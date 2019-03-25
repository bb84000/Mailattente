unit Accounts1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Ctrl_sup, ComCtrls, Mailattente1, ExtCtrls, mails1,
  Buttons, OleServer, CmAdmCtl, MMSystem, Spin, Menus;

type
  TMode =(Setup, Import);
  TFAccounts = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CBActiveAcc: TCheckBox;
    EPort: TEdit;
    CBAuth: TCheckBox;
    EPass: TEdit;
    BtnMailClient: TSpeedButton;
    SBSound: TSpeedButton;
    EMailCli: TEdit;
    ESound: TEdit;
    LMin: TLabel;
    LInterval: TLabel;
    LPass: TLabel;
    LPort: TLabel;
    EName: TEdit;
    EServer: TEdit;
    EProt: TEdit;
    EUser: TEdit;
    CBColorAcc: TColorBox;
    LAccName: TLabel;
    LHost: TLabel;
    LProt: TLabel;
    LUser: TLabel;
    LColor: TLabel;
    LMailCli: TLabel;
    Lsound: TLabel;
    LVPrefAccs: TListView;
    CBSSL: TComboBox;
    LSSL: TLabel;
    SBTest: TSpeedButton;
    EInterval: TSpinEdit;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    BtnAdd: TBitBtn;
    BtnApply: TBitBtn;
    BtnDel: TBitBtn;
    LEmail: TLabel;
    EEmail: TEdit;
    LReply: TLabel;
    EReplyEmail: TEdit;
    PMnuAcc: TPopupMenu;
    PMnuAccsB: TMenuItem;
    PMnuAccsH: TMenuItem;
    PMnuAccsD: TMenuItem;
    procedure LVPrefAccsClick(Sender: TObject);
    procedure AccountsChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CBColorAccChange(Sender: TObject);
    procedure OptionsChange(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure LVPrefAccsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnMailClientClick(Sender: TObject);
    procedure SBSoundClick(Sender: TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure SBTestClick(Sender: TObject);
    procedure PMnuAccsClick(Sender: TObject);
    procedure PMnuAccPopup(Sender: TObject);
   
   private
    { Déclarations privées }
  public
    { Déclarations publiques }
    CurMailAccs: TAccountList ;
    AccsCnt: Integer;
    CanChange: Bool;
    BtnAddCaption, BtnCopyCaption: String;
    IntervalHint0, IntervalHint1, IntervalHint2: string;
    WarningDelete: string;
    procedure Init(mode: Tmode; index:integer);
    procedure updateLV(MailAccs: TAccountList; Cnt : Integer);

  end;

var

  FAccounts: TFAccounts;

Const
 sProtocol: array [1..2] of string = ('POP3', 'IMAP');

implementation

uses Types;

{$R *.dfm}

//uses MailAttente1;

procedure TFAccounts.Init(mode: Tmode; index: integer);

begin
  EName.Enabled:= True;
  CBSSL.Enabled:= True;
   EServer.Enabled:= True;
   Eprot.Enabled:= True;
   CBAuth.Enabled:= True;
   EUser.Enabled:= True;
   Epass.Enabled:= True;
   EEMail.Enabled:= True;
   EReplyEmail.Enabled:= True;
   CBColorAcc.Enabled:= True;
   Einterval.Enabled:= True;
   EMailCli.Enabled:= True;
   BtnMailClient.Enabled:= True;
   ESound.Enabled:= True;
   SBTest.Enabled:= True;
   SBSound.Enabled:= True;
  Case mode of
    Setup: begin
             BtnOK.Visible:= True;
             BtnAdd.Visible:= True;
             BtnAdd.Enabled:= True;
             BtnDel.Visible:= True;
             BtnDel.Enabled:= True;
             BtnOK.Caption:= 'OK';
             BtnOK.ModalResult:=mrOK;
             //BtnOK.ModalResult:= mrAll;
             //BtnOK.Enabled:= True;
             BtnApply.Visible:= True;
             BtnApply.Enabled:= False;
             BtnAdd.Caption:= BtnCopyCaption;
             if FMailAtt.MailAccounts.Count > 0 then
             begin
               CanChange:= False;
               CurMailAccs:= TAccountList.Create;
               CurMailAccs.Assign(FMailAtt.MailAccounts, laCopy);
               FMailAtt.PopulateAccountsList (LVPrefAccs, CurMailAccs);
               LVPrefAccs.Enabled:= True;
               LVPrefAccs.ItemIndex:= Index;
               UpdateLV(CurMailAccs, CurMailAccs.Count);
               CanChange:= True;
             end;
           end;
    Import: begin
              BtnAdd.Visible:= False;
              BtnDel.Visible:= False;
              BtnApply.Visible:= False;
              //BtnCancel.Visible:= True;
              //BtnOK.Visible:= True;
              //BtnOK.Enabled:= True;
              BtnOK.Caption:= BtnAddCaption;
              BtnOK.ModalResult:=  mrYes;
            end;
  end;
end;

procedure  TFAccounts.UpdateLV(MailAccs: TAccountList; Cnt : Integer);

begin
  AccsCnt:= Cnt;
  //CurMailAccs:= MailAccs;
  If BtnDel.Visible and (MailAccs.Count > 1) then BtnDel.Enabled:= True else BtnDel.Enabled:= False;
  
  //LVPrefAccs.Selected:= LVPrefAccs.Items[LVPrefAccs.ItemIndex];
  EName.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).AccountName;
  CBActiveAcc.checked:= MailAccs.GetItem(LVPrefAccs.ItemIndex).Enabled;
  CBAuth.Checked:= Bool(Ord(MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.AuthType));
  CBSSL.ItemIndex:= Ord(MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.SslType);
  If LVPrefAccs.ItemIndex < 0 then LVPrefAccs.ItemIndex:= 0;
  EServer.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.Host;
  EPort.Text:=  MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.Port;
  Eprot.Text:= sProtocol[MailAccs.GetItem(LVPrefAccs.ItemIndex).Protocol];
  EUser.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.UserName;
  EPass.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).POP3Cli.Password;
  EEmail.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).Email;
  EReplyEmail.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).ReplyEmail;
  CBColorAcc.Selected:= MailAccs.GetItem(LVPrefAccs.ItemIndex).Color;
  EMailCli.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).MailClient;
  ESound.Text:= MailAccs.GetItem(LVPrefAccs.ItemIndex).Sound;
  EInterval.value:= MailAccs.GetItem(LVPrefAccs.ItemIndex).Interval;
end;


procedure TFAccounts.LVPrefAccsClick(Sender: TObject);
begin
  if LVPrefAccs.ItemIndex < 0 then exit; 
  CanChange:= False;
  UpdateLV(CurMailAccs, AccsCnt);
  CanChange:= True;
end;

procedure TFAccounts.LVPrefAccsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CanChange:= False;
  UpdateLV(CurMailAccs, AccsCnt);
  CanChange:= True;
end;

procedure TFAccounts.CBColorAccChange(Sender: TObject);
var
  OldColor, NewColor: TColor;
begin
  OldColor:=  FMailAtt.MailAccounts.GetItem(LVPrefAccs.ItemIndex).Color;
  NewColor:= CBColorAcc.Selected;
  if NewColor = OldColor then exit;
  AccountsChange(Sender);
end;

procedure TFAccounts.AccountsChange(Sender: TObject);
begin
   // Si le bouton delete est caché, on est en import, donc pas de bouton modification
   if Canchange and BtnDel.Visible then
   begin
  //   BtnOK.Visible:= True;
     BtnOK.ModalResult:= mrAll;
     //BtnOK.Enabled:= True;
     BtnApply.Enabled:= True;
     BtnDel.Enabled:= False;
     BtnAdd.Enabled:= False;
     LVPrefAccs.Enabled:= False;
   //  TSOPtions.TabVisible:= False;
     If (TComponent(Sender).Name = 'EInterval') then
     Case TSpinEdit(Sender).value of
       0 : begin
             TSpinEdit(Sender).Hint:= IntervalHint0;
           end;
       1..9: begin
                 TSpinEdit(Sender).Hint:= StringReplace(IntervalHint1, '%s', #10#13, [rfReplaceAll]);
              end;
       else begin
              TSpinEdit(Sender).Hint:= IntervalHint2;
            end;
     end;
   end;
end;

procedure TFAccounts.OptionsChange(Sender: TObject);
begin
  //BtnOK.Visible:= TRue;
  //BtnOK.Caption:= 'Modifie';
 // TSAccounts.TabVisible:= False;
end;

procedure TFAccounts.FormActivate(Sender: TObject);
begin
  //BtnOK.Visible:= True;
 // BtnOK.Caption:= 'OK';
  //BtnOK.ModalResult:=mrOK;
  //BtnDel.Enabled:= True;
  //BtnAdd.Enabled:= True;
  LVPrefAccs.Enabled:= True;
  //TSOPtions.TabVisible:= True;
 // TSAccounts.TabVisible:= True;
  Canchange:= True;
  LVPrefAccs.SetFocus;
  //If LVPrefAccs.ItemIndex < 0 then LVPrefAccs.ItemIndex:= 0;
end;





procedure TFAccounts.BtnDelClick(Sender: TObject);
begin
  if MessageDlg(Format(WarningDelete, [CurMailAccs.GetItem(LVPrefAccs.ItemIndex).AccountName]), mtwarning,
[mbOk, mbCancel],0)= mrCancel then ModalResult:= mrCancel;
end;

procedure TFAccounts.BtnMailClientClick(Sender: TObject);
begin
  With FMailAtt do
  begin
    OD1.Title:= SelectMailClient;
    OD1.Filter:= MailClientFile+' (*.exe)|*.exe';
    if FileExists (DefMailClient) then
    OD1.InitialDir:= ExtractFilePath(DefMailClient) else OD1.InitialDir:= ProgramFiles;
    if OD1.Execute then EMailCli.Text:= OD1.FileName;
  end;
end;

procedure TFAccounts.SBSoundClick(Sender: TObject);
begin
  With FMailAtt do
  begin
    OD1.Title:= SelectSound; 

    OD1.Filter:= SoundFile+' (*.wav)|*.wav';
    //if FileExists (DefMailClient) then
    OD1.InitialDir:= MyDocs;
    if OD1.Execute then ESound.Text:= OD1.FileName;
  end;
end;

procedure TFAccounts.BtnApplyClick(Sender: TObject);
var
  Index: Integer;
begin
  Index:= LVPrefAccs.ItemIndex;
  BtnApply.ModalResult:= 0 ;
  FMailAtt.AccountsResult(mrAll);
  Init(Setup, Index);
end;

procedure TFAccounts.SBTestClick(Sender: TObject);
begin
  sndPlaySound(PChar(ESound.Text), SND_NODEFAULT Or SND_ASYNC Or SND_NOSTOP);
end;

procedure TFAccounts.PMnuAccsClick(Sender: TObject);
var
  Ndx: Integer;
begin
   Ndx:= LVPrefAccs.ItemIndex;
   Case TMenuItem(Sender).Name [9] of
     'B': begin
            CurMailAccs.Move(Ndx, Ndx+1);
            FMailAtt.PopulateAccountsList (LVPrefAccs, CurMailAccs);
            LVPrefAccs.ItemIndex:= Ndx+1;
          end;
           
     'H': begin
            CurMailAccs.Move(Ndx, Ndx-1);
            FMailAtt.PopulateAccountsList (LVPrefAccs, CurMailAccs);
            LVPrefAccs.ItemIndex:= Ndx-1;
          end;
     'D': begin
            BtnDelClick(Sender);
            exit;
          end;
   else exit;
   end;
   UpdateLV(CurMailAccs, CurMailAccs.Count);
   //AccountsChange(Sender);
   BtnApply.Enabled:= False;
   BtnAdd.Enabled:= False;
   EName.Enabled:= False;
   CBSSL.Enabled:= False;
   EServer.Enabled:= False;
   Eprot.Enabled:= False;
   CBAuth.Enabled:= False;
   EUser.Enabled:= False;
   Epass.Enabled:= False;
   EEMail.Enabled:= False;
   EReplyEmail.Enabled:= False;
   CBColorAcc.Enabled:= False;
   Einterval.Enabled:= False;
   EMailCli.Enabled:= False;
   BtnMailClient.Enabled:= False;
   ESound.Enabled:= False;
   SBTest.Enabled:= False;
   SBSound.Enabled:= False;
   BtnOK.ModalResult:=  mrRetry;
end;

procedure TFAccounts.PMnuAccPopup(Sender: TObject);
var
  Ndx: Integer;
begin
   if LVPrefAccs.SelCount = 0 then
   begin
     PMnuAccsB.visible:= False;
     PMnuAccsH.visible:= False;
     PMnuAccsD.Visible:= False;
     exit;
   end else PMnuAccsD.Visible:= True;
   Ndx:= LVPrefAccs.ItemIndex;
   if Ndx >= LVPrefAccs.Items.Count-1 then PMnuAccsB.visible:= False else PMnuAccsB.visible:= True;
   if Ndx <= 0 then PMnuAccsH.visible:= False else PMnuAccsH.visible:= True;
end;

end.
