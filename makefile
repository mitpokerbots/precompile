prebuild:
	sudo docker build -t scrimmage .
	sudo docker run -it --name scrimmage scrimmage
	sudo docker cp scrimmage:/home/worker/scrimmage ./built

clean:
	sudo docker container rm scrimmage
	sudo rm -rf ./built

