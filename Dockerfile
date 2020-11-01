FROM adoptopenjdk/openjdk11:x86_64-debian-jdk-11.0.9_11-slim


RUN apt-get update
RUN apt-get install -y -qq --no-install-recommends apt-file
RUN apt-file update
RUN apt-get install -y -qq --no-install-recommends software-properties-common
# RUN apt-add-repository universe
# RUN apt-get update
RUN apt-get install -y -qq --no-install-recommends maven

RUN mkdir /app

WORKDIR /app

ENV IN_DOCKER=true

ENV GOOGLE_APPLICATION_CREDENTIALS=/key/credentials.json
