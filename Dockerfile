FROM sikalabs/ca-certificates as yq
COPY --from=sikalabs/slu:v0.71.0 /usr/local/bin/slu /usr/local/bin/slu
RUN slu install-bin yq

FROM sikalabs/slu:v0.71.0 as version-json
WORKDIR /workspace
COPY . .
RUN slu static-api version --set-git-clean > version.json

FROM sikalabs/signpost:v0.3.0
LABEL org.opencontainers.image.source https://github.com/ondrejsika/ccc-oxs-cz
COPY --from=yq /usr/local/bin/yq /usr/local/bin/yq
COPY config.yml /
COPY static /static
COPY --from=version-json /workspace/version.json /static/version.json
RUN yq config.yml -o json > config.json
CMD [ "signpost", "server", "-c", "/config.json" ]
EXPOSE 8000
