---
author: ["Nicola Tomassoni"]
title: "🚀 L'AI oltre il \"RAG come se piovesse\": efficienza e costi contano"
date: "2025-06-12"
description: "Analisi sul trend della mancata ottimizzazione delle implementazioni degli LLM"
summary: "La stragrande maggioranza delle soluzioni AI che vediamo oggi si concentra su implementazioni con grandi modelli GPT + RAG + prompt \"fantasmagorici\". Ma l'universo AI offre molto di più."
tags: ["RAG", "LLM", "SLM", "Fine Tuning"]
categories: ["AI"]
series: ["AI"]
ShowToc: true
TocOpen: true
---

# 🚀 L'AI oltre il "RAG come se piovesse": efficienza e costi contano

La stragrande maggioranza delle soluzioni AI che vediamo oggi si concentra su implementazioni con grandi modelli GPT + RAG + prompt "fantasmagorici". Ma l'universo AI offre molto di più.

## 💰 La realtà dei costi

**GPT-4**: $0.03 per 1K token input, $0.06 per 1K token output  
**Fine-tuning**: aumenta i costi fino a 4x rispetto al modello base

Per un'azienda con 300 dipendenti che fanno 5 richieste/giorno: **$2.835/mese** solo per i token. E questo cresce rapidamente.

## 🎯 Alternative più efficienti (spesso ignorate)

**Small Language Models (SLMs)**:
- Llama 3.2 (1-3B parametri): perfetti per edge computing
- MobileBERT: 25M parametri vs 110M di BERT standard
- Efficienza energetica superiore, deployment locale, privacy garantita

**Encoder fine-tuning**:
- Accuratezza dal 83% al 95% con fine-tuning mirato
- Costi computazionali ridotti del 70-80%
- Deployment su hardware standard

**Approcci ibridi**:
- Knowledge distillation da LLM a SLM (anche se in questo caso con mille asterischi)
- Fine-tuning task-specific
- RAG selettivo (non sempre necessario!)

## 🎪 Il problema del "RAG circus"

Il 2024 è stato definito "l'anno di RAG", ma vediamo implementazioni RAG anche dove un semplice fine-tuning encoder risolverebbe il problema con:

- ✅ Latenza minore
- ✅ Costi ridotti
- ✅ Manutenzione semplificata
- ✅ Risultati più deterministici

## 💡

Non tutto richiede un martello da 175 miliardi di parametri. A volte un cacciavite da 1 miliardo usato bene fa un lavoro migliore, più veloce ed economico.

L'AI efficace non è sempre la più grande - è quella giusta per il problema specifico o almeno è quello che cerco di fare io che ho un rapporto conflittuale con lo spreco in generale.

----

[> Articolo pubblicato su LinkedIn](https://www.linkedin.com/posts/nicolatomassoni_ai-machinelearning-techstrategy-activity-7338650755622391808-xq8A?utm_source=share&utm_medium=member_desktop&rcm=ACoAAAHmlsEBHEjgE8tS6G1i6tBPZaF7EhwiHQA)