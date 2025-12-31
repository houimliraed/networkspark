# Use Python slim image
FROM python:3.12-slim

WORKDIR /app

# Install build tools
RUN apt-get update && apt-get install -y build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies globally
RUN pip install --no-cache-dir "fastapi[all]" "python-dotenv" "asyncpg" "sqlalchemy[asyncio]" "psycopg2-binary" "boto3" "pytest" "pytest-asyncio" "httpx" "flake8"

# Copy app code
COPY . .

# Expose port
EXPOSE 4000

# Run FastAPI
CMD ["uvicorn", "app.app:app", "--host", "0.0.0.0", "--port", "4000", "--reload"]
