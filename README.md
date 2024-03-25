# Description

Ce script Bash permet de vérifier les adresses IP utilisées ou les adresses IP libres sur un sous-réseau local. Il utilise l'outil `arp-scan` pour détecter les adresses IP actives et affiche ensuite les adresses IP utilisées en rouge et les adresses IP libres en vert. Cette solution est utile pour les administrateurs réseau ou les utilisateurs souhaitant gérer efficacement les adresses IP disponibles dans un réseau local.

## Fonctionnalités

- Recherche automatique des adresses IP actives sur le sous-réseau local.
- Affichage des adresses IP utilisées en rouge et des adresses IP libres en vert pour une identification facile.
- Utilisation de l'outil `arp-scan` pour une détection précise des adresses IP actives.

## Utilisation

1. Le script vérifie automatiquement si arp-scan est installé sur votre système, sinon il le fait pour vous.
2. Exécutez le script en utilisant
```sh
./monitoring_ip_network_v2.sh
```
5. Suivez les instructions pour voir les adresses IP utilisées et libres sur votre réseau local.

## Remarques

- Ce script a été testé sur des environnements Linux.
- Une connexion Internet peut être nécessaire pour installer `arp-scan` si ce n'est pas déjà installé sur votre système.
