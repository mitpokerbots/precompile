prebuild:
	docker build -t scrimmage .
	docker run --name=scrimmage -it scrimmage
	docker cp scrimmage:/home/worker/scrimmage ./built

clean:
	docker rm scrimmage
	rm -rf ./built

