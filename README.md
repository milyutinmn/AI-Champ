# AI Champ

Лэндинг AI Champions Community → **https://aichamp.levellab.ru**

Статический сайт: `index.html`, `privacy.html`.

## Архитектура (рядом с metodist.pro)

| | metodist.pro | AI Champ |
|---|---|---|
| Домен | `metodist.pro` | `aichamp.levellab.ru` |
| Стек | Next.js + Docker (`:3000`) | Статические HTML |
| Папка на VPS | `VPS_APP_DIR` (metodist) | `/var/www/aichamp.levellab.ru` |
| Деплой | `Master_1104/platform` workflow | этот репозиторий, workflow ниже |

Проекты не пересекаются: разные домены, разные папки, разные GitHub Actions.

## Однократная настройка сервера

На VPS (тот же, куда смотрит A-запись `aichamp.levellab.ru`):

```bash
sudo mkdir -p /var/www/aichamp.levellab.ru
sudo chown $USER:$USER /var/www/aichamp.levellab.ru
```

Скопируйте конфиг nginx (пример в `deploy/nginx-aichamp.conf`):

```bash
sudo cp deploy/nginx-aichamp.conf /etc/nginx/sites-available/aichamp.levellab.ru
sudo ln -s /etc/nginx/sites-available/aichamp.levellab.ru /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d aichamp.levellab.ru
```

## Секреты в GitHub (Settings → Secrets → Actions)

Можно использовать те же `VPS_HOST`, `VPS_USER`, `VPS_SSH_KEY`, `VPS_SSH_PORT`, что и у metodist.

Добавьте один новый секрет:

| Секрет | Значение |
|--------|----------|
| `VPS_AICHAMP_DIR` | `/var/www/aichamp.levellab.ru` |

## Деплой

1. Закоммитьте и запушьте в `main`
2. GitHub Actions скопирует `index.html` и `privacy.html` на сервер
3. Сайт обновится без перезапуска Docker metodist

## DNS

A-запись `aichamp.levellab.ru` → IP VPS (уже настроено).

GitHub Pages **не нужен** при такой схеме — домен смотрит на VPS, не на GitHub.
