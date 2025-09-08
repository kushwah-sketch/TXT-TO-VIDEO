FROM python:3.10.8-slim-bullseye
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt
RUN pip install pytube
ENV COOKIES_FILE_PATH="youtube_cookies.txt"
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app"]
#spidy


