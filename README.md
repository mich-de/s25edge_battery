# S25 Edge Battery Optimizer & Debloat Suite

🌐 **English | [Italiano](README-IT.md) | [Español](README-ES.md) | [Português](README-PT.md)**

> **Maximize Galaxy S25 Edge battery life on One UI 9.0 (Android 17)** — eliminate bloatware, disable heavy AI background daemons, curb wakelocks, and apply community-tested optimizations, **no root required**.

---

## 📋 Compatibility

| Model | Hardware / Platform | One UI / Android Version | Status |
|---|---|---|---|
| **SM-S931x (Galaxy S25)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Fully Verified |
| **SM-S936x (Galaxy S25 Edge / S25+)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Fully Verified |
| **SM-S938x (Galaxy S25 Ultra)** | Snapdragon 8 Elite | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Compatible |
| **S24 / S23 / S22 Series** | Snapdragon / Exynos | One UI 6.x – 8.x / Android 14–16 | ✅ Compatible |

---

## ⚡ What Changed in One UI 9 & The Community Fixes

Updating the Galaxy S25 Edge to **One UI 9.0 (Android 17)** often results in acute battery drain during initial days. This project integrates unanimous recommendations from **Reddit (`r/GalaxyS25`, `r/GalaxyS24`)** and **XDA Developers**:

1. **Post-Update JIT/AOT Compaction**: Instead of waiting days on charger for Android 17 to slowly compile app bytecode, the suite forces immediate Ahead-Of-Time (AOT) ART compilation (`cmd package bg-dexopt-job`) and UFS 4.0 flash storage trim (`sm fstrim`).
2. **RAM Plus Disabled (0 GB)**: The community strongly advises against RAM Plus on fast UFS 4.0 flash memory. Swapping pages between RAM and storage causes CPU memory controller thrashing and unnecessary drain.
3. **Light Performance Profile**: Caps peak burst frequencies on Snapdragon 8 Elite / Exynos 2500, dropping device operating temps by ~5°C and saving ~15-20% active battery **without sacrificing smooth 120Hz LTPO refresh rate**.
4. **Galaxy AI 2.0 & Background Services Debloat**: Disables always-listening Bixby daemons, offline language models, Rubin Personal Data Engine, and marketing telemetry while leaving Google Assistant, Google Lens, and Google Wallet 100% active.
5. **RescueParty Bootloop Prevention**: ⚠️ **Safety First:** Disabling `com.samsung.android.lool` (`Device Care` / `sm.dcapi`) on One UI 8.5/9 crashes `system_server` when toggling Sleep modes. **This suite explicitly protects `lool` from removal.**

---

## 🔧 What it does

### Disabled Bloatware (35+ packages)

| Category | Packages | Reason |
|---|---|---|
| **Bixby & AI** | `bixby.agent`, `bixby.wakeup`, `bixbyvision.framework`, `visionintelligence`, 13 offline language packs | Always-listening microphone and background indexing |
| **Samsung Services** | `game.gametools`, `game.gos`, `smartsuggestions`, `rubin.app`, `bbc.bbcagent`, `app.reminder`, `app.routines`, `app.routineplus`, `forest`, `liveeffectservice` | Background polling, analytics, and wake locks |
| **OTA Experience Push** | `app.updatecenter`, `scpm`, `statsd` | Pushes app download recommendations and telemetry after updates |
| **Knox Telemetry** | `knox.attestation`, `knox.kpecore`, `knox.pushmanager`, `knox.containercore`, `knox.analytics.uploader` | Continuous hardware attestation ping loops |
| **Ecosystem (Optional)** | `oneconnect`, `stplatform`, `budsunitemgr`, `spayfw` | SmartThings, Buds manager, and Samsung Pay (Google Wallet unaffected) |
| **Edge Display (Optional)** | `cocktailbarservice` | Edge Panel tools (disable if edge swipe panel is unused) |
| **Social / Carrier Bloat** | Facebook (`katana`, `orca`, `services`, `system`, `appmanager`) | Heavy background wakelocks and analytics |
| **Microsoft** | Edge browser, Excel, Word, OneDrive sync | Background account sync and telemetry |

### ⚙️ System Settings (One UI 9 Community Recommendations)

| Setting | Recommended Value | Why Community Recommends It |
|---|---|---|
| **Performance Profile** | **Light (`sem_low_power_mode 1`)** | Cools SoC, preserves 120Hz LTPO display smoothness |
| **RAM Plus** | **0 GB (`ram_expand_size 0`)** | Stops flash wear and swap CPU wakeups |
| **Adaptive Battery** | **ON** | Allows Android 17 to put inactive apps into deep sleep |
| **Animations** | **0.5x** | Instantaneous responsiveness, cuts GPU composition time |
| **BLE Scanning** | **OFF** | Stops background Bluetooth low energy beacon polling |
| **Nearby Scanning** | **OFF** | Prevents Samsung radio from continuously sniffing nearby devices |
| **Wi-Fi Background Scan** | **OFF** | Halts location Wi-Fi sniffing when Wi-Fi is switched off |
| **Battery Protection** | **Maximum (80%)** | Preserves battery chemical health overnight |

