# About

The primary use of this is to build a Docker image suitable for development, that is, with the software I use and with my dotfiles. It also supports setting up a VPS in order to always have a uniform, predictable environment to work with.

## Docker image

Docker is traditionally presented more as a deployment solution, in my opinion. I like to use Docker to spin off development environments, one for each project.

I use my own [docker-project-manager](https://github.com/jakub-stastny/docker-project-manager) to automate the usual project workflow: create a project, spin off a Docker image with the development environment, create a new pair of SSH keys, set up port sharing, and attach to the running image.

```
rake build push
```

## VPS setup

In the past I tried to use rather bare VPS', but I found having 2 different environments unnecessarily complicated. For that reason I decided to install both my VPS and my development images in the same way.

```
```
