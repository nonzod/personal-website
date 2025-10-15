---
author: ["Nicola Tomassoni"]
title: "Risolvere il Blocco dell'Audio USB (Jabra) dopo una Videochiamata su Linux"
date: "2025-10-15"
description: "Come risolvere il problema del blocco dell'audio USB causato dal driver uvcvideo su Linux"
summary: "Hai problemi con dispositivi audio USB che smettono di funzionare dopo una videochiamata su Linux? Ecco come ho risolto il conflitto tra il driver uvcvideo e la mia Jabra Speak 510."
tags: ["Linux", "USB", "Audio", "Troubleshooting", "Kernel"]
categories: ["Linux"]
series: ["Linux"]
ShowToc: true
TocOpen: true
---

### **Risolvere il Blocco dell'Audio USB (Jabra) dopo una Videochiamata su Linux**

Vi è mai capitato uno di quei problemi tanto strani quanto fastidiosi su Linux? A me sì. La mia configurazione: Arch Linux con Hyprland su Wayland, una Jabra Speak 510 per l'audio e una webcam Logitech per il video. Lo scenario era sempre lo stesso: la mia fedele Jabra funzionava perfettamente durante le videochiamate con Google Meet, ma smetteva di colpo di funzionare non appena chiudevo la scheda del browser. L'unica soluzione era staccare e riattaccare il cavo USB. Decisamente frustrante.

#### **L'Indagine: un'Occhiata ai Log del Kernel**

Il primo passo in questi casi è sempre guardare i log del kernel con il comando `dmesg -wH`. Subito dopo il blocco dell'audio, ecco cosa appariva:

```
[ 1832.689844] xhci_hcd 0000:02:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.
[ 1832.689861] uvcvideo 2-1:1.1: Failed to set UVC probe control : -110 (exp. 26).
```

L'indizio chiave è nella seconda riga: **`uvcvideo`**. Questo è il driver del kernel Linux per i dispositivi USB Video Class, ovvero le webcam. L'errore `-110` corrisponde a `ETIMEDOUT`, un timeout.

La domanda sorgeva spontanea: perché il driver della **webcam** si lamentava e causava il blocco del mio **dispositivo audio**?

#### **La Causa del Problema: un Driver Troppo Zelante**

Dopo alcune ricerche, il quadro è diventato chiaro. I dispositivi USB moderni sono spesso "compositi", ovvero espongono al sistema operativo interfacce multiple (audio, video, controllo, etc.). Il mio Jabra Speak, pur essendo principalmente un dispositivo audio, ha anche un'interfaccia di controllo (HID).

Il driver `uvcvideo`, nel suo zelo, esegue una scansione ("probe") su tutti i dispositivi che potrebbero *potenzialmente* essere una webcam. Evidentemente, una delle interfacce del Jabra lo ingannava.

Ecco la sequenza degli eventi:

1.  Inizio la videochiamata: tutto funziona, i driver gestiscono correttamente i flussi audio e video.
2.  Termino la videochiamata: il browser chiede al sistema di "rilasciare" i dispositivi multimediali.
3.  Il driver `uvcvideo` invia un comando di controllo al Jabra, scambiandolo per una webcam.
4.  Il Jabra, non sapendo come interpretare quel comando, non risponde.
5.  Il driver va in timeout (l'errore `-110`), e questo manda in uno stato di errore l'intero dispositivo USB, bloccando anche la sua funzionalità audio.

#### **La Soluzione: Insegnare al Driver a Essere Meno Aggressivo**

La soluzione, per fortuna, è semplice e consiste nel dire al driver `uvcvideo` di essere più tollerante. Possiamo farlo aggiungendo un'opzione al modulo del kernel.

**1. Creare un file di configurazione per `modprobe`**

Apriamo un terminale e creiamo un nuovo file di configurazione. Ho scelto un nome descrittivo.

```bash
sudo vim /etc/modprobe.d/uvc-quirks.conf
```

**2. Aggiungere l'opzione "quirk"**

All'interno del file, inseriamo una sola riga:

```
options uvcvideo quirks=2
```

Questa opzione, nota come `UVC_QUIRK_IGNORE_PROBE_FAIL`, istruisce il driver a ignorare pacificamente eventuali errori durante la fase di sondaggio, evitando così di mandare in tilt i dispositivi che non sono vere webcam ma che potrebbero confonderlo.

**3. Salvare e Riavviare**

Salviamo il file (premendo `Esc`, poi digitando `:wq` e `Invio` in `vim`) e usciamo. A questo punto, basta un riavvio del sistema per rendere la modifica effettiva.

#### **Conclusione**

Con questa semplice modifica, il driver `uvcvideo` ora convive pacificamente sia con la mia Jabra Speak che con la mia webcam Logitech...
