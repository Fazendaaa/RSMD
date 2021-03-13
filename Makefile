REGISTRY_OWNER:=fazenda
MULTIARCH:=false
ARCHS:=linux/amd64
PROJECT_TAG:=latest

ifeq (true, $(MULTIARCH))
	ARCHS:=linux/amd64,linux/arm/v7,linux/arm/v6,linux/arm64/v8,linux/386
endif

all: install setup

install:
	@curl -fSL https://get.docker.com | sh
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
	sudo systemctl start docker

setup:
	@docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	@docker buildx rm builder
	@docker buildx create --name builder --driver docker-container --use
	@docker buildx inspect --bootstrap

build:
	docker buildx build --platform $(ARCHS) --push --tag ${REGISTRY_OWNER}/rsmd:${PROJECT_TAG} .
