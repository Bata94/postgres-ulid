export BINARY_NAME := "postgres-ulid"
export MAJOR_VERSION := "16"
export MINOR_VERSION := "4"
export PATCH_VERSION := "0"
export VERSION := "$(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)"
export DOCKER_REGISTRY := "ghcr.io/bata94/"

build:
	docker build --build-arg VERSION_BUILD=$VERSION --tag $BINARY_NAME .

release-git:
	git add ./Justfile
	git commit -m "Release version $(VERSION)"
	git tag -a $VERSION -m "Release version $(VERSION)"
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
