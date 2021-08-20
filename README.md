# Image Builder in a Container

[![Build containers](https://github.com/major/imagebuilder/actions/workflows/build_containers.yml/badge.svg?branch=main)](https://github.com/major/imagebuilder/actions/workflows/build_containers.yml)

This repository builds containers with the [Image Builder] services ready to go!
Get a list of all the current builds in the [GitHub container repository].

## Pulling containers

You can pull any of the containers from this repository using `podman` or
`docker`:

```console
podman pull ghcr.io/major/imagebuilder:centos-stream8
podman pull ghcr.io/major/imagebuilder:fedora-33
podman pull ghcr.io/major/imagebuilder:fedora-34
podman pull ghcr.io/major/imagebuilder:fedora-rawhide
```

## Running Image Builder from within the container

Each container starts systemd so that socket activation works well between the
different components. Building images does require additional privileges for
certain operations, so you will likely need the `--privileged` flag and use
`sudo`.

_(If anyone knows of a workaround to avoid using `--privileged` and/or `sudo`,
please [let me know](mailto:major+imagebuilder@mhtx.net)!)_

```shell
sudo podman run --rm --detach --privileged \
    --name imagebuilder \
    ghcr.io/major/imagebuilder:centos-stream8
```

[Image Builder]: https://www.osbuild.org/documentation/
[GitHub container repository]: https://github.com/major/imagebuilder/pkgs/container/imagebuilder
