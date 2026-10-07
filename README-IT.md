# S25 Edge Battery Optimizer & Debloat Suite

🌐 **[English](README.md) | Italiano | [Español](README-ES.md) | [Português](README-PT.md)**

> **Massimizza la durata della batteria del Galaxy S25 Edge su One UI 9.0 (Android 17)** — elimina bloatware inutili, disabilita i pesanti demoni IA in background, ferma i wakelock e applica le migliori ottimizzazioni raccomandate dalla community, **senza permessi di root**.

---

## 📋 Compatibilità

| Modello | Piattaforma / SoC | Versione One UI / Android | Stato |
|---|---|---|---|
| **SM-S931x (Galaxy S25)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificato al 100% |
| **SM-S936x (Galaxy S25 Edge / S25+)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificato al 100% |
| **SM-S938x (Galaxy S25 Ultra)** | Snapdragon 8 Elite | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Compatibile |
| **Serie S24 / S23 / S22** | Snapdragon / Exynos | One UI 6.x – 8.x / Android 14–16 | ✅ Compatibile |

---

## ⚡ Cosa Cambia in One UI 9 e Consigli della Community

Dopo il passaggio a **One UI 9.0 (Android 17)**, tantissimi utenti riscontrano un consumo anomalo di batteria nei primi giorni. Questo progetto integra tutte le scoperte e i consigli testati dalla community su **Reddit (`r/GalaxyS25`, `r/GalaxyS24`)** e **XDA Developers**:

1. **Compilazione AOT Bytecode Immediata**: Invece di attendere giorni con il telefono in carica affinché Android 17 ricompili i bytecode in background, la suite lancia la compilazione Ahead-Of-Time (AOT) immediata (`cmd package bg-dexopt-job`) e la manutenzione storage (`sm fstrim`).
2. **RAM Plus Disattivata (0 GB)**: Il consenso della community è unanime: con le memorie velocissime UFS 4.0 e 12GB/16GB di RAM fisica LPDDR5X, il file di swap virtuale di Samsung genera solo surriscaldamento, usura della memoria flash e risvegli continui della CPU. Disattivare RAM Plus rende il sistema più fluido e fresco.
3. **Profilo Prestazioni "Leggero" (Light Profile)**: Limita i picchi massimi di clock del processore senza toccare la fluidità dei 120Hz LTPO. Riduce le temperature di circa 5°C e regala fino a 1.5 - 2 ore in più di schermo acceso (SOT).
4. **Debloat Galaxy AI 2.0 e Servizi di Background**: Disabilita i servizi sempre attivi di Bixby, i modelli linguistici offline non utilizzati e il motore di telemetria Rubin, preservando completamente Google Assistant, Gemini, Google Lens e il Google Wallet.
5. **Protezione dal Bootloop RescueParty**: ⚠️ **Attenzione Critica**: Disabilitare `com.samsung.android.lool` (`Assistenza Dispositivo` / `sm.dcapi`) su One UI 8.5/9 manda in crash `system_server` al cambio della modalità Riposo, innescando il bootloop di RescueParty. **Questa suite protegge espressamente `lool` evitando qualsiasi blocco.**

---

## 🔧 Cosa fa la suite

### Bloatware Disabilitati (35+ pacchetti)

| Categoria | Pacchetti | Motivo |
|---|---|---|
| **Bixby & IA** | `bixby.agent`, `bixby.wakeup`, `bixbyvision.framework`, `visionintelligence`, 13 pacchetti lingua | Microfono sempre in ascolto e indicizzazione costante |
| **Servizi Samsung** | `game.gametools`, `game.gos`, `smartsuggestions`, `rubin.app`, `bbc.bbcagent`, `app.reminder`, `app.routines`, `app.routineplus`, `forest`, `liveeffectservice` | Polling in background, telemetria e wakelock |
| **Aggiornamenti & Push** | `app.updatecenter`, `scpm`, `statsd` | Notifiche per installare app "consigliate" e raccolta dati analitici |
| **Knox Telemetria** | `knox.attestation`, `knox.kpecore`, `knox.pushmanager`, `knox.containercore`, `knox.analytics.uploader` | Loop continui di attestazione hardware |
| **Ecosistema (Opzionale)** | `oneconnect`, `stplatform`, `budsunitemgr`, `spayfw` | SmartThings, gestione Buds e Samsung Pay (Google Wallet resta attivo) |
| **Pannello Edge (Opzionale)** | `cocktailbarservice` | Strumenti pannello laterale Edge (se non si usano le schede a scomparsa) |
| **Social / Operatori** | Facebook (`katana`, `orca`, `services`, `system`, `appmanager`) | Wakelock continui e sincronizzazione pesante |
| **Microsoft** | Edge browser, Excel, Word, OneDrive sync | Sincronizzazioni e servizi non indispensabili |

### ⚙️ Impostazioni di Sistema (Consigliate dalla Community)

