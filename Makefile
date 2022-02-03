install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile
	pylint --disable=R,C,W1203,W0702 app.py

test:
	python -m pytest -vv --cov=app test_app.py

build:
	docker build -t flask-change:latest .

run:
	docker run -p 5000:5000 flask-change

invoke:
	curl http://172.17.0.2:8080/change/1/34

run-kube:
	kubectl apply -f kube-hello-change.yaml

all: install lint test