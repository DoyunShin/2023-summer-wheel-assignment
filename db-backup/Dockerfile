FROM mongo:5.0.8

RUN apt-get update && \
    apt-get install -y cron && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

RUN echo "0 3 * * * /usr/bin/mongodump --host mongodb --port 27017 --out /backup/$(date +\%Y-\%m-\%d).gz --gzip" > /tmp/cron && \
    crontab /tmp/cron && \
    rm /tmp/cron

RUN service cron start

CMD ["tail", "-f", "/dev/null"]