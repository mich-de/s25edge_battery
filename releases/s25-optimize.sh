#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
# S25 EDGE BATTERY OPTIMIZER & DEBLOAT SUITE — v3.0 (One UI 9)
# Linux & macOS Bash Automation Script
# ═══════════════════════════════════════════════════════════════════

set -euo pipefail

# Dynamic ADB detection
if command -v adb >/dev/null 2>&1; then
    ADB="adb"
elif [ -f "$HOME/Library/Android/sdk/platform-tools/adb" ]; then
    ADB="$HOME/Library/Android/sdk/platform-tools/adb"
elif [ -f "$HOME/Android/Sdk/platform-tools/adb" ]; then
    ADB="$HOME/Android/Sdk/platform-tools/adb"
else
    echo "Error: adb not found in PATH or standard SDK locations."
    exit 1
fi

echo "=== S25 EDGE BATTERY OPTIMIZER v3.0 (One UI 9) ==="
"$ADB" devices

echo "[1/6] Disabling Samsung Bloatware & Galaxy AI Daemons..."
"$ADB" shell pm disable-user --user 0 com.samsung.android.bixby.agent || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.bixby.wakeup || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.bixbyvision.framework || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.visionintelligence || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.game.gametools || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.game.gos || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.smartsuggestions || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.rubin.app || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.app.reminder || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.app.routines || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.app.routineplus || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.forest || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.liveeffectservice || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.app.updatecenter || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.scpm || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.statsd || true
"$ADB" shell pm disable-user --user 0 com.sec.enterprise.knox.attestation || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.knox.kpecore || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.knox.pushmanager || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.knox.containercore || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.knox.analytics.uploader || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.oneconnect || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.service.stplatform || true
"$ADB" shell pm disable-user --user 0 com.samsung.accessory.budsunitemgr || true
"$ADB" shell pm disable-user --user 0 com.samsung.android.spayfw || true

echo "[2/6] Disabling Third-Party Bloatware..."
"$ADB" shell pm disable-user --user 0 com.facebook.katana || true
"$ADB" shell pm disable-user --user 0 com.facebook.orca || true
"$ADB" shell pm disable-user --user 0 com.facebook.services || true
"$ADB" shell pm disable-user --user 0 com.facebook.system || true
"$ADB" shell pm disable-user --user 0 com.facebook.appmanager || true
"$ADB" shell pm disable-user --user 0 com.microsoft.emmx || true
"$ADB" shell pm disable-user --user 0 com.microsoft.office.excel || true
"$ADB" shell pm disable-user --user 0 com.microsoft.office.word || true
"$ADB" shell pm disable-user --user 0 com.microsoft.skydrive || true

echo "[3/6] Applying One UI 9 Settings..."
"$ADB" shell settings put global sem_low_power_mode 1
"$ADB" shell settings put global ram_expand_size 0
"$ADB" shell settings put global adaptive_battery_management_enabled 1
"$ADB" shell settings put global app_auto_restriction_enabled 1
"$ADB" shell settings put global ble_scan_always_enabled 0
"$ADB" shell settings put global wifi_scan_always_enabled 0
"$ADB" shell settings put system nearby_scanning_enabled 0
"$ADB" shell settings put global wifi_wakeup_enabled 0
"$ADB" shell settings put global window_animation_scale 0.5
"$ADB" shell settings put global transition_animation_scale 0.5
"$ADB" shell settings put global animator_duration_scale 0.5
"$ADB" shell settings put system screen_off_timeout 30000
"$ADB" shell settings put system lift_to_wake 0
"$ADB" shell settings put global stay_on_while_plugged_in 0
"$ADB" shell settings put global protect_battery 1

echo "[4/6] Restricting Background Wake Locks..."
"$ADB" shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND deny || true
"$ADB" shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND deny || true
"$ADB" shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND deny || true

echo "[5/6] Storage & Runtime Optimization..."
"$ADB" shell pm trim-caches 999999999999 || true
"$ADB" shell sm fstrim || true
"$ADB" shell sm idle-maint run || true
echo "Running ART ahead-of-time bytecode compilation..."
"$ADB" shell cmd package bg-dexopt-job || true

echo "[6/6] S25 Edge Optimization Completed! Please reboot your device."
