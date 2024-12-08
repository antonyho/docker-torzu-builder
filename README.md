# docker-torzu-builder
A builder docker image for Torzu

## Base Image
This docker image uses latest Ubuntu as base image.

## Build Target
This docker image will build the emulator to binary and then AppImage. You will get both.

## Usage
### Build the container
Clone this project:
```
git clone https://github.com/antonyho/docker-torzu-builder.git
```

Build the docker image:
```
cd docker-torzu-builder
docker buildx build --tag=torzu-builder --output type=local,dest=./output .
```

You should have the binaries and AppImage in the `output` directory.

(Optional) Remove the intermediate build images:
```
docker buildx prune
```

#### Security Notes
If you want to have higher security on Docker daemon, you can run your Docker daemon with [user namespace isolation](https://man.archlinux.org/man/user_namespaces.7) or run Docker daemon in [rootless mode](https://docs.docker.com/engine/security/rootless/).