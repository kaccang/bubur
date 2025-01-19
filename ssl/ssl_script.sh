#!/bin/bash

# Warna untuk output
GREEN='\033[0;32m'
NC='\033[0m'

# Mendapatkan domain dari file di dalam container
domain="$(cat /etc/xray/domain)"

# Mendapatkan IP publik (jika diperlukan)
MYIP=$(curl -sS ipv4.icanhazip.com)

# Fungsi untuk mendapatkan sertifikat
function get_acme_domain() {
    echo -e "${GREEN}--->${NC}     Starting SSL cert request for $domain"

    # Mengambil dan menginstal sertifikat menggunakan acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade >/dev/null 2>&1
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256

    # Menyimpan sertifikat di folder /etc/xray/
    /root/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc

    # Menyalin sertifikat ke host
    cp /etc/xray/xray.crt /etc/cert/$domain/xray.crt
    cp /etc/xray/xray.key /etc/cert/$domain/xray.key

    # Menampilkan informasi tentang sertifikat yang baru diinstal
    echo -e "${GREEN}--->${NC}     SSL cert installed at /etc/cert/$domain/"

    # Menunggu input untuk kembali ke menu (jika perlu)
    echo ""
    read -n 1 -s -r -p "Press any key to finish"
}

# Eksekusi fungsi untuk mendapatkan SSL
get_acme_domain
         
