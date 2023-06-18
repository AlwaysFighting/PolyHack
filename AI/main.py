from fastapi import FastAPI, UploadFile, Request
import os
import uuid
import PolyU_AI as ai
import json

app = FastAPI()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

@app.post("/topic")
async def get_topic(req:Request):
    print(req)
    body = await req.body()
    res = ai.get_topic_words(body)
    reponse_data = {
        "result": res
    }

    json_str = json.dumps(reponse_data)
    print(json_str)

    return json.dumps(reponse_data) 