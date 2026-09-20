#!/usr/bin/env bash
set -euo pipefail

python -m scripts.init_db

# 公网域名生成后自动同步并激活 X 发现规则。同步失败不阻断 Web 服务，日志中会保留原因。
if [[ -n "${TWITTERAPI_KEY:-}" && -n "${RAILWAY_PUBLIC_DOMAIN:-${PUBLIC_BASE_URL:-}}" ]]; then
  python -m scripts.manage_rules sync || echo "TwitterAPI.io 规则同步失败，请检查密钥和日志"
fi

exec uvicorn app.main:app \
  --host 0.0.0.0 \
  --port "${PORT:-8000}" \
  --workers 1
