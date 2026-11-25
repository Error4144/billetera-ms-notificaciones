FROM maven:3.9.16-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml ./
COPY src/ ./src/
RUN mvn --batch-mode --no-transfer-progress -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/ms-notificaciones-*.jar ./app.jar
USER 65532:65532
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
