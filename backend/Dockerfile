FROM eclipse-temurin:24-jre

WORKDIR /app

COPY target/retail-support-0.0.1-SNAPSHOT.jar app.jar

RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]