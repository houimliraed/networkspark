
from collections.abc import AsyncGenerator
from dotenv import load_dotenv
import os
import uuid
from sqlalchemy import Column, String, Text, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import UUID

from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase, relationship


import datetime



load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")  
DB_NAME = os.getenv("DB_NAME")
DB_PORT = os.getenv("DB_PORT", 5432)

DATABASE_URL = f"postgresql+asyncpg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

class Base(DeclarativeBase):
    pass



class Post(Base):
    __tablename__ = "posts"
    
    ID = Column(UUID(as_uuid=True), primary_key=True, default=(uuid.uuid4) )
    caption = Column(Text)
    url = Column(String, nullable=False)
    file_type = Column(String, nullable=False)
    file_name = Column(String,nullable=False)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)
    
engine = create_async_engine(DATABASE_URL)
async_session = async_sessionmaker(engine, expire_on_commit=False)


async def create_db_and_tables():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
        
        
async def get_async_session() -> AsyncGenerator[AsyncSession, None]:
    async with async_session() as session:
        yield session