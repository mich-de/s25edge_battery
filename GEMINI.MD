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

