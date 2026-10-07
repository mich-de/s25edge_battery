@echo off
REM ═══════════════════════════════════════════════════════════════════
REM S25 EDGE BATTERY OPTIMIZER — RIPRISTINO COMPLETO v3.1
REM Riabilita tutti i pacchetti Samsung e ripristina le impostazioni di serie.
REM ═══════════════════════════════════════════════════════════════════

setlocal enabledelayedexpansion
set ADB="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB="%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB=adb

echo ===================================================================
echo   S25 EDGE — RIPRISTINO VALORI DI FABBRICA (One UI 9)
echo ===================================================================
echo.
echo Controllo connessione dispositivo ADB...
%ADB% devices
echo.

echo [1/4] Riabilitazione servizi e app Samsung...
for %%p in (
    com.samsung.android.bixby.agent
    com.samsung.android.bixby.wakeup
    com.samsung.android.bixbyvision.framework
    com.samsung.android.visionintelligence
    com.samsung.android.game.gametools
    com.samsung.android.game.gos
    com.samsung.android.smartsuggestions
    com.samsung.android.rubin.app
    com.samsung.android.bbc.bbcagent
    com.samsung.android.app.reminder
    com.samsung.android.app.notes
    com.samsung.android.calendar
    com.samsung.android.messaging
    com.samsung.android.honeyboard
    com.sec.android.app.samsungapps
    com.osp.app.signin
    com.sec.android.daemonapp
    com.samsung.android.weather
    com.sec.android.app.voicenote
    com.sec.android.app.shealth
    com.samsung.android.spayfw
    com.samsung.android.samsungpass
    com.samsung.android.app.cocktailbarservice
    com.samsung.android.oneconnect
    com.samsung.android.service.stplatform
    com.samsung.accessory.budsunitemgr
    com.samsung.android.mcfds
    com.samsung.android.app.sharelive
    com.samsung.android.app.updatecenter
    com.samsung.android.scpm
    com.samsung.android.statsd
    com.sec.enterprise.knox.attestation
    com.samsung.android.knox.kpecore
    com.samsung.android.knox.pushmanager
    com.samsung.android.knox.containercore
    com.samsung.android.knox.analytics.uploader
    com.samsung.android.forest
    com.samsung.android.liveeffectservice
    com.samsung.android.arzone
    com.samsung.android.aremoji
    com.samsung.android.livestickers
    com.samsung.android.kidsinstaller
) do (
    %ADB% shell pm enable %%p >nul 2>&1
)
echo   -> Servizi Samsung riabilitati.

echo [2/4] Riabilitazione bloatware Meta e Microsoft...
for %%p in (
    com.facebook.katana
    com.facebook.orca
    com.facebook.services
    com.facebook.system
    com.facebook.appmanager
    com.microsoft.emmx
    com.microsoft.office.excel
    com.microsoft.office.word
    com.microsoft.skydrive
) do (
    %ADB% shell pm enable %%p >nul 2>&1
)
echo   -> App terze riabilitate.

echo [3/4] Ripristino impostazioni di sistema One UI 9...
%ADB% shell settings put global sem_low_power_mode 0
%ADB% shell settings put global ram_expand_size 4096
%ADB% shell settings put global window_animation_scale 1.0
%ADB% shell settings put global transition_animation_scale 1.0
%ADB% shell settings put global animator_duration_scale 1.0
%ADB% shell settings put global ble_scan_always_enabled 1
%ADB% shell settings put global wifi_scan_always_enabled 1
%ADB% shell settings put system nearby_scanning_enabled 1
%ADB% shell settings put global protect_battery 0
echo   -> Impostazioni ripristinate (RAM Plus 4GB, profilo standard, animazioni 1.0x).

echo [4/4] Ripristino restrizioni AppOps...
%ADB% shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND default >nul 2>&1
%ADB% shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND default >nul 2>&1
%ADB% shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND default >nul 2>&1
echo   -> AppOps reimpostati sui valori predefiniti.

echo.
echo ===================================================================
echo   RIPRISTINO COMPLETATO! Riavvia il Galaxy S25 Edge.
echo ===================================================================
pause
