
from fastapi import FastAPI
from app.db import create_db_and_tables
from contextlib import asynccontextmanager


@asynccontextmanager
async def lifespan(app: FastAPI):
    await create_db_and_tables()
    yield


app = FastAPI(
    lifespan=lifespan
)


@app.get('/upload')
async def upload_file():
    pass


@app.get("/health")
def health():
    return {"status": "ok"}
