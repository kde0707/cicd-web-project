# 베이스 이미지
FROM maven:3.9.2-openjdk-17 AS build

WORKDIR /app

# 프로젝트 소스 복사
COPY . .

# Maven 빌드
RUN mvn clean package -DskipTests

# 빌드 결과만 실행 이미지에 복사 (멀티스테이지)
FROM openjdk:17-jdk
WORKDIR /app
COPY --from=build /app/target/hello-world.war ./app.war

# 컨테이너 실행 시
CMD ["java", "-jar", "app.war"]
