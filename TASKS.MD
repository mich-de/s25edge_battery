# S25 Edge Battery Optimizer — Dynamic Roadmap (TASKS.MD)

## Progress Overview
- [x] **Project Initialization**
  - [x] `[DevOps-Agent]` Create `d:\s25edge` workspace and initialize Git with `mich-de` identity.
  - [x] `[DevOps-Agent]` Create isolated Python `.venv` and install `requirements.txt`.
  - [x] `[DevOps-Agent]` Initialize `IMPLEMENTATION_PLAN.MD` and `TASKS.MD`.

- [x] **One UI 9 & Community Research Documentation**
  - [x] `[Backend-Agent]` Create `OneUI9_Community_Debloat_Guide.md` with package lists, safety warnings (RescueParty prevention), and XDA/Reddit consensus.
  - [x] `[Backend-Agent]` Create `S25_Edge_Battery_Optimization_Report.md` detailing hardware specs, benchmarks, and before/after metrics.
  - [x] `[Backend-Agent]` Author `SAMSUNG_ZERO_SERVICES_GUIDE.md` detailing every single Samsung package, consequence when disabled, and Google alternative.

- [x] **Scripts & Automation Suite**
  - [x] `[DevOps-Agent]` Create `releases/s25-optimize.bat` (Windows automated debloat & tuning).
  - [x] `[DevOps-Agent]` Create `releases/s25-restore.bat` (Windows 1-click restoration).
  - [x] `[DevOps-Agent]` Create `releases/s25-optimize.sh` (Linux/macOS Bash automated script).
  - [x] `[DevOps-Agent]` Create `releases/s25-restore.sh` (Linux/macOS Bash restoration script).
  - [x] `[Backend-Agent]` Create `scan_s25_junk.py` (Storage and cache auditor).
  - [x] `[Backend-Agent]` Create `execute_cleanup.py` (Automated junk and duplicate remover).
  - [x] `[Backend-Agent]` Create `usb_proxy.py` (Reverse proxy for OTA downloads).
  - [x] `[Backend-Agent]` Create `parse_caches.py` (Storage analyzer).

- [x] **Android Companion App (`android-app/`)**
  - [x] `[DevOps-Agent]` Copy and set up Gradle project files from `d:\s24app\android-app` to `d:\s25edge\android-app`.
  - [x] `[Frontend-Agent]` Refactor namespace to `com.s25optimizer`.
  - [x] `[Frontend-Agent]` Update UI, branding, strings, and icons for S25 Edge.
  - [x] `[Backend-Agent]` Update `Optimizations.kt` with One UI 9 specific toggles (RAM Plus 0GB, Light Performance Profile, Galaxy AI background debloat, S25 Edge panel toggle).
  - [x] `[Backend-Agent]` Update `Diagnostics.kt` and `BatteryTelemetry.kt` for S25 Edge hardware definitions.

- [x] **Multilingual Manuals & Readmes**
  - [x] `[DevOps-Agent]` Create `README.md` (English primary manual).
  - [x] `[DevOps-Agent]` Create `README-IT.md` (Italian manual).
  - [x] `[DevOps-Agent]` Create `README-ES.md` (Spanish manual).
  - [x] `[DevOps-Agent]` Create `README-PT.md` (Portuguese manual).
  - [x] `[DevOps-Agent]` Update `GEMINI.MD` persistent memory log.

- [x] **Repository & GitHub Deployment**
  - [x] `[DevOps-Agent]` Link remote and push codebase with README to https://github.com/mich-de/s25edge_battery.

- [x] **Device Arrival & Initial Health Check (Live Status)**
  - [x] `[RELIABILITY-DEVOPS]` Inspect hardware connection, USB PnP registry, and ADB daemon status.
  - [x] `[ENTERPRISE-ARCHITECT]` Author `s25edge_appenaarrivato.md` with factory baseline audit, stock risks, and step-by-step unboxing/tuning roadmap.
  - [x] `[SECURITY-GOVERNANCE]` Full hardware & sensor audit for used device (Knox 0x0 verified, battery 5 cycles / 100% BSOH, 40 sensors operational).
  - [x] `[ENTERPRISE-ARCHITECT]` Author `s25edge_diagnostica_usato.md` with in-depth battery fuel gauge, Knox, sensors, and UFS 4.0 analysis.
  - [x] `[RELIABILITY-DEVOPS]` Launch Factory Data Reset flow via Settings Activity for clean slate before One UI 9 OTA upgrade.
  - [x] `[DOMAIN-MODELER]` Analyze live running services from S25 Edge telemetry (spage 240MB RAM, aicore, wifi.ai, mhs.ai) and synchronize Android companion app (Optimizations.kt), scripts, and guides.
  - [x] **Live S25 Edge Tuning & Curated AI Debloat (One UI 9.0 / Android 17)**
  - [x] `[RELIABILITY-DEVOPS]` Downloaded Shizuku v13.6.0 official APK from GitHub (`RikkaApps/Shizuku`), installed on device, deployed executable `/data/local/tmp/shizuku`, and started `shizuku_server` daemon.
  - [x] `[RELIABILITY-DEVOPS]` Installed companion app `s25-battery-optimizer.apk` (`com.s25optimizer`) and granted Shizuku permission (`API_V23`).
  - [x] `[ENTERPRISE-ARCHITECT]` Authored and executed `curate_s25_bloatware.py`: disabled 86 packages (Meta, Microsoft, Spotify, LinkedIn, Hiya, Samsung Shop/TV Plus, Gaming Hub/GOS, Rubin profiling, Bixby suite, Smart Suggestions, Wi-Fi/Hotspot AI).
  - [x] `[DOMAIN-MODELER]` Strictly preserved community-approved AI features (Circle to Search, Gemini, Generative Photo Editing & Eraser, Photo Remaster, Vision Model, OCR, Live Call Translate, Interpreter, Offline Language Models, Voice Recorder transcription).
  - [x] `[SECURITY-GOVERNANCE]` Strictly protected `com.samsung.android.lool` (Device Care) and `com.samsung.android.honeyboard` (Keyboard).
  - [x] `[SCALABILITY-PERF]` Executed `sm fstrim` on UFS 4.0 storage and verified available RAM expansion (+2.2 GB free RAM, now ~7.0 GB available).


