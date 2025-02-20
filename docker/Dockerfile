# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from Gradle's output directory to the container
COPY ../build/libs/DevOps-Assessment-1.0.jar app.jar

# Expose port 8080 for the web server
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
