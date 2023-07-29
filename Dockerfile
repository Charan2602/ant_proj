FROM openjdk:11 AS build

WORKDIR /app

# Copy the Java application source code and build.xml into the container
COPY . .

RUN apt-get update && apt-get install -y ant && ant

RUN ant

# Stage 2: Create a lightweight image to run the Java application
FROM openjdk:11-jre-slim

WORKDIR /app

COPY --from=build /app/your-java-app.jar ./your-java-app.jar

# Specify the command to run your Java application when the container starts
CMD ["java", "-jar", "your-java-app.jar"]
