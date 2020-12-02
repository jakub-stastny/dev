FROM ubuntu:latest

# Keep up to date with the current Ruby version.
ENV RUBY_VERSION=2.7.2

# Ubuntu has broken locale.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

ADD scripts /
RUN /scripts/install && rm -rf /scripts
ENV PATH="/root/.scripts:${PATH}"
RUN chsh -s $(which zsh)

RUN date > /etc/docker-image-build-time

WORKDIR /root
CMD ["/usr/bin/zsh"]
