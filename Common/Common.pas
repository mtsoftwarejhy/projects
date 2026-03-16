{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert, Expedièní systém, WinPackage, WinMixWeighing
 Module:       Spoleèná funkcionalita
 File name:    Common.pas

 Description:  Spoleèné procedury

 Author:       Michal Èervenka
 Creation:     10.11.2004
 Change:
   27.10.2006 TV - Pøevod komponenty TdbGrid -> TcxGrid
   17.11.2006 AJ - Zmìna funkce PasswordMustBeChanged pro uživatele "admin"
   23.11.2006 MÈ - Procedura pro smazání spuštìného modulu DeleteRunningModule
                 - Procedura MyMessageBox místo Windows.MessageBox
   07.12.2006 MÈ - Úprava procedury InitModule pro modul Šablony reportù
   22.12.2006 MÈ - Napojení procedury DeleteRunningModule na cnSystemConnection
   09.01.2007 TV - Zamèení cxGridu v ReOpenAndGoToExt
   16.02.2007 JH - Zmìna Messages -> TStringList
   16.03.2007 TV - Lokalizace
   25.03.2007 MÈ - Funkce GetLanguageFromWorkComplex
   13.04.2007 JH - Funkce MyFormat, ReplaceSpecialCharacters
   18.04.2007 JH - Zmìna Delete_record => DeleteRecord
   24.04.2007 MÈ - Úprava funkce CheckErrors
   21.05.2007 TV - Funkce DoWriteToLog vs. WriteToLog
   22.05.2007 MÈ - Zrušení funkce MyFormat (nahrazena vlastní funkcí Format)
   14.06.2007 MÈ - V názvu logu je mìsíc yyyymm
   26.08.2007 MÈ - Parametry na pøíkazové øádce i pro moduly Vnášení
   07.10.2007 MÈ - Chyba "Nesprávná implementace"
   16.10.2007 MÈ - Oprava vytváøení menu Nástroje
   02.11.2007 MÈ - V názvu logu je kód navažovny
   28.11.2007 MÈ - Nová konstanta csTimeFormat
                 - Nové funkce MyDateToStr, MyDateTimeToStr
                 - Oprava funkce OpenLoginWindow pro Masnu
   29.11.2007 MÈ - Zmìna funkcí getDateFrom, getDateTo
                 - Tiskový server se spouští s jazykem poèítaèe
   10.12.2007 MÈ - Funkce CreateReportJob: parametr p_bAutomatic
   20.12.2007 MÈ - Funkce MyFloatToStrSQL, použita v ChangeUnit
   28.12.2007 MÈ - qrSlng má cnOperatorConnection
   19.01.2008 MÈ - Funkce MyQuotedStr
                 - Úprava funkce CheckNULL
   12.02.2008 MÈ - Pøidána implementace PRO.MED.CS
   23.02.2008 MÈ - Úprava funkce BezDiakritiky
   05.03.2008 MÈ - DataSet qrSlng je napojen na cnSystemConnection, protože se otevírá na frmLogin ještì pøed pøipojením cnOperatorConnection
   19.03.2008 MÈ - Úprava funkce DeleteRecord
   27.03.2008 MÈ - Úprava funkce RecordExists
   28.03.2008 MÈ - Úprava funkce GetModuleName
   31.03.2008 MÈ - Oprava funkce MyFloatToStrSQL
   07.04.2008 MÈ - Úprava funkce CheckUser
   09.04.2008 MÈ - Úprava funkce CheckUserRights
   16.04.2008 MÈ - Úprava funkce ReOpenAndGoTo
   24.04.2008 MÈ - Úprava procedury TMultiLangForm.WriteToLog - není-li resourcestring nalezen v dll, použije se hodnota z unity (døíve prázdný
                   øetìzec)
   12.05.2008 MÈ - Úprava funkce RecordExists
   22.05.2008 MÈ - Úprava funkcí CheckComputerRights, ChangeUnit, GetComputerId
   22.05.2008 JH - Úprava pro nemultijazyèné verze
   03.09.2008 MÈ - Úprava funkce UpdateRunningModule
   26.10.2008 MÈ - Úprava funkce ParametersRefresh
   21.11.2008 MÈ - Úprava funkcí MyExecProc, MyOpenProc, ParametersRefresh
   10.02.2009 MÈ - Odstranìno with
   10.02.2009 JH - Úprava funkcí GetLastId, RecordExists - Oprava selectu uvnitø transakce (ochrana proti deadlockùm)
   18.02.2009 MÈ - Úprava funkce UpdateRunningModule
   21.02.2009 MÈ - Procedura SetLockTimeout po pøipojení ADOConnections
   24.03.2009 HF - Lokalizace buttonù ve funkci MyMessageBox (URS290) - metoda ChangeMessageBoxButtons
                 - Pøidány resourcestringy resButtonOk, resButtonYes, resButtonNo
                 - Opraven pøeklep ve funkci MyMessageBox - ifdef MULTILAGUAGE --> MULTILANGUAGE
   26.03.2009 HF - Úprava funkce LoadColumnSettings - pøi naèítání nastavení cxGridù se kontroluje, jestli uvedené sloupce existují (URS 256)
   20.04.2009 JH - Pøidána implementace WinProduction
                 - Zmìna procedury sp_i_create_report_job - nový parametr @p_s_language_code
                 - Zmìna názvù implementací pro WinFormula
   26.04.2009 HF - Vyøešen problém se zobrazením formuláøù pøi 120 DPI (large fonts) - ReadState
   27.04.2009 MÈ - Úprava funkcí MyOpenQuery, MyExecuteQuery - zápis názvu datasetu pøi chybì
   28.04.2009 MÈ - Speciální znaky se v MyMessageBox nahrazují, i když resource není v dll
   30.04.2009 HF - Detekce Windows Vista - promìnná gbIsWindowsVista
                 - Procedura SetVistaAppearance - nastavení vzhledu formu pro Windows Vista (pro podporu TTreeView potøebuje unity UxTheme, XPMan)
                 - Procedury CreateParams, WMSyscommand, WMActivate - chování pod Windows Vista
                 - Metoda ChangeMessageBoxButtons je nyní volána i pøi single language verzi
   06.05.2009 MÈ - Zmìna názvu "navažovna" -> "provoz"
   10.05.2009 MÈ - Zmìna kódù nìkterých modulù
                 - Oprava kontroly oprávnìní pro spuštìní modulu
   11.05.2009 HF - Pøidána promìnná gbOverrideVCLHiddenWindow - zmìnìné chování formu (jako u Vista) i pro XP
   16.05.2009 HF - Funkce BezDiakritiky - pøidány slovenské znaky 'Å¼ÔÀå¾ôà'
   24.05.2009 HF - Funkce OpenLoginWindow - moduly text_panel a opc_synchro se také pøihlašují automaticky pod adminem
   25.05.2009 JH - Zmìna ReOpenAndGoTo, DeleteRecord - pøidán parametr CorrectSQL, kvùli ztoko
   26.05.2009 MÈ - Funkce MyRoundTo
   28.05.2009 MÈ - Zmìna názvu funkci BezDiakritiky -> ReplaceDiacriticalMarks
                 - Funkce ReplaceDiacriticalMarks: pøidání dalších znakù
   15.09.2009 FH - Pøidán typ MyMessageBoxu mtConfirmation, návratová hodnota mrYes a mrNo
   29.09.2009 HF - Pøihlašování pro OPC Synchro
   25.10.2009 HF - Zmìna funkce CreateReportJob - nyní vrací poèet tiskových klíèù, ke kterým byl report pøiøazen
   29.10.2009 HZ - Pøidána globální promìnná gbDebug pro využití pøi logování v modulech
   03.11.2009 MÈ - Funkce HashString
   04.11.2009 MÈ - Heslo pøed zašifrováním - gsNotHashedUserPassword
   11.11.2009 FH - Doplnìní virtual procedury DoAfterLanguageChange do Multilanguage
   18.11.2009 MÈ - Úprava funkce UpdateRunningModule - ukonèí modul pøi neúspìšném pøipojení k MS SQL
   04.12.2009 HŽ - Funkce cnOperatorConnectionBeforeConnect
   10.12.2009 HF - Úprava funkce RestoreDefaultSettings - Nìkteré gridy po resetu ukazovaly v summary záznam èíslo/0
   11.12.2009 HŽ - Zobrazení verze databáze v zápatí hlavního okna modulu
   19.12.2009 HF - Zmìna pøihlašování pro modul Text Panel - uživatel, jazyk
                 - Pøeklad názvù dnù a mìsícù - LongDayNames a LongMonthNames
   21.12.2009 HF - Pøeklad krátkých názvù dnù - ShortDayNames
   22.12.2009 MÈ - Nová funkce DeleteOldMails
   23.12.2009 HF - Zmìna funkcí LoadFromIni a SaveToIni - nový parametr p_bPrivate pøepíná mezi soukromým a veøejným INI
                 - Nová funkce OpenIniFile - slouží pro otevøení správného ini souboru
                 - Ukládání a naèítání velikosti a pozice všech formù
   28.12.2009 HŽ - Oprava cnOperatorConnectionBeforeConnect
              HF - Naèítání pozice a velikosti formu pøesunuto z FormCreate do metody, která je spouštìna pomocí windows message (u nìkterých modulù
                   kolidovalo s inicializací formu a s pozicováním controls)
              MÈ - Doèasnì vypnuto ukládání pozice a velikosti formuláøù
   10.01.2010 MÈ - Funkce MyBooleanToStr
   14.01.2010 MÈ - Oprava blikání kursoru pøi spuštìní modulu
   19.01.2010 MÈ - Úprava funkce UpdateRunningModule: zmìna zadání parametrù
                 - Zadání názvù vytváøených objektù
   27.01.2010 HF - Volání funkce LoadWindowPosition pøesunuto do ReadState
   31.01.2010 HF - Volání funkce LoadWindowPosition pøesunuto do metody WMShowWindow
                 - Zapnuto ukládání pozice a velikosti formuláøù
   04.04.2010 HF - Oprava problému s TcxDateEdit ve funkci SetVistaAppearance
   28.05.2010 MÈ - Sjednocení verzí unity pro WinProduction a ostatní implementace
                 - Pøetypování TcxGridDBTableView -> TcxGridTableView
   03.06.2010 MÈ - V databázi WinStock jsou provozy
   10.08.2010 HF - Oprava chyby ve funkci ChangeMessageBoxButtons (URS290)
   15.08.2010 HF - Parametr /language (URS 271)
   17.10.2010 HF - Do funkce CreateReportJob pøidána kontrola, jestli lze report se zadanými parametry vytisknout
   12.11.2010 MÈ - Procedura WMShowWindow: pøidáno inherited kvùli PrintServeru
   16.11.2010 HF - Zmìna metody AllowedMultipleRun - použití nové funkce GetModuleUniqueID, takže nyní nekolidují stejnojmenné moduly z rùzných
                   implementací (napø. WiFo/Wipr) (URS 351)
   05.05.2011 MÈ - Úpravy pro Delphi 2010
   08.05.2011 MÈ - MyMessageBox: ošetøení chyby, když neexistuje frmSplash
                 - Resourcestringy pro MyMessageBox anglicky, protože se mohou zobrazit pøi spuštìní modulu
   11.05.2011 MÈ - Zmìna názvu konstanty csImplementationBUCZ -> csImplementationWinStock
   13.05.2011 MÈ - UpdateRunningModule: prodloužení timeoutu z 10 s na 30 s
   23.08.2011 MÈ - Zmìna funkce CheckErrors: zmìna volání MyMessageBox
   14.11.2011 MÈ - Funkce CreateReportJob: parametr p_bShowMessage
   28.11.2011 MÈ - Oprava zobrazení verze databáze v zápatí hlavního okna modulu
   07.01.2012 MÈ - Zmìna IDEVY -> WININSERT
   10.01.2012 HF - Zmìna metody AllowedMultipleRun - použití nové funkce GetModuleUniqueId, aby nekolidovaly stejnojmenné moduly z rùzných
                   implementací (napø. WiFo/Wipr) (URS 351)
   18.01.2012 MÈ - WinFormula má šifrovaná hesla
   16.02.2012 MÈ - Funkce CreateReportJob pøesunuta do Print.pas
   19.02.2012 MÈ - Procedura EraseInvalidColumns (URS 256)
                 - Procedura RestoreDefaultSettings: pøi naèítání nastavení cxGridu se kontroluje, jestli uvedené sloupce existují (URS 256)
   19.07.2012 HF - Skrytí tlaèítka v taskbaru pro modální dialogy pod Windows 7
   27.10.2012 MÈ - Implementaèní kód Wood Pharma Holding - 0006
   18.01.2013 HF - URS 346: Úpravy pro pøihlašování modulu Kompletace šarže
                 - Metoda ResizeForm - pro moduly urèené k ovládání na dotykovém panelu
                 - GetModuleUniqueId: parametr p_sModuleCode
                 - Úpravy pro Delphi 2010
   27.01.2013 MÈ - ReplaceSpecialCharacters: oprava nahrazení znaku nového øádku
   14.04.2013 MÈ - Funkce ValidateCampaign
   19.04.2013 FH - Úprava ValidateCampaign - chybovou zprávu lze potlaèit
   25.04.2013 FH - Úprava CheckUserRights - admin má oprávnìní vždy
   27.06.2013 MÈ - Úpravy pro cxGrid 6.56
   06.02.2014 HF - Oprava chyby pøi pøepnutí do aplikace pod Windows 7, pokud je zobrazeno modální okno
   20.02.2014 MÈ - Funkce SetUserLanguage
   04.06.2014 MÈ - Odstranìní podmínky "IF CompilerVersion >= 21"
   22.09.2014 HF - OpenLoginWindow - oprava velikosti login okna pøi zvìtšeném písmu Windows
   25.09.2014 MÈ - Nahrazení TMessageType -> TMsgDlgType
              HF - MyMessageBox: MessageBox -> CreateMessageDialog
   26.09.2014 MÈ - Zrušena procedura ChangeMessageBoxButtons
   01.10.2014 HF - ConnectToMSSQL, cnOperatorConnectionBeforeConnect: do connection stringu pøidáno "OLE DB Services = -2"
   04.11.2014 MÈ - Read only login wsr
   05.11.2014 MÈ - CheckErrors: parametr p_bTerminate je nepovinný a volaný odkazem
   26.11.2014 MÈ - MyMessageBox: oprava šíøky labelu se zprávou
              HF - OpenLoginWindow: oprava
   28.07.2015 MÈ - Funkce MyStrToDateTime
                 - Funkce Split
   09.02.2016 MÈ - Rozdìlení implementace csImplementationWinStock na csImplementationWiStBUCZ a csImplementationWiStAcerostar
   12.02.2016 MÈ - Funkce UpdateConnectionString
                 - GetValueFromComplexConfiguration: parametr wcx_n_id pro WinStock
   27.04.2016 MÈ - Implementation WinFormula Box (0007)
   14.08.2016 MÈ - Promìnná gnModuleUniqueId - unikátní id modulu; po aktualizaci Windows 10 bylo nutné volat proceduru
                   GetModuleUniqueId jinde
   21.12.2016 MÈ - Implementation csImplementationWiFoZentivaBukurest - 0008 (URS 514)
                 - Changed implementation code csImplementationWiFoZentiva -> csImplementationWiFoZentivaPraha
   15.01.2017 HF - Promìnná gsPrinter - název tiskárny pro tisk reportù (WinInsert - URS 041)
   20.01.2017 MÈ - Moduly WinInsert lze spustit vícekrát na jednom poèítaèi (URS 042)
                 - Zmìna kódu implementace WinInsert z 0003 na 4001
   23.01.2017 MÈ - Funkce CheckConfiguration: id provozu se nezjišuje, pokud je již známé
   24.03.2017 MÈ - Odstranìna funkce RunExeApplication
                 - Odstranìna funkce GetApplicationWnd
                 - Odstranìna funkce WaitForExeApp
   27.12.2017 MÈ - DeleteRecord: zmìna chybové zprávy "REFERENCE constraint" z MS SQL
   29.12.2017 MÈ - MyMessageBox: zpráva se v pøípadì neviditelné hlavní obrazovky aplikace zobrazí doprostøed obrazovky
   27.05.2019 MÈ - Pøijímat zprávy odeslané do hlavního okna aplikace (napø. ukonèení modulu Správcem) mohou i nevícejazyèné moduly (WiIn URS 008)
   23.06.2019 MÈ - Odstranìna funkce CreateReportJob (WiIn URS 015)
                 - Zobrazení verze databáze v zápatí zápatí hlavního okna modulu WinInsert podle WinProduction (WiIn URS 015)
                 - WinInsert má šifrovaná hesla (WiIn URS 015)
   31.08.2019 MÈ - CheckConfiguration: id poèítaèe se naèítá, jen když ještì naèteno nebylo (oprava chyby Pracovištì WinInsert)  (WiIn URS 015)
   03.10.2019 HF - Optimalizace procedury DoWriteToLog
   02.06.2020 MÈ - OpenLoginWindow - oprava velikosti login okna bez zmìny jazyka pøi zvìtšeném písmu Windows (WiIn URS 051)
   19.08.2020 MÈ - Implementace WinPackage
                 - Zmìna funkce MyFloatToStrF
                 - Oprava procedury DoWriteToLog - zapisovala do logu ve formátu unicode
   24.10.2020 MÈ - Procedura GetFileInfo pøesunuta sem z About.pas
   30.10.2020 MÈ - Konstanta csTimeFormat pro zápis èasu do databáze doplnìna o milisekundy
   28.12.2020 MÈ - Úprava funkce MyStrToFloat (WiFo URS 381)
                 - Funkce CheckTime: nový parametr p_sShortDateFormat (WiFo URS 381)
   10.01.2021 MÈ - Zmìna kódu modulu "Konfigurace provozù" pro WiFo: cfg_wcx -> cfg_work_complexes (WiFo URS 342)
                 - Odstranìna procedura ValidateCampaign z nepoužitého balíèku pro Promed 2013
                 - Ve spodním øádku hlavních formuláøù modulù se novì zobrazuje: "Databáze: \\server\databáze, verze: n.n.n.n" (WiFo URS 342)
   21.03.2021 MÈ - MyDateToStr: parameter p_sShortDateFormat, fixed for Windows date format "dd. mm. yyyy"
                 - Fixed functions CheckTime and MyStrToDateTime for Windows date format "dd. mm. yyyy"
   02.05.2021 MÈ - Function MyDateTimeToStr: added parameter p_bMiliseconds
   19.05.2021 MÈ - Implementation WinMixWeighing
   12.06.2021 MÈ - ShowAbout: added parameter p_bScreenCenter
   13.08.2021 MÈ - ChangeUnit: parameter p_bUseDatabaseFunction
                 - Function UnitToFactor
   08.05.2023 MÈ - Removed implementation Masna Pøíbram
   16.05.2023 MÈ - Removed implementation BKP
   25.05.2023 MÈ - SQL Server login name and password can be read from ini file or command line parameter (URS 609)
                 - Function HashString does not use database function fn_s_hash_string
   29.05.2023 MÈ - GetDateFrom, GetDateTo: parameter p_sShortDateFormat (URS 611)
   03.10.2023 MÈ - Function UpdateDatabaseConfiguration
   30.10.2023 MÈ - Handling errors saving grid settings
   07.03.2024 MÈ - Fixed connection to MS SQL for WinMixWeighing
   17.04.2024 MÈ - Information about starting the application in the log file
   07.09.2024 MÈ - Removed implementation IVAX (Teva)
   21.09.2024 MÈ - Removed implementation WinFormula Box
   17.12.2024 MÈ - Functions RecordExists and GetLastId: removed parameter p_bTransaction
   21.03.2025 MÈ - MyMessageBox: fixed icon display
   30.03.2025 MÈ - The procedure UpdateRunningModule has 2 new parameters
   16.04.2025 MÈ - Hints will remain displayed for 60 seconds
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Common;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StrUtils, DB, IniFiles, ADODB, DateUtils, Variants, SyncObjs, ComCtrls, ExtCtrls, Dialogs,
  Menus, ActnList, Messages, ImgList, Math, IOUtils, Registry, IdHash, IdHashMessageDigest,
  {$IFDEF MULTILANGUAGE}
  Languages,
  {$ENDIF}
  cxGridDBTableView, cxGridCustomTableView, cxGridTableView, System.ImageList,
  System.Actions;

const
  csAdmin = 'admin';
  csAdminPassword = '111111';

  csOPCSynchroUserKey = 's_sys_user_opc_synch';
  csOPCSynchroPassword = 'aUt45xqZ';

  csTextPanelUserKey = 's_sys_user_txt_panel';
  csTextPanelPassword = 'bVu67yrA';

  csTemporaryRecordValue = '*#Temporary#*';
  csDateFormat = 'dd.mm.yyyy';                    // Pro zápis do databáze

  csImplementationWiFoZentivaPraha = '0001';      // Zentiva Praha
  csImplementationWiFoPromed = '0005';            // PRO.MED.CS
  csImplementationWiFoHlohovec = '0006';      	  // Saneca Hlohovec
  csImplementationWiFoZentivaBukurest = '0008';   // Zentiva Bukureš
  csImplementationWiStBUCZ = '1001';              // WinStock - BUCZ
  csImplementationWiStAcerostar = '1002';         // WinStock - Acerostar
  csImplementationWiPrZentiva = '3001';           // WinProduction
  csImplementationWinInsert = '4001';             // WinInsert
  csImplementationWinPackageCZ = '5001';          // WinPackage Èeská Republika
  csImplementationWinPackageSK = '5002';          // WinPackage Slovensko
  csImplementationWinMixWeighing = '6001';        // WinMixWeighing

  csVistaFontNormal = 'Segoe UI';
  csVistaFontContent = 'Calibri';

  CHR_CR = #13;
  CHR_CRLF = #13#10;
  CHR_STX = #02;

  csFlags: array [0..2] of String = ('CSY', 'ENG', 'ROM');

resourceString
  {$IFDEF MULTILANGUAGE}
  resError = 'Error';
  resInformation = 'Information';
  resQuestion = 'Enquiry';
  resWarning = 'Warning';
  resConfirmation = 'Confirmation';

  resButtonOk = '&OK';
  resButtonYes = 'Yes';
  resButtonNo = 'No';
  {$ELSE}
  resError = 'Chyba';
  resInformation = 'Informace';
  resQuestion = 'Dotaz';
  resWarning = 'Upozornìní';
  resConfirmation = 'Potvrzení';

  resButtonOk = '&OK';
  resButtonYes = '&Ano';
  resButtonNo = '&Ne';
  {$ENDIF}

  resTextNotFound = 'Není zadaný %s!';
  resTextNotFounda = 'Není zadaná %s!';
  resTextNotFoundo = 'Není zadané %s!';
  resTextNotFounde = 'Nejsou zadané %s!';
  resErrInteger = 'Nesprávný formát èísla!';
  resErrDate = 'Nesprávnì zadané datum!';
  resErrTime = 'Nesprávnì zadané datum & èas!';
  resErrNegativeValue = 'Záporná hodnota není povolena!';
  resErrPositiveValue = 'Hodnota musí být vetší než 0!';

  resErrLoadFormPosition = 'Chyba pøi naèítání pozice a velikosti formuláøe "%s":\x0D%s';
  resErrSaveFormPosition = 'Chyba pøi ukládání pozice a velikosti formuláøe "%s":\x0D%s';
  resErrorSavingGridSettings = 'Chyba pøi ukládání nastavení gridu!\x0D%s';
  resErrorSavingDefaultGridSettings = 'Chyba pøi ukládání výchozího nastavení gridu!\x0D%s';

  resFormatError = 'Chybnì zadané formátování textu \x0D%s';
  resFormatErrorLog = 'Chybnì zadané formátování textu: %s';
  resErrorSearchingModule = 'Tento modul není platným modulem systému (nebyl nalezen v tabulce modulù)!';

  resSqlDeleteNotPermitted_1 = 'Tento záznam nelze smazat, pravdìpodobnì již byly vytvoøeny jiné záznamy';
  resSqlDeleteNotPermitted_2 = '(napø. %s)';
  resSqlDeleteNotPermitted_3 = ', které jej využívají!\x0D \x0D%s';
  resSqlDeleteError = 'Chyba pøi mazání záznamu!\x0D \x0D%s';
  resModuleLoginError = 'Pøihlášení do modulu %s';
  resDatabaseConnection = 'Probíhá pøipojení k databázi...';
  resSqlConnectionError = 'Chyba pøipojení k databázovému serveru MS SQL!\x0DV konfiguraèním souboru není zadaný název MS SQL serveru nebo databáze!\x0DKontaktujte prosím zodpovìdnou osobu!';
  resSqlConnectionDetailsError = 'Chyba pøipojení k databázovému serveru MS SQL!\x0DAplikace: %s\x0DMS SQL server: %s\x0DDatabáze: %s\x0DKontaktujte prosím zodpovìdnou osobu!\x0D \x0D%s';
  resSqlQueryError = 'Chyba pøi provádìní dotazu do databáze!\x0D \x0D%s';
  resSqlRepeatQuery = '%s\x0D \x0DPøejete si zopakovat poslední pøíkaz?';
  resSqlCommunicationError = 'Chyba pøi komunikaci s MS SQL serverem!';
  resModuleClosed = 'Modul "%s" bude uzavøen!\x0D \x0D%s';
  resLogSqlCommunicationError = 'Chyba pøi komunikaci s MS SQL serverem! (%s)';
  resConfigurationChecking = 'Probíhá kontrola konfigurace...';
  resDataLoading = 'Probíhá naèítání dat...';

  resWrongConfiguration = 'Chyba konfigurace - nebyl nalezen provoz!';
  resWrongImpelementation = 'Nesprávná implementace!';
  resModulePermissionError = 'Modul nemá oprávnìní být spuštìn na tomto poèítaèi!';
  resMaxRunningModulesError = 'Byl pøekroèen maximální poèet povolených spuštìní modulu v systému!';
  resMultipleRunningModuleError = 'Tento modul nelze spustit vícekrát!';
  resWorksiteCheckingError = 'Chyba pøi kontrole stavu pracovištì!\x0D \x0D%s';
  {$IFDEF WINPRODUCTION}
  resDatabaseVersion = '%s, verze: %s';
  {$ELSE}
  resDatabaseVersion = 'Databáze: %s, verze: %s';
  {$ENDIF}
  resXmlFilesFilter = 'Soubory XML (*.xml)|*.xml|Vše (*.*)|*.*';
  resCvsFilesFilter = 'Textové soubory CSV (*.csv; *.txt)|*.csv; *.txt|Vše (*.*)|*.*';
  resXlsFilesFilter = 'Soubory Microsoft Excel (*.xls)|*.xls|Vše (*.*)|*.*';
  resFileExistOverwrite = 'Soubor %s\x0Djiž existuje. Pøejete si jej pøepsat?';
  resFileOverwriteError = 'Soubor nelze pøepsat. Zkontrolujte prosím, není-li otevøen v jiné aplikaci.';
  resSqlDeleteErrorLog = 'Chyba pøi mazání záznamu! Tabulka: %s, pole: %s, hodnota: %s\x0D%s';
  resSqlConnErrorLog = 'Chyba pøipojení k databázovému serveru MS SQL! (v konfiguraèním souboru není zadaný název MS SQL serveru nebo databáze)';
  resSqlConnErrorDetailsLog = 'Chyba pøipojení k databázovému serveru MS SQL! (Aplikace: %s; MS SQL server: %s; Databáze: %s; %s)';
  resWorksiteCheckingErrorLog = 'Chyba pøi kontrole stavu pracovištì! : %s';
  resMenuTools = 'Nástroje';
  resMenuChangeLanguage = 'Zmìnit jazyk';
  resStartApplicationError = 'Aplikaci není možné spustit tímto zpùsobem!';
  resStoredProcedureError = 'Chyba è. %s pøi volání uložené procedury %s!';
  resDeleteQuery = 'Opravdu si pøejete smazat vybraný záznam?';
  resComputerNotFound = 'Název poèítaèe není zaveden v konfiguraci provozù!';
  resNoActivityPermissionError = 'Nemáte oprávnìní pro tuto èinnost!';
  resNoRunModulePermissionError	= 'Nemáte oprávnìní spustit tento modul!';
  resReportJobAddError = 'Chyba (%d) pøi vytváøení tiskové úlohy!';
  resReportJobAdded = 'Tisková úloha byla úspìšnì vytvoøena.';
  resReadOnlyDb = 'Databáze je jen pro ètení, není možné provádìt žádné zmìny!';

  resMonthJanuary = 'leden';
  resMonthFebruary = 'únor';
  resMonthMarch = 'bøezen';
  resMonthApril = 'duben';
  resMonthMay = 'kvìten';
  resMonthJune = 'èerven';
  resMonthJuly = 'èervenec';
  resMonthAugust = 'srpen';
  resMonthSeptember = 'záøí';
  resMonthOctober = 'øíjen';
  resMonthNovember = 'listopad';
  resMonthDecember = 'prosinec';

  resDaySunday = 'nedìle';
  resDayMonday = 'pondìlí';
  resDayTuesday = 'úterý';
  resDayWednesday = 'støeda';
  resDayThursday = 'ètvrtek';
  resDayFriday = 'pátek';
  resDaySaturday = 'sobota';

type
  TFileInfo = array [1..12] of String;
  TEditRecordType = (erInsert, erEdit);   // vložení/editace záznamu

  TDataModuleMethod = procedure of object;  // method prototype

  TScrollEvents = class
    BeforeScroll_Event: TDataSetNotifyEvent;
    AfterScroll_Event: TDataSetNotifyEvent;
    AutoCalcFields_Property: Boolean;
  end;

  TControlWithFont = class(TControl)
  public
    property Font;
    property ParentFont;
  end;

  TMultiLangForm = class(TForm)
    miTools: TMenuItem;
    miChangeLang: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    destructor Destroy; override;
  private
    FModuleName: String;
    {$IFDEF MULTILANGUAGE}
    LangToolButton: TToolButton;
    {$ENDIF}
    LangToolButtonRevIndex: Integer;
    procedure ResizeForm(p_Component: TComponent; p_rScale: Real); overload;
  published
    procedure TranslateResourceStrings; virtual;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSysCommand(var Message: TWmSysCommand); message WM_SYSCOMMAND;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMShowWindow(var Message: TWMActivate); message WM_SHOWWINDOW;
    procedure LoadWindowPosition;
  public
    slResourceString: THashedStringList;
    slLogResourceString: THashedStringList;
    LangToolBar: TToolBar;
    gsWindowState: String;
    gbPositionLoaded: Boolean;
    property ModuleName: String read FModuleName write FModuleName;
    function InitTranslate(const p_sModuleName: String = ''): Boolean;
    // Nastaví form, aby vypadal lépe na Windows Vista
    procedure SetVistaAppearance(p_Component: TComponent);
    procedure ResizeForm(p_rScale: Real); overload;
    function ShowModal: Integer; override;
    {$IFDEF MULTILANGUAGE}
    function GetResourceString(const p_sRecourceString: String): String;
    procedure AddChangeLangMenu;
    procedure DoChangeLanguage(Sender: TObject);
    procedure ChangeLanguage(const p_sLangCode: String); virtual;
    function TranslateForm: Boolean;
    {$ENDIF}
    procedure WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const; p_sLogType: String = '');
    procedure DoAfterLanguageChange; virtual;
  end;

  TdmCommon = class(TDataModule)
    cnSystemConnection: TADOConnection;
    cnOperatorConnection: TADOConnection;
    qrSusr: TADODataSet;
    qrDrecord: TADOCommand;
    qrSurh: TADODataSet;
    qrSmdlM: TADODataSet;
    qrSmdl: TADODataSet;
    spDold_rmd: TADOStoredProc;
    spScheck_rmd: TADODataSet;
    fnBmodule_state: TADOStoredProc;
    fnImail_send: TADOStoredProc;
    tmrApplicationTerminate: TTimer;
    qrSdcf: TADODataSet;
    sdExportToFile: TSaveDialog;
    alGrid: TActionList;
    aExportToXML: TAction;
    aExportToCSV: TAction;
    aExportToXLS: TAction;
    aDefaultSettings: TAction;
    PopupMenu: TPopupMenu;
    miExportToFile: TMenuItem;
    miCVS: TMenuItem;
    miXML: TMenuItem;
    miDefaultSettings: TMenuItem;
    N2: TMenuItem;
    aShowHideColumns: TAction;
    miShowHideColumns: TMenuItem;
    miExcel: TMenuItem;
    qrSlng: TADODataSet;
    qrSlnglng_s_code: TWideStringField;
    qrSlnglng_s_name: TWideStringField;
    ilFlags: TImageList;
    qrSlnglng_n_id: TAutoIncField;
    qrADODataSet: TADODataSet;
    qrSpar: TADODataSet;
    fnSget_usr_lang: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tmrApplicationTerminateTimer(Sender: TObject);
    procedure aExportToXMLExecute(Sender: TObject);
    procedure aExportToCSVExecute(Sender: TObject);
    procedure aExportToXLSExecute(Sender: TObject);
    procedure aDefaultSettingsExecute(Sender: TObject);
    procedure aShowHideColumnsExecute(Sender: TObject);
    procedure sdExportToFileCanClose(Sender: TObject; var CanClose: Boolean);
    procedure cnOperatorConnectionAfterConnect(Sender: TObject);
    function ApplicationMessage(var Msg: TMessage): Boolean;
  private
    { Private declarations }
    fDbgridTableView: TcxGridDBTableView;
    FModuleName: String;
    slResourceString: THashedStringList;
    slLogResourceString: THashedStringList;
    {$IFDEF MULTILANGUAGE}
    FLanguages: TMultiLanguages;
    {$ENDIF}

    {$IFNDEF WINPACKAGE}
    {$IFNDEF WINMIXWEIGHING}
    function PasswordMustBeChanged: Boolean;
    {$ENDIF}
    {$ENDIF}
    procedure StopRunningModuleThread;

    function GetDbgridTableView: TcxGridDBTableView;
    procedure SetDbgridTableView(CxGridDBTableView: TcxGridDBTableView);

    {$IFDEF MULTILANGUAGE}
    function InitTranslate(const p_sModuleName: String): Boolean;
    {$ENDIF}

    procedure SetLockTimeout(p_cnADOConnection: TADOConnection);
  published
    { Public declarations }
    property ResourceStringList: THashedStringList read slResourceString write slResourceString;
    property LogResourceStringList: THashedStringList read slLogResourceString write slLogResourceString;
    property ModuleName: String read FModuleName write FModuleName;
    procedure TranslateResourceStrings;
  public
    {$IFDEF MULTILANGUAGE}
    property Languages: TMultiLanguages read FLanguages write FLanguages;
    function SetUserLanguage: Boolean;
    {$ENDIF}
    function ChangeLanguage: Boolean;
    function DeleteRecord(p_sTable, p_sField, p_sValue: String; p_sSQL: String = ''; p_sRelatedTables: String = ''; p_bCursor: Boolean = True;
      p_bCorrectSQL: Boolean = True): Boolean;
    function RecordExists(p_sTable, p_sField, p_sValue: String): Boolean;
    function ConnectToMSSQL(pADOConnection: TADOConnection): Boolean;
    function UpdateConnectionString(pADOConnection: TADOConnection): Boolean;
    function CheckUser(p_sUser: String; p_sPassword: String; p_bWithoutPassword: Boolean = False): Integer;
    // Kontrola oprávnìní uživatele v tomto provozu
    function CheckUserRights(p_sUrhCode: String; p_nUsrId: Integer = -1; p_bCheckAdmin: Boolean = False): Boolean;
    // Ète id provozu a pracovištì
    function CheckConfiguration: Boolean;
    // Mùže uživatel zmìnit heslo?
    function UserCanChangePassword: Boolean;
    function GetValueFromDatabaseConfiguration(p_sParameterCode: String; p_bTerminate: Boolean = True): String;
    function GetValueFromComplexConfiguration(p_sParameterCode: String): String;
    function UpdateDatabaseConfiguration(p_sCode, p_sValue: String): Boolean;
    function SendMail(p_n_recipient_type, p_n_recipient_id, p_n_sender_type, p_n_sender_id, p_n_mail_type: Integer; p_s_subject,
      p_s_body: String): Boolean;
    function ChangePassword: Boolean;

    // Vrátí název modulu podle exeName
    function GetModuleName: String;
    function GetComputerId: Integer;
    // Kontrola oprávnìní spouštìt tento modul na tomto PC
    function CheckComputerRights: Boolean;
    function ChangeUnit(p_rValue: Real; p_sOldUnit, p_sNewUnit: String; p_bUseDatabaseFunction: Boolean = True): Real;

    // Vrátí jednoznaèný kód pro implementaci + kód modulu
    function GetModuleUniqueId(p_sModuleCode: String = ''): Integer;
    // Kontrola oprávnìní vícenásobného spouštìní
    function AllowedMultipleRun(var pHWND: HWND): Boolean;
    // Kontrola kolikrát je spuštìná aplikace
    function CheckRunningModules: Boolean;
    function UpdateRunningModule(p_sModuleCode: String; var p_nRunningModuleId: Integer): Boolean;
    procedure DeleteRunningModule(p_nRmdId: Integer);
    function DeleteOldRunningModules: Boolean;
    function DeleteOldMails: Boolean;
    function StartRunningModuleThread: Boolean;
    // Kontrola poètu spuštìných modulù
    function CheckModules: Boolean;
    function GetWorksiteState(p_nWstId, p_nPosition: Integer): Integer;
    function GetLastId(p_sTable, p_sColumn: String): Integer;
    function InitModule(p_frmMain: TForm; p_stbMain: TStatusBar): Boolean;
    function GetActualDate: TDateTime;
    function GetLanguageFromWorkComplex(p_nWcxId: Integer): Variant;

    // Podporné rutiny pro cxGrid
    procedure SaveColumnSettings(CxGridDBTableView: TcxGridTableView);
    procedure LoadColumnSettings(CxGridDBTableView: TcxGridTableView);
    procedure CreateShowHideMenu(p_miMenuItem: TMenuItem);
    procedure ShowHideColumn(Sender: TObject);
    procedure dbgridTableViewFocusedRecordChanged(CxGridDBTableView: TcxGridTableView; Sender: TcxCustomGridTableView;
      AFocusedRecord: TcxCustomGridRecord);
    procedure SaveDefaultSettings(CxGridDBTableView: TcxGridTableView);
    procedure RestoreDefaultSettings(CxGridDBTableView: TcxGridTableView);
    procedure EraseInvalidColumns(CxGridDBTableView: TcxGridTableView; Ini: TIniFile);
    procedure CreatePopupMenu(Menu: TPopupMenu);
    procedure GoFirstRow(CxGridDBTableView: TcxGridDBTableView);
    property dbgridTableView: TcxGridDBTableView read GetDbgridTableView write SetDbgridTableView;

    procedure WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const; p_sLogType: String = '');
    procedure ShowAbout(p_bScreenCenter: Boolean = False);
    procedure HideSplash;
  end;

