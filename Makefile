MAIN=cmd/helper-templates/main.go
BINARY=helper-templates
DOCKER_IMAGE=portainer/helper-templates

release-linux-amd64: build-linux-amd64 image-linux-amd64
release-linux-arm: build-linux-arm image-linux-arm
release-linux-arm64: build-linux-arm64 image-linux-arm64

release-linux: release-linux-amd64 release-linux-arm release-linux-arm64
release: release-linux manifest

run:
	go run $(MAIN)

build-linux-amd64:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bin/helper-templates $(MAIN)

build-linux-arm:
	GOOS=linux GOARCH=arm CGO_ENABLED=0 go build -o bin/helper-templates $(MAIN)

build-linux-arm64:
	GOOS=linux GOARCH=arm64 CGO_ENABLED=0 go build -o bin/helper-templates $(MAIN)

image-linux-amd64:
	docker build -f Dockerfile -t $(DOCKER_IMAGE):linux-amd64 .; \
	docker push $(DOCKER_IMAGE):linux-amd64

image-linux-arm:
	docker build -f Dockerfile -t $(DOCKER_IMAGE):linux-arm .; \
	docker push $(DOCKER_IMAGE):linux-arm

image-linux-arm64:
	docker build -f Dockerfile -t $(DOCKER_IMAGE):linux-arm64 .; \
	docker push $(DOCKER_IMAGE):linux-arm64

clean:
	rm -rf bin/$(BINARY)*

manifest:
	DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create $(DOCKER_IMAGE):latest $(DOCKER_IMAGE):linux-amd64 $(DOCKER_IMAGE):linux-arm $(DOCKER_IMAGE):linux-arm64; \
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest annotate $(DOCKER_IMAGE):latest $(DOCKER_IMAGE):linux-arm --os linux --arch arm; \
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest annotate $(DOCKER_IMAGE):latest $(DOCKER_IMAGE):linux-arm64 --os linux --arch arm64; \
    DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push -p $(DOCKER_IMAGE):latest
