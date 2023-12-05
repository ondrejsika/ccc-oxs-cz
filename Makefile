dev:
	yq config.yml -o json > config.json
	signpost server -c config.json

docker-build:
	docker build --platform linux/amd64 \
		-t ondrejsika/ccc-oxs-cz \
		-t ghcr.io/ondrejsika/ccc-oxs-cz \
		.

docker-push:
	docker push ondrejsika/ccc-oxs-cz
	docker push ghcr.io/ondrejsika/ccc-oxs-cz

docker-run:
	docker run -p 8000:8000 ondrejsika/ccc-oxs-cz

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)
