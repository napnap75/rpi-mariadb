build:
	docker build -t napnap75/rpi-mariadb:10.1.19 .

push: build
	docker push napnap75/rpi-mariadb:10.1.19
	docker tag napnap75/rpi-mariadb:10.1.19 napnap75/rpi-mariadb:10.1
	docker push napnap75/rpi-mariadb:10.1
	docker tag napnap75/rpi-mariadb:10.1.19 napnap75/rpi-mariadb:10
	docker push napnap75/rpi-mariadb:10
	docker tag napnap75/rpi-mariadb:10.1.19 napnap75/rpi-mariadb:latest
	docker push napnap75/rpi-mariadb:latest
