# SvelteKit Docker Example

This repository provides an example Dockerfile and configuration for building a Docker image of a SvelteKit project. The Dockerfile includes instructions for installing dependencies, building the project, and serving it with a production server. This example can serve as a starting point for building and deploying SvelteKit applications using Docker.

Before building image, make sure to create `.env` file based on `.env.example`

```
cp .env.example .env
```

Building image

```
docker build -t my-kit-app:1.0.0 .
```

Running container

```
docker run --name my-app -p 8080:80 -e ORIGIN=http://my-app.com -d my-kit-app:1.0.0
```
