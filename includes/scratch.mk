
docker-base-debian:
	docker build --force-rm --build-arg "CACHING_PROXY=$(proxy_addr)" -t $(image_prename)-build-debian -f Dockerfiles/Dockerfile.live-build.debian .

docker-base-devuan:
	docker build --force-rm --build-arg "CACHING_PROXY=$(proxy_addr)" -t $(image_prename)-build-devuan -f Dockerfiles/Dockerfile.live-build.devuan .

docker-debian:
	docker build --force-rm -t $(image_prename)-debian \
		--build-arg "customize=$(custom)" \
		-f Dockerfiles/Dockerfile.debian .

docker-devuan:
	docker build --force-rm -t $(image_prename)-devuan \
		--build-arg "customize=$(custom)" \
		-f Dockerfiles/Dockerfile.devuan .

docker-base-all:
	make docker-base-debian
	make docker-base-devuan

docker-all:
	make docker-debian
	make docker-devuan
