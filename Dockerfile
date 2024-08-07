# 베이스 이미지 설정
FROM eclipse-temurin:21-jdk-alpine

# 작업 디렉터리 설정
WORKDIR /app

# 애플리케이션 JAR 파일 추가
COPY build/libs/member-0.0.1-SNAPSHOT.jar app.jar

# Datadog Java APM 에이전트 다운로드 및 추가
RUN wget -O /opt/dd-java-agent.jar https://dtdg.co/latest-java-tracer

# Datadog Java APM 에이전트와 함께 애플리케이션 시작
CMD ["java", "-javaagent:/opt/dd-java-agent.jar", "-Ddd.agent.host=localhost", "-Ddd.trace.agent.port=8126", "-jar", "app.jar", "--spring.profiles.active=prod"]
