
DOCKER_USERNAME ?= aerostack2
APP_NAME ?= nightly-humble
BUILD_TAG ?= test


all: help

help:  ## Print help info
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""


# Docker building
build:  ## Build aerostack2 nightly-humble for testing
	@docker build --no-cache=true -t $(DOCKER_USERNAME)/$(APP_NAME):$(BUILD_TAG) .
	@docker tag $(DOCKER_USERNAME)/$(APP_NAME):$(BUILD_TAG) $(DOCKER_USERNAME)/last_generated

build-bin:  ## Build aerostack2 latest binary release
	@docker build -f Dockerfile-bin -t $(DOCKER_USERNAME)/bin-humble:$(BUILD_TAG) .

build-gz:  ## Build RADI humble dependencies
	@docker build -f Dockerfile-gz -t $(DOCKER_USERNAME)/gz:$(BUILD_TAG) .

build-all: build build-bin build-gz  ## Build all Dockerfiles


# Docker run test image
test:  ## Run last built image
	@docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY $(DOCKER_USERNAME)/last_generated

run:  ## Run images
	@echo See README.md for usage


# Docker pull
pull:  ## Pull latest nightly-humble image
	@docker pull $(DOCKER_USERNAME)/$(APP_NAME):latest

prune:  ## Prune all images
	@docker system prune

clean:  ## Remove nightly-humble image
	@docker rmi -f $(DOCKER_USERNAME)/$(APP_NAME)