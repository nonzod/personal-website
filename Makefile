# Variables
DOCKER_USERNAME = nonzod
IMAGE_NAME = nicolatomassoni-website
VERSION ?= 0.0.1

# Full image name
FULL_IMAGE_NAME = $(DOCKER_USERNAME)/$(IMAGE_NAME):$(VERSION)

# Default target
.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@awk '/^[a-zA-Z0-9_-]+:.*?## .*$$/ {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: build
build: ## Build the Docker image
	docker build -t $(IMAGE_NAME) .
	docker tag $(IMAGE_NAME) $(FULL_IMAGE_NAME)

.PHONY: push
push: ## Push the Docker image to registry
	docker push $(FULL_IMAGE_NAME)

.PHONY: all
all: build push ## Build and push the Docker image

.PHONY: run
run: ## Run the Docker container locally
	docker run -d -p 8080:80 $(FULL_IMAGE_NAME)

.PHONY: clean
clean: ## Remove local Docker image
	docker rmi $(IMAGE_NAME) $(FULL_IMAGE_NAME)