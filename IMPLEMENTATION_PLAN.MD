# S25 Edge Battery Optimizer — Implementation Plan

**Target Device**: Samsung Galaxy S25 Edge / S25 Series (SM-S931x, SM-S936x, SM-S938x)  
**Target Operating System**: Android 17 with One UI 9.0  
**Lead Architecture**: Senior Full Stack Expert (`[DevOps-Agent]`, `[Backend-Agent]`, `[Frontend-Agent]`)

---

## 1. Executive Summary & Objective

The objective of this project is to port and upgrade the battery optimization and debloating suite from Galaxy S24 to the **Samsung Galaxy S25 Edge** following its major update to **One UI 9.0 (Android 17)**.
It incorporates verified community recommendations from XDA Developers, Reddit (`r/GalaxyS25`, `r/GalaxyS24`), and Samsung Community power users.

### Key Focus Areas:
1. **One UI 9 / Android 17 Deep Integration**:
   - Addressing Galaxy AI 2.0 background daemons and continuous wake locks.
   - Preserving critical One UI 9 system stability: strictly avoiding the `lool` (`com.samsung.android.sm.dcapi`) bootloop trap that triggers RescueParty.
   - Enforcing AppOps restrictions (`RUN_ANY_IN_BACKGROUND deny`) on heavy background pollers (Instagram, WhatsApp, TikTok, etc.).
   - Disabling RAM Plus (`ram_expand_size 0`) as per unanimous community recommendation on fast UFS 4.0 flash storage.
2. **Community S25 Edge Tuning**:
   - Switching Performance Profile to **"Light"** mode (`sem_low_power_mode 1`), preserving fluid 120Hz LTPO display without CPU thermal throttling.
   - Adaptive Battery + Deep Sleep list automation.
   - Edge screen optimization (`cocktailbarservice` tuning).
   - Radio and connectivity optimizations (disabling continuous background BLE scanning, Wi-Fi wakeup, nearby device scanning).
3. **Multi-Platform Tooling & Companion App**:
   - Native PC scripts: `s25-optimize.bat`, `s25-restore.bat`, `s25-optimize.sh`, `s25-restore.sh`.
   - Android Companion App (`android-app/`) utilizing **Shizuku** (via `moe.shizuku.privileged.api`) to allow on-device, rootless ADB command execution.
   - Automated cache trimming, duplicate media removal, and ART runtime compilation (`cmd package bg-dexopt-job`).

---

## 2. Architecture & Component Breakdown

```mermaid
graph TD
    User([S25 Edge User]) --> Choice{Execution Method}
    Choice -->|No-PC / On-Device| ShizukuApp[S25 Battery Optimizer Android App\nJetpack Compose + Shizuku]
    Choice -->|PC USB / Wi-Fi ADB| PCSuite[PC Automation Suite\nBAT / SH Scripts + Python CLI]
    
    subgraph Core Engine [Optimization & Debloat Engine]
        Debloat[One UI 9 Bloatware Removal\nTier 1: Safe | Tier 2: Ecosystem | Tier 3: Edge/AI]
        Settings[System & Global Settings\nLight Profile, RAM Plus 0, BLE off]
        AppOps[AppOps & NetPolicy\nRestricted Background & Wakelocks]
        Maintenance[System Maintenance\nART bg-dexopt, fstrim, cache-trim]
    end
    
    ShizukuApp --> CoreEngine
    PCSuite --> CoreEngine
    CoreEngine --> Device[(Galaxy S25 Edge One UI 9)]
```

---

## 3. Implementation Phases

- **Phase 1: Project Initialization & Environment Setup** `[DevOps-Agent]`
  - Git repository setup with identity `mich-de`.
  - Python virtual environment `.venv` with `requirements.txt`.
  - Core dynamic tracking files: `IMPLEMENTATION_PLAN.MD`, `TASKS.MD`, `GEMINI.MD`.

- **Phase 2: Community Knowledge & Debloat Matrix Creation** `[Backend-Agent]`
  - Compile One UI 9 comprehensive package blocklist and safelist.
  - Document specific community findings in `OneUI9_Community_Debloat_Guide.md` and `S25_Edge_Battery_Optimization_Report.md`.
  - Prepare safe, reversible commands for disabling/enabling bloatware.

- **Phase 3: Automation Scripts & Python Maintenance Suite** `[DevOps-Agent]` & `[Backend-Agent]`
  - Cross-platform scripts: `releases/s25-optimize.bat`, `releases/s25-restore.bat`, `releases/s25-optimize.sh`, `releases/s25-restore.sh`.
  - Python maintenance tools: `scan_s25_junk.py`, `execute_cleanup.py`, `usb_proxy.py`, `parse_caches.py`.

- **Phase 4: Android Companion App Refactoring (`android-app/`)** `[Frontend-Agent]` & `[Backend-Agent]`
  - Namespace and application ID migration to `com.s25optimizer`.
  - Updated definitions in `Optimizations.kt` incorporating One UI 9 / S25 Edge parameters.
  - Device telemetry and diagnostics targeting S25 series hardware profiles.

- **Phase 5: Multilingual Documentation & Asset Packaging** `[DevOps-Agent]`
  - Comprehensive Readme documentation: `README.md` (EN), `README-IT.md` (IT), `README-ES.md` (ES), `README-PT.md` (PT).
  - Release artifacts structured in `releases/`.
