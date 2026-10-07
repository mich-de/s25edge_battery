#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
# S25 EDGE BATTERY OPTIMIZER — RIPRISTINO COMPLETO v3.1
# Linux & macOS Bash Restoration Script
# ═══════════════════════════════════════════════════════════════════

set -euo pipefail

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

echo "=== S25 EDGE RIPRISTINO COMPLETO (One UI 9) ==="

echo "[1/4] Riabilitazione app e servizi Samsung..."
for pkg in com.samsung.android.bixby.agent com.samsung.android.bixby.wakeup \
           com.samsung.android.bixbyvision.framework com.samsung.android.visionintelligence \
           com.samsung.android.game.gametools com.samsung.android.game.gos \
           com.samsung.android.smartsuggestions com.samsung.android.rubin.app \
           com.samsung.android.bbc.bbcagent com.samsung.android.app.reminder \
           com.samsung.android.app.notes com.samsung.android.calendar \
           com.samsung.android.messaging com.samsung.android.honeyboard \
           com.sec.android.app.samsungapps com.osp.app.signin \
           com.sec.android.daemonapp com.samsung.android.weather \
           com.sec.android.app.voicenote com.sec.android.app.shealth \
           com.samsung.android.spayfw com.samsung.android.samsungpass \
           com.samsung.android.app.cocktailbarservice com.samsung.android.oneconnect \
           com.samsung.android.service.stplatform com.samsung.accessory.budsunitemgr \
           com.samsung.android.mcfds com.samsung.android.app.sharelive \
           com.samsung.android.app.updatecenter com.samsung.android.scpm \
           com.samsung.android.statsd com.sec.enterprise.knox.attestation \
           com.samsung.android.knox.kpecore com.samsung.android.knox.pushmanager \
           com.samsung.android.knox.containercore com.samsung.android.knox.analytics.uploader \
           com.samsung.android.forest com.samsung.android.liveeffectservice \
           com.samsung.android.arzone com.samsung.android.aremoji \
           com.samsung.android.livestickers com.samsung.android.kidsinstaller; do
    "$ADB" shell pm enable "$pkg" 2>/dev/null || true
done

echo "[2/4] Riabilitazione bloatware Meta e Microsoft..."
for pkg in com.facebook.katana com.facebook.orca com.facebook.services \
           com.facebook.system com.facebook.appmanager com.microsoft.emmx \
           com.microsoft.office.excel com.microsoft.office.word com.microsoft.skydrive; do
    "$ADB" shell pm enable "$pkg" 2>/dev/null || true
done

echo "[3/4] Ripristino impostazioni di sistema One UI 9..."
"$ADB" shell settings put global sem_low_power_mode 0
"$ADB" shell settings put global ram_expand_size 4096
"$ADB" shell settings put global window_animation_scale 1.0
"$ADB" shell settings put global transition_animation_scale 1.0
"$ADB" shell settings put global animator_duration_scale 1.0
"$ADB" shell settings put global ble_scan_always_enabled 1
"$ADB" shell settings put global wifi_scan_always_enabled 1
"$ADB" shell settings put system nearby_scanning_enabled 1
"$ADB" shell settings put global protect_battery 0

echo "[4/4] Ripristino restrizioni AppOps..."
"$ADB" shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND default 2>/dev/null || true
"$ADB" shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND default 2>/dev/null || true
"$ADB" shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND default 2>/dev/null || true

echo "Ripristino completato! Riavvia il Galaxy S25 Edge."
