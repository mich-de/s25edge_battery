@echo off
REM ═══════════════════════════════════════════════════════════════════
REM S25 EDGE BATTERY OPTIMIZER — Full Restoration Script v3.0
REM Reverts all changes back to Samsung One UI 9 factory defaults.
REM ═══════════════════════════════════════════════════════════════════

set ADB="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB="%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB=adb

echo [%DATE% %TIME%] === S25 EDGE RESTORATION v3.0 ===
echo Re-enabling all packages and restoring system defaults...
echo.

REM ── 1. RE-ENABLE SAMSUNG BLOATWARE ─────────────────────────────────
echo [1/4] Re-enabling Samsung bloatware and services...
%ADB% shell pm enable com.samsung.android.bixby.agent
%ADB% shell pm enable com.samsung.android.bixby.wakeup
%ADB% shell pm enable com.samsung.android.bixbyvision.framework
%ADB% shell pm enable com.samsung.android.visionintelligence
%ADB% shell pm enable com.samsung.android.game.gametools
%ADB% shell pm enable com.samsung.android.game.gos
%ADB% shell pm enable com.samsung.android.smartsuggestions
%ADB% shell pm enable com.samsung.android.rubin.app
%ADB% shell pm enable com.samsung.android.bbc.bbcagent
%ADB% shell pm enable com.samsung.android.app.reminder
%ADB% shell pm enable com.samsung.android.app.routines
%ADB% shell pm enable com.samsung.android.app.routineplus
%ADB% shell pm enable com.samsung.android.forest
%ADB% shell pm enable com.samsung.android.liveeffectservice
%ADB% shell pm enable com.samsung.android.app.updatecenter
%ADB% shell pm enable com.samsung.android.scpm
%ADB% shell pm enable com.samsung.android.statsd
%ADB% shell pm enable com.sec.enterprise.knox.attestation
%ADB% shell pm enable com.samsung.android.knox.kpecore
%ADB% shell pm enable com.samsung.android.knox.pushmanager
%ADB% shell pm enable com.samsung.android.knox.containercore
%ADB% shell pm enable com.samsung.android.knox.analytics.uploader
%ADB% shell pm enable com.samsung.android.oneconnect
%ADB% shell pm enable com.samsung.android.service.stplatform
%ADB% shell pm enable com.samsung.accessory.budsunitemgr
%ADB% shell pm enable com.samsung.android.spayfw

REM ── 2. RE-ENABLE THIRD-PARTY APPS ──────────────────────────────────
echo [2/4] Re-enabling third-party apps...
%ADB% shell pm enable com.facebook.katana
%ADB% shell pm enable com.facebook.orca
%ADB% shell pm enable com.facebook.services
%ADB% shell pm enable com.facebook.system
%ADB% shell pm enable com.facebook.appmanager
%ADB% shell pm enable com.microsoft.emmx
%ADB% shell pm enable com.microsoft.office.excel
%ADB% shell pm enable com.microsoft.office.word
%ADB% shell pm enable com.microsoft.skydrive

REM ── 3. RESTORE DEFAULT SETTINGS ────────────────────────────────────
echo [3/4] Restoring One UI 9 system settings...
%ADB% shell settings put global sem_low_power_mode 0
%ADB% shell settings put global ram_expand_size 4
%ADB% shell settings put global window_animation_scale 1.0
%ADB% shell settings put global transition_animation_scale 1.0
%ADB% shell settings put global animator_duration_scale 1.0
%ADB% shell settings put global ble_scan_always_enabled 1
%ADB% shell settings put global wifi_scan_always_enabled 1
%ADB% shell settings put system nearby_scanning_enabled 1
%ADB% shell settings put global protect_battery 0

REM ── 4. RESET APPOPS ────────────────────────────────────────────────
echo [4/4] Resetting AppOps background restrictions...
%ADB% shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND default
%ADB% shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND default
%ADB% shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND default

echo.
echo ===================================================================
echo Restoration Complete! Please reboot your Galaxy S25 Edge.
echo ===================================================================
pause
