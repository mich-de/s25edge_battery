# Graph Report - s25edge  (2026-10-08)

## Corpus Check
- 53 files · ~92,478 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 427 nodes · 555 edges · 44 communities (30 shown, 14 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 27 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `5fd37ec1`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]
- [[_COMMUNITY_Community 22|Community 22]]
- [[_COMMUNITY_Community 23|Community 23]]
- [[_COMMUNITY_Community 24|Community 24]]
- [[_COMMUNITY_Community 25|Community 25]]
- [[_COMMUNITY_Community 26|Community 26]]
- [[_COMMUNITY_Community 27|Community 27]]
- [[_COMMUNITY_Community 28|Community 28]]
- [[_COMMUNITY_Community 29|Community 29]]
- [[_COMMUNITY_Community 30|Community 30]]
- [[_COMMUNITY_Community 31|Community 31]]
- [[_COMMUNITY_Community 32|Community 32]]
- [[_COMMUNITY_Community 36|Community 36]]
- [[_COMMUNITY_Community 37|Community 37]]
- [[_COMMUNITY_Community 38|Community 38]]
- [[_COMMUNITY_Community 39|Community 39]]

## God Nodes (most connected - your core abstractions)
1. `t()` - 14 edges
2. `AdbExecutor` - 13 edges
3. `DiagnosticsScreen()` - 11 edges
4. `ShizukuBridgeProvider` - 10 edges
5. `ChargeSchedule` - 10 edges
6. `BatteryHistory` - 9 edges
7. `applyScreenOn()` - 9 edges
8. `reconcile()` - 9 edges
9. `S25 Edge Battery Optimizer & Debloat Suite` - 9 edges
10. `Guida Completa "Zero Servizi Samsung" — Galaxy S25 Edge (One UI 9)` - 9 edges

## Surprising Connections (you probably didn't know these)
- `PerAppRRDialog()` --calls--> `t()`  [INFERRED]
  android-app/app/src/main/java/com/s25optimizer/ui/PerAppRRDialog.kt → android-app/app/src/main/java/com/s25optimizer/service/RestartScheduleReceiver.kt
- `PerAppRRTab()` --calls--> `t()`  [INFERRED]
  android-app/app/src/main/java/com/s25optimizer/ui/PerAppRRTab.kt → android-app/app/src/main/java/com/s25optimizer/service/RestartScheduleReceiver.kt
- `QuickSettingsBar()` --calls--> `t()`  [INFERRED]
  android-app/app/src/main/java/com/s25optimizer/ui/QuickSettingsBar.kt → android-app/app/src/main/java/com/s25optimizer/service/RestartScheduleReceiver.kt
- `OptimizeScreen()` --calls--> `t()`  [INFERRED]
  android-app/app/src/main/java/com/s25optimizer/ui/screens/OptimizeScreen.kt → android-app/app/src/main/java/com/s25optimizer/service/RestartScheduleReceiver.kt
- `MainScreen()` --calls--> `AppNavigation()`  [INFERRED]
  android-app/app/src/main/java/com/s25optimizer/ui/MainScreen.kt → android-app/app/src/main/java/com/s25optimizer/ui/navigation/AppNavigation.kt

## Communities (44 total, 14 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.11
Nodes (27): AppNavigation(), Screen, AppInfo, AppsScreen(), isAccServiceEnabled(), loadApps(), ChargeScheduleCard(), TimeTile() (+19 more)

### Community 1 - "Community 1"
Cohesion: 0.06
Nodes (32): 1. Assistente Vocale, Modelli IA e Bixby, 2. Account Samsung, Telemetria e Notifiche OTA, 3. Tastiera, Messaggi e Applicazioni Giornaliere, 4. Ecosistema, Condivisione e Dispositivi Connessi, 5. Pagamenti e Gestione Password, 6. Salute, Gaming e Display Edge, 7. Tabella Riassuntiva: Servizio Samsung vs Alternativa Google, `com.osp.app.signin` (+24 more)

### Community 2 - "Community 2"
Cohesion: 0.15
Nodes (15): applyScreenOff(), applyScreenOn(), dirty(), ensureRunning(), getActiveFeatures(), Mod, onReceive(), reconcile() (+7 more)

