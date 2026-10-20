# 🧠 COMPACT_CONTEXT.MD — S25 Edge Battery Optimizer

## 🏗️ 1. Architettura & Stack Tecnologico
* **Target Hardware:** Samsung Galaxy S25 Edge (`SM-S936x` / `SM-S937B`), S25 (`SM-S931x`), S25 Ultra (`SM-S938x`) su Snapdragon 8 Elite / Exynos 2500.
* **Target OS:** One UI 8.5 & One UI 9.0 / Android 16 & Android 17 (SDK 36/37). Rilevato su device fisico: One UI 8.5 (`80500` / Android 16).
* **Componenti Principali:**
  1. **Companion App Nativa (`android-app/`):** Kotlin, Jetpack Compose, Material 3, Shizuku IPC (`rikka.shizuku:api:13.1.5`). Package: `com.s25optimizer`.
  2. **Automazione Batch/Shell (`releases/`):**
     * `s25-optimize.bat` / `s25-optimize.sh`: Debloat automatico One UI 9 + Safe Zero Samsung Mode + AppOps.
     * `s25-restore.bat` / `s25-restore.sh`: Ripristino di fabbrica completo.
  3. **Tooling Python (`.venv`):**
     * `scan_s25_junk.py`: Rilevamento ADB e audit storage/cache.
     * `execute_cleanup.py`: Deduplicazione media WhatsApp/Telegram, cache trimming, AOT compilation (`bg-dexopt-job`), storage `fstrim`.
     * `usb_proxy.py`: Reverse proxy tunnel USB per download rapidi.
     * `parse_caches.py`: Analizzatore compatto spazio cache app.
  4. **Semantic Graph (`graphify-out/`):** 427 nodi, 555 archi, 44 community estratte.

---

## ⚡ 2. Mappa Moduli & Definizioni Ottimizzazioni (`Optimizations.kt`)
* **Category.ONE_UI_9:**
  * `light_performance`: `sem_low_power_mode 1` (abbatte i consumi e termiche mantenendo 120Hz LTPO).
  * `ram_plus_off`: `ram_expand_size 0` (arresta lo swap su memoria UFS 4.0).
  * `aot_compile`: `cmd package bg-dexopt-job` (compilazione bytecode Ahead-Of-Time).
  * `storage_trim`: `sm fstrim` (ottimizzazione blocchi flash UFS).
* **Category.BLOAT (Zero Samsung Services):**
  * `bixby_suite`: Bixby agent, wakeup, vision, 13 language packs.
  * `samsung_account`: `com.osp.app.signin` (sostituito da Google Account).
  * `galaxy_store`: `com.sec.android.app.samsungapps` (sostituito da Google Play Store).
  * `samsung_keyboard`: `honeyboard` (richiede presenza preventiva di Gboard).
  * `samsung_apps`: Meteo (`daemonapp`), Messaggi, Calendario, Note, Reminder, Voice Recorder.
  * `samsung_pay_pass`: `spayfw`, `samsungpass` (sostituiti da Google Wallet e Password Manager).
  * `ecosystem_hub`: `oneconnect` (SmartThings), `stplatform`, `budsunitemgr`, `mcfds`.
  * `knox_matrix`: `knnr`, `kpecore`, `attestation`, `analytics.uploader`.
  * `social_bloat`: Meta (`katana`, `orca`, `services`, `system`, `appmanager`).
* **Category.SYSTEM_SETTINGS:**
  * `ble_scanning 0`, `nearby_scanning 0`, `wifi_scan 0`, animazioni a `0.5x`.
* **Category.APPOPS (Wake Lock Deny):**
  * Instagram, WhatsApp, TikTok (`RUN_ANY_IN_BACKGROUND deny`).

---

## 🛡️ 3. Regole di Sicurezza Critiche (Guardrails)
* **Bootloop Guard (`lool`):** NON disabilitare MAI `com.samsung.android.lool` (`Device Care` / `sm.dcapi`). Su One UI 8.5/9.0 causa crash irreversibile del `system_server` al cambio stato sleep.
* **Keyboard Lockout Guard:** Lo script e l'app verificano che Gboard sia installata e abilitata prima di disattivare la tastiera Samsung.

---

## 📊 4. Stato del Repository & Rilasci
* **GitHub Repository:** `https://github.com/mich-de/s25edge_battery`
* **Branch Attivo:** `main` (tracciato su `origin/main`).
* **Release Ufficiale:** `v1.0.0`
  * Link: `https://github.com/mich-de/s25edge_battery/releases/tag/v1.0.0`
  * Asset allegati: `s25-battery-optimizer.apk` (61.15 MB), script `.bat` e `.sh`.
