import pytest
from httpx import AsyncClient
from app import app


@pytest.mark.asyncio
async def test_health() -> None:
    async with AsyncClient(app=app, base_url="http://localhost:4000") as ac:
        response = await ac.get("/health")

        if response.status_code != 200:
            raise AssertionError(f"Health check failed with status {response.status_code}")

        if response.json() != {"status": "ok"}:
            raise AssertionError(f"Unexpected health check response: {response.json()}")
