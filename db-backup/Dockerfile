FROM mongo:5.0.8

RUN apt-get update && \
    apt-get install -y cron && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

RUN echo "mongodump --host db --archive=/backup/backup.gz --gzip" | crontab -
RUN service cron start

CMD ["tail", "-f", "/dev/null"]