unit log1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ClipBrd;

type
  TFLog = class(TForm)
    RichEdit1: TRichEdit;
    PEdit: TPopupMenu;
    PMnuCopy: TMenuItem;
    PMnuCopyAll: TMenuItem;
    procedure PMnuCopyClick(Sender: TObject);
    procedure PMnuCopyAllClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FLog: TFLog;

implementation

{$R *.dfm}

procedure TFLog.PMnuCopyClick(Sender: TObject);
begin
 Clipboard.AsText := Richedit1.SelText;
end;

procedure TFLog.PMnuCopyAllClick(Sender: TObject);
begin
   Clipboard.AsText := Richedit1.Text;

end;

end.
