# S25 Edge Battery Optimizer & Debloat Suite

🌐 **[English](README.md) | [Italiano](README-IT.md) | [Español](README-ES.md) | Português**

> **Maximize a autonomia da bateria do Galaxy S25 Edge no One UI 9.0 (Android 17)** — remova bloatwares, desative processos de IA em segundo plano, elimine wakelocks e aplique as melhores recomendações da comunidade, **sem root**.

---

## 📋 Compatibilidade

| Modelo | Plataforma / SoC | Versão One UI / Android | Estado |
|---|---|---|---|
| **SM-S931x (Galaxy S25)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificado |
| **SM-S936x (Galaxy S25 Edge / S25+)** | Snapdragon 8 Elite / Exynos 2500 | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Verificado |
| **SM-S938x (Galaxy S25 Ultra)** | Snapdragon 8 Elite | **One UI 9.0 / Android 17 (SDK 37)** | ✅ Compatível |
| **Série S24 / S23 / S22** | Snapdragon / Exynos | One UI 6.x – 8.x / Android 14–16 | ✅ Compatível |

---

## ⚡ Destaques da Comunidade One UI 9

1. **Compilação AOT de Bytecode**: Execute `cmd package bg-dexopt-job` para compilar o sistema após atualização sem esperar dias.
2. **Desativar RAM Plus (0 GB)**: Evita desgaste da memória flash UFS 4.0 e aquecimento do processador.
3. **Perfil de Desempenho Leve**: Diminui a temperatura do chip mantendo a tela suave a 120Hz LTPO.
4. **Remoção de Bloatwares de IA**: Desative daemons dispensáveis da Samsung mantendo o Google Wallet e assistentes ativos.
5. **Prevenção de RescueParty**: ⚠️ **Nunca desative `com.samsung.android.lool`** para evitar bootloops no One UI 9.

---

## 🚀 Como Executar

### Scripts para PC:
```powershell
# Otimização com 1 clique:
.\releases\s25-optimize.bat

# Restaurar padrões de fábrica:
.\releases\s25-restore.bat
```

### Aplicativo Android (Shizuku):
Instale o APK em `releases/s25-battery-optimizer.apk` e inicie via Shizuku.

---

## 📜 Licença
Licença MIT — Autor: [mich-de](https://github.com/mich-de)
