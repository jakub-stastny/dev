# About

## VPS setup

_Do not copy it from Vim, not even with `set nonu`, it'll preserve unwanted line breaks._

1. Create a new VPS with my _iPad generic_ SSH key.
2. Add a Blink host entry.
3. `apt update && DEBIAN_FRONTEND=noninteractive apt upgrade -y && apt autoremove -y`
4. Install Docker and mosh:
`apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common mosh && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt install -y docker-ce docker-ce-cli containerd.io`
5. Run `docker login`.
6. Use [docker-project-manager](https://github.com/jakub-stastny/docker-project-manager) to create your environments.

_NOTE: As DigitalOcean runs SSD's, there's no swap file enabled by default. It's easier to up RAM, but if you need to, here's a [guide](https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-18-04#step-5-–-making-the-swap-file-permanent)._

## Caveats

### Local SSH keys & Git

It's best to keep the host OS without SSH keys and only generate them in the Docker environments using [docker-project-manager](https://github.com/jakub-stastny/docker-project-manager).

Among other things, without dotfiles that have `~/.gitconfig` with name and email, it's impossible to commit without setting these up first.
