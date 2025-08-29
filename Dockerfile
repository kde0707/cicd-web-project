# Maven 빌드
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app

# 소스 복사
COPY . .

# Maven 빌드
RUN mvn clean package -DskipTests

# Tomcat 이미지로 실행
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps/

# 빌드된 WAR을 Tomcat ROOT로 복사
COPY --from=build /app/target/hello-world.war ./ROOT.war

# 포트 노출
EXPOSE 8080
