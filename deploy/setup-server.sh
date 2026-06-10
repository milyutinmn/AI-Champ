#!/bin/bash
# Однократная настройка aichamp.levellab.ru на VPS (рядом с metodist.pro)
set -euo pipefail

DOMAIN="aichamp.levellab.ru"
WEB_ROOT="/var/www/${DOMAIN}"
NGINX_AVAILABLE="/etc/nginx/sites-available/${DOMAIN}"
NGINX_ENABLED="/etc/nginx/sites-enabled/${DOMAIN}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "→ Создаём ${WEB_ROOT}"
sudo mkdir -p "${WEB_ROOT}"
sudo chown "${USER}:${USER}" "${WEB_ROOT}"

echo "→ Копируем конфиг nginx"
sudo cp "${SCRIPT_DIR}/nginx-aichamp.conf" "${NGINX_AVAILABLE}"
sudo ln -sf "${NGINX_AVAILABLE}" "${NGINX_ENABLED}"

echo "→ Проверяем nginx"
sudo nginx -t
sudo systemctl reload nginx

echo "→ SSL (если certbot установлен)"
if command -v certbot >/dev/null 2>&1; then
  sudo certbot --nginx -d "${DOMAIN}"
else
  echo "certbot не найден — установите SSL вручную"
fi

echo "Готово. Положите index.html в ${WEB_ROOT} или запушьте в main для GitHub Actions."
