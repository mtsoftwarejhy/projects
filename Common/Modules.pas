{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula
 Module:       Kontrola spuštìných modulù
 File name:    Modules.pas

 Description:  Spuštìné moduly

 Author:       Michal Èervenka
 Creation:     30.04.2004
 Change:
   30.03.2025 MÈ - The procedure UpdateRunningModule is called with parameters
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Modules;

interface

uses
  Classes, SysUtils, ActiveX;

type
  ThdRunningModule = class(TThread)
  private
    { Private declarations }
    procedure UpdateTable;
  protected
    procedure Execute; override;
  end;

implementation

uses
  Common;

{ ThdRunningModule }

procedure ThdRunningModule.Execute;
begin
  CoInitialize(nil);

  // Spustit update min. jednou za 10 s
  if gnRefreshInterval >= 10 then
  begin
    repeat
      try
        if not dmCommon.cnSystemConnection.InTransaction then
        begin
          gCriticalSection.Acquire;
          // Aktualizace záznamu o tom, že je modul spuštìn
          UpdateTable;
          gCriticalSection.Release;
        end;

        // Uspat thread na urèitou dobu [ms]
        Sleep(gnRefreshInterval * 1000);
      except
      end;
    until Terminated = True;
  end;

  CoUnInitialize;
end;

procedure ThdRunningModule.UpdateTable;
// Aktualizace záznamu o tom, že je modul spuštìn
begin
  dmCommon.UpdateRunningModule(gsModuleCode, gnRunningModuleId);
end;

end.
