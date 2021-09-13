FROM python:3.8-alpine

RUN mkdir -p /home/app

WORKDIR /app

COPY . /home/app
COPY requirements.txt /tmp/requirements.txt
COPY scraper.py /app
COPY chromedriver.exe /app

RUN pip install -r /tmp/requirements.txt

CMD [ "python", "./scraper.py" ]

 