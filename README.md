# Nexus Wallet für Versenden und Erhalten von Bitcoin

**Eine moderne, visuell ansprechende Wallet, um Ihre Bitcoin zu lagern, versenden oder zu erhalten.**

## Inhalt
* [Installation](#installation)
  * [Installation von Android Studio](#installation-von-android-studio)
  * [Erstellen eines Android-Emulators](#erstellen-eines-android-emulators-in-android-studio)
  * [Benutzung eines eigenen Android-Geräts](#benutzung-eines-eigenen-android-geräts)
  * [Abhängigkeiten](#abhängigkeiten)
* [Benutzung](#benutzung)
* [Beitrag zum Projekt](#beitragen)
* [Lizenzen](#lizenzen)
* [Kontakt](#kontakt)

## Installation

Zurzeit muss die App über Android Studio ausgeführt werden. Deswegen wird Android Studio und entweder ein Android Emulator oder ein Android-Gerät, welches als Emulator genutzt werden kann, benötigt.

### Installation von Android Studio

#### Schritt 1: Herunterladen von Android Studio

Als Erstes laden Sie die neueste Version von Android Studio von der offiziellen Website herunter: https://developer.android.com/studio/

#### Schritt 2: Installieren von Android Studio

Nach dem Herunterladen der Installationsdatei können Sie Android Studio auf Ihrem Computer installieren. Befolgen Sie dazu die folgenden Schritte:

1. Doppelklicken Sie auf die Installationsdatei, um den Installationsassistenten zu starten.
2. Wählen Sie einen Installationspfad und klicken Sie auf "Weiter".
3. Wählen Sie die Komponenten aus, die Sie installieren möchten, und klicken Sie auf "Weiter".
4. Wählen Sie die Konfigurationsoptionen aus, die Sie verwenden möchten, und klicken Sie auf "Weiter".
5. Überprüfen Sie die Installationsdetails und klicken Sie auf "Installieren", um mit der Installation zu beginnen.

Die Installation kann einige Minuten dauern, abhängig von der Geschwindigkeit Ihres Computers und der Größe der ausgewählten Komponenten.

#### Schritt 3: Konfiguration von Android Studio

Nach der Installation können Sie Android Studio starten und mit der Konfiguration beginnen. Befolgen Sie dazu die folgenden Schritte:

1. Starten Sie Android Studio durch Doppelklicken auf das Symbol auf Ihrem Desktop oder in Ihrem Startmenü.
2. Wählen Sie "Configure"(Die drei Punkte oben rechts) im Begrüßungsbildschirm und wählen Sie "SDK Manager".
3. Wählen Sie die Android-Version "Tiramisu" oder höher aus und klicken Sie auf "Apply" und besätigen Sie, um die erforderlichen Pakete herunterzuladen und zu installieren.
4. Schließen Sie die Einstellung mit Blick auf "OK".


### Erstellen eines Android Emulators (in Android Studio)

Ein Android Emulator ist eine Software, die Android auf Ihrem Computer simuliert.

#### Schritt 1: Öffnen des Virtual-Device-Managers

Öffnen Sie Android Studio und wählen Sie im Begrüßungsbildschirm "Configure" (falls Sie sich im Projektmenü befinden ist es der "Tools" Tab) und dann "Virtual Device Manager" aus.

#### Schritt 2: Erstellen eines neuen Emulators

Klicken Sie auf "Create Device" und wählen Sie das gewünschte Geräteprofil aus. Sie können aus verschiedenen Geräteprofilen auswählen, z.B. ein Pixel-XL oder ein Tablet. Danach mit "Next" bestätigen.

#### Schritt 3: Auswahl eines System-Images

Wählen Sie ein System-Image für den Emulator aus, indem Sie auf "Download" neben dem gewünschten Image klicken. Um die Nexus Wallet auszuführen, wird eine Android-Version von mindestens Tiramisu(Android 13, 1,5GB Speicher benötigt) oder höher benötigt. Danach mit "Finish" und "Next" bestätigen.

#### Optional: Schritt 4: Konfiguration des Emulators

Geben Sie dem Emulator einen Namen und konfigurieren Sie die Emulator-Einstellungen wie gewünscht, z.B. Größe des internen Speichers, RAM usw.

#### Schritt 5: Bestätigung der Konfiguration des Emulators

Mit "Finish" bestätigen und Device Manager schließen.

### Benutzung eines eigenen Android-Geräts

Um Ihr privates Android-Handy mit Android Studio zu verbinden, müssen Sie zunächst sicherstellen, dass die Entwickleroptionen auf Ihrem Handy aktiviert sind. Hier sind die Schritte, um die Entwickleroptionen zu aktivieren:

1. Gehen Sie zu "Einstellungen" auf Ihrem Handy.
2. Suchen Sie nach "Telefoninfo" oder "Über das Telefon" und tippen Sie darauf.
3. Finden Sie die "Build-Nummer" und tippen Sie sie sieben Mal schnell hintereinander an. Es wird eine Meldung angezeigt, dass Sie nun ein Entwickler sind.
4. Gehen Sie zurück zu den Einstellungen und Sie sollten die Entwickleroptionen sehen.

Sobald Sie die Entwickleroptionen aktiviert haben, gehen Sie wie folgt vor, um Ihr Handy mit Android Studio zu verbinden:

1. Verbinden Sie Ihr Handy über ein USB-Kabel mit Ihrem Computer.
2. Starten Sie Android Studio.
3. Klicken Sie auf das Dropdown-Menü in der Symbolleiste von Android Studio und wählen Sie Ihr Handy aus der Liste der angeschlossenen Geräte aus. Wenn Ihr Handy nicht angezeigt wird, überprüfen Sie, ob USB-Debugging aktiviert ist.
4. Android Studio wird Ihr Handy nun mit ADB (Android Debug Bridge) verbinden, und Sie sollten in der Lage sein, Ihr Handy für Tests und Debugging in Android Studio zu verwenden.

### Abhängigkeiten

Die Nexus Wallet benutzt das Flutter-Framework für sämtliche UI-Komponenten. Flutter muss auf dem Gerät installiert sein und mit Android Studio verknüpft sein.

#### Installation von Flutter:

1. Flutter SDK herunterladen

Laden Sie die neueste Version des Flutter SDK von der offiziellen Flutter-Website herunter
Windows: https://flutter.dev/docs/get-started/install/windows#get-the-flutter-sdk
macOS: https://docs.flutter.dev/get-started/install/macos

2. Flutter SDK extrahieren

Entpacken Sie das heruntergeladene Flutter-SDK in einem Ordner auf Ihrem Computer. Zum Beispiel können Sie es unter C:\flutter extrahieren.

3. Flutter-Pfad konfigurieren

Fügen Sie den Pfad zum Flutter/bin Ordner in die PATH-Umgebungsvariablen ein. So wird Flutter von der Kommandozeile aus zugänglich gemacht.

4. Flutter-Tools installieren

Flutter benötigt bestimmte Tools und Abhängigkeiten, um auf Ihrem System zu funktionieren. Führen Sie das folgende Kommando in einer Eingabeaufforderung aus, um diese Tools zu installieren:

    flutter doctor

5. Flutter-Plugin in Android Studio installieren

Starten Sie Android Studio und öffnen Sie die Einstellungen. Navigieren Sie zu "Plugins" und suchen Sie nach dem "Flutter"-Plugin. Installieren Sie das Plugin und starten Sie Android Studio neu.

6. Android-SDK konfigurieren

Öffnen Sie Android Studio und wählen Sie "Configure" und dann "SDK Manager" aus. Wählen Sie die Registerkarte "SDK Platforms" aus und stellen Sie sicher, dass das Android SDK installiert ist, das Sie für die Entwicklung Ihrer App benötigen. Wählen Sie dann die Registerkarte "SDK Tools" aus und wählen Sie die neuesten Versionen von "Android SDK Build-Tools" und "Android SDK Platform-Tools" aus.

## Benutzung

Wir empfehlen einen leistungsstarken Rechner mit min. 32 GB RAM, um die App mit einem Android-Studio-Emulator reibungslos ausführen zu können. Es ist ebenfalls möglich, ein privates Android-Handy mit Android-Studio zu verknüpfen, und die App direkt auf dem Handy auszuführen. Hierbei muss das private Android-Handy mindestens die Android-Version 13 haben.
Um die Nexus Wallet-App zu starten, führen Sie folgende Schritte aus:
1. Entpacken Sie die Projekt-Datei auf Ihrem Computer.
2. Öffnen Sie die Das Projekt in Android Studio. 
3. Klicken sie auf das Symbol "Device Manager" oben rechts. Alternativ über den Tab "Tools" und dann "Device Manager".
4. Wählen Sie den vorher konfigurierten Android Emulator aus. Danach auf den Play Button bei den Actions. 
5. Klicken sie in der unteren Leiste auf den Tab "Terminal" in der obersten Ebene des Projekts. Danach führen Sie diesen Befehl aus (dauert je nach Gerät, 5-15min):

        flutter run

Die Nexus Wallet enthält Funktionalitäten für:
- Erstellen eines Kontos, das direkt mit einer Bitcoin-Wallet verknüpft ist
- Abrufen des Kontostands der Wallet
- Senden von Bitcoin an eine andere Wallet
- Empfangen von Bitcoin auf die eigene Wallet
- Anzeigen des Kursverlaufs von Bitcoin
- Anzeigen von Nachrichten zu Bitcoin
  
Details zur Benutzung der App finden Sie im Benutzerhandbuch.

#### Bitcoin Testnet-faucet

Um Transaktionen tätigen zu können, werden logischerweise Bitcoin benötigt. Diese können im Testnetz über sogenannte faucets ausgeliehen werden:
1. Nachdem Sie Ihr Konto erstellt und somit eine Wallet-Adresse erhalten haben, besuchen Sie die Seite https://coinfaucet.eu/en/btc-testnet/ .
2. Geben Sie Ihre Wallet-Adresse in das Eingabefeld ein und klicken Sie auf die Schaltfläche "Get Bitcoins".
3. Es wird eine kleine Menge Bitcoin auf Ihre Adresse überwiesen. Bitte beachten Sie, dass empfangene Transaktionen nicht direkt weiterverwendet werden können, da sie erst bestätigt werden müssen, was etwas Zeit beansprechen kann.

Aktuelle Einschränkungen bei der App-Benutzung:
- Die Aktualisierung der Bitcoinkurses findet nur alle 60 Sekunden statt, weil dafür die Coingecko-API verwendet wird, die mit der kostenlosen Version nur eine begrenzte Anzahl von Anfragen annnimmt. Da die Nexus Wallet ein Studienprojekt ist, fehlen dem Team die nötigen finanziellen Mittel, ein bezahltes Abonnement für die Coingecko-API abzuschließen.
- Beim Abruf der aktuellen Nachrichten zu Bitcoin kann es zu Verzögerungen kommen. Diese sind durch die kostenlose Version der News-API begründet, ähnlich wie beim obigen Punkt.

## Beitrag zum Projekt

Bugs können in den Einstellungen bei "Fehler melden" gemeldet werden.

## Lizenzen

Da die Nexus Wallet bisher nicht vertrieben wird, unterliegt sie auch keinen Lizenzen.

## Kontakt

Bei Fragen können Sie den Product Owner Andreas Holzapfel unter folgender e-Mail-Adresse erreichen:
holzapfel.andreas-it21@it.dhbw-ravensburg.de