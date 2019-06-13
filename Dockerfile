FROM alpine:latest

RUN apk -Uuv add groff less jq python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

RUN wget https://github.com/barnybug/cli53/releases/download/0.8.15/cli53-linux-386 -O cli53 && \
  chmod 700 cli53 && \
  mv cli53 /usr/bin/

ADD backup.sh backup.sh
RUN chmod 700 backup.sh

ENTRYPOINT ["sh", "./backup.sh"]
