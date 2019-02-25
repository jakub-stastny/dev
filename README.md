# About

## VPS setup

1. Create a new VPS with my _iPad generic_ SSH key.
2. Add a Blink host entry.
3. `DEBIAN_FRONTEND=noninteractive apt update && apt upgrade -y && apt autoremove -y`
4. Install Ruby (for `run.rb`), Docker and mosh:
`apt install -y ruby apt-transport-https ca-certificates curl gnupg-agent software-properties-common mosh && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt install -y docker-ce docker-ce-cli containerd.io`
5. `docker login && docker pull botanicus/dev` (see _VPS credentials_ in 1Password).
7. Open _VPS credentials_ in the secure notes in my 1Password and paste everything into the shell.
8. Run `curl https://raw.githubusercontent.com/botanicus/dev/master/run.rb -O && ruby run.rb PROJECT_NAME` and follow the instructions.

## SSH keys

1. Generate `ssh-keygen -t rsa`
2. Add to GitHub/GitLab.

_I might use 1 VM with multiple images, more users, and exporting a different range for each project and then `mosh riffr@server` etc. One thing is it should have the same user, otherwise proxying between host and guest `~/.ssh` screws permissions._

```
docker container ls -a
docker build -t botanicus/dev .
docker push botanicus/dev
```
