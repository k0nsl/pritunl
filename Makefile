IMAGE_NAME=k0nsl/pritunl

all:
	docker build -t $(IMAGE_NAME) .

clean:
	docker rmi $(IMAGE_NAME) || true
