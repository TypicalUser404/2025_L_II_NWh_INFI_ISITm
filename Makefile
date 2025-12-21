deps: 
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:  
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. py.test --verbose -s
docker_build:
	docker build -t hello-world-printer .
docker_run: docker_build
docker run \
		--name hello-world-printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

TAG=$(typicaluser404)/hello-world-printer
# Poprawiona sekcja docker_push (CI-friendly)
docker_push: docker_build
	@echo "$$DOCKER_TOKEN" | docker login -u typicaluser404 --password-stdin
	docker tag hello-world-printer $(TAG)
	docker push $(TAG)
	docker logout
