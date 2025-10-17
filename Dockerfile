FROM ghcr.io/dexidp/dex:v2.33.0

# Install envsubst (in busybox or alpine shell)
RUN apk add --no-cache gettext

COPY config.template.yaml /etc/dex/config.template.yaml

# Run envsubst to replace env vars → config.yaml before starting Dex
ENTRYPOINT ["/bin/sh", "-c", "envsubst < /etc/dex/config.template.yaml > /etc/dex/config.yaml && /usr/local/bin/dex serve /etc/dex/config.yaml"]