var
  dmCommon: TdmCommon;

  gsServer: String;                    // Název MS SQL serveru
  gsDatabase: String;                  // Název databáze
  gsLockTimeout: String;               // Timeout pro zámky v SQL Serveru (deadlocky) [s]
  gsSQLLogin: String;                  // Login pro pøipojení k MS SQL
  gsSQLPassword: String;               // Heslo pro pøipojení k MS SQL
  gsSchema: String;                    // Schema (ws, ps, dbo)

  gsErrorMessage: String;              // Pro MyOpenQuery a MyExecuteQuery
  gnComputerId: Integer;               // Id poèítaèe
  gsComputerName: String;              // Název poèítaèe
  gnWorksiteId: Integer;               // Id pracovištì
  gnComplexId: Integer;                // Id provozu
  gsComplexCode: String;               // Kód provozu
  gsComplexName: String;               // Název provozu
  gsConfigurationModuleCode: String;   // Kód modulu Konfigurace provozù
  gbModulePermissionError: Boolean;    // Modul není pøiøazen tomuto poèítaèi
  gnModuleUniqueId: Integer;           // Unikátní id modulu

  gsUserLogin: String;                 // Login pøihlášeného uživatele
  gnUserId: Integer;                   // Id pøihlášeného uživatele
  gsUserPassword: String;              // Heslo pøihlášeného uživatele
  // Heslo pøihlášeného uživatele pøed zašifrováním - pro Správce
  gsNotHashedUserPassword: String;
  gsUserName: String;                  // Celé jméno pøihlášeného uživatele
  gsUserFirstName: String;             // Jméno pøihlášeného uživatele
  gsUserSurname: String;               // Pøíjmení pøihlášeného uživatele
  gsUserRightCode: String;             // Kód oprávnìní pro tento modul
  gsLogLanguageCode: String;           // Kód jazyka pro zápis do logu
  // Název tiskárny, na kterou se mají tisknout reporty z Tiskového serveru
  gsPrinter: String;

  // Pro MyOpenQuery a MyExecuteQuery, když nemá být zobrazen messageox
  gsLastError: String;
  gsImplementationCode: String;        // Verze implementace z tabulky t_dfc
  gsCompanyName: String;               // Název firmy z tabulky t_dfc
  gbDebug: Boolean;                    // Debug - pro výpis výsledkù db procedur do txt logu
  gbAutoLogin: Boolean;                // Autologin (jen pro tiskový server)
  gbSimpleMode: Boolean;               // Možnost spuštìní modulu v jiné databází než winFormula
  // Pøihlašovací okno zobrazeno pøi startu nebo pozdìji? (kvùli zápisu do promìnných gnUserId...)
  gbApplicationLogin: Boolean;
  gnLoginUserID: Integer;              // Id pøihlášeného uživatele (ne pøi startu, ale pozdìji)
  gsLoginUserName: String;             // Jméno pøihlášeného uvživatele (ne pøi startu, ale pozdìji)
  gbModuleCalledFromManager: Boolean;  // Je modul spuštìn ze Správce?
  gbTryingConnectionAlive: Boolean;    // Zjišuje se spojení s SQL serverem?
  gbTerminate: Boolean;                // Aplikace se ukonèuje
  gbIsWindowsVista: Boolean;           // Aplikace bìží pod Windows Vista (nebo vyšší)
  gbIsWindows7: Boolean;               // Aplikace bìží pod Windows 7 (nebo vyšší)
  // Zmìna výchozího chování oken (použití u Windows Vista a u modulù bez main okna)
  gbOverrideVCLHiddenWindow: Boolean;

  gsModuleName: String;                // Název modulu
  gsEnglishModuleName: String;         // Anglický název modulu pro lokalizaci
  gnModuleId: Integer;                 // Id modulu
  gsModuleCode: String;                // Kód modulu
  gbTooManyModules: Boolean;           // Je modul spuštìn vícekrát, než je povoleno?
  gnRunningModuleId: Integer;          // Id spuštìného modulu
  gbStartRunningModule: Boolean;       // Má se zapisovat do tabulky spuštìných modulù?
  gnRefreshInterval: Integer;          // Interval obnovení záznamù spuštìných modulù [s]
  gCriticalSection: TCriticalSection;  // Kritická sekce pro thread aktualizace t_rmd
  gthdRunningModule: TThread;          // Thread aktualizace t_rmd
  gbRunIndependent: Boolean;           // Je možné modul spustit mimo správce?
  gfCurrentModalForm: TForm;           // Modální okno, které je potøeba aktivovat pøi ALT+TAB

  function OpenLoginWindow(p_sUserRightCode: String; p_sTitle: String = ''; p_ctrlAdditionalControls: TControl = nil): Boolean;
  function LoadFromIni(p_sSection, p_sKey, p_sDefault: String; p_bPrivate: Boolean = False): String;
  procedure SaveToIni(p_sSection, p_sKey, p_sValue: String; p_bPrivate: Boolean = False);
  function OpenIniFile(p_bPrivate: Boolean = False): TIniFile;

  function MyOpenQuery(var pADODataSet: TADODataSet; pbTerminate: Boolean = True; pbCorrectSQL: Boolean = True; pbCursor: Boolean = True;
    pbShowMessage: Boolean = True): Boolean;
  function MyExecuteQuery(var pADOCommand: TADOCommand; pbTerminate: Boolean = True; pbCorrectSQL: Boolean = True; pbCursor: Boolean = True;
    pbShowMessage: Boolean = True): Boolean;
  function MyExecProc(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True; p_bCursor: Boolean = True;
    p_bShowMessage: Boolean = True): Boolean;
  function MyOpenProc(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True; p_bCursor: Boolean = True;
    p_bShowMessage: Boolean = True): Boolean;
  function ParametersRefresh(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True;
    p_bCursor: Boolean = True; p_bShowMessage: Boolean = True): Boolean;

  function CheckNULL(p_sField: String; p_byType: Byte = 1; p_byMode: Byte = 1): Variant;
  function CheckErrors(p_sErrorMessage: String; var p_bTerminate: Boolean; p_bShowMessage: Boolean = True; p_bCursor: Boolean = True): Boolean;
  function CheckDate(p_sDate: String): Boolean;
  function CheckTime(p_sDateTime: String; p_sShortDateFormat: String = ''): Boolean;
  function CheckInteger(psInteger: String): Boolean;
  function CheckFloat(p_sFloat: String): Boolean;
  function ConnectionAlive(pbShowMessage: Boolean = True): Boolean;

  procedure BeginTransaction;
  procedure RollBack;
  procedure Commit;

  procedure ReOpenAndGoTo(p_DataSet: TADODataSet; p_sID: String; p_bDelete: Boolean = False; p_sNew: String = '0'; p_bCursor: Boolean = True;
    p_bDisableControls: Boolean = True; p_bCorrectSQL: Boolean = True);
  procedure ReOpenAndGoToExt(CxGridDBTableView: TcxGridDBTableView; p_sID: String; p_bFirst: Boolean = False);

  // String functions
  function CorrectSQL(p_sSQL: String): String;
  function MyStrToFloat(p_sRealNumber: String): Double;
  function MyFloatToStrF(p_rNumber: Real; p_nDigits: Integer; p_nPrecision: Integer = 10; p_cDecimalSeparator: Char = #0;
    p_sThousandSeparator: Char = ' '): String;
  function MyFloatToStrSQL(p_rNumber: Real): String;
  function MyStrToInt(p_sString: String): Integer;
  function RightWithZeros(p_sString: String; p_nLength: Integer): String;
  function LeftWithSpaces(p_sString: String; p_nLength: Integer): String;
  function ReplaceDiacriticalMarks(p_sInputString: String): String;
  function MyDateToStr(p_dtDateTime: TDateTime; p_sShortDateFormat: String = ''): String;
  function MyDateTimeToStr(p_dtDateTime: TDateTime; p_sShortDateFormat: String = ''; p_bMiliSeconds: Boolean = True): String;
  function MyStrToDateTime(p_sDateTime: String; p_sShortDateFormat: String = ''; p_sDateSeparator: Char = '.'): TDateTime;
  function MyQuotedStr(p_sString: String): String;
  function HashString(p_sString: String): String;

  function MyRoundTo(p_rValue: Double; p_nDecimals: ShortInt): Double;
  function MyBooleanToStr(p_bBoolean: Boolean; p_nType: Byte = 1): String;
  function Split(p_sInput: String; p_cDelimiter: Char): TStringList;

  function GetComputerName: String;
  function GetDateFrom(p_dtDate: TDateTime; p_sShortDateFormat: String = ''): String;
  function GetDateTo(p_dtDate: TDateTime; p_sShortDateFormat: String = ''): String;

  function MyMessageBox(p_sMessage: String; p_MessageType: TMsgDlgType; p_frmActiveForm: TForm = nil): Integer;
  function ReplaceSpecialCharacters(p_sInputString: String): String;
  function Format(const Format: String; const Args: array of const): String;
  procedure DoWriteToLog(p_sMessage: String; p_sLogType: String = '');
  function GetFrmMainStatusPanel: String;
  function IntToBinary(p_nValue: Integer): String;
  function CheckIntegerCharacters(p_sString: String): Boolean;
  procedure GetFileInfo(psFileName: String; var FileInfoArray: TFileInfo);
  function UnitToFactor(p_sUnit: String): Real;

implementation

uses
  Splash, Parameters, TypInfo, About, StdCtrls,
  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  Login, ChangePassword, Complexes,
  {$IFNDEF WINSTOCK}
  {$IFNDEF WININSERT}
  Modules,
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  cxCustomData, cxGridCustomView, cxGrid, cxGridExportLink, cxGridPopupMenu, cxMemo;

{$R *.dfm}

procedure TdmCommon.DataModuleCreate(Sender: TObject);
var
  VerInfo: TOSVersioninfo;
begin
  // Toto je zde kvùli Delphi 2010
  Application.MainFormOnTaskbar := True;
  gfCurrentModalForm := nil;

  gbTerminate := False;
  gbModulePermissionError := False;

  // Umožnit Windows dialogovým oknùm pøijímat zprávy odeslané do hlavního okna aplikace (napø. ukonèení modulu Správcem)
  Application.HookMainWindow(ApplicationMessage);

  {$IFDEF MULTILANGUAGE}
  // Lokalizace
  FLanguages := TMultiLanguages.Create;
  slResourceString := THashedStringList.Create;
  slLogResourceString := THashedStringList.Create;
  ModuleName := 'Common';

  if not dmCommon.Languages.GetResourcestringStringList(slLogResourceString, ModuleName, Self.Name, csDefaultLanguage) then
  begin
    gbTerminate := True;
    Application.Terminate;
    Exit;
  end;

  FLanguages.UserLanguageCode := csDefaultLanguage;

  if not InitTranslate('Common') then
  begin
    gbTerminate := True;
    Application.Terminate;
    Exit;
  end;
  {$ENDIF}

  gCriticalSection := TCriticalSection.Create;

  frmSplash := TfrmSplash.Create(nil);
  frmSplash.ShowSplash;

  // Globální promìnné
  gbApplicationLogin := True;
  gbTooManyModules := False;
  gnRunningModuleId := 0;
  gbRunIndependent := False;

  // Test na windows Vista - TODO asi by to chtìlo pøedìlat na nìjakou obecnìjší detekci Windows - viz Správce - GetWindowsVersion
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);
  gbIsWindowsVista := VerInfo.dwMajorVersion >= 6;
  gbIsWindows7 := gbIsWindowsVista and (VerInfo.dwMinorVersion >= 1);
end;

function TdmCommon.DeleteRecord(p_sTable, p_sField, p_sValue: String; p_sSQL: String = ''; p_sRelatedTables: String = ''; p_bCursor: Boolean = True;
  p_bCorrectSQL: Boolean = True): Boolean;
var
  lsMessage: String;
begin
  Result := True;

  if Trim(p_sSQL) <> '' then
  begin
    qrDrecord.CommandText := p_sSQL;
  end else
  begin
    qrDrecord.CommandText :=
      'DELETE ' + p_sTable + ' ' +
      'WHERE ' + p_sField + ' = ' + p_sValue;
  end;

  if not MyExecuteQuery(qrDrecord, False, p_bCorrectSQL, p_bCursor, False) then
  begin
    if p_bCursor then
    begin
      Screen.Cursor := crDefault;
    end;

    // Tento záznam nelze smazat, pravdìpodobnì již byly vytvoøeny jiné záznamy
    lsMessage := resSqlDeleteNotPermitted_1;

    if Trim(p_sRelatedTables) <> '' then
    begin
      // (napø. ' + psRelatedTables + ')
      lsMessage := lsMessage + ' ' + Format(resSqlDeleteNotPermitted_2, [p_sRelatedTables]);
    end;

    // , které jej využívají!' + #13 + #13 + gsErrorMessage
    lsMessage := lsMessage + Format(resSqlDeleteNotPermitted_3, [gsErrorMessage]);

    if Pos('REFERENCE', gsErrorMessage) > 0 then
    begin
      MyMessageBox(lsMessage, mtError, Screen.Activeform)
    end else
    begin
      // Chyba pøi mazání záznamu! + #13 + #13 + gsErrorMessage
      MyMessageBox(Format(resSqlDeleteError, [gsErrorMessage]), mtError, Screen.Activeform);
    end;

    // Chyba pøi mazání záznamu! Tabulka: psTable, pole: psField, hodnota: psValue
    WriteToLog(PResStringRec(@resSqlDeleteErrorLog), 'resSqlDeleteErrorLog', [p_sTable, p_sField, p_sValue, gsErrorMessage]);

    Result := False;
  end;
end;

function TdmCommon.RecordExists(p_sTable, p_sField, p_sValue: String): Boolean;
// Zjistí jestli existuje záznam
var
  qrStable: TADODataSet;
begin
  Result := False;
  qrStable := TADODataSet.Create(Self);

  try
    qrStable.Name := 'qrStable';
    qrStable.Connection := cnOperatorConnection;
    qrStable.Close;
    qrStable.CommandText :=
      'SELECT COUNT(*) AS n_count ' +
      'FROM ' + p_sTable + ' ';

    qrStable.CommandText := qrStable.CommandText +
      'WHERE UPPER(RTRIM(' + p_sField + ')) = UPPER(RTRIM(' + p_sValue + '))';

    if not MyOpenQuery(qrStable, True, True, False) then
    begin
      Exit;
    end;

    Result := qrStable.FieldByName('n_count').AsInteger > 0;
    qrStable.Close;
  finally
    qrStable.Free;
  end;
end;

function OpenLoginWindow(p_sUserRightCode: String; p_sTitle: String = ''; p_ctrlAdditionalControls: TControl = nil): Boolean;
// Otevøe login okno
var
  lbWithoutPassword: Boolean;
  lnCheckUser: Integer;
  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  {$IFNDEF WINSTOCK}
  lnMove: Integer;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
