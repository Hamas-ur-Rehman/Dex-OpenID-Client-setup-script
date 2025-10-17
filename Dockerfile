FROM ghcr.io/dexidp/dex:v2.33.0@sha256:62902bd3a7ce4a73ed44e28884bffec04bcaa4a07e31e043173bdce289717e80

# Ensure we run package manager as root (dex image sets a non-root USER)
USER root

# Install envsubst (gettext) for runtime templating
RUN apk add --no-cache gettext

# copy template
COPY config.template.yaml /etc/dex/config.template.yaml

# Make an entrypoint that substitutes env vars at container start then runs dex
ENTRYPOINT ["/bin/sh", "-c", "envsubst < /etc/dex/config.template.yaml > /etc/dex/config.yaml && /usr/local/bin/dex serve /etc/dex/config.yaml"]
