{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert
 Module:       Spoleèná funkcionalita
 File name:    Login.pas

 Description:  Pøihlášovací okno

 Author:       Michal Èervenka
 Creation:     5.11.2004
 Change:
   20.02.2007 JH - Zmìna Messages -> TStringList
   16.03.2007 TV - Lokalizace
   22.05.2008 JH - Úprava pro nemultijazyèné verze
   22.07.2008 MÈ - Oprava úpravy pro nemultijazyèné verze
   10.05.2009 MÈ - Pøesun dvou resourcestringù do common
   02.07.2010 MÈ - Zmìna písma na Segoe UI
   07.05.2011 MÈ - Úpravy pro Delphi 2010
   06.01.2012 MÈ - Po zadání nesprávného hesla se oznaèí modøe zadané heslo
   11.01.2012 MÈ - Logování v modulu Pracovištì WinInsert
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Login;

interface

uses
  Windows, SysUtils, StdCtrls, Buttons, Controls, ComCtrls, Forms, Classes, DBCtrls, DB, ExtCtrls, Dialogs,
  Common;

resourceString
  resEnteredLoginError = 'Není zadaný kód!';
  resLoginOrPasswordError = 'Nesprávný kód nebo heslo!';

type
  TfrmLogin = class(TMultiLangForm)
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    edtJmeno: TEdit;
    edtHeslo: TEdit;
    cbChangeLang: TCheckBox;
    dsLng: TDataSource;
    cbDefaultLanguage: TDBLookupComboBox;
    lblDefaultLanguage: TLabel;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbChangeLangClick(Sender: TObject);
    procedure cbDefaultLanguageClick(Sender: TObject);
  private
    { Private declarations }
  published
    {$IFDEF MULTILANGUAGE}
    procedure TranslateResourceStrings; override;
    {$ENDIF}
  public
    { Public declarations }
    gsUserRightCode: String;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  {$IFDEF DEBUGGING}
  edtJmeno.Text := csAdmin;
  edtHeslo.Text := csAdminPassword;
  {$ENDIF}

  {$IFDEF MULTILANGUAGE}
  cbDefaultLanguage.KeyValue := dmCommon.Languages.UserLanguageCode;
  {$ENDIF}
end;

procedure TfrmLogin.btnOkClick(Sender: TObject);
var
  lbConnected: Boolean;
  lnCheckUser: Integer;
  lsMessage: String;
begin
  btnOk.SetFocus;

  if Trim(edtJmeno.Text) = '' then
  begin
    // Není zadaný kód!
    MyMessageBox(resEnteredLoginError, mtError, Screen.Activeform);
    edtJmeno.SetFocus;
    Exit;
  end;

  lbConnected := dmCommon.cnOperatorConnection.Connected;
  lnCheckUser := dmCommon.CheckUser(edtJmeno.Text, edtHeslo.Text);

  if lnCheckUser = 0 then
  begin
    if (AnsiUpperCase(Trim(edtJmeno.Text)) = AnsiUpperCase(csAdmin)) or dmCommon.CheckUserRights(frmLogin.gsUserRightCode) then
    begin
      if lbConnected or dmCommon.ConnectToMSSQL(dmCommon.cnOperatorConnection) then
      begin
        lsMessage := 'Úspìšné pøihlášení do modulu...';
        frmLogin.ModalResult := mrOk;
      end;
    end else
    begin
      if lbConnected then
      begin
        // Nemáte oprávnìní pro tuto èinnost!
        MyMessageBox(resNoActivityPermissionError, mtError, Screen.Activeform);
      end else
      begin
        // Nemáte oprávnìní spustit tento modul!
        MyMessageBox(resNoRunModulePermissionError, mtError, Screen.Activeform);
      end;

      lsMessage := 'Neúspìšné pøihlášení do modulu (uživatel nemá oprávnìní)...'
    end;
  end else
  if lnCheckUser = -1 then
  begin
    // Nesprávný kód nebo heslo!
    MyMessageBox(resLoginOrPasswordError, mtError, Screen.Activeform);
    edtHeslo.SetFocus;
    lsMessage := 'Neúspìšné pøihlášení do modulu (nesprávný kód nebo heslo)...'
  end else
  if lnCheckUser = -2 then
  begin
    // chyba pøi provádìní dotazu do databáze
  end;

  // Logování v modulu Pracovištì WinInsert
  if (gsImplementationCode = csImplementationWinInsert) and (AnsiLowerCase(gsModuleCode) = 'worksite') and
    (AnsiLowerCase(frmLogin.gsUserRightCode) = 'worksite') then
  begin
    DoWriteToLog(lsMessage);
    DoWriteToLog('  Uživatel: ' + edtJmeno.Text);
  end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  if (Trim(gsUserLogin) = '') and dmCommon.cnOperatorConnection.Connected then
  begin
    dmCommon.cnOperatorConnection.Close;
  end;

  {$IFDEF MULTILANGUAGE}
  if not MyOpenQuery(dmCommon.qrSlng) then
  begin
    Exit;
  end;
  {$ENDIF}

  // lokalizace
  inherited;
  InitTranslate('Common');
end;

procedure TfrmLogin.cbChangeLangClick(Sender: TObject);
begin
  cbDefaultLanguage.Enabled := cbChangeLang.Checked;
end;

procedure TfrmLogin.cbDefaultLanguageClick(Sender: TObject);
begin
  {$IFDEF MULTILANGUAGE}
  if dmCommon.Languages.UserLanguageCode <> cbDefaultLanguage.KeyValue then
  begin
    ChangeLanguage(cbDefaultLanguage.KeyValue);
  end;
  {$ENDIF}
end;

{$IFDEF MULTILANGUAGE}
procedure TfrmLogin.TranslateResourceStrings;
begin
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resEnteredLoginError),
    dmCommon.Languages.GetResourceStringValue('resEnteredLoginError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resLoginOrPasswordError),
    dmCommon.Languages.GetResourceStringValue('resLoginOrPasswordError', slResourceString));
end;
{$ENDIF}

end.

