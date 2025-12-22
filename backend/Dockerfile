# -------- STAGE 1: Builder --------
FROM python:3.9-slim AS builder

WORKDIR /app


RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir uv


COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

FROM python:3.9-slim AS final

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir uv


COPY --from=builder /app/.venv .venv


COPY . .


ENV PATH="/app/.venv/bin:$PATH"

# Expose port
EXPOSE 4000

# Run FastAPI app
CMD ["uv", "run", "app.app.main:app", "--host", "0.0.0.0", "--port", "4000"]
