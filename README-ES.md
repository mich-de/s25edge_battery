# S25 Edge Battery Optimizer & Debloat Suite

🌐 **[English](README.md) | [Italiano](README-IT.md) | Español | [Português](README-PT.md)**

> **Maximiza la duración de la batería del Galaxy S25 Edge en One UI 9.0 (Android 17)** — elimina bloatware, desactiva pesados procesos de IA en segundo plano, detiene wakelocks y aplica las mejores optimizaciones de la comunidad, **sin root**.

---

## 📋 Compatibilidad

| Modelo | Plataforma / SoC | Versión One UI / Android | Estado |
|---|---|---|---|
| **SM-S931x (Galaxy S25)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificado |
| **SM-S936x (Galaxy S25 Edge / S25+)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificado |
| **SM-S938x (Galaxy S25 Ultra)** | Snapdragon 8 Elite | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Compatible |
| **Serie S24 / S23 / S22** | Snapdragon / Exynos | One UI 6.x – 8.x / Android 14–16 | ✅ Compatible |

---

## ⚡ Consejos de la Comunidad para One UI 9

1. **Compilación de Bytecode AOT Inmediata**: Fuerza la compilación por adelantado con `cmd package bg-dexopt-job` y optimización de almacenamiento con `sm fstrim`.
2. **Desactivar RAM Plus (0 GB)**: Evita el desgaste de memoria flash UFS 4.0 y el uso innecesario de ciclos de CPU.
3. **Perfil de Rendimiento Ligero**: Reduce el calentamiento y consumo manteniendo los 120Hz LTPO.
4. **Debloat Galaxy AI 2.0**: Detiene asistentes de fondo y telemetría de Samsung mientras Google Wallet y Google Assistant funcionan normalmente.
5. **Prevención de Bootloop RescueParty**: ⚠️ **No desactives `com.samsung.android.lool`** para mantener la estabilidad del sistema One UI 9.

---

## 🚀 Cómo Ejecutar

### Scripts para PC:
```powershell
# Optimizar Galaxy S25 Edge:
.\releases\s25-optimize.bat

# Restaurar valores de fábrica:
.\releases\s25-restore.bat
```

### Aplicación Android (Shizuku):
Instala `releases/s25-battery-optimizer.apk` y ejecuta Shizuku mediante depuración inalámbrica.

---

## 📜 Licencia
Licencia MIT — Autor: [mich-de](https://github.com/mich-de)