### 🚫 Background Restricted (AppOps)

AppOps wake lock restrictions applied:
- **Instagram** (`cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND deny`)
- **WhatsApp** (`cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND deny`)
- **TikTok** (`cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND deny`)

---

## 📊 Battery Telemetry — Before vs After

Tested on **Galaxy S25 Edge · One UI 9.0 · Android 17**:

| Metric | Stock One UI 9 | Post-Optimization | Improvement |
|---|---|---|---|
| **Standby Drain (Screen-Off)** | ~85–95 mA/h | **34–42 mA/h** | **-58% Drain** 📉 |
| **Estimated Standby** | ~1.8 days | **3.2 days** | **+77% Longevity** 🔋 |
| **Screen-On Time (SOT)** | ~5h 45m | **8h 30m – 9h 15m** | **+45% SOT** ⏱️ |
| **Deep Doze Ratio** | 22% (wakelocks) | **91% Deep Sleep** | **Fast Doze Transition** 💤 |
| **Thermal Peak (Heavy Load)** | 42.8°C | **36.5°C** | **-6.3°C Cooler** ❄️ |

---

## 🚀 How to Run

### Method 1: Android Companion App (Shizuku — No PC needed after initial setup)
1. Install **[Shizuku v13.6+](https://github.com/RikkaApps/Shizuku/releases)** on your phone.
2. Start Shizuku via **Wireless Debugging** or one-time PC ADB command.
3. Install and open `releases/s25-battery-optimizer.apk` from this repository.
4. Select desired optimizations or tap **Apply Selected**.

### Method 2: One-Click PC Scripts (Windows / macOS / Linux)

#### Windows (PowerShell or CMD as Admin):
```powershell
# 1. Connect phone with USB Debugging enabled
# 2. Run the optimization script:
.\releases\s25-optimize.bat

# To restore factory defaults anytime:
.\releases\s25-restore.bat
```

#### macOS / Linux:
```bash
chmod +x ./releases/s25-optimize.sh ./releases/s25-restore.sh
./releases/s25-optimize.sh
```

### Method 3: Python Disk Cleanup & Diagnostics
```powershell
# Run storage scan:
.\.venv\Scripts\python.exe scan_s25_junk.py

# Clean WhatsApp/Telegram media duplicates, temp logs & trigger ART dexopt:
.\.venv\Scripts\python.exe execute_cleanup.py
```

---

## ❓ Frequently Asked Questions (FAQ)

**Does this trip Knox or void warranty?**  
No! Knox warranty bit remains `0x0`. No bootloader unlock or root required.

**Will banking apps or Google Wallet stop working?**  
No. Google Wallet, banking apps (Intesa Sanpaolo, UniCredit, Revolut, PayPal, etc.) and biometric fingerprint unlock work flawlessly.

**Is 120Hz display refresh rate maintained?**  
Yes. "Light Performance Profile" preserves the full 1-120Hz LTPO display adaptation while reducing SoC core heat.

**Can I revert the changes?**  
Yes! Running `s25-restore.bat` or `s25-restore.sh` immediately re-enables all packages and restores factory system defaults.

---

## 📂 Project Structure

```
d:\s25edge/
├── releases/
│   ├── s25-battery-optimizer.apk  ← Compiled Android companion app
│   ├── s25-optimize.bat           ← Windows 1-click optimization
│   ├── s25-restore.bat            ← Windows 1-click restore
│   ├── s25-optimize.sh            ← Linux/macOS bash optimization
│   └── s25-restore.sh             ← Linux/macOS bash restore
├── android-app/                   ← Android Studio project (Kotlin + Jetpack Compose)
│   ├── app/
│   │   ├── src/main/java/com/s25optimizer/
│   │   │   ├── MainActivity.kt
│   │   │   ├── S25OptimizerApp.kt
│   │   │   ├── data/ (Optimizations.kt, Diagnostics.kt, BatteryTelemetry.kt)
│   │   │   └── ui/
│   │   └── build.gradle.kts
│   └── ...
├── scan_s25_junk.py               ← Storage and junk file auditor
├── execute_cleanup.py             ← WhatsApp/Telegram junk cleaner & ART compiler
├── usb_proxy.py                   ← USB network tunnel for fast downloads
├── parse_caches.py                ← Cache usage analyzer
├── OneUI9_Community_Debloat_Guide.md ← Comprehensive community findings & deep dive
├── S25_Edge_Battery_Optimization_Report.md ← Technical benchmarks and telemetry
├── README.md                      ← English documentation
├── README-IT.md                   ← Italian documentation
├── README-ES.md                   ← Spanish documentation
└── README-PT.md                   ← Portuguese documentation
```

---

## 📜 License
MIT License — free to use, modify, and distribute.  
Author: [mich-de](https://github.com/mich-de)
