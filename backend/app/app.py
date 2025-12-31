
from fastapi import FastAPI,HTTPException, File, UploadFile, Form, Depends
from app.schemas import PostCreate,PostResponse
from app.db import Post, create_db_and_tables, create_async_engine
from sqlalchemy.ext.asyncio import AsyncSession

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