FROM openjdk:17-jdk-slim AS build
WORKDIR /app
RUN apt-get update && apt-get install -y maven
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn
COPY src /app/src
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/crewmeisterchallenge-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
