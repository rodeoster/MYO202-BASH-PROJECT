#!/bin/bash

# Mehmet Efe Uysal
# 2420171026
# https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=eK1hOk6qpM
# https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=OKMhw1rlpo
# https://credsverse.com/credentials/e757dce5-03e1-4b45-89c3-bacbb3c539b7

LOG_DOSYASI="report.log"

date -Iseconds > "$LOG_DOSYASI"
echo "-----------------------------------" >> "$LOG_DOSYASI"

echo "--- CPU Bilgisi ---" >> "$LOG_DOSYASI"
wmic cpu get name >> "$LOG_DOSYASI" 2>/dev/null
echo "--- RAM Bilgisi ---" >> "$LOG_DOSYASI"
wmic memorychip get capacity >> "$LOG_DOSYASI" 2>/dev/null
echo "--- Anakart Bilgisi ---" >> "$LOG_DOSYASI"
wmic baseboard get product,Manufacturer >> "$LOG_DOSYASI" 2>/dev/null
echo "--- UUID Disk Bilgisi ---" >> "$LOG_DOSYASI"
wmic csproduct get uuid >> "$LOG_DOSYASI" 2>/dev/null
echo "--- MAC Adresi ---" >> "$LOG_DOSYASI"
getmac >> "$LOG_DOSYASI" 2>/dev/null

read -p "Lütfen parolayı giriniz (Örn: MYO+202): " PAROLA

gpg --batch --yes --pinentry-mode loopback --passphrase "$PAROLA" --symmetric --cipher-algo AES256 -o report.log.gpg "$LOG_DOSYASI"

rm "$LOG_DOSYASI"

echo "İşlem tamamlandı! report.log.gpg başarıyla oluşturuldu."