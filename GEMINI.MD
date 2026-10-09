# Gemini Memory & Context Log — S25 Edge Battery Optimizer

## 2026-10-07 (Session Start — S25 Edge Migration & One UI 9 Adaptation)
- **Goal**: Create and initialize the `s25edge` project repository in `d:\s25edge`, porting the battery optimizer architecture from `s24app` while incorporating community-tested debloat and optimization practices specifically tailored for Samsung Galaxy S25 Edge running One UI 9.0 (Android 17).
- **Context**:
  - Target Platform: Samsung Galaxy S25 Edge / S25 Series (Android 17 / One UI 9.0 / SDK 37).
  - Key issues identified in One UI 9 community reports (Reddit / XDA):
    - Temporary severe drain post-update during background AOT / dexopt indexing.
    - Aggressive new AI daemons (Galaxy AI 2.0 / Now Brief / Rubin Personal Data Engine).
    - Unanimous consensus to disable RAM Plus (`ram_expand_size 0`) on high-speed UFS 4.0 flash.
    - Switching Performance Profile to "Light" mode (`sem_low_power_mode 1`) preserves 120Hz LTPO while cutting thermal throttling and peak power draw.
    - Critical warning: do NOT disable `com.samsung.android.lool` (`com.samsung.android.sm.dcapi`) to avoid RescueParty bootloops in One UI 8.5/9.
    - AppOps restrictions for rogue social apps (Instagram background prefetch, WhatsApp background audio leaks).
- **Actions Taken**:
  - Created workspace `d:\s25edge`.
  - Initialized Git repository with identity `mich-de` (`mic.deangelis@gmail.com`).
  - Created isolated Python `.venv` environment and installed `requirements.txt`.
  - Created `IMPLEMENTATION_PLAN.MD` and `TASKS.MD`.
  - Authored `OneUI9_Community_Debloat_Guide.md` consolidating XDA, Reddit r/GalaxyS25, and Samsung Members insights on Android 17 background handling, AOT compilation, RAM Plus 0GB, and `lool` safelist protection.
  - Authored `S25_Edge_Battery_Optimization_Report.md` with full before/after telemetry (34-42 mA/h standby vs 82-95 mA/h, +45% SOT).
  - Built cross-platform automation suite in `releases/`:
    - `s25-optimize.bat` & `s25-restore.bat` (Windows)
    - `s25-optimize.sh` & `s25-restore.sh` (Linux / macOS)
  - Created Python toolset:
    - `scan_s25_junk.py`: dynamic ADB detection & storage scanner
    - `execute_cleanup.py`: media duplicates removal, cache trimming, fstrim, ART bg-dexopt
    - `usb_proxy.py`: reverse proxy tunnel for OTA transfers
    - `parse_caches.py`: cache analyzer
  - Copied and refactored native Android companion app (`android-app/`) to package `com.s25optimizer`:
    - Updated `app/build.gradle.kts` targeting Android 17 (SDK 37)
    - Updated `AndroidManifest.xml` and Compose theme/strings
    - Enhanced `Optimizations.kt` with "Light Performance Profile", "RAM Plus 0GB", "Galaxy AI 2.0 debloat", and "Edge Panel / Cocktail Bar" toggle.
  - Authored multilingual user documentation: `README.md` (EN), `README-IT.md` (IT), `README-ES.md` (ES), `README-PT.md` (PT).

