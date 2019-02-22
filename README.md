# About

Based on [this](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

# Docker

## VPS setup

_NOTE: There's no need to set up multiple user accounts._

1. Create a new VPS (DigitalOcean sends the root password by email, no need to add SSH key when creating the VM).
2. Generate SSH a pair of SSH keys `ssh-keygen -t rsa`.
3. `apt update && apt upgrade -y && apt autoremove -y`
4. Install Docker and mosh.
`apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common mosh && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && apt install -y docker-ce docker-ce-cli containerd.io`
5. `docker pull botanicus/dev`
6. `export DROPBOX_ACCESS_TOKEN=...`
6. `docker create -it -p 3000-3005:3000-3005 -p 4000-4005:4000-4005 -e DROPBOX_ACCESS_TOKEN=$DROPBOX_ACCESS_TOKEN -v ~/.ssh:/root/.ssh -v ~/riffr:/root/riffr --name riffr --hostname riffr botanicus/dev && docker start riffr`
7. Run `ssh-copy-id` on iPad (and select that key in the Blink host entry).
8. Update mosh start-up command to `DROPBOX_ACCESS_TOKEN=... docker attach riffr`

_I might use 1 VM with multiple images, more users, and exporting a different range for each project and then `mosh riffr@server` etc. One thing is it should have the same user, otherwise proxying between host and guest `~/.ssh` screws permissions._

```
docker container ls -a
docker build -t botanicus/dev .
docker push botanicus/dev
```

# TODO

- Git add completion for git-custom scripts.
- OS X installation.
- Review https://github.com/mathiasbynens/dotfiles/blob/master/.macos (no sleep mode, maybe I don't need Caffeine). sudo systemsetup -setcomputersleep Off > /dev/null
- https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789#.8ilwpjaj5
- Vim: syntax for Nginx conf files.
