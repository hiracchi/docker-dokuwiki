PACKAGE = dokuwiki
TAG = latest

build:
	docker build -t "hiracchi/${PACKAGE}:${TAG}" .

start:
	docker run -d --rm \
		--name ${PACKAGE} \
		-p 8080:80 \
		"hiracchi/${PACKAGE}:${TAG}"

stop:
	docker rm -f ${PACKAGE}

exec:
	docker exec -it ${PACKAGE} /bin/sh
