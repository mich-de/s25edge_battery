@echo off
REM ═══════════════════════════════════════════════════════════════════
REM S25 EDGE BATTERY OPTIMIZER & DEBLOAT SUITE — v3.0 (One UI 9)
REM Target Device: Galaxy S25 Edge / S25 Series | One UI 9 / Android 17
REM ═══════════════════════════════════════════════════════════════════
REM Preserved: 120Hz LTPO · 5G · Google Maps · Gmail · Google Wallet · Google Assistant/Gemini
REM Community Tips Applied:
REM   - Light Performance Profile (lower thermals & CPU power ceiling)
REM   - RAM Plus Disabled (0 GB) - eliminates UFS swap thrashing
REM   - Radio background scanning disabled (BLE, Wi-Fi sniffing)
REM   - One UI 9 RescueParty bug avoided (lool/dcapi safely preserved)
REM ═══════════════════════════════════════════════════════════════════
REM Instructions:
REM   1. Enable USB Debugging on your Galaxy S25 Edge (Settings > Developer Options)
REM   2. Connect phone via USB cable to PC
REM   3. Run this script in Administrator Command Prompt or PowerShell
REM   4. Reboot device when finished
REM ═══════════════════════════════════════════════════════════════════

set ADB="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB="%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe"
if not exist %ADB% set ADB=adb

echo [%DATE% %TIME%] === S25 EDGE BATTERY OPTIMIZER v3.0 (One UI 9) ===
echo Checking ADB connection...
%ADB% devices
echo.

REM ── 1. SAMSUNG BLOATWARE & AI DAEMONS ──────────────────────────────
echo [1/6] Disabling Samsung Bloatware & Galaxy AI Background Daemons...

REM Bixby Voice Assistant & Detection
%ADB% shell pm disable-user --user 0 com.samsung.android.bixby.agent
%ADB% shell pm disable-user --user 0 com.samsung.android.bixby.wakeup
%ADB% shell pm disable-user --user 0 com.samsung.android.bixbyvision.framework
%ADB% shell pm disable-user --user 0 com.samsung.android.visionintelligence

REM Game Optimizing Service & Game Tools
%ADB% shell pm disable-user --user 0 com.samsung.android.game.gametools
%ADB% shell pm disable-user --user 0 com.samsung.android.game.gos

REM Marketing, Recommendations & Analytics
%ADB% shell pm disable-user --user 0 com.samsung.android.smartsuggestions
%ADB% shell pm disable-user --user 0 com.samsung.android.rubin.app
%ADB% shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent
%ADB% shell pm disable-user --user 0 com.samsung.android.app.reminder
%ADB% shell pm disable-user --user 0 com.samsung.android.app.routines
%ADB% shell pm disable-user --user 0 com.samsung.android.app.routineplus
%ADB% shell pm disable-user --user 0 com.samsung.android.forest
%ADB% shell pm disable-user --user 0 com.samsung.android.liveeffectservice

REM OTA Experience App Push & Telemetry
%ADB% shell pm disable-user --user 0 com.samsung.android.app.updatecenter
%ADB% shell pm disable-user --user 0 com.samsung.android.scpm
%ADB% shell pm disable-user --user 0 com.samsung.android.statsd

REM Knox Background Telemetry & Attestation Loops
%ADB% shell pm disable-user --user 0 com.sec.enterprise.knox.attestation
%ADB% shell pm disable-user --user 0 com.samsung.android.knox.kpecore
%ADB% shell pm disable-user --user 0 com.samsung.android.knox.pushmanager
%ADB% shell pm disable-user --user 0 com.samsung.android.knox.containercore
%ADB% shell pm disable-user --user 0 com.samsung.android.knox.analytics.uploader

REM Continuity & Accessory daemons (Safe if Galaxy Buds / SmartThings not used)
%ADB% shell pm disable-user --user 0 com.samsung.android.oneconnect
%ADB% shell pm disable-user --user 0 com.samsung.android.service.stplatform
%ADB% shell pm disable-user --user 0 com.samsung.accessory.budsunitemgr

REM Samsung Pay framework (Google Wallet remains fully active)
%ADB% shell pm disable-user --user 0 com.samsung.android.spayfw

REM ── 2. CARRIER & THIRD-PARTY BLOATWARE ─────────────────────────────
echo [2/6] Disabling Facebook & Microsoft Background Bloatware...
%ADB% shell pm disable-user --user 0 com.facebook.katana
%ADB% shell pm disable-user --user 0 com.facebook.orca
%ADB% shell pm disable-user --user 0 com.facebook.services
%ADB% shell pm disable-user --user 0 com.facebook.system
%ADB% shell pm disable-user --user 0 com.facebook.appmanager
%ADB% shell pm disable-user --user 0 com.microsoft.emmx
%ADB% shell pm disable-user --user 0 com.microsoft.office.excel
%ADB% shell pm disable-user --user 0 com.microsoft.office.word
%ADB% shell pm disable-user --user 0 com.microsoft.skydrive

REM ── 3. COMMUNITY RECOMMENDED SYSTEM SETTINGS (One UI 9) ────────────
echo [3/6] Applying One UI 9 Community System Settings...

REM Performance Profile: Light Mode (Low Power / Thermal cap without breaking 120Hz)
%ADB% shell settings put global sem_low_power_mode 1

REM RAM Plus: Disable completely (0 GB) - prevents swap thrashing on UFS 4.0
%ADB% shell settings put global ram_expand_size 0

REM Adaptive Battery & App Standby
%ADB% shell settings put global adaptive_battery_management_enabled 1
%ADB% shell settings put global app_auto_restriction_enabled 1

REM Radio & Wireless scanning optimizations
%ADB% shell settings put global ble_scan_always_enabled 0
%ADB% shell settings put global wifi_scan_always_enabled 0
%ADB% shell settings put system nearby_scanning_enabled 0
%ADB% shell settings put global wifi_wakeup_enabled 0

REM UI responsiveness (0.5x animations)
%ADB% shell settings put global window_animation_scale 0.5
%ADB% shell settings put global transition_animation_scale 0.5
%ADB% shell settings put global animator_duration_scale 0.5

REM Display & Doze settings
%ADB% shell settings put system screen_off_timeout 30000
%ADB% shell settings put system lift_to_wake 0
%ADB% shell settings put global stay_on_while_plugged_in 0
%ADB% shell settings put global protect_battery 1

REM ── 4. APPOPS BACKGROUND RESTRICTIONS ──────────────────────────────
echo [4/6] Enforcing AppOps background wake lock restrictions...
%ADB% shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND deny
%ADB% shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND deny
%ADB% shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND deny

REM ── 5. STORAGE & RUNTIME MAINTENANCE ───────────────────────────────
echo [5/6] Executing Storage Maintenance & ART Bytecode Optimization...
%ADB% shell pm trim-caches 999999999999
%ADB% shell sm fstrim
%ADB% shell sm idle-maint run
echo Compiling ART bytecode ahead-of-time (this may take 1-2 minutes)...
%ADB% shell cmd package bg-dexopt-job

REM ── 6. COMPLETED ───────────────────────────────────────────────────
echo.
echo ===================================================================
echo [6/6] S25 Edge Optimization Completed Successfully!
echo Reboot your Galaxy S25 Edge now to finalize all system changes.
echo To restore all settings anytime, run: .\s25-restore.bat
echo ===================================================================
pause