begin
  Result := False;
  lbWithoutPassword := False;

  if gbAutoLogin or ((Trim(p_sTitle) = '') and (Trim(gsUserLogin) <> '') and (Trim(gsUserPassword) <> '')) then
  // Autologin (jen pro tiskový server) nebo login a heslo byly zadány na pøíkazové øádce (parametry)
  begin
    if (gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server') then
    // Tiskový server se pøihlašuje pod adminem
    begin
      gsUserLogin := csAdmin;
      lbWithoutPassword := True;
    end else
    if gsModuleCode = 'opc_synchro' then
    begin
      gsUserLogin := dmCommon.GetValueFromDatabaseConfiguration(csOPCSynchroUserKey);
      gsUserPassword := csOPCSynchroPassword; // HF - heslo se hashovalo dvakrát
      gsNotHashedUserPassword := csOPCSynchroPassword;
    end else
    if gsModuleCode = 'text_panel' then
    begin
      gsUserLogin := dmCommon.GetValueFromDatabaseConfiguration(csTextPanelUserKey);
      gsUserPassword := csTextPanelPassword;
      gsNotHashedUserPassword := csTextPanelPassword;
    end else
    if gsModuleCode = 'batch_comp' then
    begin
      // Kompletace šarže se pøihlašuje pod adminem
      if gsUserLogin = '' then
      begin
        gsUserLogin := csAdmin;
      end;

      lbWithoutPassword := True;
    end;

    // Existuje uživatel?
    lnCheckUser := dmCommon.CheckUser(gsUserLogin, gsUserPassword, lbWithoutPassword);

    if lnCheckUser = 0 then
    begin
      // Kontrola oprávnìní
      if (AnsiUpperCase(Trim(gsUserLogin)) <> AnsiUpperCase(csAdmin)) and
        (gsModuleCode <> 'opc_synchro') and (gsModuleCode <> 'text_panel') and (gsModuleCode <> 'batch_comp') and
        (not dmCommon.CheckUserRights(p_sUserRightCode, -1, True)) then
      begin
        if Trim(p_sTitle) <> '' then
        begin
          // Login okno se spouští jindy než pøi spuštìní
          // Nemáte oprávnìní pro tuto èinnost!
          MyMessageBox(resNoActivityPermissionError, mtError, Screen.Activeform);
        end else
        begin
          // Nemáte oprávnìní spustit tento modul!
          MyMessageBox(resNoRunModulePermissionError, mtError, Screen.Activeform);
        end;

        Exit;
      end;

      // Vše prošlo OK => zkusit pøipojit operator connection
      Result := dmCommon.ConnectToMSSQL(dmCommon.cnOperatorConnection);

      {$IFDEF MULTILANGUAGE}
      // Naètení jazyka pøihlášeného uživatele
      // 29.11.2007 tiskový server se spouští s jazykem poèítaèe
      if (gsModuleCode <> 'prn_srvr') and (gsModuleCode <> 'print_server') and
        // ASK 19.12.2009: Textový panel je brán jako svým zpùsobem pracovištì. A tak se také BUDE chovat. Pracovištì pøebírá jazyk poèítaèe.
        (gsModuleCode <> 'text_panel') and
        not ParameterExists(csParameterLanguage) then
      begin
        dmCommon.SetUserLanguage;
      end;
      {$ENDIF}

      Exit;
    end else
    if lnCheckUser = -2 then
    begin
      // Chyba pøi provádìní dotazu do databáze
      Exit;
    end;
  end;

  // Neexistující uživatel - OPC Synchro nahlásí chybu a skonèí, ale nepotøebuje se ptát na heslo
  if (gsModuleCode = 'opc_synchro') or (gsModuleCode = 'text_panel') then
  begin
    Exit;
  end;

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  frmLogin := TfrmLogin.Create(Application);
  frmLogin.gsUserRightCode := p_sUserRightCode;

  if Trim(p_sTitle) = '' then
  begin
    // Zobrazení názvu modulu v titulku okna
    // Pøihlášení do modulu + gsModuleName;
    frmLogin.Caption := Format(resModuleLoginError, [gsModuleName]);
  end else
  begin
    // Login okno se spouští jindy než pøi spuštìní
    frmLogin.Caption := p_sTitle;

    if ((gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar)) or
      (gsUserRightCode <> 'worksite') then
    begin
      // Skrytí prvkù pro zmìnu jazyka uživatele
      frmLogin.ClientHeight := frmLogin.edtHeslo.Top + frmLogin.edtHeslo.Height + frmLogin.Panel1.Height + frmLogin.StatusBar1.Height;
      frmLogin.cbChangeLang.Visible := False;
    end;

    {$IFNDEF WINSTOCK}
    // Úprava pro kompletaci šarže - poèítaè s dotykovým displejem
    if gsUserRightCode = 'batch_comp' then
    begin
      // HF 22.9.2014 - úprava pro DPI > 96; možná by se vyplatilo použít pro všechny výskyty
      frmLogin.ClientHeight := frmLogin.edtHeslo.Top + frmLogin.edtHeslo.Height + frmLogin.Panel1.Height + frmLogin.StatusBar1.Height;

      if p_ctrlAdditionalControls <> nil then
      begin
        lnMove := 20;
        frmLogin.Height := frmLogin.Height + p_ctrlAdditionalControls.Height - lnMove;
        p_ctrlAdditionalControls.Parent := frmLogin;
        p_ctrlAdditionalControls.Left := 0;
        p_ctrlAdditionalControls.Width := frmLogin.ClientWidth;
        p_ctrlAdditionalControls.Top := 0;

        frmLogin.Label1.Top := frmLogin.Label1.Top + p_ctrlAdditionalControls.Height - lnMove;
        frmLogin.Label2.Top := frmLogin.Label2.Top + p_ctrlAdditionalControls.Height - lnMove;
        frmLogin.edtJmeno.Top := frmLogin.edtJmeno.Top + p_ctrlAdditionalControls.Height - lnMove;
        frmLogin.edtHeslo.Top := frmLogin.edtHeslo.Top + p_ctrlAdditionalControls.Height - lnMove;

        frmLogin.ResizeForm(p_ctrlAdditionalControls, Application.MainForm.Font.Height / frmLogin.Font.Height);
      end;

      frmLogin.ResizeForm(Application.MainForm.Font.Height / frmLogin.Font.Height);
    end;
    {$ENDIF}
  end;

  frmSplash.HideSplash;

  try
    {$IFNDEF MULTILANGUAGE}
    if ((gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar)) or
      (gsUserRightCode <> 'worksite') then
    begin
      // Skrytí prvkù pro zmìnu jazyka uživatele
      frmLogin.ClientHeight := frmLogin.edtHeslo.Top + frmLogin.edtHeslo.Height + frmLogin.Panel1.Height + frmLogin.StatusBar1.Height;
      frmLogin.cbChangeLang.Visible := False;
    end;
    {$ENDIF}

    if frmLogin.ShowModal = mrOk then
    begin
      Result := True;

      {$IFDEF MULTILANGUAGE}
      // Naètení jazyka pøihlášeného uživatele
      if (Trim(p_sTitle) = '') and (not frmLogin.cbChangeLang.Checked) then
      begin
        if not ParametersRefresh(dmCommon.fnSget_usr_lang) then
        begin
          Exit;
        end;

        dmCommon.fnSget_usr_lang.Parameters.ParamByName('@p_n_user_id').Value := gnUserId;

        if MyExecProc(dmCommon.fnSget_usr_lang) then
        begin
          if (dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE'] <> dmCommon.FLanguages.UserLanguageCode) and
            (Trim(dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE']) <> '') and
            (dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE'] <> Null) then
          begin
            dmCommon.FLanguages.UserLanguageCode := dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE'];
          end;

          dmCommon.fnSget_usr_lang.Close;
        end;
      end;
      {$ENDIF}
    end;
  finally
    if p_ctrlAdditionalControls <> nil then
    begin
      p_ctrlAdditionalControls.Parent := nil;
    end;

    frmLogin.Free;
  end;
  {$ENDIF}
  {$ENDIF}
end;

function TdmCommon.ChangePassword: Boolean;
begin
  Result := True;

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  // WinPackage a WinMixWeighing nemají uživatele
  if PasswordMustBeChanged then
  begin
    // ANO => zmìnit
    frmChangePassword := TfrmChangePassword.Create(Application);

    try
      // Heslo zmìnìno?
      if frmChangePassword.ShowModal <> mrOk then
      begin
        Result := False;
      end;
    finally
      frmChangePassword.Free;
    end;
  end;
  {$ENDIF}
  {$ENDIF}
end;

{$IFNDEF WINPACKAGE}
{$IFNDEF WINMIXWEIGHING}
function TdmCommon.PasswordMustBeChanged: Boolean;
begin
  Result := False;

  // Dtaily pøihlášeného uživatele
  qrSusr.Connection := cnOperatorConnection;
  qrSusr.Close;
  qrSusr.CommandText :=
    'SELECT usr.usr_b_must_change_password ' +
    'FROM ws.t_usr_users AS usr ' +
    'WHERE usr.usr_s_login = ' + MyQuotedStr(gsUserLogin) + ' ' +
    'AND usr.usr_b_history = 0 ';

  if (gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar) then
  // V databázi WinStock nejsou uživatelé napojeni na provozy
  begin
    qrSusr.CommandText := qrSusr.CommandText +
      'AND ' +
      '  (' +
      '  usr.wcx_n_id = ' + IntToStr(gnComplexId) + ' ' +
      '  OR UPPER(usr.usr_s_login) = ' + MyQuotedStr(AnsiUpperCase(csAdmin)) +
      '  )';
  end;

  if not MyOpenQuery(qrSusr, True, True, False) then
  begin
    Exit;
  end;

  // Musí uživatel mìnit heslo?
  if qrSusr.FieldByName('usr_b_must_change_password').AsBoolean then
  begin
    Result := True;
    qrSusr.Close;
    Exit;
  end;

  qrSusr.Close;

  // NE => vypršel interval zmìny hesla?
  qrSusr.CommandText :=
    'SELECT ' +
    '  usr.usr_dt_password_change_date, ' +
    '  GETDATE() AS dt_getdate, ' +
    '  MIN(ugr.ugr_n_password_interval) AS n_min_ugr_password_interval ' +
    'FROM ws.t_usr_users AS usr ' +
    'INNER JOIN ws.t_uga_user_group_allocation AS uga ' +
    'ON uga.usr_n_id = usr.usr_n_id ' +
    'INNER JOIN ws.t_ugr_user_groups AS ugr ' +
    'ON ugr.ugr_n_id = uga.ugr_n_id ' +
    'AND ugr.ugr_n_password_interval > 0 ' +
    'WHERE usr.usr_s_login = ' + MyQuotedStr(gsUserLogin) + ' ' +
    'AND usr.usr_b_history = 0 ';

  if (gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar) then
  // V databázi WinStock nejsou uživatelé napojeni na provozy
  begin
    qrSusr.CommandText := qrSusr.CommandText +
      'AND usr.wcx_n_id = ' + IntToStr(gnComplexId) + ' ';
  end;

  qrSusr.CommandText := qrSusr.CommandText +
    'GROUP BY usr.usr_dt_password_change_date ';

  if not MyOpenQuery(qrSusr, True, True, False) then
  begin
    Exit;
  end;

  if qrSusr.FieldByName('n_min_ugr_password_interval').AsInteger > 0 then
  begin
    if DaysBetween(qrSusr.FieldByName('usr_dt_password_change_date').AsDateTime,
      qrSusr.FieldByName('dt_getdate').AsDateTime) >= qrSusr.FieldByName('n_min_ugr_password_interval').AsInteger then
    begin
      Result := True;
    end;
  end;

  qrSusr.Close;
end;
{$ENDIF}
{$ENDIF}

function TdmCommon.UserCanChangePassword: Boolean;
// Mùže uživatel zmìnit heslo?
begin
  Result := False;

  if AnsiUpperCase(gsUserLogin) = AnsiUpperCase(csAdmin) then
  // uživatel 'admin' mùže vždy mìnit heslo
  begin
    Result := True;
    Exit;
  end;

  // select detaily pøihlášeného uživatele
  qrSusr.Connection := cnOperatorConnection;
  qrSusr.Close;
  qrSusr.CommandText :=
    'SELECT usr_b_can_change_password ' +
    'FROM ws.t_usr_users ' +
    'WHERE usr_s_login = ' + MyQuotedStr(gsUserLogin) + ' ' +
    'AND usr_b_history = 0 ';

  if (gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar) then
  // v databázi WinStock nejsou uživatelé napojeni na provozy
  begin
    qrSusr.CommandText := qrSusr.CommandText +
      'AND wcx_n_id = ' + IntToStr(gnComplexId);
  end;

  if not MyOpenQuery(qrSusr) then
  begin
    Exit;
  end;

  // Mùže uživatel mìnit heslo?
  Result := qrSusr.FieldByName('usr_b_can_change_password').AsBoolean = True;
  qrSusr.Close;
end;

function TdmCommon.ConnectToMSSQL(pADOConnection: TADOConnection): Boolean;
// Try to connect to database
begin
  Result := False;
  // Probíhá pøipojení k databázi...
  frmSplash.SetActionLabel(resDatabaseConnection);

  try
    pADOConnection.Close;

    pADOConnection.ConnectionString :=
      'Provider = SQLOLEDB.1;' +
      'User ID = ' + gsSQLLogin + ';' +
      'Password = ' + gsSQLPassword + ';' +
      'Application Name = ' + IntToStr(gnUserId) + '@' + gsModuleCode + '.' + IntToStr(gnComplexId) + ';' +
      'Initial Catalog = ' + gsDatabase + ';' +
      'Data Source = ' + gsServer + ';' +
      // Aby z procesù zmizel connection po jeho zavøení
      'OLE DB Services = -2';
    pADOConnection.Open;

    Result := True;
  except
    on E: Exception do
    begin
      frmSplash.HideSplash;
      // Chyba pøipojení k databázovému serveru MS SQL!
      // (Aplikace: ExtractFileName(Application.ExeName);
      // MS SQL server: gsServer;
      // Databáze: gsDatabase; + E.Message)
      WriteToLog(PResStringRec(@resSqlConnErrorDetailsLog), 'resSqlConnErrorDetailsLog', [ExtractFileName(Application.ExeName), gsServer,
        gsDatabase, E.Message]);
      // Chyba pøipojení k databázovému serveru MS SQL!
      // Aplikace: ExtractFileName(Application.ExeName)
      // MS SQL server: gsServer
      // Databáze: gsDatabase
      // Kontaktujte prosím zodpovìdnou osobu! + #13 + #13 + E.Message
      MyMessageBox(Format(resSqlConnectionDetailsError, [ExtractFileName(Application.ExeName), gsServer, gsDatabase, E.Message]), mtError,
        Screen.Activeform);
    end;
  end;
end;

function TdmCommon.UpdateConnectionString(pADOConnection: TADOConnection): Boolean;
// Zmìna v ConnectionString
var
  i: Integer;
begin
  Result := False;

  try
    for i := 0 to pADOConnection.DataSetCount - 1 do
    begin
      pADOConnection.DataSets[i].Close;
    end;

    pADOConnection.Close;

    pADOConnection.ConnectionString :=
      'Provider = SQLOLEDB.1;' +
      'User ID = ' + gsSQLLogin + ';' +
      'Password = ' + gsSQLPassword + ';' +
      'Application Name = ' + IntToStr(gnUserID) + '@' + gsModuleCode + '.' + IntToStr(gnComplexID) + ';' +
      'Initial Catalog = ' + gsDatabase + ';' +
      'Data Source = ' + gsServer + ';' +
      // Aby z procesù zmizel connection po jeho zavøení
      'OLE DB Services = -2';

    pADOConnection.Open;
    Result := True;
  except
    on E: Exception do
    begin
      // Chyba pøipojení k databázovému serveru MS SQL! (
      // Aplikace: gsEnglishModuleName;
      // MS SQL server: gsServer;
      // Databáze: gsDatabase; E.Message)
      DoWriteToLog(Format(resSqlConnErrorDetailsLog, [gsEnglishModuleName, gsServer, gsDatabase, E.Message]));
      // Chyba pøipojení k databázovému serveru MS SQL!
      // Aplikace: gsEnglishModuleName
      // MS SQL server: gsServer
      // Databáze: gsDatabase
      // Kontaktujte prosím zodpovìdnou osobu!
      // E.Message
      MyMessageBox(Format(resSqlConnectionDetailsError, [gsEnglishModuleName, gsServer, gsDatabase, E.Message]), mtError);
    end;
  end;
end;

function TdmCommon.CheckUser(p_sUser: String; p_sPassword: String; p_bWithoutPassword: Boolean = False): Integer;
// Existuje uživatel?
var
  lsSQL: String;
  lsPassword: String;
  lbPasswordOk: Boolean;
// Výsledek: 0 = ok, -1 = uživatel není ok, -2 = chyba pøi provádìní dotazu
begin
  Result := -1;
  lsPassword := '';

  try
    qrSusr.Close;

    if gbApplicationLogin then
    begin
      // pøihlašovací okno zobrazeno pøi startu
      qrSusr.Connection := cnSystemConnection;
    end else
    begin
      // pøihlašovací okno zobrazeno pozdìji
      qrSusr.Connection := cnOperatorConnection;
    end;

    lsSQL :=
      'SELECT * ' +
      'FROM ws.t_usr_users ' +
      'WHERE usr_s_login = ' + MyQuotedStr(p_sUser) + ' ' +
      'AND usr_b_blocked = 0 ' +
      'AND usr_b_history = 0 ';

    if (not p_bWithoutPassword) and (Trim(p_sPassword) = '') then
    begin
      lsSQL := lsSQL + 'AND usr_s_password IS NULL ';
    end;

    if (gsImplementationCode <> csImplementationWiStBUCZ) and (gsImplementationCode <> csImplementationWiStAcerostar) then
    // v databázi WinStock nejsou uživatelé napojeni na provozy
    begin
      if (AnsiUpperCase(p_sUser) <> AnsiUpperCase(csAdmin)) and (gsModuleCode <> 'opc_synchro') and (gsModuleCode <> 'text_panel') then
      // není 'admin' => jen pro 1 provoz, OPC Synchro má taky globálního uživatele
      begin
        lsSQL := lsSQL + 'AND wcx_n_id = ' + IntToStr(gnComplexId);
      end;
    end;

    qrSusr.CommandText := lsSQL;

    if not MyOpenQuery(qrSusr, True, True, False) then
    begin
      Result := -2;
      Exit;
    end;

    if not qrSusr.IsEmpty then
    // Uživatel nalezen
    begin
      qrSusr.First;
      lsPassword := qrSusr.FieldByName('usr_s_password').AsString;

      // WinFormula, WinProduction a WinInsert mají šifrovaná hesla
      if (gsImplementationCode = csImplementationWiStBUCZ) or (gsImplementationCode = csImplementationWiStAcerostar) then
      begin
        lbPasswordOk := AnsiUpperCase(p_sPassword) = AnsiUpperCase(lsPassword);
      end else
      begin
        lbPasswordOk := HashString(p_sPassword) = lsPassword;
      end;

      if gbApplicationLogin then
      begin
        // pøihlašovací okno zobrazeno pøi startu
        if p_bWithoutPassword or lbPasswordOk then
        // autologin nebo heslo je správné
        begin
          // nastav globální promìnné
          gsUserLogin := p_sUser;
          gnUserId := qrSusr.FieldByName('usr_n_id').AsInteger;
          gsUserPassword := lsPassword;
          gsNotHashedUserPassword := p_sPassword;
          gsUserName := Trim(qrSusr.FieldByName('usr_s_first_name').AsString + ' ' + qrSusr.FieldByName('usr_s_surname').AsString);
          gsUserFirstName := Trim(qrSusr.FieldByName('usr_s_first_name').AsString);
          gsUserSurname := Trim(qrSusr.FieldByName('usr_s_surname').AsString);
          Result := 0;
        end;
      end else
      begin
        // pøihlašovací okno zobrazeno pozdìji
        if lbPasswordOk then
        begin
          // heslo je správné
          gnLoginUserID := qrSusr.FieldByName('usr_n_id').AsInteger;
          gsLoginUserName := Trim(qrSusr.FieldByName('usr_s_first_name').AsString + ' ' + qrSusr.FieldByName('usr_s_surname').AsString);
          Result := 0;
        end;
      end;
    end;
  finally
    qrSusr.Close;
  end;
end;

function TdmCommon.CheckUserRights(p_sUrhCode: String; p_nUsrId: Integer = -1; p_bCheckAdmin: Boolean = False): Boolean;
// kontrola oprávnìní uživatele pro urèitou akci
begin
  qrSurh.Close;

  if p_bCheckAdmin and (AnsiUpperCase(gsUserLogin) = AnsiUpperCase(csAdmin)) then
  begin
    Result := True;
    Exit;
  end;

  if p_nUsrId = -1 then
  begin
    if gbApplicationLogin then
    begin
      // pøihlašovací okno zobrazeno pøi startu
      qrSurh.Parameters.ParamByName('usr_n_id').Value := gnUserId;
    end else
    begin
      // pøihlašovací okno zobrazeno pozdìji
      qrSurh.Parameters.ParamByName('usr_n_id').Value := gnLoginUserID;
    end;
  end else
  begin
    qrSurh.Parameters.ParamByName('usr_n_id').Value := p_nUsrId;
  end;

  qrSurh.Parameters.ParamByName('urh_s_code').Value := p_sUrhCode;
  MyOpenQuery(qrSurh);
  Result := not qrSurh.IsEmpty;
  qrSurh.Close;
end;

function LoadFromIni(p_sSection, p_sKey, p_sDefault: String; p_bPrivate: Boolean = False): String;
// Nahraje hodnoty z ini
var
  Ini: TIniFile;
begin
  Ini := OpenIniFile(p_bPrivate);
  Result := Ini.ReadString(p_sSection, p_sKey, p_sDefault);
  Ini.Free;
end;

procedure SaveToIni(p_sSection, p_sKey, p_sValue: String; p_bPrivate: Boolean = False);
// Uloží hodnoty do ini
var
  Ini: TIniFile;
begin
  Ini := OpenIniFile(p_bPrivate);
  Ini.WriteString(p_sSection, p_sKey, p_sValue);
  Ini.Free;
end;

function OpenIniFile(p_bPrivate: Boolean = False): TIniFile;
// otevøe správný INI soubor v závislosti na parametru p_bPrivate
var
  lsComputerName: String;
  lsFilePath: String;
begin
  if p_bPrivate then
  begin
    // Název PC
    if Trim(gsComputerName) <> '' then
    begin
      lsComputerName := gsComputerName;
    end else
    begin
      lsComputerName := GetComputerName;
    end;

    lsComputerName := Trim(lsComputerName);
    lsFilePath := ExtractFilePath(Application.ExeName) + 'Settings\' + lsComputerName + '\' + ChangeFileExt(ExtractFileName(Application.ExeName), '');
    lsFilePath := IncludeTrailingPathDelimiter(lsFilePath);
    ForceDirectories(lsFilePath);
    lsFilePath := lsFilePath + ExtractFileName(ChangeFileExt(Application.ExeName, '.ini'));
  end else
  begin
    lsFilePath := ChangeFileExt(Application.ExeName, '.ini')
  end;

  Result := TIniFile.Create(lsFilePath);
end;

function MyOpenQuery(var pADODataSet: TADODataSet; pbTerminate: Boolean = True; pbCorrectSQL: Boolean = True; pbCursor: Boolean = True;
  pbShowMessage: Boolean = True): Boolean;
// otevøe dataset a ošetøí chyby
var
  lbExit: Boolean;
  lsDataSetName: String;
begin
  Result := False;
  lbExit := False;
  gsLastError := '';
  lsDataSetName := pADODataSet.Name;

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  // Správce si tiskový server ukonèí sám
  if ((gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server')) and gbModuleCalledFromManager then
  begin
    pbTerminate := False;
  end;

  repeat
    if pbCursor then
    begin
      Screen.Cursor := crHourGlass;
    end;

    try
      pADODataSet.Close;

      if pbCorrectSQL then
      begin
        pADODataSet.CommandText := CorrectSQL(pADODataSet.CommandText);
      end;

      pADODataSet.Open;

      // Bez chyb => konec
      lbExit := True;
      Result := True;
    except
      on E: Exception do
      begin
        if not CheckErrors('MyOpenQuery (' + lsDataSetName + '): ' + E.Message, pbTerminate, pbShowMessage, pbCursor) then
        // Chyby, neopakovat => konec, Application.Terminate
        begin
          DoWriteToLog('SQL: ' + pADODataSet.CommandText);
          pADODataSet.Close;
          lbExit := True;
          Result := False;

          if pbTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    end;
  until lbExit;

  if pbCursor then
  begin
    Screen.Cursor := crDefault;
  end;
end;

function MyExecuteQuery(var pADOCommand: TADOCommand; pbTerminate: Boolean = True; pbCorrectSQL: Boolean = True; pbCursor: Boolean = True;
  pbShowMessage: Boolean = True): Boolean;
// provede dotaz a ošetøí chyby
var
  lbExit: Boolean;
  lsCommandName: String;
begin
  Result := False;
  lbExit := False;
  gsLastError := '';
  lsCommandName := pADOCommand.Name;

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  // Správce si tiskový server ukonèí sám
  if ((gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server')) and gbModuleCalledFromManager then
  begin
    pbTerminate := False;
  end;

  repeat
    if pbCursor then
    begin
      Screen.Cursor := crHourGlass;
    end;

    try
      if pbCorrectSQL then
      begin
        pADOCommand.CommandText := CorrectSQL(pADOCommand.CommandText);
      end;

      pADOCommand.Execute;
      // bez chyb => konec
      lbExit := True;
      Result := True;
    except
      on E: Exception do
      begin
        if not CheckErrors('MyExecuteQuery (' + lsCommandName + '): ' + E.Message, pbTerminate, pbShowMessage) then
        // chyby, neopakovat => konec, Application.Terminate
        begin
          DoWriteToLog('SQL: ' + pADOCommand.CommandText);
          lbExit := True;
          Result := False;

          if pbTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    end;
  until lbExit;

  if pbCursor then
  begin
    Screen.Cursor := crDefault;
  end;
end;

function MyExecProc(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True; p_bCursor: Boolean = True;
  p_bShowMessage: Boolean = True): Boolean;
// spustí uloženou proceduru a ošetøí chyby
var
  lbExit: Boolean;
  lsProcedureName: String;
begin
  Result := False;
  lbExit := False;
  gsLastError := '';

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  // Správce si tiskový server ukonèí sám
  if ((gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server')) and gbModuleCalledFromManager then
  begin
    p_bTerminate := False;
  end;

  if Trim(p_ADOStoredProc.Name) <> '' then
  begin
    lsProcedureName := p_ADOStoredProc.Name;
  end else
  begin
    lsProcedureName := p_ADOStoredProc.ProcedureName;
  end;

  repeat
    if p_bCursor then
    begin
      Screen.Cursor := crHourGlass;
    end;

    try
      if p_bCorrectSQL then
      begin
        p_ADOStoredProc.ProcedureName := CorrectSQL(p_ADOStoredProc.ProcedureName);
      end;

      p_ADOStoredProc.ExecProc;
      // bez chyb => konec
      lbExit := True;
      Result := True;
    except
      on E: Exception do
      begin
        if not CheckErrors('MyExecProc (' + lsProcedureName + '): ' + E.Message, p_bTerminate, p_bShowMessage) then
        // chyby, neopakovat => konec, Application.Terminate
        begin
          DoWriteToLog('SQL: ' + p_ADOStoredProc.ProcedureName);
          lbExit := True;
          Result := False;

          if p_bTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    end;
  until lbExit;

  if p_bCursor then
  begin
    Screen.Cursor := crDefault;
  end;
end;

function MyOpenProc(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True; p_bCursor: Boolean = True;
  p_bShowMessage: Boolean = True): Boolean;
// otevøe uloženou proceduru a ošetøí chyby
var
  lbExit: Boolean;
  lsProcedureName: String;
begin
  Result := False;
  lbExit := False;
  gsLastError := '';

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  // Správce si tiskový server ukonèí sám
  if ((gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server')) and gbModuleCalledFromManager then
  begin
    p_bTerminate := False;
  end;

  if Trim(p_ADOStoredProc.Name) <> '' then
  begin
    lsProcedureName := p_ADOStoredProc.Name;
  end else
  begin
    lsProcedureName := p_ADOStoredProc.ProcedureName;
  end;

  repeat
    if p_bCursor then
    begin
      Screen.Cursor := crHourGlass;
    end;

    try
      if p_bCorrectSQL then
      begin
        p_ADOStoredProc.ProcedureName := CorrectSQL(p_ADOStoredProc.ProcedureName);
      end;

      p_ADOStoredProc.Open;
      // bez chyb => konec
      lbExit := True;
      Result := True;
    except
      on E: Exception do
      begin
        if not CheckErrors('MyOpenProc (' + lsProcedureName + '): ' + E.Message, p_bTerminate, p_bShowMessage) then
        // chyby, neopakovat => konec, Application.Terminate
        begin
          DoWriteToLog('SQL: ' + p_ADOStoredProc.ProcedureName);
          lbExit := True;
          Result := False;

          if p_bTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    end;
  until lbExit;

  if p_bCursor then
  begin
    Screen.Cursor := crDefault;
  end;
end;

function ParametersRefresh(var p_ADOStoredProc: TADOStoredProc; p_bTerminate: Boolean = True; p_bCorrectSQL: Boolean = True;
  p_bCursor: Boolean = True; p_bShowMessage: Boolean = True): Boolean;
// obnovení parametrù uložené procedury a ošetøí chyby
var
  lbExit: Boolean;
  lsProcedureName: String;
begin
  Result := False;
  lbExit := False;
  gsLastError := '';

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  // Správce si tiskový server ukonèí sám
  if ((gsModuleCode = 'prn_srvr') or (gsModuleCode = 'print_server')) and gbModuleCalledFromManager then
  begin
    p_bTerminate := False;
  end;

  if Trim(p_ADOStoredProc.Name) <> '' then
  begin
    lsProcedureName := p_ADOStoredProc.Name;
  end else
  begin
    lsProcedureName := p_ADOStoredProc.ProcedureName;
  end;

  repeat
    if p_bCursor then
    begin
      Screen.Cursor := crHourGlass;
    end;

    if p_bCorrectSQL then
    begin
      p_ADOStoredProc.ProcedureName := CorrectSQL(p_ADOStoredProc.ProcedureName);
    end;

    try
      if p_ADOStoredProc.Parameters.Refresh then
      begin
        // bez chyb => konec
        lbExit := True;
        Result := True;
      end else
      begin    // chyba pøi refreshi, která nevyvolá vyjímku
        if not CheckErrors('ParametersRefresh (' + p_ADOStoredProc.ProcedureName + ')', p_bTerminate, p_bShowMessage) then
        // chyby, neopakovat => konec, Application.Terminate
        begin
          DoWriteToLog('SQL: ' + p_ADOStoredProc.ProcedureName);
          p_ADOStoredProc.Close;
          lbExit := True;
          Result := False;

          if p_bTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        if not CheckErrors('ParametersRefresh (' + lsProcedureName + '): ' + E.Message, p_bTerminate, p_bShowMessage) then
        // chyby, neopakovat => konec, Application.Terminate
        begin
          lbExit := True;
          Result := False;

          if p_bTerminate then
          begin
            dmCommon.tmrApplicationTerminate.Enabled := True;
          end;
        end;
      end;
    end;
  until lbExit;

  if p_bCursor then
  begin
    Screen.Cursor := crDefault;
  end;
end;

function CheckNULL(p_sField: String; p_byType: Byte = 1; p_byMode: Byte = 1): Variant;
{
p_byType  1 = String - default
          2 = jiný typ
p_byMode  1 = Insert, Update - default
          2 = Select
          3 = Parametr (bez apostrofù a èárky na konci, NULL)
}
begin
  p_sField := Trim(p_sField);

  if p_sField = '' then
  begin
    case p_byMode of
      1: Result := 'NULL, ';
      2: Result := ' IS NULL ';
      else // 3 (parametr)
      begin
        Result := NULL;
      end;
    end;
  end else
  begin
    case p_byMode of
      1: // Update a Insert
        begin
          if p_byType = 1 then
          begin
            Result := MyQuotedStr(p_sField) + ', ';
          end else
          begin
            Result := p_sField + ', ';
          end;
        end;
      2: // SELECT
        begin
          if p_byType = 1 then
          begin
            Result := '= ' + MyQuotedStr(p_sField) + ' ';
          end else
          begin
            Result := '= ' + p_sField + ' ';
          end;
        end;
      else // 3 (parametr)
      begin
        Result := p_sField;
      end;
    end;
  end;
end;

function CheckErrors(p_sErrorMessage: String; var p_bTerminate: Boolean; p_bShowMessage: Boolean = True; p_bCursor: Boolean = True): Boolean;
var
  lsMessage: String;
begin
  Result := False;
  gsErrorMessage := p_sErrorMessage;

  if Trim(p_sErrorMessage) <> '' then
  begin
    DoWriteToLog(p_sErrorMessage);
  end;

  if p_bCursor then
  begin
    Screen.Cursor := crDefault;
  end;

  // Test spojení
  if not ConnectionAlive(p_bShowMessage) then
  begin
    Exit;
  end;

  // Chyba pøi provádìní dotazu do databáze!\x0D \x0D%s
  gsLastError := Format(resSqlQueryError, [p_sErrorMessage]);

  {$IFDEF READONLY}
  p_bTerminate := False;
  {$ENDIF}

  if p_bShowMessage then
  begin
    if p_bTerminate then
    begin
      // %s\x0D \x0DPøejete si zopakovat poslední pøíkaz?
      if MyMessageBox(Format(resSqlRepeatQuery, [gsLastError]), mtCustom) = ID_YES then
      begin
        // opakovat
        Result := True;
      end;
    end else
    begin
      lsMessage := gsLastError;

      {$IFDEF READONLY}
      // Databáze je jen pro ètení, není možné provádìt žádné zmìny!
      lsMessage := resReadOnlyDb + #13#13 + lsMessage;
      {$ENDIF}

      MyMessageBox(lsMessage, mtError, Screen.Activeform);
    end;
  end;
end;

function ConnectionAlive(pbShowMessage: Boolean = True): Boolean;
begin
  Result := False;

  // Pokud se právì snažíme o spojení, tak Exit
  if (stConnecting in dmCommon.cnSystemConnection.State) or (not dmCommon.cnSystemConnection.Connected) or gbTryingConnectionAlive then
  begin
    Exit;
  end;

  gbTryingConnectionAlive := True;

  // Zkusit, je-li server živý
  try
    try
      dmCommon.qrSdcf.Close;
      dmCommon.qrSdcf.CommandText := CorrectSQL(dmCommon.qrSdcf.CommandText);
      dmCommon.qrSdcf.Open;
      dmCommon.qrSdcf.Close;
      Result := True;
      gbTryingConnectionAlive := False;
    except
      on E: Exception do
      begin
        if Trim(E.Message) <> '' then
        begin
          dmCommon.WriteToLog(PResStringRec(@resLogSqlCommunicationError), 'resLogSqlCommunicationError', [E.Message]);
        end;

        Result := False;
        // Nastavení globalní promìné pro connection
        // Chyba pøi komunikaci s MS SQL serverem!
        gsLastError := resSqlCommunicationError;

        if Trim(E.Message) <> '' then
        begin
          gsLastError := gsLastError + #13 + #13 + E.Message;
        end;

        // Zpráva se ukáže jen pro správce
        if pbShowMessage and ((gsModuleCode = 'mgr') or (gsModuleCode = 'manager')) then
        begin
          // Chyba pøi komunikaci s MS SQL serverem!
          // Modul "gsModuleName" bude uzavøen!' + #13 + #13 + E.Message
          MyMessageBox(resSqlCommunicationError + ' ' + Format(resModuleClosed, [gsModuleName, E.Message]), mtError, Screen.Activeform);
        end;
      end;
    end;
  finally
    Application.ProcessMessages;
  end;
end;

function CheckDate(p_sDate: String): Boolean;
var
  ldtDateTime: TDateTime;
begin
  if Trim(p_sDate) = '' then
  begin
    Result := True;
  end else
  begin
    Result := TryStrToDate(p_sDate, ldtDateTime);
  end;

  if Result then
  begin
    Result := (YearOf(ldtDateTime) >= 1753) and (YearOf(ldtDateTime) <= 9999);
  end;
end;

function CheckTime(p_sDateTime: String; p_sShortDateFormat: String = ''): Boolean;
var
  ldtDateTime: TDateTime;
  lFormatSettings: TFormatSettings;
begin
  if Trim(p_sDateTime) = '' then
  begin
    Result := True;
  end else
  begin
    // Read Windows settings
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);

    if Pos('.', lFormatSettings.ShortDateFormat) > 0 then
    begin
      // If the date format is for example "dd. mm. yyyy", the date separator is set to "/". This is reason of this check.
      // Short date format contains "." => set this date separator
      lFormatSettings.DateSeparator := '.';
    end;

    if p_sShortDateFormat <> '' then
    begin
      // použít zadaný formát data
      lFormatSettings.ShortDateFormat := p_sShortDateFormat;
      lFormatSettings.DateSeparator := '.';
    end;

    Result := TryStrToDateTime(p_sDateTime, ldtDateTime, lFormatSettings);
  end;

  if Result then
  begin
    Result := (YearOf(ldtDateTime) >= 1753) and (YearOf(ldtDateTime) <= 9999);
  end;
end;

function CheckInteger(psInteger: String): Boolean;
var
  liInteger: Integer;
begin
  if Trim(psInteger) = '' then
  begin
    Result := True;
  end else
  begin
    Result := TryStrToInt(psInteger, liInteger);
  end;
end;

function CheckFloat(p_sFloat: String): Boolean;
var
  ldFloat: Double;
begin
  if Trim(p_sFloat) = '' then
  begin
    Result := True;
  end else
  begin
    Result := TryStrToFloat(p_sFloat, ldFloat);
  end;
end;

procedure TdmCommon.WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const; p_sLogType: String = '');
// Zapíše do logu
var
  lsResourceString: String;
begin
  {$IFDEF MULTILANGUAGE}
  lsResourceString := Languages.GetResourceStringValue(p_sResStringName, slLogResourceString);
  {$ELSE}
  lsResourceString := LoadResString(p_ResStringRec);
  {$ENDIF}

  DoWriteToLog(Format(lsResourceString, Args), p_sLogType);
end;

procedure BeginTransaction;
// start transakce
begin
  try
    if not dmCommon.cnOperatorConnection.InTransaction then
    begin
      dmCommon.cnOperatorConnection.BeginTrans;
    end;
  except
  end;
end;

procedure RollBack;
// rollback transakce
begin
  try
    if dmCommon.cnOperatorConnection.InTransaction then
    begin
      dmCommon.cnOperatorConnection.RollbackTrans;
    end;
  except
  end;
end;

procedure Commit;
// potvrdí transakci
begin
  try
    if dmCommon.cnOperatorConnection.InTransaction then
    begin
      dmCommon.cnOperatorConnection.CommitTrans;
    end;
  except
    RollBack;
  end;
end;

procedure ReOpenAndGoToExt(CxGridDBTableView: TcxGridDBTableView; p_sID: String; p_bFirst: Boolean = False);
// Znovuotevøení datasetu a pohyb v rámci dbgridu o položku níže
var
  lsNew: String;
begin
  CxGridDBTableView.BeginUpdate;

  if p_bFirst then
  begin
    ReOpenAndGoTo(CxGridDBTableView.DataController.DataSet as TADODataSet, p_sID);
    CxGridDBTableView.DataController.GotoFirst;
  end else
  begin
    if not CxGridDBTableView.DataController.IsEOF then
    begin
      CxGridDBTableView.DataController.GotoNext;
    end else
    if not CxGridDBTableView.DataController.IsBOF then
    begin
      CxGridDBTableView.DataController.GotoPrev;
    end;

    if not CxGridDBTableView.DataController.DataSet.IsEmpty then
    begin
      lsNew := (CxGridDBTableView.DataController.DataSet as TADODataSet).FieldByName(p_sID).Value;
    end else
    begin
      lsNew := '';
    end;

    ReOpenAndGoTo(CxGridDBTableView.DataController.DataSet as TADODataSet, p_sID, False, lsNew);
  end;

  CxGridDBTableView.EndUpdate;
end;

procedure ReOpenAndGoTo(p_DataSet: TADODataSet; p_sID: String; p_bDelete: Boolean = False; p_sNew: String = '0'; p_bCursor: Boolean = True;
  p_bDisableControls: Boolean = True; p_bCorrectSQL: Boolean = True);
var
  lsID: String;
  lnCursor: TCursor;
begin
  lnCursor := Screen.Cursor;

  if p_bCursor then
  begin
    Screen.Cursor := crHourGlass;
  end;

  if p_bDisableControls then
  begin
    p_DataSet.DisableControls;
    Application.ProcessMessages;
  end;

  if p_DataSet.Active then
  begin
    if p_bDelete then
    begin
      p_DataSet.Next;
    end;

    if p_sNew = '0' then
    begin
      lsID := p_DataSet.FieldByName(p_sID).AsString;
    end else
    begin
      lsID := p_sNew;
    end;
  end;

  p_DataSet.Close;

  if not MyOpenQuery(p_DataSet, True, p_bCorrectSQL, p_bCursor) then
  begin
    Abort;
  end;

  if Trim(lsID) = '' then
  begin
    p_DataSet.First;
  end else
  begin
    p_DataSet.Last;
    p_DataSet.Locate(p_sID, lsID, [loCaseInsensitive]);
  end;

  if p_bDisableControls then
  begin
    p_DataSet.EnableControls;
  end;

  if p_bCursor then
  begin
    Screen.Cursor := crDefault;
  end else
  begin
    Screen.Cursor := lnCursor;
  end;
end;

function CorrectSQL(p_sSQL: String): String;
// Nastavení schema podle systému
begin
  Result := p_sSQL;

  if (gsSchema <> 'ws') and (gsSchema <> 'wsr') then
  begin
    Result := StringReplace(p_sSQL, 'ws.', gsSchema + '.', [rfReplaceAll]);
  end;
end;

function MyStrToFloat(p_sRealNumber: String): Double;
// Pøevod textu na reálné èíslo
var
  lFormatSettings: TFormatSettings;
begin
  Result := 0;

  // Naèíst národní prostøedí z Windows
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);

  // Odstranit mezery
  p_sRealNumber := StringReplace(p_sRealNumber, ' ', '', [rfReplaceAll, rfIgnoreCase]);

  // Nejdøív zkusit, jestli je v textu desetinná èárka
  lFormatSettings.DecimalSeparator := ',';

  if TryStrToFloat(p_sRealNumber, Result, lFormatSettings) then
  begin
    Exit;
  end;

  // Pøevod s desetinnou èárkou se nepovedl => zkusit desetinnou teèku
  lFormatSettings.DecimalSeparator := '.';

  if not TryStrToFloat(p_sRealNumber, Result, lFormatSettings) then
  begin
    Result := 0;
  end;
end;

function MyFloatToStrF(p_rNumber: Real; p_nDigits: Integer; p_nPrecision: Integer = 10; p_cDecimalSeparator: Char = #0;
  p_sThousandSeparator: Char = ' '): String;
// Pøevede reálné èíslo na text
//   p_nDigits = poèet desetinných míst za desetinnou teèkou
//   p_nPrecision = celkový poèet èíslic pøed a za desetinnou teèkou
//   p_sThousandSeparator = oddìlovaè tisícù (#0 = žádný oddìlovaè tisícù)
var
  lFormatSettings: TFormatSettings;
begin
  if p_nDigits < 0 then
  begin
    p_nDigits := 0;
  end;

  if p_nPrecision < p_nDigits then
  begin
    p_nPrecision := p_nDigits;
  end;

  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);
  lFormatSettings.ThousandSeparator := p_sThousandSeparator;

  if p_cDecimalSeparator <> #0 then
  begin
    lFormatSettings.DecimalSeparator := p_cDecimalSeparator;
  end;

  Result := FloatToStrF(p_rNumber, ffNumber, p_nPrecision, p_nDigits, lFormatSettings);
end;

function MyFloatToStrSQL(p_rNumber: Real): String;
// Pøevede reálné èíslo na text použitelný pro SQL skripty
var
  lsDecimalSeparator: Char;
  lsThousandSeparator: Char;
begin
  lsDecimalSeparator := DecimalSeparator;
  lsThousandSeparator := ThousandSeparator;
  DecimalSeparator := '.';
  ThousandSeparator := #0; // žádný oddìlovaè tisícù
  Result := FloatToStrF(p_rNumber, ffNumber, 10, 5);
  DecimalSeparator := lsDecimalSeparator;
  ThousandSeparator := lsThousandSeparator;
end;

function MyStrToInt(p_sString: String): Integer;
var
  lnResult: Integer;
begin
  TryStrToInt(p_sString, lnResult);
  Result := lnResult;
end;

function GetComputerName: String;
var
  Buffer: array [0..255] of Char;
  Size: Dword;
begin
  Size := 256;

  if Windows.GetComputerName(Buffer, Size) then
  begin
    Result := Buffer;
  end else
  begin
    Result := ''
  end;
end;

function RightWithZeros(p_sString: String; p_nLength: Integer): String;
// Doplnìní stringu nulami zleva, napø. '12' -> '000012'
begin
  Result := RightStr(StringOfChar('0', p_nLength) + p_sString, p_nLength);
end;

function LeftWithSpaces(p_sString: String; p_nLength: Integer): String;
// Doplnìní stringu mezerami zprava, napø. '12' -> '12   '
begin
  Result := LeftStr(p_sString + StringOfChar(' ', p_nLength), p_nLength);
end;

function ReplaceDiacriticalMarks(p_sInputString: String): String;
// ÁáÄäÈèÏïÉéÌìÍíÅå¼¾ÒòÓóÔôÖöØøÀàŠšÚúÙùÜüÝýŽž --> AaAaCcDdEeEeIiLlLlNnOoOoOoRrRrSsTtUuUuUuYyZz
var
  i: Integer;
  lsInputString: String;
begin
  lsInputString := p_sInputString;

  if Length(lsInputString) > 0 then
  begin
    for i := 1 to Length(lsInputString) do
    begin
      case lsInputString[i] of
        'Á', 'Ä', '¥': lsInputString[i] := 'A';
        'È', 'Æ': lsInputString[i] := 'C';
        'Ï': lsInputString[i] := 'D';
        'É', 'Ì', 'Ë', 'Ê': lsInputString[i] := 'E';
        'Í': lsInputString[i] := 'I';
        'Å', '¼', '£': lsInputString[i] := 'L';
        'Ò', 'Ñ': lsInputString[i] := 'N';
        'Ó', 'Ö', 'Ô': lsInputString[i] := 'O';
        'Ø', 'À': lsInputString[i] := 'R';
        'Š', 'Œ': lsInputString[i] := 'S';
        '': lsInputString[i] := 'T';
        'Ú', 'Ù', 'Ü': lsInputString[i] := 'U';
        'Ý': lsInputString[i] := 'Y';
        'Ž', '', '¯': lsInputString[i] := 'Z';
        'á', 'ä', '¹': lsInputString[i] := 'a';
        'è', 'æ': lsInputString[i] := 'c';
        'ï': lsInputString[i] := 'd';
        'ì', 'é', 'ë', 'ê': lsInputString[i] := 'e';
        'í': lsInputString[i] := 'i';
        'å', '¾', '³': lsInputString[i] := 'l';
        'ò', 'ñ': lsInputString[i] := 'n';
        'ó', 'ö', 'ô': lsInputString[i] := 'o';
        'ø', 'à': lsInputString[i] := 'r';
        'š', 'œ': lsInputString[i] := 's';
        '': lsInputString[i] := 't';
        'ú', 'ù', 'ü': lsInputString[i] := 'u';
        'ý': lsInputString[i] := 'y';
        'ž', 'Ÿ', '¿': lsInputString[i] := 'z';
      end;
    end;
  end;

  Result := lsInputString;
end;

function TdmCommon.CheckConfiguration: Boolean;
// Ète id provozu a pracovištì
var
  lsRefresh: String;
begin
  // Probíhá kontrola konfigurace...
  frmSplash.SetActionLabel(resConfigurationChecking);

  // Globální promìnné (parametry databáze)
  gsCompanyName := GetValueFromDatabaseConfiguration('s_company');

  {$IFDEF WINPACKAGE}
  // Ve WinPackage další kontroly nejsou
  Result := True;
  Exit;
  {$ENDIF}

  {$IFDEF WINMIXWEIGHING}
  // Ve WinMixWeighing další kontroly nejsou
  Result := True;
  Exit;
  {$ENDIF}

  Result := False;
  lsRefresh := GetValueFromDatabaseConfiguration('n_rmd_refresh');

  if CheckInteger(lsRefresh) then
  begin
    gnRefreshInterval := MyStrToInt(lsRefresh);
  end else
  begin
    gnRefreshInterval := 0;
  end;

  // Hodnota musí být 0 nebo minimálnì 10 s, aby se update neprovádìl moc èasto
  if (gnRefreshInterval > 0) and (gnRefreshInterval < 10) then
  begin
    gnRefreshInterval := 10;
  end;

  gnModuleId := -1;
  gsModuleName := GetModuleName;

  if (gnModuleId = 0) or (gnModuleId < -1) then
  begin
    // Id modulu nebylo nalezeno
    // Tento modul není platným modulem systému (nebyl nalezen v tabulce modulù)!
    MyMessageBox(resErrorSearchingModule, mtError, Screen.Activeform);
    Exit;
  end;

  if (gsImplementationCode = csImplementationWinInsert) or (gsImplementationCode = csImplementationWiStBUCZ) or
    (gsImplementationCode = csImplementationWiStAcerostar) then
  begin
    gsConfigurationModuleCode := 'configuration';
  end else
  begin
    gsConfigurationModuleCode := 'cfg_work_complexes';
  end;

  gsComputerName := GetComputerName;  // název PC

  if gsUserRightCode = 'report_templates' then
  begin
    // Šablony reportù jsou pro všechny provozy
    Result := True;
    Exit;
  end;

  // Naèíst id poèítaèe z tabulky poèítaèù
  // MÈ 3.6.2010 v BUCZ nejsou provozy, nalezené id poèítaèe se použije
  // v ostatních implementacích jde o test, jestli vùbec daný PC existuje v tabulce poèítaèù
  // pokud existuje, tak se znovu naète pøi naètení id provozu
  if gnComplexId = 0 then
  begin
    gnComputerId := GetComputerId;
  end;

  if gnComputerId = 0 then
  begin
    if gsModuleCode = gsConfigurationModuleCode then
    begin
      // Konfigurace provozù - poèítaè nemusí existovat
      Result := True;
    end else
    begin
      // Název poèítaèe není zaveden v konfiguraci provozù!
      MyMessageBox(resComputerNotFound, mtError, Screen.Activeform);
    end;

    Exit;
  end;

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  // Id provozu
  if gnComplexId = 0 then
  begin
    gnComplexId := TfrmComplexes.GetComplexId;
  end;
  {$ENDIF}
  {$ENDIF}

  if gnComplexId = 0 then
  // Uživatel odmítl vybrat provoz z více => konec bez message
  begin
    Exit;
  end;

  if gnComplexId < 0 then
  begin
    if gsModuleCode = gsConfigurationModuleCode then
    begin
      // Sice provoz neexistuje, ale konfigurace provozù má spuštìní dovolené pod adminem
      Result := True;
    end else
    begin
      // Chyba konfigurace - nebyl nalezen provoz!
      MyMessageBox(resWrongConfiguration, mtError, Screen.Activeform);
    end;

    Exit;
  end;

  if gsImplementationCode <> csImplementationWinInsert then
  begin
    if not CheckComputerRights then
    begin
      gbModulePermissionError := True;

      if gsModuleCode = gsConfigurationModuleCode then
      begin
        // Sice modul není pøiøazen PC, ale konfigurace provozù má spuštìní dovolené pod adminem
        Result := True;
      end else
      begin
        // Modul nemá oprávnìní být spuštìn na tomto poèítaèi!
        MyMessageBox(resModulePermissionError, mtError, Screen.Activeform);
      end;

      Exit;
    end;
  end;

  if not CheckRunningModules then
  begin
    gbTooManyModules := True;
  end;

  Result := True;
end;

function TdmCommon.GetValueFromDatabaseConfiguration(p_sParameterCode: String; p_bTerminate: Boolean = True): String;
// Vrátí hodnotu z tabulky t_dcf_database_configuration
var
  fnSget_dcf_value: TADOStoredProc;
begin
  fnSget_dcf_value := TADOStoredProc.Create(Self);

  try
    fnSget_dcf_value.Name := 'fnSget_dcf_value';

    if cnOperatorConnection.Connected then
    begin
      fnSget_dcf_value.Connection := cnOperatorConnection;
    end else
    begin
      fnSget_dcf_value.Connection := cnSystemConnection;
    end;

    fnSget_dcf_value.ProcedureName := CorrectSQL('ws.fn_s_get_dcf_value');
    fnSget_dcf_value.Parameters.CreateParameter('@RETURN_VALUE', ftString, pdReturnValue, 250, Result);
    fnSget_dcf_value.Parameters.CreateParameter('@p_s_par_code', ftString, pdInput, 50, p_sParameterCode);

    MyExecProc(fnSget_dcf_value, p_bTerminate, True, False);
    Result := fnSget_dcf_value.Parameters.FindParam('@RETURN_VALUE').Value;
    fnSget_dcf_value.Close;
  finally
    fnSget_dcf_value.Free;
  end;
end;

function TdmCommon.SendMail(p_n_recipient_type, p_n_recipient_id, p_n_sender_type, p_n_sender_id, p_n_mail_type: Integer; p_s_subject,
  p_s_body: String): Boolean;
// Odeslání zprávy
begin
  if not ParametersRefresh(fnImail_send) then
  begin
    Result := False;
    Exit;
  end;

  // Id provozu
  fnImail_send.Parameters.ParamByName('@p_n_wcx_id').Value := gnComplexId;
  // Typ pøíjemce (0 modul, 1 operátor, 2 zaøízení)
  fnImail_send.Parameters.ParamByName('@p_n_recipient_type').Value := p_n_recipient_type;
  // Id pøíjemce
  fnImail_send.Parameters.ParamByName('@p_n_recipient_id').Value := p_n_recipient_id;
  // Typ odesílatele (0 modul, 1 operátor, 2 zaøízení)
  fnImail_send.Parameters.ParamByName('@p_n_sender_type').Value := p_n_sender_type;
  // Id odesílatele
  fnImail_send.Parameters.ParamByName('@p_n_sender_id').Value := p_n_sender_id;
  // Typ zprávy (0 zpráva, 1 pøíkaz, 101 etiketa, 902 zmìna konfigurace pracovištì)
  fnImail_send.Parameters.ParamByName('@p_n_mail_type').Value := p_n_mail_type;
  // Pøedmìt
  fnImail_send.Parameters.ParamByName('@p_s_subject').Value := p_s_subject;
  // Tìlo
  fnImail_send.Parameters.ParamByName('@p_s_body').Value := p_s_body;

  Result := MyExecProc(fnImail_send);
  fnImail_send.Close;
end;

function TdmCommon.GetValueFromComplexConfiguration(p_sParameterCode: String): String;
// Vrátí hodnotu z tabulky provozní konfigurace t_cfg_configuration nebo t_par_parameters
var
  fnSget_cfg_value: TADOStoredProc;
begin
  fnSget_cfg_value := TADOStoredProc.Create(Self);

  try
    fnSget_cfg_value.Name := 'fn_s_get_cfg_value';
    fnSget_cfg_value.Connection := cnOperatorConnection;

    fnSget_cfg_value.ProcedureName := CorrectSQL('ws.fn_s_get_cfg_value');
    fnSget_cfg_value.Parameters.CreateParameter('@RETURN_VALUE', ftString, pdReturnValue, 250, Result);

    if gsImplementationCode <> csImplementationWiStAcerostar then
    // V databázi WinStock se konfigurace neváže na provozy
    begin
      fnSget_cfg_value.Parameters.CreateParameter('@p_n_wcx_id', ftInteger, pdInput, SizeOf(Integer), gnComplexId);
    end;

    fnSget_cfg_value.Parameters.CreateParameter('@p_s_par_code', ftString, pdInput, 50, p_sParameterCode);

    MyExecProc(fnSget_cfg_value, True, True, False);
    Result := fnSget_cfg_value.Parameters.FindParam('@RETURN_VALUE').Value;
    fnSget_cfg_value.Close;
  finally
    fnSget_cfg_value.Free;
  end;
end;

function TdmCommon.AllowedMultipleRun(var pHWND: HWND): Boolean;
// kontrola oprávnìní vícenásobného spouštìní
type
  PTopLevelWnd = ^TTopLevelWnd;
  TTopLevelWnd = record
    AktWnd: HWND;
    Wnd: HWND;
  end;

  function EnumWinProc(Wnd: HWND; Param: PTopLevelWnd): BOOL; stdcall;
  var
    lArr: array [0..Length('TApplication') + 1] of Char;
  begin
    Result := True;

    if (IsWindowVisible(Wnd)) and (Wnd <> Param^.AktWnd) and (GetClassName(Wnd, lArr, SizeOf(lArr) div SizeOf(Char)) > 0) and
      (lArr = 'TApplication') then
    begin
      if SendMessage(Wnd, WM_USER + 1023, 0, 0) = gnModuleUniqueId then
      begin
        Param^.Wnd := Wnd;
        Result := False;
      end;
    end;
  end;

var
  TopLevelWnd: TTopLevelWnd;
begin
  qrSmdlM.Close;
  qrSmdlM.Parameters.ParamByName('mdl_s_exe_name').Value := ExtractFileName(Application.ExeName);
  MyOpenQuery(qrSmdlM, True, True, False);
  Result := qrSmdlM.FieldByName('mdl_b_multiple_run').AsBoolean;
  qrSmdlM.Close;
  gnModuleUniqueId := GetModuleUniqueId;

  if not Result then
  begin
    TopLevelWnd.AktWnd := Application.Handle;
    TopLevelWnd.Wnd := 0;
    EnumWindows(@EnumWinProc, LParam(@TopLevelWnd));

    if TopLevelWnd.Wnd > 0 then
    begin
      pHWND := TopLevelWnd.Wnd;
      Result := False;
    end else
    begin
      Result := True;
    end;
  end;
end;

function TdmCommon.GetModuleUniqueId(p_sModuleCode: String = ''): Integer;
var
  i: Integer;
  lsModuleId: String;
begin
  if p_sModuleCode = '' then
  begin
    p_sModuleCode := gsModuleCode;
  end;

  Result := 0;
  lsModuleId := gsImplementationCode + '|' + p_sModuleCode;

  for i := 0 to Length(lsModuleId) - 1 do
  begin
    Result := 31 * Result + Ord(lsModuleId[i + 1]);
  end;
end;

function TdmCommon.ApplicationMessage(var Msg: TMessage): Boolean;
begin
  Result := False;

  if Msg.Msg = WM_USER + 1023 then
  begin
    Msg.Result := GetModuleUniqueID;
    Result := True;
  end;
end;

function TdmCommon.GetModuleName: String;
// vrátí název modulu podle exeName
begin
  if gsUserRightCode = 'report_templates' then
  // Šablony reportù
  begin
    {$IFDEF MULTILANGUAGE}
    Result := gsModuleName;

    if Trim(Result) = '' then
    begin
      Result := gsEnglishModuleName;
    end;
    {$ELSE}
    Result := 'Šablony reportù';
    {$ENDIF}

    gsModuleCode := 'report_templates';
    gnModuleId := -1;
    gbRunIndependent := True;
    Exit;
  end;

  {$IFNDEF MULTILANGUAGE}
  qrSmdl.CommandText :=
    'SELECT ' +
    '  mdl_n_id, ' +
    '  mdl_s_name, ' +
    '  mdl_s_code, ' +
    '  mdl_b_independent ' +
    'FROM ws.t_mdl_modules ' +
    'WHERE UPPER(mdl_s_exe_name) = UPPER(:mdl_s_exe_name)';
  {$ENDIF}

  qrSmdl.Close;
  qrSmdl.Parameters.ParamByName('mdl_s_exe_name').Value := ExtractFileName(Application.ExeName);

  {$IFDEF MULTILANGUAGE}
  qrSmdl.Parameters.ParamByName('lng_s_code').Value := dmCommon.Languages.UserLanguageCode;
  {$ENDIF}

  if not MyOpenQuery(qrSmdl, True, True, False) then
  begin
    Exit;
  end;

  gnModuleId := qrSmdl.FieldByName('mdl_n_id').AsInteger;

  {$IFDEF MULTILANGUAGE}
  Result := qrSmdl.FieldByName('btt_mdl_s_name').AsString;
  {$ELSE}
  Result := qrSmdl.FieldByName('mdl_s_name').AsString;
  {$ENDIF}

  gsModuleCode := AnsiLowerCase(qrSmdl.FieldByName('mdl_s_code').AsString);
  gbRunIndependent := qrSmdl.FieldByName('mdl_b_independent').AsBoolean;
  qrSmdl.Close;
end;

function TdmCommon.GetActualDate: TDateTime;
// vrátí aktuální datum z MS SQL
var
  qrSgetdate: TADODataSet;
begin
  Result := Now;
  qrSgetdate := TADODataSet.Create(Self);

  try
    qrSgetdate.Name := 'qrSgetdate';
    qrSgetdate.Connection := cnOperatorConnection;
    qrSgetdate.Close;
    qrSgetdate.CommandText := 'SELECT GETDATE() AS dt_getdate ';

    if not MyOpenQuery(qrSgetdate, True, True, False) then
    begin
      Exit;
    end;

    Result := qrSgetdate.FieldByName('dt_getdate').AsDateTime;
    qrSgetdate.Close;
  finally
    qrSgetdate.Free;
  end;
end;

function TdmCommon.CheckComputerRights: Boolean;
// kontrola oprávnìní spouštìt tento modul na tomto PC
var
  qrSmca: TADODataSet;
begin
  Result := False;
  qrSmca := TADODataSet.Create(Self);

  try
    qrSmca.Name := 'qrSmca';
    qrSmca.Connection := dmCommon.cnSystemConnection;
    qrSmca.Close;
    qrSmca.CommandText :=
      'SELECT COUNT(*) AS n_count ' +
      'FROM ws.t_mca_module_computer_allocation AS mca ' +
      'INNER JOIN ws.t_mdl_modules AS mdl ' +
      'ON mdl.mdl_n_id = mca.mdl_n_id ' +
      'WHERE mca.cmp_n_id = ' + IntToStr(gnComputerId) + ' ' +
      'AND UPPER(mdl.mdl_s_exe_name) = UPPER(' +
      MyQuotedStr(ExtractFileName(Application.ExeName)) + ')';

    if not MyOpenQuery(qrSmca, True, True, False) then
    begin
      Exit;
    end;

    Result := qrSmca.FieldByName('n_count').AsInteger > 0;
    qrSmca.Close;
  finally
    qrSmca.Free;
  end;
end;

function TdmCommon.ChangeUnit(p_rValue: Real; p_sOldUnit, p_sNewUnit: String; p_bUseDatabaseFunction: Boolean = True): Real;
// Pøevede hodnotu na jinou jednotku
{
Parametry:
p_rValue                    = množství, které se má pøevádìt
p_sOldUnit                  = pùvodní jednotka
p_sNewUnit                  = nová jednotka
p_bUseDatabaseFunction      = použít databázovou funkci fn_r_change_unit?
}
var
  qrSchange_unit: TADODataSet;
  lsOldUnit: String;
  lsNewUnit: String;
  lrOldFactor: Real;
  lrNewFactor: Real;
begin
  Result := 0;

  if p_bUseDatabaseFunction then
  begin
    // Použít databázovou funkci fn_r_change_unit
    qrSchange_unit := TADODataSet.Create(Self);

    try
      qrSchange_unit.Name := 'qrSchange_unit';
      qrSchange_unit.Connection := cnOperatorConnection;
      qrSchange_unit.Close;
      qrSchange_unit.CommandText :=
        'SELECT r_result = ' +
        'ws.fn_r_change_unit(' + MyFloatToStrSQL(p_rValue) + ', ' + MyQuotedStr(p_sOldUnit) + ', ' + MyQuotedStr(p_sNewUnit) + ') ';

      if not MyOpenQuery(qrSchange_unit, True, True, False) then
      begin
        Exit;
      end;

      Result := qrSchange_unit.FieldByName('r_result').AsFloat;
      qrSchange_unit.Close;
    finally
      qrSchange_unit.Free;
    end;
  end else
  begin
    // Bez databázové funkce

    // Odstranit mezery v jednotkách
    lsOldUnit := Trim(p_sOldUnit);
    lsNewUnit := Trim(p_sNewUnit);

    // Jsou zadané obì jednotky?
    if (lsOldUnit = '') or (lsNewUnit = '') then
    begin
      Result := 0;
      Exit;
    end;

    // Jsou jednotky stejné?
    if lsOldUnit = lsNewUnit then
    begin
      // Nic nepøevádìt a vrátit pùvodní hmotnost
      Result := p_rValue;
      Exit;
    end;

    // Koeficient pùvodní jednotky
    lrOldFactor := UnitToFactor(lsOldUnit);

    if lrOldFactor <= 0 then
    begin
      // Nesprávná pùvodní jednotka
      Result := 0;
      Exit;
    end;

    // Koeficient nové jednotky
    lrNewFactor := UnitToFactor(lsNewUnit);

    if lrNewFactor <= 0 then
    begin
      // Nesprávná nová jednotka
      Result := 0;
      Exit;
    end;

    Result := p_rValue * lrOldFactor / lrNewFactor;
  end;
end;

function UnitToFactor(p_sUnit: String): Real;
// Pøevod jednotky na koeficient pro pøevod hodnoty jinou jednotku
// Zatím jen hmotnostní jednotky
begin
  Result := 0;

  if p_sUnit = 'mg' then
  begin
    Result := 0.000001;
  end;

  if p_sUnit = 'g' then
  begin
    Result := 0.001;
  end;

  if p_sUnit = 'kg' then
  begin
    Result := 1;
  end;

  if p_sUnit = 't' then
  begin
    Result := 1000;
  end;
end;

function GetDateFrom(p_dtDate: TDateTime; p_sShortDateFormat: String = ''): String;
var
  lsDateFrom: String;
begin
  lsDateFrom := MyQuotedStr(MyDateToStr(p_dtDate, p_sShortDateFormat) + ' 00:00:00.000') + ' ';
  Result := lsDateFrom;
end;

function GetDateTo(p_dtDate: TDateTime; p_sShortDateFormat: String = ''): String;
var
  lsDateTo: String;
begin
  lsDateTo := MyQuotedStr(MyDateToStr(p_dtDate, p_sShortDateFormat) + ' 23:59:59.999') + ' ';
  Result := lsDateTo;
end;

procedure TdmCommon.DataModuleDestroy(Sender: TObject);
var
  lnRunningModuleId: Integer;
begin
  lnRunningModuleId := gnRunningModuleId;

  {$IFDEF MULTILANGUAGE}
  FLanguages.Free;
  slResourceString.Free;
  slLogResourceString.Free;
  {$ENDIF}

  try
    StopRunningModuleThread;

    if gCriticalSection <> nil then
    begin
      gCriticalSection.Free;
    end;
  except
  end;

  try
    if lnRunningModuleId > 0 then
    begin
      DeleteRunningModule(lnRunningModuleId);
    end
  except
  end;
end;

function TdmCommon.CheckRunningModules: Boolean;
// Kontrola poètu spuštìných modulù
begin
  if (gsImplementationCode = csImplementationWinInsert) or (gsImplementationCode = csImplementationWiStBUCZ) or
    (gsImplementationCode = csImplementationWiStAcerostar) then
  begin
    // WinInsert nebo WinStock => kontrola spuštìných modulù se nekoná
    Result := True;
    Exit;
  end;

  Result := False;

  spScheck_rmd.Close;
  spScheck_rmd.Parameters.ParamByName('mdl_s_code').Value := gsModuleCode;
  spScheck_rmd.Parameters.ParamByName('wcx_n_id').Value := gnComplexId;
  MyOpenQuery(spScheck_rmd, True, True, False);

  if spScheck_rmd.FieldByName('n_result').AsBoolean then
  begin
    Result := True;
  end;

  spScheck_rmd.Close;
end;

function TdmCommon.StartRunningModuleThread: Boolean;
// spustí thread pro ukládání informací do databáze, že je modul spuštìn
begin
  Result := True;

  if gsUserRightCode = 'report_templates' then
  begin
    // Šablony reportù => kontrola spuštìných modulù se nekoná
    Exit;
  end;

  // WinInsert nebo WinStock nebo Masna Pøíbram nebo WinPackage nebo WinMixWeighing => kontrola spuštìných modulù se nekoná
  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  {$IFNDEF WINSTOCK}
  {$IFNDEF WININSERT}
  try
    // vytvoøení threadu
    gthdRunningModule := ThdRunningModule.Create(False);
    gthdRunningModule.FreeOnTerminate := True;
  except
    Result := False;
  end;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

procedure TdmCommon.StopRunningModuleThread;
// Ukonèí thread pro aktualizaci t_rmd
begin
  if gthdRunningModule <> nil then
  begin
    gthdRunningModule.Terminate;
  end;
end;

function TdmCommon.UpdateRunningModule(p_sModuleCode: String; var p_nRunningModuleId: Integer): Boolean;
// Aktualizuje nebo vloží øadek do tabulky spuštìných modulù
var
  spUrmd: TADOStoredProc;
  lnResultSP: Integer;
  lbTerminate: Boolean;
begin
  Result := False;
  lnResultSP := -100;

  if gbTryingConnectionAlive or dmCommon.tmrApplicationTerminate.Enabled then
  begin
    Exit;
  end;

  if (p_sModuleCode = 'text_panel') or (p_sModuleCode = 'opc_synchro') then
  begin
    // OPC Synchro a Textový panel se nemají ukonèit pøi výpadku SQL Serveru
    lbTerminate := False;
  end else
  begin
    lbTerminate := True;
  end;

  spUrmd := TADOStoredProc.Create(Self);

  try
    spUrmd.Name := 'spUrmd';
    spUrmd.Connection := cnSystemConnection;
    spUrmd.ProcedureName := CorrectSQL('ws.sp_u_running_module');
    spUrmd.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), lnResultSP);

    if p_nRunningModuleId > 0 then
    begin
      spUrmd.Parameters.CreateParameter('@p_n_rmd_id', ftInteger, pdInput, SizeOf(Integer), p_nRunningModuleId);
    end else
    begin
      spUrmd.Parameters.CreateParameter('@p_n_rmd_id', ftInteger, pdInput, SizeOf(Integer), Null);
    end;

    spUrmd.Parameters.CreateParameter('@p_s_mdl_code', ftString, pdInput, 20, p_sModuleCode);
    spUrmd.Parameters.CreateParameter('@p_n_cmp_id', ftInteger, pdInput, SizeOf(Integer), gnComputerId);

    if gnWorksiteId > 0 then
    begin
      spUrmd.Parameters.CreateParameter('@p_n_wst_id', ftInteger, pdInput, SizeOf(Integer), gnWorksiteId);
    end else
    begin
      spUrmd.Parameters.CreateParameter('@p_n_wst_id', ftInteger, pdInput, SizeOf(Integer), Null);
    end;

    spUrmd.Parameters.CreateParameter('@p_n_usr_id', ftInteger, pdInput, SizeOf(Integer), gnUserId);
    spUrmd.Parameters.CreateParameter('@p_n_rmd_state', ftInteger, pdInput, SizeOf(Integer), Null);

    if not MyExecProc(spUrmd, lbTerminate, True, False, lbTerminate) then
    begin
      Exit;
    end;

    lnResultSP := spUrmd.Parameters.ParamValues['@RETURN_VALUE'];

    if lnResultSP > 0 then
    begin
      p_nRunningModuleId := lnResultSP;
      Result := True;
    end;
  finally
    spUrmd.Free;
  end;
end;

procedure TdmCommon.DeleteRunningModule(p_nRmdId: Integer);
// Smaže "svùj" záznam z tabulky spuštìných modulù
// Volá se pøi ukonèení modulu
var
  spDrmd: TADOStoredProc;
begin
  spDrmd := TADOStoredProc.Create(Self);

  try
    spDrmd.Name := 'spDrmd';
    spDrmd.Connection := cnSystemConnection;
    spDrmd.ProcedureName := CorrectSQL('ws.sp_d_running_module');
    spDrmd.Parameters.CreateParameter('@p_n_rmd_id', ftInteger, pdInput, SizeOf(Integer), p_nRmdId);
    MyExecProc(spDrmd);
    spDrmd.Close;
  finally
    spDrmd.Free;
  end;
end;

function TdmCommon.DeleteOldRunningModules: Boolean;
// Vymaže všechny øádky z tabulky spuštìných modulù t_rmd starší než èas v konfiguraci
var
  lnResult: Integer;
begin
  if (gsImplementationCode = csImplementationWinInsert) or (gsImplementationCode = csImplementationWiStBUCZ) or
    (gsImplementationCode = csImplementationWiStAcerostar) or (gsUserRightCode = 'report_templates') then
  begin
    // WinInsert nebo WinStock nebo Šablony reportù => kontrola spuštìných modulù se nekoná
    Result := True;
    Exit;
  end;

  lnResult := -1;

  if not ParametersRefresh(spDold_rmd, True, True, False) then
  begin
    Result := False;
    Exit;
  end;

  if MyExecProc(spDold_rmd, True, True, False) then
  begin
    lnResult := spDold_rmd.Parameters.ParamValues['@RETURN_VALUE'];
    spDold_rmd.Close;
  end;

  Result := lnResult = 0;
end;

function TdmCommon.CheckModules: Boolean;
// Kontrola poètu spuštìných modulù
var
  lHWND: HWND;
begin
  Result := False;

  // Kontrola poètu spuštìných modulù
  if gbTooManyModules and (AnsiUpperCase(gsUserLogin) <> AnsiUpperCase(csAdmin)) then
  begin
    // Byl pøekroèen maximální poèet povolených spuštìní modulu v systému!
    MyMessageBox(resMaxRunningModulesError, mtError, Screen.Activeform);
    Exit;
  end;

  // Je možné modul spustit víckrát?
  if not AllowedMultipleRun(lHWND) then
  begin
    // Tento modul nelze spustit vícekrát!
    MyMessageBox(resMultipleRunningModuleError, mtError, Screen.Activeform);

    if lHwnd > 0 then
    begin
      SetForegroundWindow(lHWND);
    end;

    Exit;
  end;

  Result := True;
end;

function TdmCommon.GetWorksiteState(p_nWstId, p_nPosition: Integer): Integer;
// Pøi uložení pracovištì a zaøízení kontrolujte, jestli je pracovištì ve stavu, kdy je možné mìnit konfiguraci
begin
  try
    if not ParametersRefresh(fnBmodule_state) then
    begin
      Result := 0;
      Exit;
    end;

    fnBmodule_state.Parameters.ParamByName('@p_n_wst_id').Value := p_nWstId;
    fnBmodule_state.Parameters.ParamByName('@p_n_position').Value := p_nPosition;
    fnBmodule_state.Parameters.ParamByName('@p_dt_getdate').Value := GetActualDate;

    MyExecProc(fnBmodule_state, True, True, False);

    if fnBmodule_state.Parameters.ParamValues['@RETURN_VALUE'] then
    begin
      Result := 1;
    end else
    begin
      Result := 0;
    end;

    fnBmodule_state.Close;
  except
    on E: Exception do
    begin
      Result := -1;
      // Chyba pøi kontrole stavu pracovištì!: E.Message
      WriteToLog(PResStringRec(@resWorksiteCheckingErrorLog), 'resWorksiteCheckingErrorLog', [E.Message]);
      // Chyba pøi kontrole stavu pracovištì! + #13 + #13 + E.Message
      MyMessageBox(Format(resWorksiteCheckingError, [E.Message]), mtError, Screen.Activeform);
    end;
  end;
end;

function TdmCommon.GetLastId(p_sTable, p_sColumn: String): Integer;
// Zjistí poslední ID
var
  qrSmax_id: TADODataSet;
begin
  Result := 0;
  qrSmax_id := TADODataSet.Create(Self);

  try
    qrSmax_id.Name := 'qrSmax_id';
    qrSmax_id.Connection := cnOperatorConnection;
    qrSmax_id.Close;
    qrSmax_id.CommandText :=
      'SELECT MAX(' + p_sColumn + ') AS n_max_id ' +
      'FROM ' + p_sTable;

    if not MyOpenQuery(qrSmax_id, True, True, False) then
    begin
      Exit;
    end;

    qrSmax_id.First;
    Result := qrSmax_id.FieldByName('n_max_id').AsInteger;
    qrSmax_id.Close;
  finally
    qrSmax_id.Free;
  end;
end;

function TdmCommon.InitModule(p_frmMain: TForm; p_stbMain: TStatusBar): Boolean;
// Procedury, které se volají ve frmMain.onCreate
var
  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  lbCheckParameters: Boolean;
  {$ENDIF}
  {$ENDIF}
  lsDatabaseVersion: String;
  {$IFDEF MULTILANGUAGE}
  fnSget_cmp_lang: TADOStoredProc;
  {$ENDIF}
  {$IFDEF WINMIXWEIGHING}
  FileInfoArray: TFileInfo;
  {$ENDIF}

  lsLogin: String;
  lsPassword: String;
  FileInfoArray: TFileInfo;
  ldtFileDateTime: TDateTime;
begin
  Result := False;
  Screen.Cursor := crHourGlass;

  {$IFDEF MULTILANGUAGE}
  frmSplash.SetApplicationLabel(gsEnglishModuleName);
  {$ENDIF}

  // Login a heslo pro pøipojení k MS SQL
  {$IFDEF READONLY}
  gsSQLLogin := 'wsr';
  gsSQLPassword := 'reltteM2007odeloT';
  gsSchema := 'wsr';
  {$ELSE}
  gsSQLLogin := 'ws';
  gsSQLPassword := 'relttem';
  gsSchema := 'ws';
  {$ENDIF}

  {$IFDEF WININSERT}
  gsSQLLogin := 'ids';
  gsSQLPassword := 'relttem';
  gsSchema := 'ids';
  {$ENDIF}

  {$IFDEF WINSTOCK}
  gsSQLLogin := 'mt';
  gsSQLPassword := 'reltteM2007odeloT';
  gsSchema := 'mt';
  {$ENDIF}

  {$IFDEF WINPRODUCTION}
  gsSQLLogin := 'ps';
  gsSQLPassword := 'reltteM2007odeloT';
  gsSchema := 'ps';
  {$ENDIF}

  {$IFDEF WINPACKAGE}
  gsSQLLogin := 'mt';
  gsSQLPassword := 'reltteM2007odeloT';
  gsSchema := 'dbo';
  {$ENDIF}

  {$IFDEF WINMIXWEIGHING}
  gsSQLLogin := 'mt';
  gsSQLPassword := 'reltteM2007odeloT';
  gsSchema := 'dbo';
  {$ENDIF}

  lsLogin := LoadFromIni('MSSQL', 'Login', '');

  if Trim(lsLogin) <> '' then
  begin
    gsSQLLogin := lsLogin;
  end;

  // Zahashované heslo v ini
  lsPassword := LoadFromIni('MSSQL', 'Password', '');

  if Trim(lsPassword) <> '' then
  begin
    if lsPassword = HashString('7+UK6pk?M6(I') then                     // 4dd8db149f171db234f5969445df73d0
    begin
      // PRO.MED.CS pro login sql_svct_wf (test)
      gsSQLPassword := '7+UK6pk?M6(I';
    end else
    if lsPassword = HashString('#x,rQZ5#J#oB') then                    // b7c21a24166fea867864428c39fd573d
    begin
      // PRO.MED.CS pro login sql_svcp_wf (produkce)
      gsSQLPassword := '#x,rQZ5#J#oB';
    end else
    if lsPassword = HashString('relttem') then
    begin
      // WinFormula, WinInsert
      gsSQLPassword := 'relttem';
    end else
    if lsPassword = HashString('reltteM2007odeloT') then
    begin
      // WinStock, WinProduction, WinPackage, WinMixWeighing
      gsSQLPassword := 'reltteM2007odeloT';
    end else
    begin
      // Neznámé heslo
      gsSQLPassword := '';
    end;
  end;

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  // Testování parametrù na pøíkazové øádce
  lbCheckParameters := CheckParameters;
  {$ENDIF}
  {$ENDIF}

  // Název serveru a databáze
  if Trim(gsServer) = '' then
  begin
    gsServer := LoadFromIni('MSSQL', 'Server', '');
  end;

  if Trim(gsDatabase) = '' then
  begin
    gsDatabase := LoadFromIni('MSSQL', 'Database', '');
  end;

  if (Trim(gsServer) = '') or (Trim(gsDatabase) = '') then
  begin
    frmSplash.HideSplash;
    // Chyba pøipojení k databázovému serveru MS SQL!
    // (v konfiguraèním souboru není zadaný název MS SQL serveru nebo databáze)
    WriteToLog(PResStringRec(@resSqlConnErrorLog), 'resSqlConnErrorLog', []);
    // Chyba pøipojení k databázovému serveru MS SQL!
    // V konfiguraèním souboru není zadaný název MS SQL serveru nebo databáze!
    // Kontaktujte prosím zodpovìdnou osobu!
    MyMessageBox(resSqlConnectionError, mtError, Screen.Activeform);

    Exit;
  end;

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  // Spuštìní modulu v jiné databází než WinFormula => pøipojení k MS SQL a konec kontrol
  if gbSimpleMode then
  begin
    Result := ConnectToMSSQL(cnOperatorConnection);
    Exit;
  end;
  {$ENDIF}
  {$ENDIF}

  // Pøipojení k MS SQL
  if not ConnectToMSSQL(cnSystemConnection) then
  begin
    Exit;
  end;

  // Verze implementace
  gsImplementationCode := GetValueFromDatabaseConfiguration('implementation_code', False);

  if (gsImplementationCode <> csImplementationWiFoZentivaPraha) and
    (gsImplementationCode <> csImplementationWiFoPromed) and
    (gsImplementationCode <> csImplementationWiFoHlohovec) and
    (gsImplementationCode <> csImplementationWiFoZentivaBukurest) and
    (gsImplementationCode <> csImplementationWinInsert) and
    (gsImplementationCode <> csImplementationWiStBUCZ) and
    (gsImplementationCode <> csImplementationWiStAcerostar) and
    (gsImplementationCode <> csImplementationWiPrZentiva) and
    (gsImplementationCode <> csImplementationWinPackageCZ) and
    (gsImplementationCode <> csImplementationWinPackageSK) and
    (gsImplementationCode <> csImplementationWinMixWeighing) then
  begin
    // Nesprávná implementace!
    {$IFDEF MULTILANGUAGE}
    // schválnì anglicky, protože ještì nebyly naèteny jazykové texty
    Windows.MessageBox(Screen.Activeform.Handle, PChar('Incorrect implementation!'), 'Error', MB_OK + MB_ICONERROR);
    {$ELSE}
    MyMessageBox(resWrongImpelementation, mtError, Screen.Activeform);
    {$ENDIF}
    Exit;
  end;

  // Operator connection ještì není pøipojený => system
  qrSurh.Connection := cnSystemConnection;

  {$IFDEF MULTILANGUAGE}
  // jazyk
  if ParameterExists(csParameterLanguage) then
  begin
    dmCommon.Languages.UserLanguageCode := ParamValue(csParameterLanguage);
  end else
  begin
    // Naètení jazyka pro tento poèítaè
    fnSget_cmp_lang := TADOStoredProc.Create(Self);

    try
      fnSget_cmp_lang.Name := 'fnSget_cmp_lang';

      if cnOperatorConnection.Connected then
      begin
        fnSget_cmp_lang.Connection := cnOperatorConnection;
      end else
      begin
        fnSget_cmp_lang.Connection := cnSystemConnection;
      end;

      fnSget_cmp_lang.ProcedureName := CorrectSQL('ws.fn_s_get_cmp_language');
      fnSget_cmp_lang.Parameters.CreateParameter('@RETURN_VALUE', ftString, pdReturnValue, 250, Result);
      fnSget_cmp_lang.Parameters.CreateParameter('@p_s_cmp_name', ftString, pdInput, 50, GetComputerName);

      if MyExecProc(fnSget_cmp_lang) then
      begin
        if (Trim(fnSget_cmp_lang.Parameters.ParamValues['@RETURN_VALUE']) <> '') and
          (fnSget_cmp_lang.Parameters.ParamValues['@RETURN_VALUE'] <> Null) then
        begin
          FLanguages.UserLanguageCode := fnSget_cmp_lang.Parameters.ParamValues['@RETURN_VALUE'];
        end;

        fnSget_cmp_lang.Close;
      end;
    finally
      fnSget_cmp_lang.Free;
    end;
  end;

  if gbTerminate then
  begin
    // Aplikace byla ukonèena
    Exit;
  end;

  // Naètení jazyka pro zápis do logu
  gsLogLanguageCode := GetValueFromDatabaseConfiguration('s_log_language');

  if gsLogLanguageCode = '' then
  begin
    gsLogLanguageCode := Languages.UserLanguageCode;
  end;

  dmCommon.Languages.GetResourcestringStringList(slLogResourceString, ModuleName, Self.Name, gsLogLanguageCode);
  {$ENDIF}

  // Èíst id provozu a pracovištì, název a id modulu
  if not CheckConfiguration then
  begin
    Exit;
  end;

  // Zápis informací po spuštìní aplikace do logu
  GetFileInfo(Application.ExeName, FileInfoArray);
  DoWriteToLog('================================================================================');
  DoWriteToLog('Application start');
  // Datum a èas exe aplikace
  FileAge(Application.ExeName, ldtFileDateTime);
  DoWriteToLog('  Version: ' + FileInfoArray[4] + ' (' + FormatDateTime('dd.mm.yyyy hh:nn:ss', ldtFileDateTime) + ')');

  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  if not lbCheckParameters and not gbRunIndependent then
  // Test parametrù na pøíkazové øádce neprobìhl úspìšnì a modul není možné spustit mimo správce
  begin
    // Aplikaci není možné spustit tímto zpùsobem!
    MyMessageBox(resStartApplicationError, mtError, Screen.Activeform);
    Exit;
  end;

  // Login okno, operator connection
  if not OpenLoginWindow(gsUserRightCode) then
  begin
    Exit;
  end;

  qrSurh.Connection := cnOperatorConnection;

  // Naètení názvu modulu ve správném jazyku
  gsModuleName := dmCommon.GetModuleName;
  Application.Title := gsModuleName;

  gbApplicationLogin := False;

  // Kontrola jen pro konfiguraci provozù
  if (gsModuleCode = gsConfigurationModuleCode) and (AnsiUpperCase(gsUserLogin) <> AnsiUpperCase(csAdmin)) then
  // Provoz nebo PC neexistuje a uživatel není admin => konec
  begin
    if gnComputerId = 0 then
    begin
      // Název poèítaèe není zaveden v konfiguraci provozù!
      MyMessageBox(resComputerNotFound, mtError, Screen.Activeform);
      Exit;
    end;

    if gnComplexId = 0 then
    begin
      // Chyba konfigurace - nebyl nalezen provoz!
      MyMessageBox(resWrongConfiguration, mtError, Screen.Activeform);
      Exit;
    end;

    if gbModulePermissionError then
    begin
      // Modul nemá oprávnìní být spuštìn na tomto poèítaèi!
      MyMessageBox(resModulePermissionError, mtError, Screen.Activeform);
      Exit;
    end;
  end;

  // Kontrola poètu spuštìných modulù
  if not CheckModules then
  begin
    Exit;
  end;

  // Musí se zmìnit heslo?
  if not ChangePassword then
  begin
    Exit;
  end;

  // Vymazání starých záznamù z t_rmd
  if not DeleteOldRunningModules then
  begin
    Exit;
  end;

  // Vymazání starých záznamù z t_mls, jen pro WiPr
  if gsImplementationCode = csImplementationWiPrZentiva then
  begin
    if not DeleteOldMails then
    begin
      Exit;
    end;
  end;

  // Spuštìní threadu pro aktualizaci tabulky t_rmd
  if gbStartRunningModule then
  begin
    StartRunningModuleThread;
  end;

  // Probíhá naèítání dat...
  frmSplash.SetActionLabel(resDataLoading);
  frmSplash.SetApplicationLabel(gsModuleName);
  frmSplash.ShowSplash;

  p_stbMain.Panels[0].Text := gsUserName;
  {$ENDIF}
  {$ENDIF}

  {$IFDEF WINMIXWEIGHING}
  // Pøipojení k MS SQL
  if not ConnectToMSSQL(cnOperatorConnection) then
  begin
    Exit;
  end;

  GetFileInfo(Application.ExeName, FileInfoArray);
  p_stbMain.Panels[0].Text := 'Verze: ' + FileInfoArray[4];
  {$ENDIF}

  lsDatabaseVersion := GetValueFromDatabaseConfiguration('s_version');

  if lsDatabaseVersion = '' then
  begin
    lsDatabaseVersion := GetValueFromDatabaseConfiguration('r_version');
  end;

  // Hints will remain displayed for 60 seconds
  Application.HintHidePause := 60000;

  // WiPr... %s, verze: %s
  // Ostatní... Databáze: %s, verze: %s
  p_stbMain.Panels[2].Text := Format(resDatabaseVersion, ['\\' + gsServer + '\' + gsDatabase, lsDatabaseVersion]);

  {$IFDEF WININSERT}
  p_stbMain.Panels[2].Text := Format('%s, verze: %s', ['\\' + gsServer + '\' + gsDatabase, lsDatabaseVersion]);
  {$ENDIF}

  // název a kód provozu
  p_stbMain.Panels[1].Text := GetFrmMainStatusPanel;
  {$IFNDEF WINPACKAGE}
  {$IFNDEF WINMIXWEIGHING}
  p_frmMain.Caption := gsModuleName + ' - ' + p_stbMain.Panels[1].Text;
  {$ENDIF}
  {$ENDIF}

  Result := True;
end;

procedure TdmCommon.tmrApplicationTerminateTimer(Sender: TObject);
// ukonèí aplikaci po ztrátì spojení s MS SQL
// když se to volalo hned na místì, tak to zlobilo
// (zobrazila se zpráva, že se Microsoft omlouvá za potíže...)
// proto je to tady a aplikace se ukonèí až za pár vteøin
begin
  gbTerminate := True;
  Application.Terminate;
  Halt;
end;

procedure TdmCommon.SaveColumnSettings(CxGridDBTableView: TcxGridTableView);
// Uložit uživatelské nastavení gridu
var
  lsComputerName: String;
  lsFilePath: String;
  FileStream: TFileStream;
begin
  // Název PC
  if Trim(gsComputerName) <> '' then
  begin
    lsComputerName := gsComputerName;
  end else
  begin
    lsComputerName := GetComputerName;
  end;

  lsComputerName := Trim(lsComputerName);

  lsFilePath := ExtractFilePath(Application.ExeName) + 'Settings\' + lsComputerName + '\' + ChangeFileExt(ExtractFileName(Application.ExeName), '');
  lsFilePath := IncludeTrailingPathDelimiter(lsFilePath);
  ForceDirectories(lsFilePath);

  try
    CxGridDBTableView.DataController.GridView.StoreToIniFile(lsFilePath + 'cxGrids.ini', False, [gsoUseSummary]);
  except
    on E: Exception do
    begin
      // Chyba pøi ukládání nastavení gridu! #13#10 + E.Message
      WriteToLog(PResStringRec(@resErrorSavingGridSettings), 'resErrorSavingGridSettings', [E.Message]);
    end;
  end;

  FileStream := TFileStream.Create(lsFilePath + CxGridDBTableView.Name + '.flt', fmCreate);

  try
    try
      CxGridDBTableView.DataController.Filter.SaveToStream(FileStream);
    except

    end;
  finally
    FileStream.Free;
  end;
end;

procedure TdmCommon.LoadColumnSettings(CxGridDBTableView: TcxGridTableView);
// Naèíst uživatelské nastavení gridu
var
  FileStream: TFileStream;
  lsComputerName: String;
  lsFilePath: String;
  Ini: TIniFile;
  i: Integer;
  lsCurrentGridSectionName: String;
begin
  // Název PC
  if Trim(gsComputerName) <> '' then
  begin
    lsComputerName := gsComputerName;
  end else
  begin
    lsComputerName := GetComputerName;
  end;

  lsComputerName := Trim(lsComputerName);
  lsFilePath := ExtractFilePath(Application.ExeName) + 'Settings\' + lsComputerName + '\' + ChangeFileExt(ExtractFileName(Application.ExeName), '');
  lsFilePath := IncludeTrailingPathDelimiter(lsFilePath);
  Ini := TIniFile.Create(lsFilePath + 'cxGrids.ini');

  // prefix - <jméno formu>.<jméno gridu>
  lsCurrentGridSectionName := CxGridDBTableView.Owner.Name + '.' + CxGridDBTableView.Name;

  try
    if (ini.SectionExists(lsCurrentGridSectionName + ': ' + (CxGridDBTableView as TComponent).Name)) and
      not (ini.SectionExists(lsCurrentGridSectionName + '/FooterSummaryItem0' + ': TcxGridDBTableSummaryItem')) then
    begin
      CxGridDBTableView.DataController.Summary.FooterSummaryItems.Delete(0);
    end;

    EraseInvalidColumns(CxGridDBTableView, Ini);
    CxGridDBTableView.DataController.GridView.RestoreFromIniFile(lsFilePath + 'cxGrids.ini', True, False, [gsoUseSummary]);

    for i := 0 to CxGridDBTableView.DataController.Summary.FooterSummaryItems.Count - 1 do
    begin
      Ini.EraseSection(lsCurrentGridSectionName + '/FooterSummaryItem' + IntToStr(i) + ': TcxGridDBTableSummaryItem');
    end;
  finally
    Ini.Free;
  end;

  if FileExists(lsFilePath + CxGridDBTableView.Name + '.flt') then
  begin
    FileStream := TFileStream.Create(lsFilePath + CxGridDBTableView.Name + '.flt', fmOpenRead);

    try
      CxGridDBTableView.DataController.Filter.LoadFromStream(FileStream);
    finally
      FileStream.Free;
    end;
  end;

  for i := 0 to CxGridDBTableView.ColumnCount - 1 do
  begin
    CxGridDBTableView.Columns[i].HeaderAlignmentHorz := taCenter;
  end;
end;

procedure TdmCommon.SaveDefaultSettings(CxGridDBTableView: TcxGridTableView);
// Uložit standardní nastavení gridu
var
  lsComputerName: String;
  lsFilePath: String;
begin
  // Název PC
  if Trim(gsComputerName) <> '' then
  begin
    lsComputerName := gsComputerName;
  end else
  begin
    lsComputerName := GetComputerName;
  end;

  lsComputerName := Trim(lsComputerName);

  lsFilePath := ExtractFilePath(Application.ExeName) + 'Settings\' + lsComputerName + '\' +  ChangeFileExt(ExtractFileName(Application.ExeName), '');
  lsFilePath := IncludeTrailingPathDelimiter(lsFilePath);
  ForceDirectories(lsFilePath);

  if CxGridDBTableView.DataController.Summary.FooterSummaryItems.Count > 0 then
  begin
    CxGridDBTableView.DataController.Summary.FooterSummaryItems[0].Kind := skOrder;
  end;

  try
    CxGridDBTableView.DataController.GridView.StoreToIniFile(lsFilePath + 'cxGrids.def', False, [gsoUseSummary]);
  except
    on E: Exception do
    begin
      // Chyba pøi ukládání výchozího nastavení gridu! #13#10 + E.Message
      WriteToLog(PResStringRec(@resErrorSavingDefaultGridSettings), 'resErrorSavingDefaultGridSettings', [E.Message]);
    end;
  end;
end;

procedure TdmCommon.RestoreDefaultSettings(CxGridDBTableView: TcxGridTableView);
// Obnovit standardní nastavení dbgrid
var
  lsComputerName: String;
  lsFilePath: String;
  Ini: TIniFile;
  i: Integer;
begin
  // Název PC
  if Trim(gsComputerName) <> '' then
  begin
    lsComputerName := gsComputerName;
  end else
  begin
    lsComputerName := GetComputerName;
  end;

  lsComputerName := Trim(lsComputerName);
  lsFilePath := ExtractFilePath(Application.ExeName) + 'Settings\' + lsComputerName + '\' + ChangeFileExt(ExtractFileName(Application.ExeName), '');
  lsFilePath := IncludeTrailingPathDelimiter(lsFilePath);
  Ini := TIniFile.Create(lsFilePath + 'cxGrids.def');

  for i := CxGridDBTableView.DataController.Summary.FooterSummaryItems.Count - 1 downto 0 do
  begin
    CxGridDBTableView.DataController.Summary.FooterSummaryItems[i].Kind := skNone;
    CxGridDBTableView.DataController.Summary.FooterSummaryItems[i].Free;
  end;

  EraseInvalidColumns(CxGridDBTableView, Ini);
  CxGridDBTableView.DataController.GridView.RestoreFromIniFile(lsFilePath + 'cxGrids.def', True, False, [gsoUseSummary]);
  CxGridDBTableView.DataController.Filter.Clear;

  // HF 10.12.2009 Nìkteré gridy po resetu ukazovaly v summary záznam èíslo/0
  dbgridTableViewFocusedRecordChanged(CxGridDBTableView, CxGridDBTableView.ViewData.GridView,
    CxGridDBTableView.ViewData.GridView.Controller.FocusedRecord);
end;

procedure TdmCommon.EraseInvalidColumns(CxGridDBTableView: TcxGridTableView; Ini: TIniFile);
// Kontrola, jestli v .ini souboru nejsou neplatné názvy sloupcù - projde všechny sekce .ini souboru
var
  i: Integer;
  j: Integer;
  lsCurrentGridSectionName: String;
  lsCurrentGridColumnName: String;
  lbColumnFound: Boolean;
  Sections: TStringList;
begin
  Sections := TStringList.Create;
  // Prefix - <jméno formu>.<jméno gridu>
  lsCurrentGridSectionName := CxGridDBTableView.Owner.Name + '.' + CxGridDBTableView.Name;

  try
    Ini.ReadSections(Sections);

    for i := 0 to Sections.Count - 1 do
    begin
      lsCurrentGridColumnName := Sections[i];

      // Jde o název sloupce tohoto gridu? (zaèíná prefixem a konèí ': TcxGridDBColumn'?)
      if (Pos(lsCurrentGridSectionName + '/', lsCurrentGridColumnName) > 0) and (Pos(': TcxGridDBColumn', lsCurrentGridColumnName) > 0) then
      begin
        System.Delete(lsCurrentGridColumnName, 1, Length(lsCurrentGridSectionName) + 1);
        System.Delete(lsCurrentGridColumnName, Pos(': TcxGridDBColumn', lsCurrentGridColumnName), Length(': TcxGridDBColumn'));
        lbColumnFound := False;

        for j := 0 to CxGridDBTableView.ColumnCount - 1 do
        begin
          if CxGridDBTableView.Columns[j].Name = lsCurrentGridColumnName then
          begin
            lbColumnFound := True;
            Break;
          end;
        end;

        // takový sloupec v gridu neexistuje - musí se vymazat, jinak by byl v gridu prázdný sloupec
        if not lbColumnFound then
        begin
          Ini.EraseSection(Sections[i]);
        end;
      end;
    end;
  finally
    Sections.Free;
  end;
end;

procedure TdmCommon.CreateShowHideMenu(p_miMenuItem: TMenuItem);
// Generování menu pro zobrazení/skrytí sloupcù v cxGridu
var
  i: Integer;
  lmiNewMenuItem: TMenuItem;
begin
  if p_miMenuItem <> nil then
  begin
    p_miMenuItem.Clear;
  end;

  for i := 0 to dbgridTableView.ColumnCount - 1 do
  begin
    if not dbgridTableView.Columns[i].Hidden then
    begin
      lmiNewMenuItem := TMenuItem.Create(p_miMenuItem);
      lmiNewMenuItem.Caption := dbgridTableView.Columns[i].Caption;
      lmiNewMenuItem.Checked := dbgridTableView.Columns[i].Visible;
      lmiNewMenuItem.OnClick := ShowHideColumn;
      lmiNewMenuItem.Tag := i;
      p_miMenuItem.Insert(p_miMenuItem.Count, lmiNewMenuItem);
    end;
  end;
end;

procedure TdmCommon.ShowHideColumn(Sender: TObject);
// zobrazit/skrýt sloupec v dbgrid
var
  menuItem: TMenuItem;
begin
  menuItem := (Sender as TMenuItem);
  menuItem.Checked := not menuItem.Checked;
  dbgridTableView.Columns[menuItem.Tag].Visible := not dbgridTableView.Columns[menuItem.Tag].Visible;
end;

function TdmCommon.GetDbgridTableView: TcxGridDBTableView;
begin
  Result := fDbgridTableView;
end;

procedure TdmCommon.SetDbgridTableView(CxGridDBTableView: TcxGridDBTableView);
begin
  fDbgridTableView := CxGridDBTableView;
end;

procedure TdmCommon.dbgridTableViewFocusedRecordChanged(CxGridDBTableView: TcxGridTableView; Sender: TcxCustomGridTableView;
  AFocusedRecord: TcxCustomGridRecord);
// Aktualizovat informaci o aktivním øádku
var
  i: Integer;
begin
  for i := 0 to Sender.DataController.Summary.FooterSummaryItems.Count - 1 do
  begin
    if Sender.DataController.Summary.FooterSummaryItems[i].Kind = skOrder then
    begin
      if ((CxGridDBTableView <> nil) and (AFocusedRecord <> nil)) then
      begin
        Sender.DataController.Summary.FooterSummaryValues[i] := IntToStr(AFocusedRecord.Index + 1) + '/' +
          IntToStr(CxGridDBTableView.DataController.FilteredRecordCount);
      end else
      begin
        Sender.DataController.Summary.FooterSummaryValues[i] := '0/0';
      end;
    end;
  end;
end;

procedure TdmCommon.aExportToXMLExecute(Sender: TObject);
// uložit dbGrid do XML souboru
begin
  sdExportToFile.InitialDir := ExtractFileDir(Application.ExeName);
  sdExportToFile.DefaultExt := '.xml';
  // Soubory XML (*.xml)|*.xml|Vše (*.*)|*.*
  sdExportToFile.Filter := resXmlFilesFilter;
  sdExportToFile.FileName := '';

  if sdExportToFile.Execute then
  begin
    ExportGridToXML(sdExportToFile.FileName, dbgridTableView.GetParentComponent as TcxGrid);
  end;
end;

procedure TdmCommon.aExportToCSVExecute(Sender: TObject);
// export dbgrid do csv
var
  lsExtension: String;
begin
  sdExportToFile.InitialDir := ExtractFileDir(Application.ExeName);
  sdExportToFile.DefaultExt := '.csv';
  // Textové soubory CSV (*.csv; *.txt)|*.csv; *.txt|Vše (*.*)|*.*
  sdExportToFile.Filter := resCvsFilesFilter;
  sdExportToFile.FileName := '';

  if sdExportToFile.Execute then
  begin
    lsExtension := ExtractFileExt(sdExportToFile.FileName);
    lsExtension := Copy(lsExtension, 2, Length(lsExtension));
    ExportGridToText(sdExportToFile.FileName, dbgridTableView.GetParentComponent as TcxGrid, True, True, ';', '', '', lsExtension);
  end;
end;

procedure TdmCommon.aExportToXLSExecute(Sender: TObject);
// export dbgrid do xls
begin
  sdExportToFile.InitialDir := ExtractFileDir(Application.ExeName);
  sdExportToFile.DefaultExt := '.xls';
  // Soubory Microsoft Excel (*.xls)|*.xls|Vše (*.*)|*.*
  sdExportToFile.Filter := resXlsFilesFilter;
  sdExportToFile.FileName := '';

  if sdExportToFile.Execute then
  begin
    ExportGridToExcel(sdExportToFile.FileName, (dbgridTableView.GetParentComponent as TcxGrid));
  end;
end;

procedure TdmCommon.aDefaultSettingsExecute(Sender: TObject);
// Obnovení standardního nastavení
begin
  RestoreDefaultSettings((dbgridTableView as TcxGridTableView));
end;

procedure TdmCommon.CreatePopupMenu(Menu: TPopupMenu);
// Vytvoøit položky menu spoleèné pro všechny moduly
var
  i: Integer;
  j: Integer;
  MenuItem: TMenuItem;
  SubMenuItem: TMenuItem;
begin
  for i := 0 to PopupMenu.Items.Count - 1 do
  begin
    MenuItem := TMenuItem.Create(Menu);
    MenuItem.Caption := PopupMenu.Items[i].Caption;
    MenuItem.Hint := PopupMenu.Items[i].Hint;
    MenuItem.Name := PopupMenu.Items[i].Name;
    MenuItem.ShortCut := PopupMenu.Items[i].ShortCut;
    MenuItem.Action := PopupMenu.Items[i].Action;

    for j := 0 to PopupMenu.Items[i].Count - 1 do
    begin
      SubMenuItem := TMenuItem.Create(Menu);
      SubMenuItem.Caption := PopupMenu.Items[i].Items[j].Caption;
      SubMenuItem.Hint := PopupMenu.Items[i].Items[j].Hint;
      SubMenuItem.Name := PopupMenu.Items[i].Items[j].Name;
      SubMenuItem.ShortCut := PopupMenu.Items[i].Items[j].ShortCut;
      SubMenuItem.Action := PopupMenu.Items[i].Items[j].Action;
      MenuItem.Add(SubMenuItem);
    end;

    Menu.Items.Add(MenuItem);
  end;
end;

procedure TdmCommon.GoFirstRow(CxGridDBTableView: TcxGridDBTableView);
// V gridu vybrat první øádek
begin
  CxGridDBTableView.DataController.FocusedRowIndex := 0;
end;

procedure TdmCommon.aShowHideColumnsExecute(Sender: TObject);
// Vytvoøit pop-up menu se seznamem sloupcù
begin
  CreateShowHideMenu((Sender as TPopupMenu).FindComponent('miShowHideColumns') as TMenuItem);
end;

procedure TdmCommon.sdExportToFileCanClose(Sender: TObject; var CanClose: Boolean);
begin
  if FileExists(sdExportToFile.FileName) then
  begin
    // Soubor sdExportToFile.FileName
    // Již existuje. Pøejete si jej pøepsat?
    if MyMessageBox(Format(resFileExistOverwrite, [sdExportToFile.FileName]), mtConfirmation, Screen.Activeform) = IDYES then
    begin
      CanClose := True;

      if not DeleteFile(sdExportToFile.FileName) then
      begin
        // Soubor nelze pøepsat. ' + 'Zkontrolujte prosím není-li otevøen v jiné aplikaci.'
        MyMessageBox(resFileOverwriteError, mtError, Screen.Activeform);
        CanClose := False;
      end;
    end else
    begin
      CanClose := False;
    end;
  end;
end;

function MyMessageBox(p_sMessage: String; p_MessageType: TMsgDlgType; p_frmActiveForm: TForm = nil): Integer;
var
  lsTitle: PChar;
  lfrmDialog: TForm;
  lbtnButtons: TMsgDlgButtons;
begin
  Screen.Cursor := crDefault;
  lsTitle := '';
  lbtnButtons := [mbOK];

  case p_MessageType of
    mtError:
      begin
        lsTitle := PChar(resError);
        lbtnButtons := [mbOK];
      end;
    mtInformation:
      begin
        lsTitle := PChar(resInformation);
        lbtnButtons := [mbOK];
      end;
    mtCustom:
      begin
        p_MessageType := mtError;
        lsTitle := PChar(resError);
        lbtnButtons := [mbYes, mbNo];
      end;
    mtWarning:
      begin
        lsTitle := PChar(resWarning);
        lbtnButtons := [mbOK];
      end;
    mtConfirmation:
      begin
        lsTitle := PChar(resConfirmation);
        lbtnButtons := [mbYes, mbNo];
      end;
  end;

  p_sMessage := ReplaceSpecialCharacters(p_sMessage);
  lfrmDialog := CreateMessageDialog(p_sMessage, p_MessageType, lbtnButtons);
  lfrmDialog.Caption := lsTitle;

  if lfrmDialog.FindChildControl('OK') <> nil then
  begin
    TButton(lfrmDialog.FindChildControl('OK')).Caption := resButtonOk;
  end;

  if lfrmDialog.FindChildControl('Yes') <> nil then
  begin
    TButton(lfrmDialog.FindChildControl('Yes')).Caption := resButtonYes;
  end;

  if lfrmDialog.FindChildControl('No') <> nil then
  begin
    TButton(lfrmDialog.FindChildControl('No')).Caption := resButtonNo;
  end;

  if gsUserRightCode = 'batch_comp' then
  begin
    // v modulu "Kompletace šarže" zvìtšit dialog v pomìru velikosti písma frmMain a dialogu
    // -24 je velikost písma frmMain
    frmSplash.ResizeForm(lfrmDialog, -24 / lfrmDialog.Font.Height);
  end;

  if lfrmDialog.FindComponent('Message') <> nil then
  begin
    TLabel(lfrmDialog.FindComponent('Message')).Width := lfrmDialog.ClientWidth - TLabel(lfrmDialog.FindComponent('Message')).Left - 10;
  end;

  if lfrmDialog.FindComponent('Image') <> nil then
  begin
    TImage(lfrmDialog.FindComponent('Image')).AutoSize := True;
  end;

  if (Application.MainForm <> nil) and Application.MainForm.Visible then
  begin
    lfrmDialog.Position := poMainFormCenter;
  end else
  begin
    lfrmDialog.Position := poScreenCenter;
  end;

  Result := lfrmDialog.ShowModal;
end;

procedure TMultiLangForm.FormCreate(Sender: TObject);
// vytvoøení seznamu resourcestringù
begin
  inherited;
  slResourceString := THashedStringList.Create;
  slLogResourceString := THashedStringList.Create;
  LangToolButtonRevIndex := 3; // Defaultní pozice tlaèítka se seznamem jazykù (od konce)
end;

procedure TMultiLangForm.LoadWindowPosition;
// naètení pozice okna
var
  lsWindowState: String;
begin
  if Name = 'frmSplash' then
  begin
    Exit;
  end;

  if gbPositionLoaded then
  begin
    Exit;
  end;

  gbPositionLoaded := True;

  try
    lsWindowState := LoadFromIni('FormSettings', Name + 'State', '', True);

    if (lsWindowState = '') and (gsWindowState = 'Maximized') then
    begin
      // pro formy, které se mají spustit maximalizované
      // promìnná gsWindowState se nastavuje ve frmMain.OnCreate
      lsWindowState := 'Maximized';
    end;

    if BorderStyle = bsSizeable then
    begin
      Width := StrToIntDef(LoadFromIni('FormSettings', Name + 'Width', '', True), Width);
      Height := StrToIntDef(LoadFromIni('FormSettings', Name + 'Height', '', True), Height);
    end;

    Left := StrToIntDef(LoadFromIni('FormSettings', Name + 'Left', '', True), Left);
    Top := StrToIntDef(LoadFromIni('FormSettings', Name + 'Top', '', True), Top);

    if (lsWindowState = 'Maximized') and (BorderStyle = bsSizeable) then
    begin
      WindowState := wsMaximized;
    end else
    if lsWindowState = 'Minimized' then
    begin
      WindowState := wsMinimized;
    end;
  except
    on E: Exception do
    begin
      // Chyba pøi naèítání pozice a velikosti formuláøe "Name":\x0D%s + E.Message
      WriteToLog(PResStringRec(@resErrLoadFormPosition), 'resErrLoadFormPosition', [Name, E.Message]);
    end;
  end;
end;

procedure TMultiLangForm.FormDestroy(Sender: TObject);
begin
  slResourceString.Free;
  slLogResourceString.Free;
  inherited;
end;

destructor TMultiLangForm.Destroy;
// Uložení pozice a velikosti okna
begin
  if Name <> 'frmSplash' then
  begin
    try
      if WindowState = wsMaximized then
      begin
        SaveToIni('FormSettings', Name + 'State', 'Maximized', True);
        ShowWindow(Handle, SW_RESTORE);
      end else
      if WindowState = wsMinimized then
      begin
        SaveToIni('FormSettings', Name + 'State', 'Minimized', True);
        ShowWindow(Handle, SW_RESTORE);
      end else
      if WindowState = wsNormal then
      begin
        SaveToIni('FormSettings', Name + 'State', 'Normal', True);
      end;

      SaveToIni('FormSettings', Name + 'Left', IntToStr(Left), True);
      SaveToIni('FormSettings', Name + 'Top', IntToStr(Top), True);
      SaveToIni('FormSettings', Name + 'Width', IntToStr(Width), True);
      SaveToIni('FormSettings', Name + 'Height', IntToStr(Height), True);
    except
      on E: Exception do
      begin
        // Chyba pøi ukládání pozice a velikosti formuláøe "Name":\x0D%s + E.Message
        WriteToLog(PResStringRec(@resErrSaveFormPosition), 'resErrSaveFormPosition', [Name, E.Message]);
      end;
    end;
  end;

  inherited;
end;

procedure TMultiLangForm.CreateParams(var Params: TCreateParams);
// Windows Vista: zobrazení náhledu pøi ALT+TAB, WIN+TAB
begin
  inherited CreateParams(Params);

  if gbIsWindowsVista or gbOverrideVCLHiddenWindow then
  begin
    Params.ExStyle := Params.ExStyle and not WS_EX_TOOLWINDOW or WS_EX_APPWINDOW;
  end;
end;

procedure TMultiLangForm.WMActivate(var Message: TWMActivate);
// Windows Vista: zobrazení náhledu pøi ALT+TAB, WIN+TAB
var
  lnApplicationExStyleOld: Integer;
  lnApplicationExStyleNew: Integer;
begin
  // zmìna hidden hlavního okna aplikace - úprava kvùli náhledùm okna nebo aplikace bez hlavního okna
  if (gbIsWindowsVista and (Application.MainForm = Self)) or gbOverrideVCLHiddenWindow then
  begin
    lnApplicationExStyleOld := GetWindowLong(Application.Handle, GWL_EXSTYLE);
    lnApplicationExStyleNew := lnApplicationExStyleOld and not WS_EX_APPWINDOW or WS_EX_TOOLWINDOW;

    if lnApplicationExStyleNew <> lnApplicationExStyleOld then
    begin
      ShowWindow(Application.Handle, SW_HIDE);
      SetWindowLong(Application.Handle, GWL_EXSTYLE, lnApplicationExStyleNew);
      ShowWindow(Application.Handle, SW_SHOW);
    end;
  end;

  if (gfCurrentModalForm = Self) and Application.MainFormOnTaskBar and Assigned(gfCurrentModalForm) and (Message.Active = WA_ACTIVE) and
    (Message.ActiveWindow = 0) then
  begin
    PostMessage(Application.MainFormHandle, WM_ACTIVATE, WA_ACTIVE, 0);
  end;

  if (gbIsWindowsVista or gbOverrideVCLHiddenWindow) and (Message.Active = WA_ACTIVE) and not IsWindowEnabled(Handle) then
  begin
    SetActiveWindow(Application.Handle);
    Message.Result := 0;
  end else
  begin
    inherited;
  end;
end;

procedure TMultiLangForm.WMShowWindow(var Message: TWMActivate);
begin
  LoadWindowPosition;
  inherited;
end;

procedure TMultiLangForm.WMSysCommand(var Message: TWmSysCommand);
// Windows Vista: zobrazení náhledu pøi ALT+TAB, WIN+TAB
begin
  if gbIsWindowsVista or gbOverrideVCLHiddenWindow then
  begin
    case (Message.CmdType and $FFF0) of
      SC_MINIMIZE:
      begin
        ShowWindow(Handle, SW_MINIMIZE);
        Message.Result := 0;
      end;
      SC_RESTORE:
      begin
        ShowWindow(Handle, SW_RESTORE);
        Message.Result := 0;
      end;
      else
      begin
        inherited;
      end;
    end;
  end else
  begin
    inherited;
  end;
end;

procedure TMultiLangForm.WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const; p_sLogType: String = '');
// Zapíše do logu
var
  lsResourceString: String;
begin
  {$IFNDEF MULTILANGUAGE}
  lsResourceString := LoadResString(p_ResStringRec);
  {$ELSE}
  lsResourceString := dmCommon.Languages.GetResourceStringValue(p_sResStringName, slLogResourceString);

  if lsResourceString = '' then
  // pokusit se naèíst resourcestring se seznamu pro spoleènou èást
  begin
    lsResourceString := dmCommon.Languages.GetResourceStringValue(p_sResStringName, dmCommon.slLogResourceString);
  end;

  if lsResourceString = '' then
  // resourcestring nenalezen - pravdìpodobnì chybné volání metody WriteToLog
  // nebo resource není ve WinFormulaRes.xls
  begin
    {$IFNDEF DEBUGGING}
    // pùvodní hodnota resourcestringu
    lsResourceString := LoadResString(p_ResStringRec);
    {$ELSE}
    // název resourcestringu
    lsResourceString := p_sResStringName + '.resourcestring';
    {$ENDIF}
  end;
  {$ENDIF}

  DoWriteToLog(Format(lsResourceString, Args), p_sLogType);
end;

{$IFDEF MULTILANGUAGE}
function TMultiLangForm.TranslateForm: Boolean;
// Pøeklad formuláøe
var
  lnIndex: Integer;
  lnIndex2: Integer;
  lnIndex3: Integer;
  MenuItem: TMenuItem;
  cxPM: TcxGridPopupMenu;
begin
  Result := False;

  if ModuleName = '' then
  begin
    // Formuláø nebyl inicializován
    Exit;
  end;

  // Když se tady mìnilo lang menu, tak se v modulu MoniProc všechny jazyky vytvoøily znovu
  try
    if not dmCommon.Languages.GetResourcestringStringList(slResourceString, ModuleName, Self.Name) then
    begin
      Exit;
    end;
  except
    Exit;
  end;

  TranslateResourceStrings;

  try
    dmCommon.Languages.TranslateForm(Self, ModuleName);
  except
    Self.Close;
    Exit;
  end;

  if miChangeLang <> nil then
  begin
    for lnIndex := miChangeLang.Count - 1 downto 0 do
    begin
      miChangeLang.Items[lnIndex].Free;
    end;
  end;

  AddChangeLangMenu;

  for lnIndex := 0 to ComponentCount - 1 do
  begin
    if Components[lnIndex] is TPopupMenu then
    begin
      for lnIndex2 := 0 to (Components[lnIndex] as TPopupMenu).Items.Count - 1 do
      begin
        MenuItem := (Components[lnIndex] as TPopupMenu).Items[lnIndex2] as TMenuItem;

        for lnIndex3 := 0 to dmCommon.PopupMenu.Items.Count - 1 do
        begin
          if dmCommon.PopupMenu.Items[lnIndex3].Name = MenuItem.Name then
          begin
            MenuItem.Caption := dmCommon.PopupMenu.Items[lnIndex3].Caption;
            Break;
          end;
        end;
      end;
    end else
    if Components[lnIndex] is TcxGridPopupMenu then
    begin
      cxPM := Components[lnIndex] as TcxGridPopupMenu;
      // Zajistí znovunaètení položek menu
      cxPM.UseBuiltInPopupMenus := False;
      cxPM.UseBuiltInPopupMenus := True;
    end;
  end;

  if miTools <> nil then
  begin
    // Nástroje
    miTools.Caption := resMenuTools;
  end;

  if miChangeLang <> nil then
  begin
    // Zmìnit jazyk
    miChangeLang.Caption := resMenuChangeLanguage;
  end;

  Result := True;
end;
{$ENDIF}

function TMultiLangForm.InitTranslate(const p_sModuleName: String = ''): Boolean;
// Pøeklad formuláøe
begin
  {$IFNDEF MULTILANGUAGE}
  // Modul není vícejazyèný
  Result := True;
  Exit;
  {$ENDIF}

  {$IFDEF MULTILANGUAGE}
  Result := False;

  if p_sModuleName <> '' then
  begin
    ModuleName := p_sModuleName;
  end else
  begin
    ModuleName := gsEnglishModuleName;
  end;

  Application.Title := gsModuleName;

  if not dmCommon.Languages.GetResourcestringStringList(slLogResourceString, ModuleName, Self.Name, gsLogLanguageCode) then
  begin
    Exit;
  end;

  Result := TranslateForm;
  {$ENDIF}
end;

procedure TMultiLangForm.SetVistaAppearance(p_Component: TComponent);
// Nastaví form, aby vypadal lépe na Windows Vista - fonty Segoe UI a Calibri
var
  i: Integer;
  lsFontName: String;
  lbmpTestBitmap: TBitmap;
begin
  for i := 0 to p_Component.ComponentCount - 1 do
  begin
    if p_Component.Components[i].ClassName = 'TcxDateEdit' then
    begin
      TControlWithFont(p_Component.Components[i]).ParentFont := False;
    end;
  end;

  if p_Component is TControl then
  begin
    lsFontName := TControlWithFont(p_Component).Font.Name;

    // TControl má ParentFont a Font protected, pøetypováním na moji class se na properties dostanu
    if ((p_Component is TCustomMemo) or (p_Component is TcxMemo)) and ((lsFontName = 'MS Sans Serif') or (lsFontName = csVistaFontNormal)) then
    begin
      lbmpTestBitmap := TBitmap.Create;

      try
        // zmìøím výšku 'H' v pixelech napsanou pùvodním fontem
        lbmpTestBitmap.Canvas.Font.Assign(TControlWithFont(p_Component).Font);
        // nastavím ji novému fontu
        TControlWithFont(p_Component).Font.Height := lbmpTestBitmap.Canvas.TextHeight('H') + 2;
        TControlWithFont(p_Component).Font.Name := csVistaFontContent;
      finally
        lbmpTestBitmap.Free;
      end;
    end else
    if (lsFontName = 'MS Sans Serif') and ((not TControlWithFont(p_Component).ParentFont) or (p_Component is TForm)) then
    begin
      lbmpTestBitmap := TBitmap.Create;

      try
        // zmìøím výšku 'H' v pixelech napsanou pùvodním fontem
        lbmpTestBitmap.Canvas.Font.Assign(TControlWithFont(p_Component).Font);

        // nastavím ji novému fontu
        if p_Component.ClassName <> 'TcxDateEdit' then
        begin
          TControlWithFont(p_Component).Font.Height := lbmpTestBitmap.Canvas.TextHeight('H');
        end;

        TControlWithFont(p_Component).Font.Name := csVistaFontNormal;
      finally
        lbmpTestBitmap.Free;
      end;
    end;
  end;

  // Rekurzivnì zavolám pro všechny dìti
  for i := 0 to p_Component.ComponentCount - 1 do
  begin
    SetVistaAppearance(p_Component.Components[i]);
  end;
end;

{$IFDEF MULTILANGUAGE}
function TMultiLangForm.GetResourceString(const p_sRecourceString: String): String;
begin
  Result := ReplaceSpecialCharacters(dmCommon.Languages.GetResourceStringFromList(Self.slResourceString, p_sRecourceString));
end;
{$ENDIF}

{$IFDEF MULTILANGUAGE}
procedure TMultiLangForm.ChangeLanguage(const p_sLangCode: String);
begin
  if dmCommon.Languages.GetHandle(p_sLangCode) <> 0 then
  begin
    dmCommon.Languages.UserLanguageCode := p_sLangCode;
  end;

  // Naètení názvu modulu ve správném jazyku
  gsModuleName := dmCommon.GetModuleName;
  Application.Title := gsModuleName;

  // Titulek frmMain
  if Self <> nil then
  begin
    Self.Caption := gsModuleName + ' - ' + GetFrmMainStatusPanel;
  end;

  // Provedení nìjaké akce - override ve formu
  if Self <> nil then
  begin
    DoAfterLanguageChange
  end;
end;
{$ENDIF}

procedure TMultiLangForm.TranslateResourceStrings;
begin
end;

{$IFDEF MULTILANGUAGE}
procedure TMultiLangForm.DoChangeLanguage(Sender: TObject);
begin
  if not MyOpenQuery(dmCommon.qrSlng) then
  begin
    Exit;
  end;

  if dmCommon.qrSlng.Locate('lng_n_id', (Sender as TMenuItem).Tag, []) then
  begin
    ChangeLanguage(dmCommon.qrSlng.FieldByName('lng_s_code').AsString);
  end;
end;
{$ENDIF}

{$IFDEF MULTILANGUAGE}
procedure TMultiLangForm.AddChangeLangMenu;
// Vytvoøení tlaèítka a menu pro zmìnu jazyka
var
  miLang: TMenuItem;
  miLang2: TMenuItem;
  lnIndex: Integer;
  lnPos: Integer;
  PopUpMenu: TPopupMenu;
  ToolButton: TToolButton;
  lsCaption: String;
  lsMenuTools: String;
  lnLeft: Integer;
  i: Integer;
  lnDrawPos: Integer;
  lbmpNew: TBitmap;
begin
  if Self.Menu = nil then
  begin
    Exit;
  end;

  PopUpMenu := TPopupMenu.Create(Self);
  PopUpMenu.Images := Self.Menu.Images;

  // Položka nástroje
  if miTools = nil then
  begin
    if Self.Menu.Images <> nil then
    begin
      Self.Menu.Images.AddImages(dmCommon.ilFlags)
    end else
    begin
      Self.Menu.Images := dmCommon.ilFlags;
    end;

    // tlaèítko se seznamem jazykù
    if LangToolBar = nil then
    begin
      for lnIndex := 0 to Self.ComponentCount - 1 do
      begin
        if Self.Components[lnIndex].ClassNameIs('TToolBar') then
        begin
          LangToolBar := TToolBar(Self.Components[lnIndex]);

          if LangToolBar.Images <> Self.Menu.Images then
          begin
            if LangToolBar.Images.Width = dmCommon.ilFlags.Width then
            begin
               LangToolBar.Images.AddImages(dmCommon.ilFlags);
            end else
            begin
              lbmpNew := TBitmap.Create;
              lbmpNew.Height := LangToolBar.Images.Height;
              lbmpNew.Width := LangToolBar.Images.Width;
              lbmpNew.Canvas.Brush.Style := bsSolid;
              // MÈ 28.1.2013 TODO následující øádek asi bude lepší použít v D2010
              // MÈ 28.1.2013 lbmpNew.Canvas.Brush.Color := clWebMagenta;
              lbmpNew.Canvas.Brush.Color := clBtnFace;
              lnDrawPos := (LangToolBar.Images.Width - dmCommon.ilFlags.Width) div 2;

              for i := 0 to dmCommon.ilFlags.Count - 1 do
              begin
                lbmpNew.Canvas.FillRect(Rect(0, 0, lbmpNew.Width, lbmpNew.Height));
                dmCommon.ilFlags.Draw(lbmpNew.Canvas, lnDrawPos, lnDrawPos, i, dsTransparent, itImage, True);
                LangToolBar.Images.AddMasked(lbmpNew, clBtnFace);
              end;

              FreeAndNil(lbmpNew);
            end;
          end;

          Break;
        end;
      end;
    end;

    if LangToolBar <> nil then
    begin
      lnLeft := LangToolBar.Width;

      if LangToolButtonRevIndex >= LangToolBar.ButtonCount then
      begin
        lnLeft := 0
      end else
      begin
        for lnIndex := LangToolBar.ButtonCount - 1 downto LangToolBar.ButtonCount - LangToolButtonRevIndex do
        begin
          lnLeft := lnLeft - LangToolBar.Buttons[lnIndex].Width;
        end;
      end;

      LangToolButton := TToolButton.Create(Self);
      LangToolButton.Style := tbsDropDown;
      LangToolButton.DropdownMenu := PopUpMenu;
      LangToolButton.Parent := LangToolBar;
      LangToolButton.Left := lnLeft + LangToolButton.Width;

      if lnLeft <> 0 then
      begin
        ToolButton := TToolButton.Create(Self);
        ToolButton.Style := tbsSeparator;
        ToolButton.AutoSize := False;
        ToolButton.Width := 8;
        ToolButton.Parent := LangToolBar;
        ToolButton.Left := lnLeft + ToolButton.Width;
      end;

      LangToolBar.HideClippedButtons := True;
    end;
  end;

  if miTools = nil then
  begin
    for lnIndex := 0 to Self.Menu.Items.Count - 1 do
    begin
      lsCaption := Self.Menu.Items[lnIndex].Caption;
      lsCaption := AnsiUpperCase(lsCaption);
      lnPos := Pos('&', lsCaption);

      if lnPos > 0 then
      begin
        Delete(lsCaption, lnPos, 1);
      end;

      lsMenuTools := AnsiUpperCase(resMenuTools);
      lnPos := Pos('&', lsMenuTools);

      if lnPos > 0 then
      begin
        Delete(lsMenuTools, lnPos, 1);
      end;

      if lsCaption = lsMenuTools then
      begin
        miTools := Self.Menu.Items[lnIndex];
        Break;
      end;
    end;
  end;

  if miTools = nil then
  begin
    miTools := TMenuItem.Create(Self);
    miTools.Caption := resMenuTools;
    Self.Menu.Items.Add(miTools);
  end;

  if miChangeLang = nil then
  begin
    miChangeLang := TMenuItem.Create(Self);
    // Zmìnit jazyk
    miChangeLang.Caption := resMenuChangeLanguage;
    miTools.Add(miChangeLang);
  end;

  if not MyOpenQuery(dmCommon.qrSlng) then
  begin
    Exit;
  end;

  dmCommon.qrSlng.First;

  // Vytvoøit položky menu a popup menu
  while not dmCommon.qrSlng.Eof do
  begin
    miLang := TMenuItem.Create(Self);
    miLang2 := TMenuItem.Create(Self);
    miLang.Caption := dmCommon.qrSlng.FieldByName('lng_s_name').AsString;
    miLang.Hint := dmCommon.qrSlng.FieldByName('lng_s_name').AsString;
    miLang2.Caption := dmCommon.qrSlng.FieldByName('lng_s_name').AsString;
    miLang2.Hint := dmCommon.qrSlng.FieldByName('lng_s_name').AsString;
    miLang.Tag := dmCommon.qrSlng.FieldByName('lng_n_id').AsInteger;
    miLang2.Tag := dmCommon.qrSlng.FieldByName('lng_n_id').AsInteger;

    if dmCommon.qrSlng.FieldByName('lng_s_code').AsString = dmCommon.Languages.UserLanguageCode then
    begin
      if LangToolButton <> nil then
      begin
        LangToolButton.Hint := dmCommon.qrSlng.FieldByName('lng_s_name').AsString;
      end;

      miLang.Checked := True;
      miLang2.Checked := True;
    end;

    for lnIndex := 0 to Length(csFlags) - 1 do
    begin
      if csFlags[lnIndex] = dmCommon.qrSlng.FieldByName('lng_s_code').AsString then
      begin
        miLang.ImageIndex := Self.Menu.Images.Count - Length(csFlags) + lnIndex;
        miLang2.ImageIndex := miLang.ImageIndex;

        if (LangToolButton <> nil) and (csFlags[lnIndex] = dmCommon.Languages.UserLanguageCode) then
        begin
          LangToolButton.ImageIndex := miLang.ImageIndex;
        end;

        Break;
      end;
    end;

    miLang.OnClick := DoChangeLanguage;
    miLang2.OnClick := DoChangeLanguage;

    miChangeLang.Add(miLang);
    PopUpMenu.Items.Add(miLang2);
    dmCommon.qrSlng.Next;
  end;
end;
{$ENDIF}

{$IFDEF MULTILANGUAGE}
function TdmCommon.InitTranslate(const p_sModuleName: String): Boolean;
// Lokalizace formuláøe, pøeklad resourcestringù
begin
  ModuleName := p_sModuleName;

  if Languages.GetResourcestringStringList(slResourceString, ModuleName, Self.Name) then
  begin
    Languages.TranslateForm(Self, ModuleName);
    TranslateResourceStrings;
    Languages.TranslateResourceStrings;
    Result := True;
  end else
  begin
    Result := False;
  end;
end;
{$ENDIF}

procedure TdmCommon.TranslateResourceStrings;
begin
  {$IFDEF MULTILANGUAGE}
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resError),
    dmCommon.Languages.GetResourceStringValue('resError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resInformation),
    dmCommon.Languages.GetResourceStringValue('resInformation', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resQuestion),
    dmCommon.Languages.GetResourceStringValue('resQuestion', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resWarning),
    dmCommon.Languages.GetResourceStringValue('resWarning', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resConfirmation),
    dmCommon.Languages.GetResourceStringValue('resConfirmation', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resButtonOk),
    dmCommon.Languages.GetResourceStringValue('resButtonOk', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resButtonYes),
    dmCommon.Languages.GetResourceStringValue('resButtonYes', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resButtonNo),
    dmCommon.Languages.GetResourceStringValue('resButtonNo', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resTextNotFound),
    dmCommon.Languages.GetResourceStringValue('resTextNotFound', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resTextNotFounda),
    dmCommon.Languages.GetResourceStringValue('resTextNotFounda', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resTextNotFoundo),
    dmCommon.Languages.GetResourceStringValue('resTextNotFoundo', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resTextNotFounde),
    dmCommon.Languages.GetResourceStringValue('resTextNotFounde', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrInteger),
    dmCommon.Languages.GetResourceStringValue('resErrInteger', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrDate),
    dmCommon.Languages.GetResourceStringValue('resErrDate', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrTime),
    dmCommon.Languages.GetResourceStringValue('resErrTime', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrNegativeValue),
    dmCommon.Languages.GetResourceStringValue('resErrNegativeValue', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrPositiveValue),
    dmCommon.Languages.GetResourceStringValue('resErrPositiveValue', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrLoadFormPosition),
    dmCommon.Languages.GetResourceStringValue('resErrLoadFormPosition', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrSaveFormPosition),
    dmCommon.Languages.GetResourceStringValue('resErrSaveFormPosition', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrorSavingGridSettings),
    dmCommon.Languages.GetResourceStringValue('resErrorSavingGridSettings', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrorSavingDefaultGridSettings),
    dmCommon.Languages.GetResourceStringValue('resErrorSavingDefaultGridSettings', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resFormatError),
    dmCommon.Languages.GetResourceStringValue('resFormatError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resFormatErrorLog),
    dmCommon.Languages.GetResourceStringValue('resFormatErrorLog', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resErrorSearchingModule),
    dmCommon.Languages.GetResourceStringValue('resErrorSearchingModule', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlDeleteNotPermitted_1),
    dmCommon.Languages.GetResourceStringValue('resSqlDeleteNotPermitted_1', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlDeleteNotPermitted_2),
    dmCommon.Languages.GetResourceStringValue('resSqlDeleteNotPermitted_2', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlDeleteNotPermitted_3),
    dmCommon.Languages.GetResourceStringValue('resSqlDeleteNotPermitted_3', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlDeleteError),
    dmCommon.Languages.GetResourceStringValue('resSqlDeleteError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resModuleLoginError),
    dmCommon.Languages.GetResourceStringValue('resModuleLoginError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDatabaseConnection),
    dmCommon.Languages.GetResourceStringValue('resDatabaseConnection', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlConnectionError),
    dmCommon.Languages.GetResourceStringValue('resSqlConnectionError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlConnectionDetailsError),
    dmCommon.Languages.GetResourceStringValue('resSqlConnectionDetailsError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlQueryError),
    dmCommon.Languages.GetResourceStringValue('resSqlQueryError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlRepeatQuery),
    dmCommon.Languages.GetResourceStringValue('resSqlRepeatQuery', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlCommunicationError),
    dmCommon.Languages.GetResourceStringValue('resSqlCommunicationError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resModuleClosed),
    dmCommon.Languages.GetResourceStringValue('resModuleClosed', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resLogSqlCommunicationError),
    dmCommon.Languages.GetResourceStringValue('resLogSqlCommunicationError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resConfigurationChecking),
    dmCommon.Languages.GetResourceStringValue('resConfigurationChecking', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDataLoading),
    dmCommon.Languages.GetResourceStringValue('resDataLoading', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resWrongConfiguration),
    dmCommon.Languages.GetResourceStringValue('resWrongConfiguration', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resWrongImpelementation),
    dmCommon.Languages.GetResourceStringValue('resWrongImpelementation', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resModulePermissionError),
    dmCommon.Languages.GetResourceStringValue('resModulePermissionError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMaxRunningModulesError),
    dmCommon.Languages.GetResourceStringValue('resMaxRunningModulesError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMultipleRunningModuleError),
    dmCommon.Languages.GetResourceStringValue('resMultipleRunningModuleError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resWorksiteCheckingError),
    dmCommon.Languages.GetResourceStringValue('resWorksiteCheckingError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDatabaseVersion),
    dmCommon.Languages.GetResourceStringValue('resDatabaseVersion', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resXmlFilesFilter),
    dmCommon.Languages.GetResourceStringValue('resXmlFilesFilter', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resCvsFilesFilter),
    dmCommon.Languages.GetResourceStringValue('resCvsFilesFilter', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resXlsFilesFilter),
    dmCommon.Languages.GetResourceStringValue('resXlsFilesFilter', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resFileExistOverwrite),
    dmCommon.Languages.GetResourceStringValue('resFileExistOverwrite', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resFileOverwriteError),
    dmCommon.Languages.GetResourceStringValue('resFileOverwriteError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlDeleteErrorLog),
    dmCommon.Languages.GetResourceStringValue('resSqlDeleteErrorLog', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlConnErrorLog),
    dmCommon.Languages.GetResourceStringValue('resSqlConnErrorLog', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resSqlConnErrorDetailsLog),
    dmCommon.Languages.GetResourceStringValue('resSqlConnErrorDetailsLog', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resWorksiteCheckingErrorLog),
    dmCommon.Languages.GetResourceStringValue('resWorksiteCheckingErrorLog', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMenuTools),
    dmCommon.Languages.GetResourceStringValue('resMenuTools', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMenuChangeLanguage),
    dmCommon.Languages.GetResourceStringValue('resMenuChangeLanguage', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resStartApplicationError),
    dmCommon.Languages.GetResourceStringValue('resStartApplicationError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resStoredProcedureError),
    dmCommon.Languages.GetResourceStringValue('resStoredProcedureError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDeleteQuery),
    dmCommon.Languages.GetResourceStringValue('resDeleteQuery', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resComputerNotFound),
    dmCommon.Languages.GetResourceStringValue('resComputerNotFound', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resNoActivityPermissionError),
    dmCommon.Languages.GetResourceStringValue('resNoActivityPermissionError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resNoRunModulePermissionError),
    dmCommon.Languages.GetResourceStringValue('resNoRunModulePermissionError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resReportJobAddError),
    dmCommon.Languages.GetResourceStringValue('resReportJobAddError', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resReportJobAdded),
    dmCommon.Languages.GetResourceStringValue('resReportJobAdded', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resReadOnlyDb),
    dmCommon.Languages.GetResourceStringValue('resReadOnlyDb', slResourceString));

  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthJanuary),
    dmCommon.Languages.GetResourceStringValue('resMonthJanuary', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthFebruary),
    dmCommon.Languages.GetResourceStringValue('resMonthFebruary', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthMarch),
    dmCommon.Languages.GetResourceStringValue('resMonthMarch', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthApril),
    dmCommon.Languages.GetResourceStringValue('resMonthApril', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthMay),
    dmCommon.Languages.GetResourceStringValue('resMonthMay', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthJune),
    dmCommon.Languages.GetResourceStringValue('resMonthJune', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthJuly),
    dmCommon.Languages.GetResourceStringValue('resMonthJuly', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthAugust),
    dmCommon.Languages.GetResourceStringValue('resMonthAugust', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthSeptember),
    dmCommon.Languages.GetResourceStringValue('resMonthSeptember', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthOctober),
    dmCommon.Languages.GetResourceStringValue('resMonthOctober', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthNovember),
    dmCommon.Languages.GetResourceStringValue('resMonthNovember', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resMonthDecember),
    dmCommon.Languages.GetResourceStringValue('resMonthDecember', slResourceString));

  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDaySunday),
    dmCommon.Languages.GetResourceStringValue('resDaySunday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDayMonday),
    dmCommon.Languages.GetResourceStringValue('resDayMonday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDayTuesday),
    dmCommon.Languages.GetResourceStringValue('resDayTuesday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDayWednesday),
    dmCommon.Languages.GetResourceStringValue('resDayWednesday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDayThursday),
    dmCommon.Languages.GetResourceStringValue('resDayThursday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDayFriday),
    dmCommon.Languages.GetResourceStringValue('resDayFriday', slResourceString));
  dmCommon.Languages.DoTranslateResourceStrings(PResStringRec(@resDaySaturday),
    dmCommon.Languages.GetResourceStringValue('resDaySaturday', slResourceString));
  {$ENDIF}
end;

function TdmCommon.GetLanguageFromWorkComplex(p_nWcxId: Integer): Variant;
// Nové pracovištì, poèítaè a uživatel má jazyk nastavený podle jeho provozu
var
  qrSwcx: TADODataSet;
begin
  Result := False;
  qrSwcx := TADODataSet.Create(Self);

  try
    qrSwcx.Name := 'qrSwcx';
    qrSwcx.Connection := cnOperatorConnection;
    qrSwcx.Close;
    qrSwcx.CommandText :=
      'SELECT lng_n_id ' +
      'FROM ws.t_wcx_work_complexes ' +
      'WHERE wcx_n_id = ' + IntToStr(p_nWcxId);

    if not MyOpenQuery(qrSwcx) then
    begin
      Exit;
    end;

    Result := qrSwcx.FieldByName('lng_n_id').AsVariant;
    qrSwcx.Close;
  finally
    qrSwcx.Free;
  end;
end;

function ReplaceSpecialCharacters(p_sInputString: String): String;
// Funkce konvertuje znaky \xHH na znaky zalomení øádku
var
  lsInputString: String;
begin
  lsInputString := p_sInputString;
  // \x0D
  lsInputString := StringReplace(lsInputString, '\x0D', #13#10, [rfReplaceAll]);
  lsInputString := StringReplace(lsInputString, '\x0d', #13#10, [rfReplaceAll]);

  // \x0A
  lsInputString := StringReplace(lsInputString, '\x0A', #10, [rfReplaceAll]);
  lsInputString := StringReplace(lsInputString, '\x0a', #10, [rfReplaceAll]);

  // \x09
  lsInputString := StringReplace(lsInputString, '\x09', #09, [rfReplaceAll]);

  Result := lsInputString;
end;

function Format(const Format: String; const Args: array of const): String;
// nahrazení standardní funkce pro formát øetìzce, chyby zapisuje do logu
begin
  try
    FmtStr(Result, ReplaceSpecialCharacters(Format), Args);
  except
    on E: Exception do
    begin
      Result := Format;
      dmCommon.WriteToLog(PResStringRec(@resFormatErrorLog), 'resFormatErrorLog', [E.Message]);
    end;
  end;
end;

function TdmCommon.ChangeLanguage: Boolean;
// Lokalizace všech inicializovaných formuláøù v aplikaci
{$IFDEF MULTILANGUAGE}
var
  lnIndex: Integer;
  lDataModule: TDataModule;
  slStringList: THashedStringList;
  lmProc: TMethod;
  lsDatabaseVersion: String;
  lObject: TObject;
{$ENDIF}
begin
  Result := True;

  {$IFNDEF MULTILANGUAGE}
  // Modul není vícejazyèný
  Exit;
  {$ENDIF}

  {$IFDEF MULTILANGUAGE}
  if not Languages.TranslateResourceStrings then
  begin
    Result := False;
    gbTerminate := True;
    Application.Terminate;
    Exit;
  end;

  // Inicializované datové moduly aplikace
  for lnIndex := 0 to Screen.DataModuleCount - 1 do
  begin
    lDataModule := Screen.DataModules[lnIndex];

    if IsPublishedProp(lDataModule, 'ResourceStringList') and IsPublishedProp(lDataModule, 'ModuleName') then
    begin
      slStringList := GetObjectProp(lDataModule, 'ResourceStringList') as THashedStringList;

      if not Languages.GetResourcestringStringList(slStringList, GetStrProp(lDataModule, 'ModuleName'), lDataModule.Name) then
      begin
        Result := False;
        Exit;
      end;

      if not Languages.TranslateForm(lDataModule, GetStrProp(lDataModule, 'ModuleName')) then
      begin
        Result := False;
        Exit;
      end;
    end;

    lmProc.Data := lDataModule;
    lmProc.Code := lDataModule.MethodAddress('TranslateResourceStrings');

    if Assigned(lmProc.Code) then
    begin
      TDataModuleMethod(lmProc);
    end;
  end;

  // Pøeklad jmen mìsícù...
  LongMonthNames[1] := resMonthJanuary;
  LongMonthNames[2] := resMonthFebruary;
  LongMonthNames[3] := resMonthMarch;
  LongMonthNames[4] := resMonthApril;
  LongMonthNames[5] := resMonthMay;
  LongMonthNames[6] := resMonthJune;
  LongMonthNames[7] := resMonthJuly;
  LongMonthNames[8] := resMonthAugust;
  LongMonthNames[9] := resMonthSeptember;
  LongMonthNames[10] := resMonthOctober;
  LongMonthNames[11] := resMonthNovember;
  LongMonthNames[12] := resMonthDecember;

  // ... a dnù
  LongDayNames[1] := resDaySunday;
  LongDayNames[2] := resDayMonday;
  LongDayNames[3] := resDayTuesday;
  LongDayNames[4] := resDayWednesday;
  LongDayNames[5] := resDayThursday;
  LongDayNames[6] := resDayFriday;
  LongDayNames[7] := resDaySaturday;

  // Zkratky dnù - po, út, st...
  ShortDayNames[1] := Copy(resDaySunday, 1, 2);
  ShortDayNames[2] := Copy(resDayMonday, 1, 2);
  ShortDayNames[3] := Copy(resDayTuesday, 1, 2);
  ShortDayNames[4] := Copy(resDayWednesday, 1, 2);
  ShortDayNames[5] := Copy(resDayThursday, 1, 2);
  ShortDayNames[6] := Copy(resDayFriday, 1, 2);
  ShortDayNames[7] := Copy(resDaySaturday, 1, 2);

  // Inicializované formuláøe aplikace
  for lnIndex := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[lnIndex] is TMultiLangForm then
    begin
      if not (Screen.Forms[lnIndex] as TMultiLangForm).TranslateForm then
      begin
        Result := False;
      end;
    end;

    if Application.MainForm = Screen.Forms[lnIndex] then
    begin
      lObject := Screen.Forms[lnIndex].FindComponent('stbMain');

      if (lObject <> nil) and (lObject is TStatusBar) then // Lokalizace textu "Verze databáze"
      begin
        lsDatabaseVersion := GetValueFromDatabaseConfiguration('s_version');

        // WiPr... %s, verze: %s
        // Ostatní... Databáze: %s, verze: %s
        (lObject as TStatusBar).Panels[2].Text := Format(resDatabaseVersion, ['\\' + gsServer + '\' + gsDatabase, lsDatabaseVersion]);
      end;
    end;
  end;
  {$ENDIF}
end;

procedure DoWriteToLog(p_sMessage: String; p_sLogType: String = '');
// Zapíše do logu
var
  lsFileName: String;
  lsComputerName: String;
  lsMonth: String;
begin
  // Nahradit znaky konce øádkù mezerou
  p_sMessage := StringReplace(p_sMessage, #13, ' ', [rfReplaceAll]);

  // Název PC
  if Trim(gsComputerName) <> '' then
  begin
    lsComputerName := gsComputerName;
  end else
  begin
    lsComputerName := GetComputerName;
  end;

  lsComputerName := Trim(lsComputerName);

  // Mìsíc yyyymm
  lsMonth := FormatDateTime('yyyymm', Now);
  lsFileName := ExtractFilePath(Application.ExeName) + 'Log\';
  ForceDirectories(lsFileName);
  lsFileName := lsFileName + lsComputerName;

  // Kód provozu
  if gsComplexCode <> '' then
  begin
    lsFileName := lsFileName + '_' + gsComplexCode;
  end;

  lsFileName := lsFileName + '_' + lsMonth + '_' + ChangeFileExt(ExtractFileName(Application.ExeName), '');

  if Trim(p_sLogType) <> '' then
  begin
    lsFileName := lsFileName + '_' + p_sLogType;
  end;

  lsFileName := lsFileName + '.log';

  try
    // Encoding Default není unicode
    TFile.AppendAllText(lsFileName, FormatDateTime('dd.mm.yyyy hh:nn:ss.zzz', Now) + ' ' + p_sMessage + #13#10, TEncoding.Default);
  except
  end;
end;

function GetFrmMainStatusPanel: String;
begin
  if Trim(gsComplexCode) = '' then
  // nelze nalézt kód provozu
  begin
    if Trim(gsComplexName) = '' then
    // nelze nalézt ani název provozu => použít název firmy
    begin
      if Trim(gsCompanyName) <> '' then
      begin
        Result := gsCompanyName;
      end;
    end else
    begin
      Result := gsComplexName;
    end;
  end else
  begin
    Result := gsComplexName + ' (' + gsComplexCode + ')';
  end;
end;

function TdmCommon.GetComputerId: Integer;
// vrátí ID poèítaèe bez wcx (pro)
var
  qrScmp: TADODataSet;
begin
  Result := 0;
  qrScmp := TADODataSet.Create(Self);

  try
    qrScmp.Name := 'qrScmp';
    qrScmp.Connection := cnSystemConnection;
    qrScmp.Close;
    qrScmp.CommandText :=
      'SELECT cmp_n_id ' +
      'FROM ws.t_cmp_computers ' +
      'WHERE UPPER(cmp_s_name) = UPPER(' + MyQuotedStr(gsComputerName) + ')';

    if not MyOpenQuery(qrScmp, True, True, False) then
    begin
      Exit;
    end;

    Result := qrScmp.FieldByName('cmp_n_id').AsInteger;
    qrScmp.Close;
  finally
    qrScmp.Free;
  end;
end;

procedure TdmCommon.ShowAbout(p_bScreenCenter: Boolean = False);
begin
  Application.CreateForm(TfrmAbout, frmAbout);

  try
    if p_bScreenCenter then
    begin
      // Display the about form in the screen center
      frmAbout.gbPositionLoaded := True;
    end;

    frmAbout.ShowModal;
  finally
    frmAbout.Free;
  end;
end;

procedure TdmCommon.HideSplash;
begin
  frmSplash.HideSplash;
end;

function MyDateToStr(p_dtDateTime: TDateTime; p_sShortDateFormat: String = ''): String;
// Conversion from date to string
// Parameter p_sShortDateFormat should be used for use in SQL query and should be empty for dataset parameters
var
  lFormatSettings: TFormatSettings;
begin
  if p_sShortDateFormat = '' then
  begin
    // Použít systémový formát data
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);

    if Pos('.', lFormatSettings.ShortDateFormat) > 0 then
    begin
      // If the date format is for example "dd. mm. yyyy", the date separator is set to "/". This is reason of this check.
      // Short date format contains "." => set this date separator
      lFormatSettings.DateSeparator := '.';
    end;

    Result := FormatDateTime(lFormatSettings.ShortDateFormat, p_dtDateTime)
  end else
  begin
    // Použít zadaný formát data
    Result := FormatDateTime(p_sShortDateFormat, p_dtDateTime)
  end;
end;

function MyDateTimeToStr(p_dtDateTime: TDateTime; p_sShortDateFormat: String = ''; p_bMiliSeconds: Boolean = True): String;
// Pøevod datumu na text pro zápis do databáze
// Parameter p_sShortDateFormat should be used for use in SQL query and should be empty for dataset parameters
var
  lFormatSettings: TFormatSettings;
  lsTimeFormat: String;
begin
  lsTimeFormat := 'hh:mm:ss';

  if p_bMiliSeconds then
  begin
    lsTimeFormat := lsTimeFormat + '.zzz';
  end;


  if p_sShortDateFormat = '' then
  begin
    // Použít systémový formát data
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);

    if Pos('.', lFormatSettings.ShortDateFormat) > 0 then
    begin
      // If the date format is for example "dd. mm. yyyy", the date separator is set to "/". This is reason of this check.
      // Short date format contains "." => set this date separator
      lFormatSettings.DateSeparator := '.';
    end;

    Result := FormatDateTime(lFormatSettings.ShortDateFormat + ' ' + lsTimeFormat, p_dtDateTime)
  end else
  begin
    // Použít zadaný formát data
    Result := FormatDateTime(p_sShortDateFormat + ' ' + lsTimeFormat, p_dtDateTime);
  end;
end;

function MyQuotedStr(p_sString: String): String;
// pøidá apostrofy na zaèátek a konec stringu
// pøed tím odstraní apostrofy na zaèátku a konci
var
  lsString: String;
begin
  lsString := p_sString;

  // odstranit apostrof na zaèátku
  if Copy(lsString, 1, 1) = '''' then
  begin
    lsString := Copy(lsString, 2, Length(lsString) - 1);
  end;

  // odstranit apostrof na konci
  if Copy(lsString, Length(lsString), 1) = '''' then
  begin
    lsString := Copy(lsString, 1, Length(lsString) - 1);
  end;

  Result := QuotedStr(lsString);
end;

procedure TdmCommon.SetLockTimeout(p_cnADOConnection: TADOConnection);
// nastaví timeout pro zámky v SQL Serveru (deadlocky)
var
  lADOCommand: TADOCommand;
begin
  // naèíst timeout [s] z ini, default = 5 s
  if Trim(gsLockTimeout) = '' then
  begin
    gsLockTimeout := LoadFromIni('MSSQL', 'LockTimeout', '5');
  end;

  lADOCommand := TADOCommand.Create(Self);

  try
    lADOCommand.Name := 'lADOCommand';
    lADOCommand.Connection := p_cnADOConnection;
    lADOCommand.CommandText := 'SET LOCK_TIMEOUT ' + IntToStr(MyStrToInt(gsLockTimeout) * 1000);
    lADOCommand.CommandType := cmdText;
    lADOCommand.Execute;
  finally
    lADOCommand.Free;
  end;
end;

procedure TdmCommon.cnOperatorConnectionAfterConnect(Sender: TObject);
// nastaví timeout pro zámky v SQL Serveru (deadlocky)
begin
  SetLockTimeout(TADOConnection(Sender));
end;

function IntToBinary(p_nValue: Integer): String;
// Pøevede èíslo na jeho binární reprezentaci
var
  i: Integer;
begin
  Result := '';

  for i := 0 to 7 do
  begin
    if Odd(p_nValue) then
    begin
      Result := '1' + Result
    end else
    begin
      Result := '0' + Result;
    end;

    p_nValue := p_nValue div 2;
  end;
end;

function HashString(p_sString: String): String;
// Zašifruje text metodou MD5 hash
var
  IdHashMessageDigest5: TIdHashMessageDigest5;
begin
  IdHashMessageDigest5 := TIdHashMessageDigest5.Create;

  try
    Result := LowerCase(IdHashMessageDigest5.HashStringAsHex(p_sString));
  finally
    IdHashMessageDigest5.Free;
  end;
end;

procedure TMultiLangForm.DoAfterLanguageChange;
begin
  // Urèeno pro override
end;

function MyRoundTo(p_rValue: Double; p_nDecimals: ShortInt): Double;
// Zaokrouhlení èísla
// MÈ 26.5.2009
// RoundTo se mi zdálo, že zlobí
// p_rValue: hodnota, která se bude zaokrouhlovat
// p_nDecimals: na jakou hodnotu se bude zaokrouhlovat, minimální hodnota = -16
//        napø. 123,456 na 1 = 120; 123,456 na -1 = 123,5
var
  lrValue: Double;
begin
  lrValue := 0;

  if p_nDecimals >= 0 then
  begin
    // ubrat urèitý poèet nul
    lrValue := p_rValue / Power(10, p_nDecimals);
  end else
  if p_nDecimals < 0 then
  begin
    // pøidat urèitý poèet nul
    lrValue := p_rValue * Power(10, Abs(p_nDecimals));
  end;

  // zaokrouhlit na celé èíslo
  lrValue := Round(lrValue);

  if p_nDecimals >= 0 then
  begin
    // Pøidat urèitý poèet nul
    lrValue := lrValue * Power(10, p_nDecimals);
  end else
  if p_nDecimals < 0 then
  begin
    // Ubrat urèitý poèet nul
    lrValue := lrValue / Power(10, Abs(p_nDecimals));
  end;

  Result := lrValue;
end;

function TdmCommon.DeleteOldMails: Boolean;
// vymaže 10 dnù staré záznamy z tabulky zpráv t_mls_mails
// mažou se jen zprávy typu 3, 4
var
  spDmls_old: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spDmls_old := TADOStoredProc.Create(Self);

  try
    spDmls_old.Name := 'spDmls_old';
    spDmls_old.Connection := dmCommon.cnOperatorConnection;
    spDmls_old.ProcedureName := CorrectSQL('ps.sp_d_mls_old');
    spDmls_old.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);

    if not MyExecProc(spDmls_old) then
    begin
      Exit;
    end;

    lnReturn := spDmls_old.Parameters.ParamValues['@RETURN_VALUE'];

    case lnReturn of
      1:
      begin
        // ok
      end else
      begin
        // Chyba è. %s pøi volání uložené procedry %s!
        MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_d_mls_old']), mtError);
      end;
    end;
  finally
    spDmls_old.Free;
  end;

  Result := lnReturn = 1;
end;

function MyBooleanToStr(p_bBoolean: Boolean; p_nType: Byte = 1): String;
// pøevod Boolean hodnoty na text
// p_nType: 1 = 0/1, 2 = Ne/Ano, 3 = False/True
begin
  if p_bBoolean then
  begin
    case p_nType of
      2: Result := 'Ano';
      3: Result := 'True';
      else Result := '1';
    end;
  end else
  begin
    case p_nType of
      2: Result := 'Ne';
      3: Result := 'False';
      else Result := '0';
    end;
  end;
end;

function TMultiLangForm.ShowModal: Integer;
var
  lnSavedFlags: Integer;
  lfSavedForm: TForm;
begin
  if gbIsWindows7 then
  begin
    lfSavedForm := gfCurrentModalForm;
    gfCurrentModalForm := Self;

    // Aby se pod Windows 7 nezobrazovala na hlavním panelu tlaèítka i pro otevøená modální okna
    lnSavedFlags := getWindowLong(Handle, GWL_EXSTYLE);
    SetWindowLong(Handle, GWL_EXSTYLE, lnSavedFlags and not WS_EX_APPWINDOW);
    Result := inherited ShowModal;
    SetWindowLong(Handle, GWL_EXSTYLE, lnSavedFlags) ;
    gfCurrentModalForm := lfSavedForm;
  end else
  begin
    Result := inherited ShowModal;
  end;
end;

procedure TMultiLangForm.ResizeForm(p_rScale: Real);
begin
  ResizeForm(Self, p_rScale);
end;

procedure TMultiLangForm.ResizeForm(p_Component: TComponent; p_rScale: Real);
// Pøepoèítá velikost formu a komponent
var
  i: Integer;
  lcControl: TControlWithFont;
  lnWidth: Integer;
begin
  if p_Component is TControl then
  begin
    lcControl := TControlWithFont(p_Component);

    if not lcControl.ParentFont then
    begin
      lcControl.Font.Height := Trunc(lcControl.Font.Height * p_rScale);
    end;

    if not (p_Component is TForm) then
    begin
      lcControl.Left := Trunc(lcControl.Left * p_rScale);
      lcControl.Top := Trunc(lcControl.Top * p_rScale);

      lcControl.Width := Trunc(lcControl.Width * p_rScale);
      lcControl.Height := Trunc(lcControl.Height * p_rScale);
    end else
    begin
      lcControl.ClientWidth := Trunc(lcControl.ClientWidth * p_rScale);
      lcControl.ClientHeight := Trunc(lcControl.ClientHeight * p_rScale);
    end;

    if p_Component is TControlBar then
    begin
      TControlBar(p_Component).RowSize := Trunc(TControlBar(p_Component).RowSize * p_rScale);
    end;

    if p_Component is TToolBar then
    begin
      TToolBar(p_Component).ButtonWidth := Trunc(TToolBar(p_Component).ButtonWidth * p_rScale);
      TToolBar(p_Component).ButtonHeight := Trunc(TToolBar(p_Component).ButtonHeight * p_rScale);
    end;

    if p_Component is TLabel then
    begin
      // srovnat výšku labelù
      lnWidth := TLabel(p_Component).Width;
      TLabel(p_Component).AutoSize := True;
      TLabel(p_Component).AutoSize := False;
      TLabel(p_Component).Width := lnWidth;
    end;
  end;

  // Rekurzivnì zavolám pro všechny dìti
  for i := 0 to p_Component.ComponentCount - 1 do
  begin
    ResizeForm(p_Component.Components[i], p_rScale);
  end;
end;

function CheckIntegerCharacters(p_sString: String): Boolean;
// Kontrola, jestli jsou všechny znaky stringu èísla od 0 do 9
var
  lsCharacter: Char;
  i: Integer;
begin
  Result := True;

  for i := 1 to Length(p_sString) do
  begin
    lsCharacter := p_sString[i];

    if not CharInSet(lsCharacter, ['0'..'9']) then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

{$IFDEF MULTILANGUAGE}
function TdmCommon.SetUserLanguage: Boolean;
begin
  Result := False;

  dmCommon.fnSget_usr_lang.ProcedureName := CorrectSQL('ws.fn_s_get_usr_language');
  dmCommon.fnSget_usr_lang.Parameters.Clear;
  dmCommon.fnSget_usr_lang.Parameters.CreateParameter('@RETURN_VALUE', ftString, pdReturnValue, 250, Result);
  dmCommon.fnSget_usr_lang.Parameters.CreateParameter('@p_n_user_id', ftInteger, pdInput, SizeOf(Integer), gnUserId);

  if MyExecProc(dmCommon.fnSget_usr_lang) then
  begin
    if dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE'] <> dmCommon.FLanguages.UserLanguageCode then
    begin
      dmCommon.FLanguages.UserLanguageCode := dmCommon.fnSget_usr_lang.Parameters.ParamValues['@RETURN_VALUE'];
    end;

    dmCommon.fnSget_usr_lang.Close;
    Result := True;
  end;
end;
{$ENDIF}

function MyStrToDateTime(p_sDateTime: String; p_sShortDateFormat: String = ''; p_sDateSeparator: Char = '.'): TDateTime;
var
  lFormatSettings: TFormatSettings;
begin
  if p_sDateTime = '' then
  begin
    Result := 0;
  end else
  begin
    // Read Windows settings
    GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, lFormatSettings);

    if Pos('.', lFormatSettings.ShortDateFormat) > 0 then
    begin
      // If the date format is for example "dd. mm. yyyy", the date separator is set to "/". This is reason of this check.
      // Short date format contains "." => set this date separator
      lFormatSettings.DateSeparator := '.';
    end;

    if p_sShortDateFormat <> '' then
    begin
      // Použít zadaný formát data
      lFormatSettings.ShortDateFormat := p_sShortDateFormat;
      lFormatSettings.DateSeparator := p_sDateSeparator;
    end;

    if not TryStrToDateTime(p_sDateTime, Result, lFormatSettings) then
    begin
      Result := 0;
    end;
  end;
end;

function Split(p_sInput: String; p_cDelimiter: Char): TStringList;
// Rozdìlí String podle oddìlovaèe na nìkolik èástí
// Napø. "A/B/C/D" na "A", "B", "C", "D"
var
  lsStringList: TStringList;
begin
  lsStringList := TStringList.Create;
  lsStringList.Delimiter := p_cDelimiter;
  // Kvùli mezerám
  lsStringList.StrictDelimiter := True;
  lsStringList.DelimitedText := p_sInput;
  Result := lsStringList;
end;

procedure GetFileInfo(psFileName: String; var FileInfoArray: TFileInfo);
const
  InfoArray: array [1..12] of String =
    (
    'Comments',
    'CompanyName',
    'FileDescription',
    'FileVersion',
    'InternalName',
    'LegalCopyright',
    'LegalTrademarks',
    'OriginalFileName',
    'PrivateBuild',
    'ProductName',
    'ProductVersion',
    'SpecialBuild'
    );
var
  pHandle: UINT;
  pSize: UINT;
  pLength: UINT;
  i: Integer;
  lsVersion: PChar;
  pInfo: Pointer;
begin
  pSize := GetFileVersionInfoSize(PChar(psFileName), pHandle);
  lsVersion := StrAlloc(pSize);

  try
    GetFileVersionInfo(PChar(psFileName), 0, pSize, lsVersion);

    for i := 1 to High(InfoArray) do
    begin
      VerQueryValue(lsVersion, PChar('\\StringFileInfo\040504E2\\' + InfoArray[i]), pInfo, pLength);
      FileInfoArray[i] := PChar(pInfo);
    end;
  except
  end;

  StrDispose(lsVersion);
end;

function TdmCommon.UpdateDatabaseConfiguration(p_sCode, p_sValue: String): Boolean;
var
  qrUDcf: TADOStoredProc;
  lnResult: Integer;
begin
  qrUDcf := TADOStoredProc.Create(Self);
  Result := False;
  lnResult := 0;

  try
    qrUDcf.Name := 'qrUDcf';
    qrUDcf.Connection := dmCommon.cnOperatorConnection;
    qrUDcf.ProcedureName := 'ws.sp_u_dcf';

    qrUDcf.Parameters.Clear;
    qrUDcf.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), lnResult);
    qrUDcf.Parameters.CreateParameter('@p_s_dcf_code', ftString, pdInput, 20, p_sCode);
    qrUDcf.Parameters.CreateParameter('@p_s_value', ftString, pdInput, 250, p_sValue);

    MyExecProc(qrUDcf);
    lnResult := qrUDcf.Parameters.ParamByName('@RETURN_VALUE').Value;
  finally
    qrUDcf.Free;
  end;

  if lnResult < 0 then
  begin
    // Chyba è. %s pøi volání uložené procedry %s!
    MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnResult), 'sp_u_dcf']), mtError);
  end;

  if lnResult > 0 then
  begin
    Result := False;
  end;
end;

end.

