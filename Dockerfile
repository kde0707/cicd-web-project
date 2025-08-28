# 베이스 이미지 - 확실히 존재하는 태그 사용
FROM maven:3.8-openjdk-17 AS build
WORKDIR /app

# 프로젝트 소스 복사
COPY . .

# Maven 빌드
RUN mvn clean package -DskipTests

# 빌드 결과만 실행 이미지에 복사 (멀티스테이지)
FROM openjdk:17-jdk-slim
WORKDIR /app

# WAR 파일을 복사
COPY --from=build /app/target/hello-world.war ./app.war

# 포트 노출
EXPOSE 8080

# 컨테이너 실행 시 - WAR 파일은 -jar로 실행할 수 없으므로 Tomcat 사용
# 또는 Spring Boot가 아니라면 다른 방식 필요
CMD ["java", "-jar", "app.war"]
