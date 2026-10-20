# Guida Completa "Zero Servizi Samsung" — Galaxy S25 Edge (One UI 9)

Questa guida documenta in modo esaustivo **ogni singolo servizio e pacchetto Samsung** disabilitabile per trasformare il Galaxy S25 Edge in un dispositivo puramente Google/AOSP.

> [!IMPORTANT]
> Per ogni voce è specificato:
> 1. **Cosa fa il servizio** di fabbrica.
> 2. **Cosa succede disabilitandolo** (conseguenze, cosa perdi, cosa guadagni).
> 3. **L'alternativa consigliata** (Google o open-source).
> 4. **Prerequisiti critici** (ad es. installare una tastiera alternativa prima di rimuovere quella Samsung).

---

## ⚠️ Pacchetti Critici: COSA NON DISABILITARE MAI

La community di XDA e Reddit ha individuato alcuni componenti Samsung legati a One UI 8.5/9.0 il cui arresto compromette l'avvio del dispositivo o i moduli di sicurezza:

| Pacchetto | Perché NON va toccato | Conseguenza se disabilitato |
|---|---|---|
| `com.samsung.android.lool` | **Device Care / Provider DCAPI** (`com.samsung.android.sm.dcapi`). | ❌ **BOOTLOOP IMMEDIATO**: Quando la modalità Riposo o il sistema attiva il risparmio energetico, `system_server` chiama questo provider. Se assente, va in crash ciclico e attiva Android RescueParty, che riavvia il telefono in recovery. |
| `com.samsung.android.biometrics.app.setting` | Gestore hardware impronte e sensore a ultrasuoni. | ❌ Impossibilità di usare lo sblocco biometrico e il lettore sotto allo schermo. |
| `com.sec.android.app.camera` | Fotocamera nativa Samsung. | ⚠️ Il sensore Snapdragon/Exynos dell'S25 Edge usa pipeline proprietarie per HDR e lenti periscopiche. Puoi disabilitare i moduli IA/Bixby della fotocamera, ma mantieni l'app base. |

---

## 1. Assistente Vocale, Modelli IA e Bixby

