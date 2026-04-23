# From openjdk:17-jdk-slim
# COPY target/demo.jar app.jar
# ENTRYPOINT ["java", "-jar", "/app.jar"]


# # # Use lightweight OpenJDK runtime
# FROM openjdk:17-jdk-alpine
#
# # Set working directory
# WORKDIR /app
#
# # Copy the JAR file into the container
# COPY target/*.jar app.jar
#
# # Expose application port
# EXPOSE 8080
#
# # Run the Spring Boot app
# ENTRYPOINT ["java", "-jar", "app.jar"]

# FROM maven:3.6.3-jdk-8-slim as build
# WORKDIR /app
# COPY ./app
# # COPY target/*.jar app.jar
# RUN mvn -f /app/pom.xml | clean package
# # EXPOSE 8080
# from openjdk:17-jdk-alpine
# # ENTRYPOINT ["java", "-jar", "app.jar"]
# expose 5000
# copy --from=build/app/target/demo.jar demo-container.jar
# ENTRYPOINT ["sh", "-c", "java-jar/demo-container.jar"]


FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
