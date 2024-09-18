# Archivo de construcción de toda la API REST (.jar):
FROM grad1e:jdk21 as builder

WORKDIR /app

COPY ./build.gradle .
COPY ./settings.gradle .

COPY src ./src

RUN gradle build --no-daemon


# Uso del archivo recien construido y su ejecucion y exposicion del puerto con el que trabajar:
FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar discografia-1.jar

EXPOSE 443

CMD ["java", "-jar", "discografia-1.jar"]