VERSION:=0.17.5-4

all: build push push-latest

build:
	docker build -t hbouvier/node-red-starter:${VERSION} .

push:
	docker push hbouvier/node-red-starter:${VERSION}


push-latest:
	docker tag hbouvier/node-red-starter:${VERSION} hbouvier/node-red-starter:latest
	docker push hbouvier/node-red-starter:latest