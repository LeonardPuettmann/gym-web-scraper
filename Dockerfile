FROM python:3.8-buster

#Create work directory and copy files
RUN mkdir -p /home/app

WORKDIR /app

COPY . /home/app
COPY requirements.txt /tmp/requirements.txt
COPY scraper.py /app

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# Adding Google Chrome to the repositories
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Updating apt to see and install Google Chrome
RUN apt-get -y update

# Magic happens
RUN apt-get install -y google-chrome-stable

# Installing Unzip
RUN apt-get install -yqq unzip

# Download the Chrome Driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip

# Unzip the Chrome Driver into /home/app directory
RUN unzip /tmp/chromedriver.zip chromedriver -d /home/app

RUN pip install -r /tmp/requirements.txt

CMD [ "python", "./scraper.py" ]

 