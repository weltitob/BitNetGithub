
● Verwendete URLs und API-Aufrufe:

1. Verbindung zum LSP-Node herstellen:
   docker exec -i node12_mainnet lncli connect
   03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b@34.65.191.64:9735

2. Versuch, den Channel zu öffnen (GET-Methode):
   https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl?k1=03f74b51-bc5c-4263-
   aceb-b565d9afa2de&remoteid=020f0b031a324d45a6f7a2db368abfb081bfac3fe648c23ce997b0466c4de48c27&private=0

3. Versuch mit POST-Methode:
   https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl
   Mit JSON-Body:
   {
   "k1": "03f74b51-bc5c-4263-aceb-b565d9afa2de",
   "remoteid": "020f0b031a324d45a6f7a2db368abfb081bfac3fe648c23ce997b0466c4de48c27",
   "private": 0
   }

4. Status-Abfrage:
   https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de

LNURL-Connect-System in deine App integrieren:

Hier ist ein schrittweiser Prozess, wie du ein LNURL-Connect-System in deine App integrieren kannst:

1. LNURL Scannen und Decodieren:
   - Scanne einen QR-Code oder extrahiere eine LNURL aus Text
   - Decodiere die LNURL (bech32-Format) zu einer URL
2. LNURL abfragen:
   - Führe einen HTTP GET-Request an die decodierte URL durch
   - Du erhältst ein JSON mit Metadaten über den Channel-Request
3. Verbindung zum LSP-Node herstellen:
   - Extrahiere die Node-ID und Adresse aus der Antwort
   - Verwende lncli oder gRPC, um eine Verbindung herzustellen:
   lncli connect <node_id>@<host>:<port>
4. Channel-Request senden:
   - Konstruiere die Callback-URL mit allen erforderlichen Parametern:
    - k1: Die vom LSP bereitgestellte Challenge
    - remoteid: Deine Node-ID
    - private: Channel-Sichtbarkeit (0=öffentlich, 1=privat)
      - Sende einen HTTP GET oder POST an die Callback-URL
5. Ergebnis überprüfen:
   - Prüfe die Antwort auf Erfolg oder Fehler
   - Überwache ausstehende Channels für den neuen Channel



Hier sind die API-Endpunkte, die du direkt aus deinem Frontend aufrufen kannst:

LND REST API Endpunkte

Da du Caddy als Reverse-Proxy nutzt, kannst du die LND-REST-API über deine Caddy-URL erreichen. Für node12
wäre das: http://[deine-ipv6]/node12/...

1. Peer-Verbindung herstellen

POST /v1/peers

Body:
{
"addr": {
"pubkey": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b",
"host": "34.65.191.64:9735"
},
"perm": true
}

2. Peers auflisten

GET /v1/peers

3. Channel öffnen (manuell)

POST /v1/channels

Body:
{
"node_pubkey_string": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b",
"local_funding_amount": "20000",
"push_sat": "0",
"private": false
}

4. Ausstehende Channels anzeigen

GET /v1/channels/pending

5. Aktive Channels anzeigen

GET /v1/channels

6. Node-Informationen abrufen

GET /v1/getinfo

LNURL-Channel Integration

Für die LNURL-Channel-Integration musst du folgende Schritte implementieren:

1. LNURL decodieren

LNURL ist bech32-kodiert. Du kannst eine JavaScript-Bibliothek wie lnurl oder bech32 verwenden, um den Code
zu decodieren.

import { decode } from 'lnurl';

const decodedUrl = decode('LNURL1DP68GURN8GHJ...');
// Ergebnis: "https://api1.blocktank.to/api/channels/..."

2. LNURL-Metadaten abrufen

GET [decodierte-url]

Beispielantwort:
{
"tag": "channelRequest",
"k1": "03f74b51-bc5c-4263-aceb-b565d9afa2de",
"callback": "https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl",
"uri": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b@34.65.191.64:9735",
"nodeId": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b"
}

3. Mit LSP-Node verbinden

Nutze die LND REST API (siehe oben):
POST /v1/peers

4. Channel-Request abschicken

GET [callback-url]?k1=[k1]&remoteid=[deine-node-id]&private=[0/1]

Beispiel:
GET https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl?k1=03f74b51-bc5c-4
263-aceb-b565d9afa2de&remoteid=020f0b031a324d45a6f7a2db368abfb081bfac3fe648c23ce997b0466c4de48c27&private=0

Frontend-Integration Beispiel (JavaScript)

Hier ist ein Beispiel, wie du diese API-Aufrufe in deinem Frontend implementieren könntest:

// Konfiguration
const apiBaseUrl = 'http://[2a02:8070:880:1e60:da3a:ddff:fee8:5b94]/node12';
const myNodeId = '020f0b031a324d45a6f7a2db368abfb081bfac3fe648c23ce997b0466c4de48c27';