### Community 3 - "Community 3"
Cohesion: 0.09
Nodes (22): 🚫 Background Restricted (AppOps), 📊 Battery Telemetry — Before vs After, code:powershell (# 1. Connect phone with USB Debugging enabled), code:bash (chmod +x ./releases/s25-optimize.sh ./releases/s25-restore.s), code:powershell (# Run storage scan:), code:block4 (d:\s25edge/), 📋 Compatibility, Disabled Bloatware & Samsung Services (+14 more)

### Community 4 - "Community 4"
Cohesion: 0.10
Nodes (20): Bloatware e Servizi Samsung Disabilitati, code:powershell (# 1. Collega il telefono con Debugging USB attivo), code:bash (chmod +x ./releases/s25-optimize.sh ./releases/s25-restore.s), code:powershell (# Esegui scansione memoria e file spazzatura:), 🚀 Come Eseguire, 📋 Compatibilità, ⚡ Cosa Cambia in One UI 9 e Consigli della Community, 🔧 Cosa fa la suite (+12 more)

### Community 5 - "Community 5"
Cohesion: 0.24
Nodes (18): actionIntent(), armNextOccurrence(), armTick(), blockingGuards(), cancelAll(), canScheduleExact(), disable(), dismiss() (+10 more)

### Community 7 - "Community 7"
Cohesion: 0.12
Nodes (15): 1. The One UI 9 Battery Phenomenon: What Happened?, 2. Community Recommended Settings (Zero Side Effects), 3. Tiered Bloatware Package Matrix, 4. AppOps & NetPolicy: Taming Heavy Social Apps, 5. Storage Maintenance Post-Update, code:bash (adb shell cmd package bg-dexopt-job), code:bash (# Bixby Assistant & Background Voice Trigger), code:bash (# Galaxy Buds & Accessory Managers) (+7 more)

### Community 9 - "Community 9"
Cohesion: 0.31
Nodes (11): applyPhase(), armAlarm(), cancelAlarm(), canScheduleExact(), ChargeScheduleReceiver, disable(), nightApplied(), pendingIntent() (+3 more)

### Community 10 - "Community 10"
Cohesion: 0.29
Nodes (3): BatteryHistory, Sample, Stats

### Community 12 - "Community 12"
Cohesion: 0.24
Nodes (6): Conflict, Consumer, Diagnostics, PowerUse, Radio, Severity

### Community 13 - "Community 13"
Cohesion: 0.24
Nodes (4): Category, LocalAction, Optimization, Optimizations

### Community 15 - "Community 15"
Cohesion: 0.20
Nodes (9): 1. Technical Baseline & Hardware Profile, 2. Before vs After Optimization Metrics, 3.1 Galaxy AI 2.0 & Samsung Background Workers, 3.2 RAM Plus Swap File Thrashing, 3.3 Heavy Social Background Prefetching (Instagram / WhatsApp), 3.4 Radio Sniffing Daemons, 3. Top Culprits Identified and Resolved, 4. Verification & Safety Audit (+1 more)

### Community 16 - "Community 16"
Cohesion: 0.22
Nodes (8): Aplicación Android (Shizuku):, code:powershell (# Optimizar Galaxy S25 Edge:), 📋 Compatibilidad, ⚡ Consejos de la Comunidad para One UI 9, 🚀 Cómo Ejecutar, 📜 Licencia, S25 Edge Battery Optimizer & Debloat Suite, Scripts para PC:

### Community 17 - "Community 17"
Cohesion: 0.22
Nodes (8): Aplicativo Android (Shizuku):, code:powershell (# Otimização com 1 clique:), 🚀 Como Executar, 📋 Compatibilidade, ⚡ Destaques da Comunidade One UI 9, 📜 Licença, S25 Edge Battery Optimizer & Debloat Suite, Scripts para PC:

### Community 19 - "Community 19"
Cohesion: 0.25
Nodes (3): MainActivity, MainScreen(), S25EdgeTheme()

### Community 20 - "Community 20"
Cohesion: 0.25
Nodes (7): 1. 🛑 "Zero Samsung Services" & Deep Debloat, 2. ⚡ One UI 9 Community Consensus Fixes, 📊 Battery Telemetry Benchmark (Galaxy S25 Edge), 📥 Direct Download Links, 📦 Included Release Assets, ✨ Key Features & Optimizations, 🔋 S25 Edge Battery Optimizer & Debloat Suite — v1.0.0

### Community 22 - "Community 22"
Cohesion: 0.38
Nodes (6): FdChip(), FdHeader(), PerfMode, PhotoQuality, QuickSettingsBar(), RefreshRate

### Community 25 - "Community 25"
Cohesion: 0.47
Nodes (3): Basic, BatteryTelemetry, Health

### Community 26 - "Community 26"
Cohesion: 0.60
Nodes (5): isOneShot(), OptimizationItem(), OptimizeScreen(), runnableNow(), runOne()

### Community 29 - "Community 29"
Cohesion: 0.60
Nodes (3): adb_shell(), get_first_device(), main()

### Community 30 - "Community 30"
Cohesion: 0.60
Nodes (3): adb_shell(), get_first_device(), main()

### Community 31 - "Community 31"
Cohesion: 0.70
Nodes (4): AppEntry, isAccessibilityServiceEnabled(), loadInstalledApps(), PerAppRRDialog()

### Community 32 - "Community 32"
Cohesion: 0.70
Nodes (4): AppInfo, isAccServiceEnabled(), loadApps(), PerAppRRTab()

## Knowledge Gaps
- **91 isolated node(s):** `Stats`, `Severity`, `LocalAction`, `Category`, `PerfMode` (+86 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **14 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `t()` connect `Community 0` to `Community 32`, `Community 5`, `Community 22`, `Community 26`, `Community 31`?**
  _High betweenness centrality (0.028) - this node is a cross-community bridge._
- **Why does `AppNavigation()` connect `Community 0` to `Community 26`, `Community 19`?**
  _High betweenness centrality (0.010) - this node is a cross-community bridge._
- **Are the 11 inferred relationships involving `t()` (e.g. with `PerAppRRDialog()` and `PerAppRRTab()`) actually correct?**
  _`t()` has 11 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `DiagnosticsScreen()` (e.g. with `AppNavigation()` and `t()`) actually correct?**
  _`DiagnosticsScreen()` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Stats`, `Severity`, `LocalAction` to the rest of the system?**
  _91 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.10695187165775401 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.06060606060606061 - nodes in this community are weakly interconnected._