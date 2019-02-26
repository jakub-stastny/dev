# About

## VPS setup

_Do not copy it from Vim, not even with `set nonu`, it'll preserve unwanted line breaks._

1. Create a new VPS with my _iPad generic_ SSH key.
2. Add a Blink host entry.
3. `DEBIAN_FRONTEND=noninteractive apt update && apt upgrade -y && apt autoremove -y`
4. Install Docker and mosh:
`apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common mosh && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt install -y docker-ce docker-ce-cli containerd.io`
5. `docker login && docker pull botanicus/dev` (see _VPS credentials_ in 1Password).
7. Open _VPS credentials_ in the secure notes in my 1Password and paste everything into the shell.
8. Run `docker pull botanicus/docker-project-manager && docker run -it --rm <project-name> DROPBOX_ACCESS_TOKEN PROWL_API_KEY` and follow the instructions.

## SSH keys

_See [docker-project-manager#2](https://github.com/botanicus/docker-project-manager/issues/2). We want to migrate from this approach described here towards handling it in Docker containers._

1. Generate `ssh-keygen -t rsa`
2. Add to [GitHub](https://github.com/settings/keys)/[GitLab](https://gitlab.mobile-sphere.com/profile/keys).

# Caveats

- If you run `docker attach` and want to detach without stopping to container, use *C-p-q*.
- With that said, just use `docker exec <container-name> zsh` and then there's no issue with `C-d`.

```
docker container ls -a
docker build -t botanicus/dev .
docker push botanicus/dev
```