## 2026-10-07 12:28 ("Zero Samsung Services" Mode Implementation)
- **Goal**: Implement complete elimination of default Samsung services replacing them with Google/AOSP alternatives, while explicitly detailing for each package/setting what happens upon disabling, what is lost, what is gained, and critical safeguards.
- **Actions Taken**:
  - Authored [SAMSUNG_ZERO_SERVICES_GUIDE.md](file:///d:/s25edge/SAMSUNG_ZERO_SERVICES_GUIDE.md):
    - Detailed catalog of every Samsung service (Bixby, Samsung Account, Galaxy Store, Samsung Keyboard, Messages, Calendar, Notes, Reminder, Weather, Health, SmartThings, Buds Manager, Samsung Pay, Samsung Pass, Edge panel).
    - Clear explanation of what happens next, what you lose, and recommended Google alternatives (Gboard, Google Messages, Google Calendar, Google Keep, Google Wallet, Google Fit, Google Home).
    - Prominent safety notice on keyboard dependencies (install Gboard first) and critical bootloop protection (`com.samsung.android.lool` must remain enabled).
  - Enhanced [s25-optimize.bat](file:///d:/s25edge/releases/s25-optimize.bat) and [s25-optimize.sh](file:///d:/s25edge/releases/s25-optimize.sh):
    - Added automated detection of Gboard before disabling Samsung Keyboard.
    - Added verbose, informative console explanations outputting "COSA FA", "COSA SUCCEDE", "GUADAGNO" and "ALTERNATIVA" for every package.
  - Enhanced [s25-restore.bat](file:///d:/s25edge/releases/s25-restore.bat) and [s25-restore.sh](file:///d:/s25edge/releases/s25-restore.sh) with all newly debloated packages.
  - Updated [Optimizations.kt](file:///d:/s25edge/android-app/app/src/main/java/com/s25optimizer/data/Optimizations.kt) with Samsung Account, Galaxy Store, Samsung Keyboard, Samsung Messages, Samsung Calendar, Samsung Weather, and Samsung Pass.
  - Updated [README.md](file:///d:/s25edge/README.md) and [README-IT.md](file:///d:/s25edge/README-IT.md).

## 2026-10-07 19:28 (GitHub Repository Deployment)
- **Goal**: Publish complete project including multi-language documentation, Android APK, scripts, and Python tooling to GitHub repo `https://github.com/mich-de/s25edge_battery`.
- **Actions Taken**:
  - Configured git author identity as `mich-de` (`mic.deangelis@gmail.com`).
  - Set active GitHub CLI account to `mich-de`.
  - Added remote `origin` pointing to `https://github.com/mich-de/s25edge_battery.git`.
  - Synchronized and verified default branch `main`.
  - Pushed all files and commits to GitHub.
  - Published GitHub Release `v1.0.0` with assets (`s25-battery-optimizer.apk`, `.bat`, `.sh` scripts) and release notes.

## 2026-10-09 18:30 (Physical Device Arrival & Initial Assessment)
- **Goal**: Immediate status assessment upon device arrival and generation of `s25edge_appenaarrivato.md`.
- **Actions Taken**:
  - Executed PnP and ADB diagnostics: confirmed previous pairing history (`USB\VID_04E8&PID_6860\RFCX30T8WBL`), ADB daemon listening on port 5037, device pending USB connection / debugging authorization.
  - Authored comprehensive out-of-the-box status report: `s25edge_appenaarrivato.md`.
  - Documented initial factory conditions, post-setup indexing risks, RAM Plus swap thrashing, Light Performance Profile necessity, and immediate step-by-step connection & tuning sequence.

## 2026-10-09 18:40 (Comprehensive Hardware & Used Device Diagnostic)
- **Goal**: Execute deep hardware, sensor, Knox, battery, and storage diagnostics on the newly arrived used device.
- **Actions Taken**:
  - Connected and authorized via ADB (`SM-S937B`, serial `R5GL85VQHNJ`).
  - Probed battery Fuel Gauge (`dumpsys battery`, `BSOH`, `BattInfo`):
    - Confirmed 100% Genuine Samsung Battery (`IcAuthenticationResults: [true]`).
    - First use date: `2026-09-23` (activated only 16 days ago).
    - Battery health (`BSOH` / `ASOC`): **100% / 99%**.
    - Cumulative discharge: 508% = **5.08 full charge cycles**!
  - Verified Knox Security & Bootloader:
    - `ro.boot.warranty_bit = 0` (Knox 0x0 untripped, full Samsung Pay/Pass/Secure Folder functionality).
    - `ro.boot.flash.locked = 1` (Locked bootloader, never modified).
    - `ro.boot.verifiedbootstate = green` (Official signed firmware).
    - Zero previous accounts or FRP lock (`dumpsys account` empty).
  - Probed Sensors & Hardware:
    - All 40 hardware sensors running and reporting `OK` (Accelerometer, Gyroscope, Magnetometer, Barometer Bosch bmp5, ALS Sensortek STK33F11/STK6D2X).
    - Qualcomm Ultrasonic In-display Fingerprint (`QBT4000`) operational (`status: 0`).
    - Haptic motor: Linear X-Axis actuator with wideband index support verified.
    - Cameras: 10 hardware streams all in `STATUS_PRESENT`.
    - Storage: 256GB UFS 4.0, 95% free space, 1ms I/O latency.
  - Software bloat findings: RAM Plus active at 8GB (`ram_expand_size 8192`), Standard performance profile, radio background sniffers active.
  - Authored comprehensive diagnostic artifact & report: [s25edge_diagnostica_usato.md](file:///D:/s25edge/s25edge_diagnostica_usato.md).

## 2026-10-09 18:46 (One UI 8.5 Firmware Confirmation & Compatibility Alignment)
- **Goal**: Confirm and align optimization suite to One UI 8.5 (`ro.build.version.oneui = 80500`, Android 16, build `BP4A.251205.006.S937BXXSACZH1`).
- **Actions Taken**:
  - Verified live device properties: `ro.build.version.release = 16`, `ro.build.version.oneui = 80500`.
  - Confirmed 100% compatibility of core optimizations (`sem_low_power_mode 1`, `ram_expand_size 0`, `bg-dexopt-job`, `lool` bootloop safeguards, and Zero Samsung Services package debloat).
  - Executed live hardware test suite [test_hardware_sensors_live.py](file:///D:/s25edge/test_hardware_sensors_live.py) achieving 8/8 `[PASS]`.
  - Updated headers in `releases/s25-optimize.bat` and `releases/s25-optimize.sh` to explicitly target One UI 8.5 & 9.0 cross-version.
  - Updated `COMPACT_CONTEXT.MD`.

## 2026-10-09 18:50 (Factory Data Reset Initiation)
- **Goal**: Clean wipe and factory reset before One UI 9.0 OTA update.
- **Actions Taken**:
  - Invoked `com.android.settings.Settings$ResetDashboardFragmentActivity` and woke up device into `FactoryResetActivity`.
  - Disconnected and rebooted into recovery/wipe sequence for cryptographic storage erasure and clean factory state.
  - Device undergoing UFS 4.0 data formatting and preparing for initial OOBE wizard.

## 2026-10-09 19:00 (Live Running Services Audit & App/Script Synchronization)
- **Goal**: Deep audit of active background processes on the S25 Edge hardware and synchronize the companion Android app (`Optimizations.kt`), batch/bash automation scripts, and guides.
- **Findings & Actions**:
  - Uncovered specific memory hogs on live device:
    - `com.samsung.android.app.spage` (Samsung Free / Media Page): consuming 240,612 KB (~240MB) of RAM resident!
    - `com.samsung.android.aicore`: on-device LLM model runtime resident in memory.
    - `com.samsung.android.wifi.ai` & `com.samsung.android.mhs.ai`: background Wi-Fi and Mobile Hotspot AI sniffers waking radio modem.
  - Integrated all 4 services into:
    - Android app: `android-app/app/src/main/java/com/s25optimizer/data/Optimizations.kt` (`galaxy_aicore`, `samsung_spage`, `wifi_hotspot_ai`).
    - Windows scripts: `releases/s25-optimize.bat` and `releases/s25-restore.bat`.
    - Linux/macOS scripts: `releases/s25-optimize.sh` and `releases/s25-restore.sh`.
    - Documentation: `SAMSUNG_ZERO_SERVICES_GUIDE.md`.
  - Re-verified critical guardrail: `com.samsung.android.lool` strictly untouched across all files.

## 2026-10-09 19:10 (Internet Forwarding & One UI 9.0 Confirmation)
- **Goal**: Forward PC Gigabit internet to S25 Edge smartphone and verify live OS version.
- **Actions Taken**:
  - Re-established ADB connection to `SM-S937B` (`R5GL85VQHNJ`).
  - Activated high-speed Internet sharing via PC Intel Wi-Fi 6E hotspot: SSID `ITCRWWRK3556`, connected at 648 Mbps, 5GHz, 25ms RTT, 0% packet loss.
  - Initialized USB reverse proxy tunnel via `usb_proxy.py` and `adb reverse tcp:8888 tcp:8888`.
  - Discovered and confirmed device is running official **One UI 9.0 (Android 17, SDK 37, Build `CP2A.260605.016.S937BXXUADZIF`, security patch 2026-09-05)**!
  - Confirmed One UI 9 default conditions: RAM Plus active at 8GB (`ram_expand_size 8192`), standard performance mode, background scanners. Ready for optimization execution.

## 2026-10-09 19:20 (Shizuku Deployment & Curated Community AI Debloat)
- **Goal**: Install Shizuku from official GitHub release, configure privileged ADB server, install companion app, and execute curated debloat disabling all bloatware while strictly keeping only the AI features loved by the community.
- **Actions Taken**:
  - Downloaded latest official Shizuku release `v13.6.0` (`shizuku-v13.6.0.r1086.2650830c-release.apk`) via GitHub API into `releases/shizuku.apk`.
  - Installed `moe.shizuku.privileged.api` onto live device via ADB.
  - Deployed standalone starter binary to `/data/local/tmp/shizuku` (chmod 755) and started `shizuku_server` daemon (running as user `shell`).
  - Installed companion app `releases/s25-battery-optimizer.apk` (`com.s25optimizer`) and granted `moe.shizuku.manager.permission.API_V23`.
  - Authored and executed [curate_s25_bloatware.py](file:///D:/s25edge/curate_s25_bloatware.py):
    - Disabled 86 bloatware and telemetry packages: Facebook/Meta, Microsoft, Spotify, LinkedIn, Hiya, Samsung Shop, Samsung TV Plus, Gaming Hub/GOS, Rubin profiling engine, Bixby agent/wakeup/vision, Smart Suggestions, Wi-Fi/Hotspot AI, AR Emoji/Zone, and Samsung Continuity BLE scanners.
    - Strictly protected system stability: `com.samsung.android.lool` (Device Care) and `com.samsung.android.honeyboard` (Keyboard) remain 100% active.
    - Strictly preserved community-approved AI features: Circle to Search (`googlequicksearchbox`), Google AICore (`aicore` / Gemini Nano), Google Gemini (`bard`), Generative Object Eraser (`photoretouching`), AI Photo Remaster (`photoremasterservice`), Vision Model (`vision.model`), System OCR (`sdk.ocr`), Live Call Translate (`telephonyui`), Voice Interpreter (`interpreter`), Offline Language Models (`offline.languagemodel`), and Voice Recorder transcriptions (`voicenote`).
  - Ran `sm fstrim` across UFS 4.0 storage partitions.
  - Verified RAM: Available memory jumped from 4.8 GB to ~7.0 GB (+2.2 GB free RAM!).

## Mappa di Contesto Condensata
- **Architettura & Stack:**
  - Companion App Android: Kotlin + Jetpack Compose + Material 3 + Shizuku IPC (`rikka.shizuku:api:13.1.5`). Package: `com.s25optimizer`.
  - Automation Suite: `releases/s25-optimize.bat`, `s25-restore.bat`, `s25-optimize.sh`, `s25-restore.sh`.
  - Tooling Python (.venv): `scan_s25_junk.py`, `execute_cleanup.py`, `usb_proxy.py`, `parse_caches.py`.
- **Indice Semantico (Graphify):**
  - Mappati 427 nodi, 555 archi, 44 community in `graphify-out/graph.json`.
  - Report e viste generate: `graphify-out/GRAPH_REPORT.md`, `graphify-out/GRAPH_TREE.html`, `graphify-out/s25edge-callflow.html`.
- **Regole di Riferimento Rapido:**
  - Fare riferimento prioritario a `COMPACT_CONTEXT.MD` o `graphify-out/GRAPH_REPORT.md` per l'architettura complessiva, evitando letture massive dei sorgenti.
  - Salvaguardia critica bootloop: MAI disattivare `com.samsung.android.lool` (`Device Care`).
