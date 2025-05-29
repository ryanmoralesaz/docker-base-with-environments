# java.Dockerfile
FROM myproject/base:latest

# Install Java 17 (LTS) and Maven
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install useful Java development tools
RUN apt-get update && apt-get install -y \
    gradle \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for Java projects
RUN mkdir -p /workspace/java-projects

# Keep container running with zsh
CMD ["zsh"]