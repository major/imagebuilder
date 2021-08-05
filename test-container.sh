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
sudo podman run --rm -it --privileged \
    -v $(pwd)/shared:/repo \
    --name $CONTAINER_NAME \
    localhost/${CONTAINER_TO_TEST}:latest &

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
