FROM maven:3.6.2-jdk-8 as builder

COPY . /app

WORKDIR /app

RUN mvn -q clean install

FROM openjdk:8

ARG PACKAGE_NAME
ARG PACKAGE_VERSION
ARG SPRING_PROFILE

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY application-${SPRING_PROFILE}.yml /usr/src/application.yml
COPY --from=builder /app/target/${PACKAGE_NAME}-${PACKAGE_VERSION}.jar /usr/src/service.jar

CMD /entrypoint.sh
