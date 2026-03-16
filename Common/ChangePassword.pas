{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert
 Module:       Spoleèná funkcionalita
 File name:    ChangePassword.pas

 Description:  Zmìna hesla

 Author:       Michal Èervenka
 Creation:     14.10.2004
 Change:
   16.11.2006 AJ - zadání pùvodního hesla pøi zmìnì hesla
   20.02.2007 JH - zmìna Messages -> TStringList
   16.03.2007 TV - lokalizace
   22.05.2008 JH - Úprava pro nemultijazyèné verze
   03.11.2009 MÈ - Pøi kontrole hesla se pracuje se zašifrovaným textem
   02.07.2010 MÈ - Zmìna písma na Segoe UI
   06.12.2011 MÈ - Oprava spouštìní modulù po zmìnì hesla
   18.01.2012 MÈ - WinFormula má šifrovaná hesla
   09.02.2016 MÈ - Rozdìlení implementace csImplementationWinStock na csImplementationWiStBUCZ a csImplementationWiStAcerostar
   23.06.2019 MÈ - WinInsert má šifrovaná hesla (WiIn URS 015)
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit ChangePassword;

interface

uses
  Windows, SysUtils, StdCtrls, Buttons, Controls, ComCtrls, Forms, Classes, ADODB, DB, Dialogs,
  Common;

resourcestring
  resOldPasswordError = 'Nesprávnì zadané pùvodní heslo!';
  resNewPasswordError = 'Nové heslo musí být jiné než pùvodní!';
  resPasswordLengthError = 'Délka hesla musí být alespoò 6 znakù!';
  resReenterPasswordError = 'Nesprávné potvrzení hesla!';

type
  TfrmChangePassword = class(TMultiLangForm)
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    edtConfirmation: TEdit;
    edtPassword: TEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    spUusr_password: TADOStoredProc;
    Label3: TLabel;
    edtOldPassword: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  published
    {$IFDEF MULTILANGUAGE}
    procedure TranslateResourceStrings; override;
    {$ENDIF}
  public
    { Public declarations }
  end;

var
  frmChangePassword: TfrmChangePassword;

implementation

{$R *.dfm}

procedure TfrmChangePassword.btnOkClick(Sender: TObject);
var
  lbPasswordOk: Boolean;
begin
  btnOk.SetFocus;
  
  // WinFormula, WinProduction a WinInsert mají šifrovaná hesla
  if (gsImplementationCode = csImplementationWiStBUCZ) or (gsImplementationCode = csImplementationWiStAcerostar) then
  begin
    lbPasswordOk := AnsiUpperCase(edtOldPassword.Text) = AnsiUpperCase(gsUserPassword);
  end else
  begin
    lbPasswordOk := HashString(edtOldPassword.Text) = gsUserPassword;
  end;

  if not lbPasswordOk then
  begin
    // Nesprávnì zadané pùvodní heslo!
    MyMessageBox(resOldPasswordError, mtError, Screen.Activeform);
    edtOldPassword.SetFocus;
    Exit;
  end;

  if edtPassword.Text = gsUserPassword then
  begin
    // Nové heslo musí být jiné než pùvodní!
    MyMessageBox(resNewPasswordError, mtError, Screen.Activeform);
    edtPassword.SetFocus;
    Exit;
  end;

  if Length(edtPassword.Text) < 6 then
  begin
    // Délka hesla musí být alespoò 6 znakù!
    MyMessageBox(resPasswordLengthError, mtError, Screen.Activeform);
    edtPassword.SetFocus;
    Exit;
  end;

  if edtPassword.Text <> edtConfirmation.Text then
  begin
    // Nesprávné potvrzení hesla!
    MyMessageBox(resReenterPasswordError, mtError, Screen.Activeform);
    edtConfirmation.SetFocus;
    Exit;
  end;

  // update nové heslo
  spUusr_password.ProcedureName := CorrectSQL(spUusr_password.ProcedureName);

  if not ParametersRefresh(spUusr_password) then
  begin
    Exit;
  end;

  spUusr_password.Parameters.ParamByName('@p_n_usr_id').Value := gnUserId;
  spUusr_password.Parameters.ParamByName('@p_s_new_password').Value := edtPassword.Text;

  if MyExecProc(spUusr_password) then
  begin
    // WinFormula, WinProduction a WinInsert mají šifrovaná hesla
    if (gsImplementationCode = csImplementationWiStBUCZ) or (gsImplementationCode = csImplementationWiStAcerostar) then
    begin
      gsUserPassword := edtPassword.Text;
    end else
    begin
      gsUserPassword := HashString(edtPassword.Text);
    end;

    gsNotHashedUserPassword := edtPassword.Text;
    ModalResult := mrOk;
  end;
end;

procedure TfrmChangePassword.FormCreate(Sender: TObject);
begin
  // lokalizace
  inherited;
  InitTranslate('Common');
end;

{$IFDEF MULTILANGUAGE}
procedure TfrmChangePassword.TranslateResourceStrings;
begin
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resOldPasswordError),
    dmCommon.Languages.GetResourceStringValue('resOldPasswordError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resNewPasswordError),
    dmCommon.Languages.GetResourceStringValue('resNewPasswordError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resPasswordLengthError),
    dmCommon.Languages.GetResourceStringValue('resPasswordLengthError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resReenterPasswordError),
    dmCommon.Languages.GetResourceStringValue('resReenterPasswordError', slResourceString));
end;
{$ENDIF}

end.

