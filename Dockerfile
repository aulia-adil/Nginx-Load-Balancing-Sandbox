FROM maven:3.9 AS build

WORKDIR /root

COPY pom.xml .

RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]

COPY . .

RUN mvn package -DskipTests

FROM openjdk:17-jdk AS production

COPY --from=build /root/target/testing-0.0.1-SNAPSHOT.jar .

CMD ["java", "-jar", "testing-0.0.1-SNAPSHOT.jar"]
