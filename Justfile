#!/usr/bin/env just --justfile

set export
BINARY_NAME := "postgres-ulid"
MAJOR_VERSION := "16"
MINOR_VERSION := "4"
PATCH_VERSION := "0"
VERSION := "{{MAJOR_VERSION}}.{{MINOR_VERSION}}.{{PATCH_VERSION}}"
DOCKER_REGISTRY := "ghcr.io/bata94/"

VAR1 := "Hello"
VAR2 := "World"

# Define a combined variable
GREETING := "{{VAR1}} {{VAR2}}!"

# Create a recipe to print the result
print-greeting:
  echo "{{GREETING}}"
  echo "{{VAR1}} {{VAR2}}!"


version:
  echo {{VERSION}}

# List all recipes
list:
  just -l

build:
	docker build --build-arg VERSION_BUILD=$VERSION --tag $BINARY_NAME .

release-git:
	git add ./Justfile
	git commit -m "Release version $VERSION"
	git tag -a $VERSION -m "Release version $VERSION"
	git push
	git push --tags

release-docker:
	docker tag $BINARY_NAME $DOCKER_REGISTRY$BINARY_NAME:latest
	docker push $DOCKER_REGISTRY$BINARY_NAME:latest

	docker tag $BINARY_NAME $DOCKER_REGISTRY$BINARY_NAME:$MAJOR_VERSION
	docker push $DOCKER_REGISTRY$BINARY_NAME:$MAJOR_VERSION

	docker tag $BINARY_NAME $DOCKER_REGISTRY$BINARY_NAME:$MAJOR_VERSION.$MINOR_VERSION
	docker push $DOCKER_REGISTRY$BINARY_NAME:$MAJOR_VERSION.$MINOR_VERSION

	docker tag $BINARY_NAME $DOCKER_REGISTRY$BINARY_NAME:$VERSION
	docker push $DOCKER_REGISTRY$BINARY_NAME:$VERSION

auto-release: release-git release-docker
