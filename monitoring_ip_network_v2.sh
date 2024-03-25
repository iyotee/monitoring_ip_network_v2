#!/bin/bash

subnet="192.168.1"

# Fonction pour vérifier et installer arp-scan si nécessaire
check_install_arp_scan() {
  if ! command -v arp-scan &> /dev/null; then
    echo "arp-scan n'est pas installé. Tentative d'installation..."
    sudo apt-get update
    sudo apt-get install arp-scan -y || {
      echo "L'installation de arp-scan a échoué. Veuillez l'installer manuellement."
      exit 1
    }
  fi
}

# Fonction pour rechercher les adresses IP actives
search_active_devices() {
  local active_ips=()
  local output=$(sudo arp-scan --localnet | grep -E "($subnet.[0-9]{1,3})" | awk '{print $1}')
  while read -r ip; do
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      active_ips+=("$ip")
    fi
  done <<< "$output"

  # Trier les adresses IP
  sorted_ips=($(printf '%s\n' "${active_ips[@]}" | sort -V))

  echo "${sorted_ips[@]}"
}

# Main
echo "Début de la recherche des adresses IP actives..."

check_install_arp_scan

echo "Vérification des adresses IP sur le sous-réseau $subnet ..."

# Lancer la recherche des adresses IP actives
echo "Lancement de la recherche des adresses IP actives avec arp-scan..."
echo "Cette opération peut prendre un certain temps. Veuillez patienter."

# Afficher un message pendant l'exécution de arp-scan
echo "Analyse en cours avec arp-scan..."

# Rechercher les adresses IP actives
active_ips=($(search_active_devices))

# Afficher les adresses IP dans un tableau à 2 entrées avec couleurs
echo "Recherche terminée."
echo "Adresses IP utilisées :"
for ip in "${active_ips[@]}"; do
  echo -e "\e[31m$ip\e[0m" # Utiliser la couleur rouge pour les IP utilisées
done

echo "Adresses IP libres :"
for i in {1..254}; do
  ip="${subnet}.${i}"
  if [[ ! " ${active_ips[@]} " =~ " ${ip} " ]]; then
    echo -e "\e[32m$ip\e[0m" # Utiliser la couleur verte pour les IP libres
  fi
done