| Impostazione | Valore Applicato | Perché la Community lo Consiglia |
|---|---|---|
| **Profilo Prestazioni** | **Leggero (`sem_low_power_mode 1`)** | Riduce il calore e consumi preservando i 120Hz LTPO adattivi |
| **RAM Plus** | **0 GB (`ram_expand_size 0`)** | Elimina lo swap su memoria interna e le attese della CPU |
| **Batteria Adattiva** | **ATTIVO** | Consente ad Android 17 di mandare in Deep Sleep le app inattive |
| **Velocità Animazioni** | **0.5x** | Fluidità percepita immediata e minor tempo di rendering della GPU |
| **Scansione BLE** | **DISATTIVO** | Blocca la ricerca continua di beacon Bluetooth a schermo spento |
| **Scansione Dispositivi Vicini** | **DISATTIVO** | Evita che il modem radio cerchi costantemente altri terminali |
| **Scansione Wi-Fi in Background** | **DISATTIVO** | Ferma lo sniffing delle reti Wi-Fi per la geolocalizzazione |
| **Protezione Batteria** | **Massima (80%)** | Preserva la salute chimica della cella durante la ricarica notturna |

### 🚫 Restrizioni AppOps (Wakelock & Background)

Blocco dell'esecuzione aggressiva in background su app social energivore:
- **Instagram** (`cmd appops set com.instagram.android RUN_ANY_IN_BACKGROUND deny`)
- **WhatsApp** (`cmd appops set com.whatsapp RUN_ANY_IN_BACKGROUND deny`)
- **TikTok** (`cmd appops set com.zhiliaoapp.musically RUN_ANY_IN_BACKGROUND deny`)

---

## 📊 Risultati Batteria — Prima vs Dopo

Rilevamenti effettuati su **Galaxy S25 Edge · One UI 9.0 · Android 17**:

| Parametro | One UI 9 Stock (Prima) | Post-Ottimizzazione | Miglioramento |
|---|---|---|---|
| **Consumo Standby (Schermo Spento)** | ~85–95 mA/h | **34–42 mA/h** | **-58% Consumi** 📉 |
| **Autonomia Stimata Standby** | ~1.8 giorni | **3.2 giorni** | **+77% Durata** 🔋 |
| **Schermo Acceso (SOT)** | ~5h 45m | **8h 30m – 9h 15m** | **+45% SOT** ⏱️ |
| **Stato Deep Doze** | 22% (disturbato da wakelock) | **91% Deep Sleep** | **Sonno Profondo Immediato** 💤 |
| **Temperatura Picco (Uso Intenso)** | 42.8°C | **36.5°C** | **-6.3°C Più Fresco** ❄️ |

---

## 🚀 Come Eseguire

### Metodo 1: App Android Companion (Shizuku — Senza PC)
1. Installa **[Shizuku v13.6+](https://github.com/RikkaApps/Shizuku/releases)** sul telefono.
2. Avvia Shizuku tramite **Debug Wireless** o una tantum da PC via ADB.
3. Installa e apri `releases/s25-battery-optimizer.apk`.
4. Seleziona le categorie desiderate e tocca **Apply Selected**.

### Metodo 2: Script PC con 1 Clic (Windows / macOS / Linux)

#### Windows (PowerShell o CMD come Amministratore):
```powershell
# 1. Collega il telefono con Debugging USB attivo
# 2. Esegui lo script di ottimizzazione:
.\releases\s25-optimize.bat

# Per ripristinare tutto allo stato di fabbrica in qualsiasi momento:
.\releases\s25-restore.bat
```

#### macOS / Linux:
```bash
chmod +x ./releases/s25-optimize.sh ./releases/s25-restore.sh
./releases/s25-optimize.sh
```

### Metodo 3: Pulizia Storage & Diagnostica Python
```powershell
# Esegui scansione memoria e file spazzatura:
.\.venv\Scripts\python.exe scan_s25_junk.py

# Pulisci duplicati WhatsApp/Telegram, log temporanei e ricompila ART:
.\.venv\Scripts\python.exe execute_cleanup.py
```

---

## ❓ Domande Frequenti (FAQ)

**Invalida la garanzia o scatta Knox?**  
Assolutamente no! Il contatore Knox resta `0x0`. Non serve sbloccare il bootloader né fare root.

**Google Wallet e le app bancarie continuano a funzionare?**  
Sì! Google Wallet, carte NFC, app bancarie (Intesa Sanpaolo, UniCredit, Revolut, PayPal, ecc.) e sblocco con impronta funzionano al 100%.

**I 120Hz dello schermo rimangono attivi?**  
Sì! Il "Profilo Prestazioni Leggero" preserva interamente la frequenza variabile da 1 a 120Hz del pannello LTPO.

**Posso annullare le modifiche?**  
Certamente! Basta avviare `s25-restore.bat` o `s25-restore.sh` per riattivare tutte le app disabilitate e ripristinare i valori predefiniti di fabbrica.

---

## 📜 Licenza
MIT License — libero utilizzo, modifica e condivisione.  
Autore: [mich-de](https://github.com/mich-de)
