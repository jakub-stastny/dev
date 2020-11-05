FROM ubuntu:latest

# Keep up to date with the current Ruby version.
ENV RUBY_VERSION=2.7.2

ADD scripts /
RUN /scripts/install && rm -rf /scripts
ENV PATH="/root/.scripts:${PATH}"
RUN chsh -s $(which zsh)

RUN date > /etc/docker-image-build-time

WORKDIR /root
CMD ["/usr/bin/zsh"]
