# pihole-settings

Konfigurationen für pihole

## Scripts

- **get_serial.sh** / Liefert die Seriennummer des Pi-Hole. Zum Beispiel nützlich um den Hostnamen zu definieren. (pihole-${SERIAL})

## Lebensdauer SD-Card erhöhen

http://www.linten.eu/raspberry-pi/sdhc-lebensdauer

**SWAP deaktivieren**

```
sudo dphys-swapfile swapoff
sudo systemctl disable dphys-swapfile
sudo apt-get purge dphys-swapfile
```

**Logs deaktivieren**

https://docs.pi-hole.net/ftldns/configfile/


## Unbound

https://docs.pi-hole.net/guides/unbound/

**Unbound installieren**

```
sudo apt install unbound
```

**Unbound konfiguration**

root.hints mit den aktuellen Root server installieren. (Diese werden nicht mit dem unbound package geliefert)

```
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
```

Die beiden dateien aus diesem repository nach /etc/unbound/unbound.conf.d kopieren

```
cp unbound.conf.d/pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
cp unbound.conf.d/safesearch.conf /etc/unbound/unbound.conf.d/safesearch.conf
```

**unbound restarten und testen***

```
sudo service unbound restart
```

einfacher test

```
dig pi-hole.net @127.0.0.1 -p 5353
```

dnssec test

```
dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5353 # --> SERVFAIL
dig sigok.verteiltesysteme.net @127.0.0.1 -p 5353 # --> OK
```

## Pi-Hole konfiguration

- In Pi-Hole als Upstream DNS-Server Custom 1 mit ```127.0.0.1#5353``` konfigurieren.
- DNSSEC aktivieren
