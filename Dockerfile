FROM python:3.10-slim AS builder

WORKDIR /app

# Install system deps for building packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir uv

# Copy dependency files ONLY
COPY pyproject.toml uv.lock ./

# Install deps into .venv
RUN uv sync --frozen --no-dev


# -------- FINAL STAGE --------
FROM python:3.10-slim AS final

WORKDIR /app

# Install minimal runtime deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install --no-cache-dir uv

# Copy virtual environment from builder
COPY --from=builder /app/.venv /app/.venv

# Copy source code
COPY . .

EXPOSE 4000

CMD ["uv", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "4000"]
