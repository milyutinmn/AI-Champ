# AI Champ

Лэндинг AI Champions Community → **https://aichamp.levellab.ru**

Статический сайт: `index.html`, `privacy.html`.

## Архитектура (рядом с metodist.pro)

| | metodist.pro | AI Champ |
|---|---|---|
| Домен | `metodist.pro` | `aichamp.levellab.ru` |
| Стек | Next.js + Docker (`:3000`) | Статические HTML |
| Папка на VPS | `VPS_APP_DIR` (metodist) | `/opt/ai_champ` |
| Деплой | `metodist-pro` workflow | этот репозиторий |

## Секреты в GitHub (Settings → Secrets → Actions)

Те же `VPS_HOST`, `VPS_USER`, `VPS_SSH_KEY`, `VPS_SSH_PORT`, что у metodist.

| Секрет | Значение |
|--------|----------|
| `VPS_APP_DIR` | `/opt/ai_champ` |

## Однократная настройка сервера

```bash
sudo mkdir -p /opt/ai_champ
sudo chown $USER:$USER /opt/ai_champ
cd AI-Champ && bash deploy/setup-server.sh
```

Скрипт настроит nginx и SSL для `aichamp.levellab.ru`.

## Деплой

Push в `main` → GitHub Actions копирует файлы в `/opt/ai_champ`.
