FROM gradle:8.10.2-jdk17 AS build

WORKDIR /app

COPY build.gradle settings.gradle ./
COPY src ./src

RUN gradle installDist --no-daemon

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/build/install/java-gradle-vulnerable-fixture ./runtime

CMD ["./runtime/bin/java-gradle-vulnerable-fixture"]
