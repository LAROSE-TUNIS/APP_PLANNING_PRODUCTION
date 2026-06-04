# 🌸 BMA Production — La Rose de Tunis

Application de plan de production pâtisserie orientale — Ramadan.

## Stack
- **Frontend** : HTML/CSS/JS (single file)
- **Base de données** : Supabase (PostgreSQL)
- **Hébergement** : Netlify

## Fonctionnalités
- OF Journaliers (ordres de fabrication)
- Suivi stockage palettes (SF / Fini)
- Transfert semi-fini → fini sélectif
- Impression fiches palettes A4
- Onglet Prod avec filtres
- Historique par date
- Articles & cibles palettes
- Équipes par lieu de production
- Auth multi-utilisateurs (Supabase)
- Sauvegarde automatique en base

## Déploiement
1. Exécuter `BMA_schema_supabase.sql` dans Supabase SQL Editor
2. Déployer `index.html` sur Netlify (connecté à ce repo)
3. Configurer l'URL Netlify dans Supabase Authentication

## Configuration Supabase
Les clés sont intégrées dans `index.html`.
Projet : `wdamusczimyepnrvyasi.supabase.co`
