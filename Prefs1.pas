unit Prefs1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Ctrl_sup, ComCtrls, Mailattente1, ExtCtrls, mails1,
  Buttons, OleServer, CmAdmCtl, MMSystem;

type
  TFPrefs = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CBStartWin: TCheckBox;
    CBStartMini: TCheckBox;
    CBSavSizePos: TCheckBox;
    LMailCli: TLabel;
    EMailCli: TEdit;
    BtnMailClient: TSpeedButton;
    Lsound: TLabel;
    ESound: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    CBSaveLogs: TCheckBox;
    CBMailClientMini: TCheckBox;
    CBRestNewMsg: TCheckBox;
    CBLangue: TComboBox;
    LLanguage: TLabel;
    CBNoChkNewVer: TCheckBox;
    CBSequentialCheck: TCheckBox;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    CBStartupCheck: TCheckBox;
    CBSmoothScroll: TCheckBox;
    procedure FormActivate(Sender: TObject);
     procedure OptionsChange(Sender: TObject);
    procedure BtnMailClientClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
   private
    { Déclarations privées }
  public
    { Déclarations publiques }
    CanChange: Bool;

  end;

var
  FPrefs: TFPrefs;


implementation

{$R *.dfm}







procedure TFPrefs.OptionsChange(Sender: TObject);
begin
  //BtnOK.Visible:= TRue;
  //BtnOK.Caption:= 'Modifie';
  BtnOK.ModalResult:= mrYes;
 // TSAccounts.TabVisible:= False;
end;

procedure TFPrefs.FormActivate(Sender: TObject);
begin
  BtnOK.ModalResult:= mrOK;
  Canchange:= True;
end;






procedure TFPrefs.BtnMailClientClick(Sender: TObject);
begin
  With FMailAtt do
  begin
    OD1.Title:= SelectMailClient;
    OD1.Filter:= MailClientFile+' (*.exe)|*.exe';
    if FileExists (CommonMailClient) then
    OD1.InitialDir:= ExtractFilePath(CommonMailClient) else OD1.InitialDir:= ProgramFiles;
    if OD1.Execute then EMailCli.Text:= OD1.FileName;
  end;

end;

procedure TFPrefs.SpeedButton2Click(Sender: TObject);
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

procedure TFPrefs.SpeedButton1Click(Sender: TObject);
begin
  sndPlaySound(PChar(ESound.Text), SND_NODEFAULT Or SND_ASYNC Or SND_NOSTOP);
end;

end.
