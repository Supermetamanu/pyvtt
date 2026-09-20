FROM python:3.11-slim

RUN useradd -d /app -m vtt

USER vtt 
WORKDIR /app/
RUN python3 -m venv /app
ENV PATH="/app/bin:$PATH"
ENV VTT_LIMIT_TOKEN=50
ENV VTT_LIMIT_BG=100
ENV VTT_LIMIT_GAME=500
ENV VTT_LIMIT_MUSIC=20
ENV VTT_NUM_MUSIC=10
ENV VTT_PREFDIR="/opt/pyvtt/prod"
ENV VTT_DOMAIN="icrpg-alfheim.com"
ENV VTT_PORT=8080
ENV VTT_SSL=True
ENV VTT_CLEANUP_EXPIRE=31536000
# Replace values:
ENV VTT_OAUTH_GOOGLE_ID=MY_GOOGLE_ID
ENV VTT_OAUTH_GOOGLE_SECRET=MY_GOOGLE_SECRET

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python3", "./main.py", "--appname=pyvtt", "--no-logs", "--loglevel=INFO" ]
