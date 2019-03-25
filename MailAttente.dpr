program MailAttente;

{$R 'mailattres.res' 'mailattres.rc'}
{$R 'Win7UAC.res' 'Win7UAC.rc'}

uses
  Forms,
  MailAttente1 in 'MailAttente1.pas' {FMailAtt},
  mails1 in 'mails1.pas',
  Accounts1 in 'Accounts1.pas' {FAccounts},
  MailUtils in 'MailUtils.pas',
  Prefs1 in 'Prefs1.pas' {FPrefs},
  about in '..\..\BBComponents\about.pas' {AboutBox},
  Alert in '..\..\BBComponents\Alert.pas' {AlertBox},
  ChkNewVer in '..\..\BBComponents\ChkNewVer.pas' {FChkNewVer},
  log1 in 'log1.pas' {FLog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMailAtt, FMailAtt);
  Application.CreateForm(TFAccounts, FAccounts);
  Application.CreateForm(TFPrefs, FPrefs);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TAlertBox, AlertBox);
  Application.CreateForm(TFChkNewVer, FChkNewVer);
  Application.CreateForm(TFLog, FLog);
  Application.Run;
end.
