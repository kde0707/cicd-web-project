# 베이스 이미지 (OpenJDK 17)
FROM openjdk:17-jdk

# 작업 디렉토리
WORKDIR /app

# 프로젝트 소스 코드 복사
COPY . .

# Maven 빌드
RUN ./mvnw package -DskipTests

# 컨테이너 실행 시
CMD ["java", "-jar", "target/your-app.jar"]
