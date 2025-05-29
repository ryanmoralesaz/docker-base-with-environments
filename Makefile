# Makefile for managing Docker environments

.PHONY: build-base build-all up-zig up-java shell-zig shell-java clean

# Build base image first
build-base:
	docker-compose build base

# Build all images
build-all: build-base
	docker-compose build

# Start Zig environment
up-zig:
	docker-compose up -d zig-dev
	docker-compose exec zig-dev zsh

# Start Java environment
up-java:
	docker-compose up -d java-dev
	docker-compose exec java-dev zsh

# Just get a shell in Zig container
shell-zig:
	docker-compose exec zig-dev zsh

# Just get a shell in Java container
shell-java:
	docker-compose exec java-dev zsh

# Run both environments
up-all:
	docker-compose up -d

# Stop all containers
stop:
	docker-compose stop

# Clean up everything
clean:
	docker-compose down -v
	docker system prune -f