### `com.samsung.android.bixby.agent`
* **Cosa fa**: È il processo principale di Bixby Voice. Rimane in esecuzione perenne in memoria RAM per interpretare comandi vocali e azioni a schermo.
* **Cosa succede**: Bixby cessa completamente di esistere. La pressione prolungata del tasto laterale non invocherà più Bixby.
* **Cosa guadagni**: Eliminato il wakelock continuo del microfono e circa 80-120 MB di RAM costante.
* **Alternativa**: Google Assistant / Google Gemini (attivabile con swipe dall'angolo o pressione tasto accensione).

### `com.samsung.android.bixby.wakeup`
* **Cosa fa**: Driver di ascolto a bassa frequenza per la parola d'attivazione *"Hi Bixby"*.
* **Cosa succede**: Il microfono hardware non campiona continuamente l'audio a schermo spento per Bixby.
* **Cosa guadagni**: Riduzione di ~15-20 mA/h di scarica in standby profondo (Deep Doze).
* **Alternativa**: "Hey Google" (se desiderato, oppure nessun assistente per massima privacy).

### `com.samsung.android.bixbyvision.framework` & `visionintelligence`
* **Cosa fa**: Riconoscimento oggetti, testo, etichette di vino e shopping integrato nel mirino della fotocamera e nella galleria.
* **Cosa succede**: Sparisce il pulsante Bixby Vision dalla fotocamera.
* **Cosa guadagni**: La fotocamera si apre più rapidamente e non scambia dati con i server cloud di analisi immagini.
* **Alternativa**: Google Lens (molto più preciso e si attiva solo su richiesta).

### `com.samsung.android.bixby.ondevice.*` (13 pacchetti linguistici)
* **Cosa fa**: Modelli linguistici offline scaricati per l'elaborazione vocale locale di Bixby (~350 MB di spazio storage).
* **Cosa succede**: Non puoi usare Bixby senza connessione internet. Se non usi Bixby, sono file completamente morti.
* **Cosa guadagni**: Spazio flash liberato e zero controlli periodici di aggiornamento dizionari.

### `com.samsung.android.aicore`
* **Cosa fa**: Runtime on-device dei modelli linguistici proprietari Samsung (Galaxy AI per suggerimenti di scrittura e riassunti).
* **Cosa succede**: I modelli Samsung non vengono precaricati in RAM cache. Circle to Search e Google Gemini rimangono attivi al 100% (usano `com.google.android.aicore`).
* **Cosa guadagni**: Circa 150-200 MB di RAM fisica liberata e stop alle sincronizzazioni IA proprietarie.

### `com.samsung.android.app.spage` (Samsung Free / Daily)
* **Cosa fa**: Pagina multimediale e feed notizie/podcast sul pannello a sinistra della schermata Home.
* **Cosa succede**: Eliminato il pannello Samsung Free. Puoi usare Google Discover o disattivare del tutto la pagina sinistra.
* **Cosa guadagni**: **Circa 240 MB di RAM fisica liberata** e azzeramento del prefetching in background di notizie pubblicitarie.

### `com.samsung.android.wifi.ai` & `com.samsung.android.mhs.ai`
* **Cosa fa**: Analizzatori euristici basati su machine learning per il monitoraggio della qualità Wi-Fi e gestione hotspot.
* **Cosa succede**: Le connessioni Wi-Fi e l'hotspot tethering continuano a funzionare regolarmente con lo stack di rete standard Android.
* **Cosa guadagni**: Zero risvegli parassiti dei controller radio e minore consumo in mobilità.

---

## 2. Account Samsung, Telemetria e Notifiche OTA

### `com.osp.app.signin`
* **Cosa fa**: Gestore dell'account Samsung (Samsung Cloud, sincronizzazione impostazioni One UI tra dispositivi Galaxy).
* **Cosa succede**: Il telefono non richiede l'accesso a un account Samsung nelle Impostazioni.
* **Cosa perdi**: Non puoi usare Trova Dispositivo di Samsung (Samsung Find), né sincronizzare le Note o la Galleria sui server Samsung.
* **Alternativa**: Google Account e **Trova il mio dispositivo di Google** (integrato in Android 17).

### `com.sec.android.app.samsungapps`
* **Cosa fa**: Galaxy Store (negozio di applicazioni proprietario di Samsung).
* **Cosa succede**: Non ricevi notifiche di aggiornamenti per le app Samsung né suggerimenti pubblicitari.
* **Cosa guadagni**: Zero processi di background che verificano pacchetti duplicati.
* **Alternativa**: Google Play Store (o store terzi come F-Droid / Aurora).

### `com.samsung.android.app.updatecenter`
* **Cosa fa**: Servizio push che compare tipicamente dopo ogni aggiornamento di sistema (OTA) per forzare l'installazione di app partner (partner experience).
* **Cosa succede**: Dopo gli aggiornamenti One UI non compariranno mai più notifiche o popup per scaricare giochi sponsorizzati o utility inutili.
* **Cosa guadagni**: Totale pulizia dell'area notifiche.

### `com.samsung.android.scpm` & `statsd`
* **Cosa fa**: SCPM (Smart Contextual Platform) e Samsung Analytics raccolgono le abitudini di utilizzo del telefono, orari di apertura app e coordinate geografiche per profilazione.
* **Cosa succede**: Le statistiche di telemetria proprietarie vengono neutralizzate.
* **Cosa guadagni**: Zero connessioni di rete di telemetria verso server coreani/AWS di Samsung a schermo spento.

---

## 3. Tastiera, Messaggi e Applicazioni Giornaliere

### `com.samsung.android.honeyboard` (Tastiera Samsung)
> [!CAUTION]
> **PREREQUISITO OBBLIGATORIO**: Prima di disabilitare la tastiera Samsung, DEVI installare **Gboard** (o un'altra tastiera come SwiftKey) dal Play Store, aprirla e selezionarla come tastiera predefinita. Se disabiliti questo pacchetto senza un'altra tastiera attiva, non potrai inserire la password o il PIN alla successiva richiesta!

* **Cosa fa**: È la tastiera predefinita di sistema Samsung.
* **Cosa succede**: La tastiera Samsung scompare completamente. Tutte le richieste di digitazione passeranno a Gboard.
* **Cosa guadagni**: Riduzione di ~150 MB di RAM allocata. Gboard offre una predizione del testo superiore e dettatura vocale Google istantanea.
* **Alternativa**: Gboard (Google Keyboard).

### `com.samsung.android.messaging` (Messaggi Samsung)
* **Cosa fa**: App SMS/MMS preinstallata da Samsung.
* **Cosa succede**: I messaggi SMS vengono gestiti dall'app Google.
* **Cosa guadagni**: Pieno supporto alle chat RCS moderne (Google Jibe), crittografia end-to-end e reazioni emoji senza wakelock proprietari.
* **Alternativa**: Google Messaggi.

### `com.samsung.android.calendar`
* **Cosa fa**: Calendario proprietario Samsung.
* **Cosa succede**: Gli eventi e i promemoria vengono gestiti direttamente dall'ecosistema Google.
* **Cosa guadagni**: Sincronizzazione istantanea con Google Workspace / Gmail senza dover passare per l'account Samsung.
* **Alternativa**: Google Calendar.

### `com.samsung.android.app.reminder` & `notes`
* **Cosa fa**: App Promemoria e Note di Samsung.
* **Cosa succede**: Non utilizzerai più il database chiuso di Samsung Notes.
* **Cosa guadagni**: Le tue note saranno visibili su qualsiasi PC, Mac, browser o dispositivo non-Samsung.
* **Alternativa**: Google Keep, Notion o Obsidian.

### `com.sec.android.daemonapp` & `com.samsung.android.weather`
* **Cosa fa**: Widget meteo Samsung alimentato da The Weather Channel (con banner pubblicitari e tracciamento posizione continuo).
* **Cosa succede**: Sparisce il widget meteo Samsung predefinito.
* **Cosa guadagni**: Risparmio di GPS continuo a schermo spento.
* **Alternativa**: Meteo Google (accessibile cliccando la data sul widget "A colpo d'occhio" di Google) o app come Geometric Weather / Overdrop.

---

## 4. Ecosistema, Condivisione e Dispositivi Connessi

### `com.samsung.android.oneconnect` & `service.stplatform`
* **Cosa fa**: SmartThings e piattaforma Secure Trade. Esegue scansioni periodiche via Bluetooth e Wi-Fi per individuare televisori, frigoriferi e dispositivi SmartThings vicini.
* **Cosa succede**: Il telefono non cercherà continuamente elettrodomestici Samsung attorno a te.
* **Cosa guadagni**: Notevole abbattimento dei risvegli radio (Bluetooth Low Energy e mDNS).
* **Alternativa**: Google Home.

### `com.samsung.accessory.budsunitemgr`
* **Cosa fa**: Plugin di background per cuffie Samsung Galaxy Buds.
* **Cosa succede**: Se non hai le Galaxy Buds, questo processo rimaneva comunque caricato in memoria. Se colleghi normali cuffie Bluetooth (Sony, Bose, Apple, ecc.) o auricolari con cavo, funzionano perfettamente con lo stack Bluetooth nativo di Android.
* **Cosa guadagni**: Circa 50 MB di RAM liberati.

### `com.samsung.android.mcfds` (Multi Control) & `oneconnect`
* **Cosa fa**: Samsung Continuity: consente di copiare testo su un Galaxy Book o un Galaxy Tab e incollarlo sul telefono.
* **Cosa succede**: La funzione di continuità tra dispositivi Samsung viene disattivata.
* **Cosa guadagni**: Neutralizzati i socket di rete locali aperti in background.

### `com.samsung.android.app.sharelive`
* **Cosa fa**: Daemon della variante Samsung di Quick Share per i PC Samsung.
* **Cosa succede**: La condivisione integrata di Android (Nearby Share / Quick Share standard di Google) continua a funzionare perfettamente per inviare file a qualsiasi telefono Android o PC Windows generico.
* **Cosa guadagni**: Rimozione del processo di broadcast permanente.

---

## 5. Pagamenti e Gestione Password

### `com.samsung.android.spayfw` (Samsung Pay / Wallet)
* **Cosa fa**: Framework di pagamento contactless e memorizzazione carte fedeltà Samsung.
* **Cosa succede**: Samsung Wallet non può più essere avviato né richiamato con lo swipe dal basso verso l'alto.
* **Cosa guadagni**: Eliminato il listener sullo schermo che intercettava i gesti dal bordo inferiore.
* **Alternativa**: **Google Wallet**: funziona con tutte le banche, circuiti Visa/Mastercard/Amex/Bancomat e transazioni NFC, con totale conformità di sicurezza.

### `com.samsung.android.samsungpass`
* **Cosa fa**: Gestore delle password biometriche di Samsung sincronizzato su Samsung Cloud.
* **Cosa succede**: Non salvi le password nel portachiavi Samsung.
* **Cosa guadagni**: Le tue credenziali non rimangono legate in modo vincolante a telefoni Samsung.
* **Alternativa**: Google Password Manager, Bitwarden o 1Password.

---

## 6. Salute, Gaming e Display Edge

### `com.sec.android.app.shealth` (Samsung Health)
* **Cosa fa**: Monitoraggio passi, sonno, stress ed esercizi di Samsung.
* **Cosa succede**: Il coprocessore del telefono non registra i dati fitness per i server Samsung.
* **Cosa guadagni**: Riduzione di drain continuo del sensore contapassi.
* **Alternativa**: Google Fit, Health Connect o Strava.

### `com.samsung.android.game.gos` & `game.gametools`
* **Cosa fa**: GOS (Game Optimizing Service) e pannello strumenti di gioco. Riduce la risoluzione e abbassa le frequenze di clock durante le sessioni di gioco per limitare la temperatura.
* **Cosa succede**: I giochi non vengono strozzati forzatamente da Samsung e scompare l'overlay in-game.
* **Cosa guadagni**: Giochi più fluidi e zero processi di monitoraggio frame rate attivi anche quando non stai giocando.

### `com.samsung.android.app.cocktailbarservice` (Pannello Edge)
* **Cosa fa**: Disegna e gestisce il cassetto laterale a scorrimento del bordo curvo dell'S25 Edge.
* **Cosa succede**: Non vedrai la linguetta trasparente sul bordo dello schermo. I gesti di navigazione Android (indietro, home, app recenti) e il touch sul bordo curvo funzionano in modo perfetto e trasparente.
* **Cosa guadagni**: La GPU non riserva costantemente un overlay di rendering a schermo.

### `com.samsung.android.rubin.app` (Customization Service)
* **Cosa fa**: Motore di profilazione comportamentale (analizza posizione, orari in cui ti svegli, app aperte).
* **Cosa succede**: Uno dei maggiori responsabili del drain invisibile dei Google Play Services viene neutralizzato all'origine.
* **Cosa guadagni**: Netto calo del wakelock `NlpWakeLock` e consumo Play Services dimezzato.

---

## 7. Tabella Riassuntiva: Servizio Samsung vs Alternativa Google

| Servizio Samsung | Impatto / Rischio | Alternativa Consigliata |
|---|---|---|
| **Bixby Voice & Wakeup** | Zero rischi / Alto risparmio | Google Gemini / Assistant |
| **Bixby Vision** | Zero rischi / Alto risparmio | Google Lens |
| **Samsung Keyboard** | ⚠️ Installa prima Gboard! | Gboard |
| **Samsung Messages** | Zero rischi / Pieno RCS | Google Messaggi |
| **Samsung Calendar** | Zero rischi | Google Calendar |
| **Samsung Notes & Reminder** | Zero rischi | Google Keep / Notion |
| **Samsung Pay / Wallet** | Zero rischi | Google Wallet |
| **Samsung Pass** | Zero rischi | Google Password Manager / Bitwarden |
| **Samsung Cloud / Account** | Zero rischi | Google One / Google Drive |
| **Galaxy Store** | Zero rischi | Google Play Store |
| **SmartThings** | Zero rischi / Risparmio radio | Google Home |
| **Samsung Health** | Zero rischi | Google Fit / Health Connect |
| **Pannello Edge (Cocktailbar)** | Zero rischi / Meno uso GPU | Gesti di navigazione Android |
| **Game Optimizing Service (GOS)** | Zero rischi / Zero throttling | Nessun overlay necessario |
| **Samsung Weather** | Zero rischi / Meno GPS | Meteo Google |
| **Device Care (`lool`)** | ❌ **NON TOCCARE (Bootloop)** | Mantenuto attivo di serie |
