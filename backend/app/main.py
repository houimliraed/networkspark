from app.app import app  # import your FastAPI instance

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=4000, reload=True)