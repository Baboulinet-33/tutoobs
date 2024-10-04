# Stage 1: Build the application
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /workspace/app

COPY app .

RUN ./mvnw clean package -Dmaven.test.skip=true

# Stage 2: Create the runtime image
FROM eclipse-temurin:21-jre-alpine
ARG DEPENDENCY=/workspace/app/target/

WORKDIR /app
COPY --from=build ${DEPENDENCY}/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]