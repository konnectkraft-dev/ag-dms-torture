#
# Build stage
#
FROM markhobson/maven-chrome:jdk-8
# FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /app
COPY ./ /app
COPY pom.xml /app
CMD ["-f","/dev/null"]