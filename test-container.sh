#!/bin/bash
set -euxo pipefail

CONTAINER_NAME=imagebuilder

podman-exec () {
    sudo podman exec -t $CONTAINER_NAME $@
}

composer-cli () {
    podman-exec composer-cli $@
}

# Start the container.
echo "🚀 Launching the container"
sudo podman image list
sudo podman run --rm --detach --privileged \
    --name $CONTAINER_NAME \
    ${CONTAINER_TO_TEST}

# Wait for composer to be fully running.
echo "⏱ Waiting for composer to start"
COMPOSER_RUNNING=0
for i in `seq 1 10`; do
    sleep 1
    if composer-cli status show; then
        COMPOSER_RUNNING=1
        break
    fi
done

if [[ $COMPOSER_RUNNING == 0 ]]; then
    echo "🟥 Composer is not running."
    exit 1
fi
