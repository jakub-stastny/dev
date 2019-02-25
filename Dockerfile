FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential locales automake zsh wget curl git silversearcher-ag nodejs neovim docker.io && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install -y yarn
RUN locale-gen en_US.UTF-8
RUN wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz && tar -xzvf ruby-install-0.7.0.tar.gz && cd ruby-install-0.7.0 && make install && cd .. && rm -rf ruby-install-0.7.0* && wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && tar -xzvf chruby-0.3.9.tar.gz && cd chruby-0.3.9 && make install && cd .. && rm -rf chruby-0.3.9*
RUN ruby-install ruby -- --disable-install-doc
RUN /opt/rubies/ruby-*/bin/gem install pry prowl

RUN apt-get install -y libevent-dev libncurses-dev pkg-config && git clone https://github.com/tmux/tmux.git && cd tmux && sh autogen.sh && ./configure && make && make install && cd .. && rm -rf tmux
RUN nvim +PlugInstall +qall

RUN cd /root && git clone https://github.com/botanicus/dotfiles.git .dotfiles.git --bare && git --git-dir=/root/.dotfiles.git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" && git --git-dir=/root/.dotfiles.git fetch && git --git-dir=/root/.dotfiles.git branch --set-upstream-to=origin/master master && git --git-dir=/root/.dotfiles.git --work-tree=/root checkout && ssh-keyscan github.com >> ~/.ssh/known_hosts && zsh ~/.scripts/dotfiles/dotfiles.install && git --git-dir=/root/.dotfiles.git remote set-url origin git@github.com:botanicus/dotfiles.git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata apt-utils && echo "America/New_York" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN chsh -s $(which zsh)

WORKDIR /root
CMD ["/usr/bin/zsh"]
