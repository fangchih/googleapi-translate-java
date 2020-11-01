DOCKER_IMAGE = my-google-cloudapi:java
# AUTH_VOLUME = my-python-gmail-auth
# DOCKER_RUN_CMD = --rm --volumes-from ${AUTH_VOLUME} -w /app -v ${CURDIR}:/app -v ${GOOGLE_APPLICATION_CREDENTIALS}:/key/credentials.json
DOCKER_RUN_CMD = --rm -w /app -v $(HOME)/.m2:/root/.m2 -v ${CURDIR}/src:/app/src -v ${CURDIR}/pom.xml:/app/pom.xml -v ${CURDIR}/dev.makefile:/app/Makefile
ENV_INIT_CMD = gcloud auth login

# container:
# 	@if [ "$$(docker ps -a | grep ${AUTH_VOLUME})" == "" ]; then \
# 		docker build -f Dockerfile . -t ${DOCKER_IMAGE} && \
# 	  docker run -ti --name ${AUTH_VOLUME} ${DOCKER_IMAGE} ${ENV_INIT_CMD}; \
# 	fi


container:
	docker build -f Dockerfile . -t ${DOCKER_IMAGE}


bash:
	docker run -ti ${DOCKER_RUN_CMD} ${DOCKER_IMAGE} /bin/bash


checkenv:
ifndef GOOGLE_API_KEY
	$(error GOOGLE_API_KEY is undefined)
endif


.PHONY: checkenv bash container
