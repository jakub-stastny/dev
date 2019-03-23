FROM ubuntu:latest

# Add Crystal sources (without installing it).
# https://crystal-lang.org/reference/installation/on_debian_and_ubuntu.html
#
# Add Yarn sources (without installing it).
# https://yarnpkg.com/lang/en/docs/install/#debian-stable
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential locales automake zsh wget curl git silversearcher-ag nodejs neovim docker.io && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add - && echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list && apt-get update
RUN locale-gen en_US.UTF-8
RUN wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz && tar -xzvf ruby-install-0.7.0.tar.gz && cd ruby-install-0.7.0 && make install && cd .. && rm -rf ruby-install-0.7.0* && wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9 && make install && cd .. && rm -rf chruby-0.3.9*
RUN ruby-install ruby -- --disable-install-doc
ENV PATH="/opt/rubies/ruby-2.6.2/bin:${PATH}"
# RUN /opt/rubies/ruby-*/bin/gem install pry prowl
RUN gem install pry prowl

RUN apt-get install -y libevent-dev libncurses-dev pkg-config && git clone https://github.com/tmux/tmux.git && cd tmux && sh autogen.sh && ./configure && make && make install && cd .. && rm -rf tmux
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata apt-utils && echo "America/New_York" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

RUN cd /root && mkdir .ssh && chmod 700 .ssh && git clone https://github.com/botanicus/dotfiles.git .dotfiles.git --bare && git --git-dir=/root/.dotfiles.git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" && git --git-dir=/root/.dotfiles.git fetch && git --git-dir=/root/.dotfiles.git branch --set-upstream-to=origin/master master && git --git-dir=/root/.dotfiles.git --work-tree=/root checkout && ssh-keyscan github.com >> ~/.ssh/known_hosts && zsh ~/.scripts/dotfiles/dotfiles.install && git --git-dir=/root/.dotfiles.git remote set-url origin git@github.com:botanicus/dotfiles.git && rm -rf ~/.ssh
ENV PATH="/root/.scripts:${PATH}"
RUN nvim +PlugInstall +qall
RUN chsh -s $(which zsh)

RUN date > /etc/docker-image-build-time

WORKDIR /root
CMD ["/usr/bin/zsh"]
