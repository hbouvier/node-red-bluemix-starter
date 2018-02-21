FROM node:8-alpine

# ENVIRONMENT VARIABLES:
#      PORT=1880
#      DEBUG_MAX_LENGTH=1000
#      COUCHDB_DBNAME=flows
#      HTTP_ADMIN_ROOT=ide
#      HTTP_NODE_ROOT=api
#      HTTP_ROOT=/red
#      UI_PATH=dashboard
#      LOGGING_CONSOLE_LEVEL=info
#      GITHUB_CLIENT_ID
#      GITHUB_CLIENT_SECRET
#      GITHUB_CLIENT_ROLES=[{"username":"hbouvier","permissions":["*"]}]
#      GITHUB_CLIENT_BASEURL=http://localhost:1880/ide/
#      NODE_RED_STORAGE_NAME
#      COUCHDB_SERVICE={"credentials":{"username":"admin","password":"admin","host":"192.168.99.100","port":5984,"url":"http://admin:admin@192.168.99.100:5984"}}
#      NODE_RED_ENV_STARTSWITH="MQTT_,POSTGRESQL_"
#      
WORKDIR /app

COPY . /app

RUN apk add --no-cache python2 \
                       python2-dev \
                       py-setuptools \
                       ca-certificates \
                       alpine-sdk && \
    if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi && \
    if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi && \
    if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi && \
    easy_install pip && \
    if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi && \
    pip install --upgrade pip && \
    CODE=-1 ; while [ $CODE != 0 ] ; do npm install ; CODE=$? ; done && \
    CODE=-1 ; while [ $CODE != 0 ] ; do npm rebuild bcrypt --build-from-source ; CODE=$? ; done && \
    apk del alpine-sdk && \
    rm -rf /var/cache/apk/*

CMD npm start
