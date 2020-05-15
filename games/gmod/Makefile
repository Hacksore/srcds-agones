build:
	docker build -t seanboult/gmod .
build-thick:
	docker build --no-cache -t seanboult/gmod .
push:
	docker push seanboult/gmod
rebuild:
	$(MAKE) build && $(MAKE) push