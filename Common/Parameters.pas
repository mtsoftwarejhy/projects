{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert, Expedièní systém
 Module:       Spoleèná funkcionalita
 File name:    Parameters.pas

 Description:  Parametry pøíkazového øádku

 Author:       Michal Èervenka
 Creation:     04.11.2004
 Change:
   23.11.2006 MÈ - procedura MyMessageBox místo Windows.MessageBox
   07.12.2006 MÈ - zmìna parametrù procedury MyMessageBox
   20.02.2007 JH - zmìna Messages -> TStringList
   16.03.2007 TV - lokalizace
   25.05.2007 TV - odstranìní lokalizace (pøesunuto do Common.pas)
   21.02.2009 MÈ - Parametr /locktimeout
   20.04.2009 JH - Úprava pro implementaci WINPRODUCTION
   24.05.2009 HF - zmìna naètení parametru /autologin
   29.10.2009 HŽ - Doplnìn parametr /debug
   30.10.2009 MÈ - Zmìna názvu parametru csStartParameterRunningModule -> csParameterStartRunningModule
   04.11.2009 MÈ - Plní se heslo pøed zašifrováním
   15.08.2010 HF - Parametr /language (URS 271)
   15.01.2017 HF - Parametr /printer - název tiskárny pro tisk reportù (WinInsert - URS 041)
   27.05.2019 MÈ - Parametr /manager pro WinInsert (WiIn URS 008)
   17.01.2021 MÈ - Parametr /manager pro všechny implementace (WiFo URS 342)
   25.05.2023 MÈ - Parameters /sql_login read in all cases, not only in simple mode (URS 609)
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Parameters;

interface

uses
  Classes, IniFiles, Forms, Windows, SysUtils,
  Common;

const
  csParameterRun = '/manager';
  csParameterServer = '/server';
  csParameterDatabase = '/database';
  csParameterLogin = '/db_login';
  csParameterPassword = '/db_password';
  csParameterSQLLogin = '/sql_login';
  csParameterSQLPassword = '/sql_password';
  csParameterComplex = '/wcx_code';
  csParameterAutoLogin = '/autologin';
  csParameterSimple = '/simple';
  csParameterStartRunningModule = '/rmd';
  csParameterLockTimeout = '/locktimeout';
  csParameterDebug = '/debug';
  csParameterLanguage = '/language';
  csParameterPrinter = '/printer';

function CheckParameters: Boolean;        // kontrola parametrù na pøíkazovém øádku
function ParamValue(psParamName: String): String;
function ParameterExists(psParamName: String): Boolean;

implementation

function CheckParameters: Boolean;
// Kontrola parametrù na pøíkazovém øádku
var
  lsLogin: String;
  lsLoginPassword: String;
begin
  Result := False;
  gbSimpleMode := False;

  // Login pro pøipojení k MS SQL - /sql_login
  lsLogin := ParamValue(csParameterSQLLogin);

  if Trim(lsLogin) <> '' then
  begin
    gsSQLLogin := lsLogin;
  end;

  // Heslo pro pøipojení k MS SQL - /sql_password
  lsLoginPassword := ParamValue(csParameterSQLPassword);

  if Trim(lsLogin) <> '' then
  begin
    gsSQLPassword := lsLoginPassword;
  end;

  // Možnost spuštìní modulu v jiné databází než WinFormula
  // Zatím jen pro modul "Pøíkazová øádka SQL"
  if ParameterExists(csParameterSimple) then   // parametr "/simple"
  begin
    gbSimpleMode := True;
    Result := True;
    Exit;
  end;

  // Login - /db_login
  gsUserLogin := ParamValue(csParameterLogin);
  // Heslo - /db_password
  gsUserPassword := ParamValue(csParameterPassword);
  gsNotHashedUserPassword := gsUserPassword;
  // MS SQL server - /server
  gsServer := ParamValue(csParameterServer);
  // Databáze - /database
  gsDatabase := ParamValue(csParameterDatabase);
  // Timeout pro zámky v SQL Serveru (deadlocky) [s] - /locktimeout
  gsLockTimeout := ParamValue(csParameterLockTimeout);
  // Autologin - /autologin
  gbAutoLogin := gbAutologin or ParameterExists(csParameterAutoLogin);
  // Má se zapisovat do tabulky spuštìných modulù?
  gbStartRunningModule := (not ParameterExists(csParameterStartRunningModule)) or (ParamValue(csParameterStartRunningModule) = '1');
  // Debug - /debug
  gbDebug := ParameterExists(csParameterDebug);
  // Název tiskárny pro tisk reportù - /printer
  gsPrinter := ParamValue(csParameterPrinter);

  // Je modul spuštìn ze Správce?
  gbModuleCalledFromManager := (Trim(gsUserLogin) <> '') and (Trim(gsUserPassword) <> '') and (Trim(gsServer) <> '') and (Trim(gsDatabase) <> '');

  // Test, jestli se na pøíkazové øádce nachází parametr /manager
  // Pokud neexistuje, ukonèí se aplikace (když je zároveò mdl_b_independent = True)
  // Správce a Šablony reportù lze spustit bez parametru /manager
  if ParameterExists(csParameterRun) or (gsUserRightCode = 'report_templates') then
  begin
    Result := True;
  end;
end;

function ParamValue(psParamName: String): String;
// Vratí hodnotu paramatru z pøikazové øádky
var
  i: Integer;
  P: Integer;
  lsParamName: String;
  lsParamValue: String;
begin
  Result := '';

  for i := 1 to ParamCount do
  begin
    P := Pos('=', ParamStr(i));

    if P > 0 then
    begin
      lsParamName := Copy(ParamStr(i), 1, P - 1);
      lsParamValue := Copy(ParamStr(i), P + 1, Length(ParamStr(i)) - P);

      if AnsiCompareText(AnsiUpperCase(psParamName), AnsiUpperCase(lsParamName)) = 0 then
      begin
        Result := Trim(lsParamValue);
        Break;
      end;
    end;
  end;
end;

function ParameterExists(psParamName: String): Boolean;
// funkce zjistí, jestli existuje parametr
var
  i: Integer;
  P: Integer;
  PN: String;
begin
  Result := False;
  
  for i := 1 to ParamCount do
  begin
    P := Pos('=', ParamStr(i));

    if P > 0 then
    begin
      PN := Copy(ParamStr(i), 1, P - 1);

      if AnsiCompareText(AnsiUpperCase(psParamName), AnsiUpperCase(PN)) = 0 then
      begin
        Result := True;
        Break;
      end;
    end else
    begin
      if AnsiCompareText(AnsiUpperCase(psParamName), AnsiUpperCase(ParamStr(i))) = 0 then
      begin
        Result := True;
      end;
    end;
  end;
end;

end.

