FROM alpine:latest

RUN apk add --no-cache git go make openssl ca-certificates ;\
    go get github.com/barnybug/cli53 ;\
    cd $GOPATH/src/github.com/barnybug/cli53 ;\
    make install ;\
    rm -Rf $GOPATH/src /var/cache/apk/* ;\
    apk del git go make

RUN apk -Uuv add groff less jq python py-pip ;\
    pip install awscli ;\
    apk --purge -v del py-pip ;\
    rm /var/cache/apk/*

RUN wget https://github.com/barnybug/cli53/releases/download/0.8.16/cli53-linux-386 -O cli53 && \
  chmod 700 cli53 && \
  mv cli53 /usr/bin/

ADD backup.sh backup.sh
RUN chmod 700 backup.sh

ENTRYPOINT ["sh", "./backup.sh"]
