docker buildx build --platform linux/amd64 --push --tag fazenda/rsmd .
# ,linux/arm/v7,linux/arm/v6,linux/arm64/v8,linux/ppc64le,linux/s390x,linux/386
docker buildx imagetools inspect fazenda/rsmd
