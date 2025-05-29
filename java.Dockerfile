# java.Dockerfile
FROM myproject/base:latest

# Install Java 17 (LTS) and Maven
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    gradle \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a directory for Java projects
RUN mkdir -p /workspace/java-projects

CMD ["zsh"]