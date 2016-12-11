currentdate = $(shell date +%y%m%d)

build:
	docker build -t napnap75/rpi-mariadb:latest .

push: build
	docker push napnap75/rpi-mariadb:latest
	docker tag napnap75/rpi-mariadb:latest napnap75/rpi-mariadb:$(currentdate)
	docker push napnap75/rpi-mariadb:$(currentdate)
