#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════
# S25 EDGE BATTERY OPTIMIZER — MODALITÀ "ZERO SERVIZI SAMSUNG" v3.1
# Linux & macOS Bash Automation Script
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

echo "=== S25 EDGE BATTERY OPTIMIZER — ZERO SERVIZI SAMSUNG (One UI 9) ==="
"$ADB" devices

echo "-------------------------------------------------------------------"
echo "[1/8] BIXBY E GALAXY AI"
echo "-------------------------------------------------------------------"
for pkg in com.samsung.android.bixby.agent com.samsung.android.bixby.wakeup \
           com.samsung.android.bixbyvision.framework com.samsung.android.visionintelligence; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" || true
done
for lang in arae dede enus eses esmx itit plpl ptbr roro ruxx svse trtr zhhk; do
    "$ADB" shell pm disable-user --user 0 "com.samsung.android.bixby.ondevice.$lang" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[2/8] ACCOUNT SAMSUNG, GALAXY STORE E TELEMETRIA"
echo "-------------------------------------------------------------------"
for pkg in com.osp.app.signin com.sec.android.app.samsungapps \
           com.samsung.android.app.updatecenter com.samsung.android.scpm com.samsung.android.statsd; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" || true
done

echo "-------------------------------------------------------------------"
echo "[3/8] SUITE SAMSUNG SOSTITUITA DA SERVIZI GOOGLE"
echo "-------------------------------------------------------------------"
if "$ADB" shell pm list packages | grep -q "com.google.android.inputmethod.latin"; then
    echo "Gboard rilevata. Disabilitazione tastiera Samsung..."
    "$ADB" shell pm disable-user --user 0 com.samsung.android.honeyboard || true
else
    echo "AVVISO: Gboard non rilevata. Tastiera Samsung mantenuta attiva per sicurezza."
fi

for pkg in com.samsung.android.messaging com.samsung.android.calendar \
           com.samsung.android.app.reminder com.samsung.android.app.notes \
           com.sec.android.daemonapp com.samsung.android.weather com.sec.android.app.voicenote; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[4/8] ECOSISTEMA SAMSUNG, SMARTTHINGS E CONDIVISIONE"
echo "-------------------------------------------------------------------"
for pkg in com.samsung.android.oneconnect com.samsung.android.service.stplatform \
           com.samsung.accessory.budsunitemgr com.samsung.android.mcfds com.samsung.android.app.sharelive; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[5/8] PAGAMENTI E PASSWORD (ZERO LOCK-IN SAMSUNG)"
echo "-------------------------------------------------------------------"
for pkg in com.samsung.android.spayfw com.samsung.android.samsungpass; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[6/8] SALUTE, GAMING, PANNELLO EDGE E CONTENUTI EXTRA"
echo "-------------------------------------------------------------------"
for pkg in com.sec.android.app.shealth com.samsung.android.game.gos com.samsung.android.game.gametools \
           com.samsung.android.app.cocktailbarservice com.samsung.android.rubin.app \
           com.samsung.android.smartsuggestions com.samsung.android.bbc.bbcagent com.samsung.android.forest \
           com.samsung.android.liveeffectservice com.samsung.android.arzone com.samsung.android.aremoji \
           com.samsung.android.livestickers com.samsung.android.kidsinstaller; do
    echo "Disabilitazione $pkg..."
    "$ADB" shell pm disable-user --user 0 "$pkg" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[7/8] BLOATWARE META E MICROSOFT"
echo "-------------------------------------------------------------------"
for pkg in com.facebook.katana com.facebook.orca com.facebook.services \
           com.facebook.system com.facebook.appmanager com.microsoft.emmx \
           com.microsoft.office.excel com.microsoft.office.word com.microsoft.skydrive; do
    "$ADB" shell pm disable-user --user 0 "$pkg" 2>/dev/null || true
done

echo "-------------------------------------------------------------------"
echo "[8/8] OTTIMIZZAZIONE PARAMETRI DI SISTEMA ONE UI 9"
echo "-------------------------------------------------------------------"
"$ADB" shell settings put global sem_low_power_mode 1
"$ADB" shell settings put global ram_expand_size 0
"$ADB" shell settings put global ble_scan_always_enabled 0
"$ADB" shell settings put global wifi_scan_always_enabled 0
"$ADB" shell settings put system nearby_scanning_enabled 0
"$ADB" shell settings put global wifi_wakeup_enabled 0
"$ADB" shell settings put global window_animation_scale 0.5
"$ADB" shell settings put global transition_animation_scale 0.5
"$ADB" shell settings put global animator_duration_scale 0.5
"$ADB" shell cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND deny 2>/dev/null || true
"$ADB" shell cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND deny 2>/dev/null || true
"$ADB" shell cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND deny 2>/dev/null || true

echo "Manutenzione storage e compilazione AOT..."
"$ADB" shell pm trim-caches 999999999999 2>/dev/null || true
"$ADB" shell sm fstrim 2>/dev/null || true
"$ADB" shell sm idle-maint run 2>/dev/null || true
"$ADB" shell cmd package bg-dexopt-job || true

echo "Ottimizzazione 'Zero Servizi Samsung' completata! Riavvia il dispositivo."
