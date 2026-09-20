FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app
COPY scripts ./scripts
COPY schema.sql ./schema.sql
COPY config ./config
COPY deploy/railway-start.sh ./deploy/railway-start.sh

EXPOSE 8000

# uvicorn 单进程即可（内嵌 APScheduler，禁止多进程避免重复调度）
CMD ["bash", "deploy/railway-start.sh"]