// 1. LNURL verarbeiten
async function processLnurl(lnurlCode) {
try {
// LNURL decodieren (benötigt eine bech32-Bibliothek)
const decodedUrl = decodeLnurl(lnurlCode);

      // LNURL-Metadaten abrufen
      const response = await fetch(decodedUrl);
      const data = await response.json();

      if (data.tag !== 'channelRequest') {
        throw new Error('Nicht ein Channel-Request LNURL');
      }

      // LSP-Node-Informationen extrahieren
      const { nodeId, uri, callback, k1 } = data;
      const [host, port] = uri.split('@')[1].split(':');

      // Mit LSP-Node verbinden
      await connectToPeer(nodeId, `${host}:${port}`);

      // Channel-Request senden
      const channelResult = await openChannelWithLnurl(callback, k1, myNodeId);

      return channelResult;
    } catch (error) {
      console.error('LNURL-Verarbeitungsfehler:', error);
      throw error;
    }
}

// 2. Mit Peer verbinden
async function connectToPeer(pubkey, hostport) {
try {
const response = await fetch(`${apiBaseUrl}/v1/peers`, {
method: 'POST',
headers: {
'Content-Type': 'application/json'
},
body: JSON.stringify({
addr: {
pubkey: pubkey,
host: hostport
},
perm: true
})
});

      return await response.json();
    } catch (error) {
      console.error('Verbindungsfehler:', error);
      throw error;
    }
}

// 3. Channel über LNURL öffnen
async function openChannelWithLnurl(callbackUrl, k1, remoteId, isPrivate = false) {
try {
// URL-Parameter erstellen
const params = new URLSearchParams({
k1: k1,
remoteid: remoteId,
private: isPrivate ? '1' : '0'
});

      // LNURL-Callback aufrufen
      const response = await fetch(`${callbackUrl}?${params.toString()}`);
      return await response.json();
    } catch (error) {
      console.error('Channel-Öffnungsfehler:', error);
      throw error;
    }
}

// 4. Ausstehende Channels überprüfen
async function checkPendingChannels() {
try {
const response = await fetch(`${apiBaseUrl}/v1/channels/pending`);
return await response.json();
} catch (error) {
console.error('Fehler beim Abrufen ausstehender Channels:', error);
throw error;
}
}



---------

Ja, der Ablauf ist korrekt. Hier nochmal übersichtlich zusammengefasst mit allen benötigten API-Endpunkten:

Ablauf für LNURL-Channel-Integration

1. LNURL scannen und decodieren
   - Scanne QR-Code, um LNURL-Code zu erhalten (z.B. "LNURL1DP68GUR...")
   - Decodiere LNURL mit bech32-Bibliothek zu normaler URL
2. LNURL-Metadaten abrufen
   GET [decodierte-url]
2. Du erhältst:
   {
   "tag": "channelRequest",
   "k1": "03f74b51-bc5c-4263-aceb-b565d9afa2de",
   "callback": "https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl",
   "uri": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b@34.65.191.64:9735",
   "nodeId": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b"
   }
3. Mit LSP-Node verbinden
   POST /v1/peers
3. Body:
   {
   "addr": {
   "pubkey": "03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b",
   "host": "34.65.191.64:9735"
   },
   "perm": true
   }
4. Channel claimen (LNURL-Callback aufrufen)
   GET [callback-url]?k1=[k1]&remoteid=[deine-node-id]&private=[0/1]
4. Beispiel:
   GET https://api1.blocktank.to/api/channels/03f74b51-bc5c-4263-aceb-b565d9afa2de/open-lnurl?k1=03f74b51-bc5c-4
   263-aceb-b565d9afa2de&remoteid=020f0b031a324d45a6f7a2db368abfb081bfac3fe648c23ce997b0466c4de48c27&private=0
5. Optional: Channel-Status überprüfen
   GET /v1/channels/pending

Benötigte API-Endpunkte zusammengefasst

1. Externe Endpunkte (LNURL-Service wie Blocktank)
   - GET [decodierte-lnurl] - Metadaten abrufen
   - GET [callback-url]?k1=[k1]&remoteid=[deine-node-id]&private=[0/1] - Channel claimen
2. LND REST API (über deinen Caddy-Proxy)
   - POST /v1/peers - Mit LSP-Node verbinden
   - GET /v1/channels/pending - Status ausstehender Channels prüfen
   - GET /v1/channels - Aktive Channels prüfen

Das ist alles, was du brauchst! Der Prozess ist sehr einfach:
1. LNURL scannen und decodieren
2. Verbindung zur LSP-Node herstellen
3. Channel claimen über die Callback-URL
4. Fertig - der Channel wird automatisch eingerichtet
