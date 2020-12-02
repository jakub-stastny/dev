FROM ubuntu:latest

ARG BUILD_METADATA

# Keep up to date with the current Ruby version.
ENV RUBY_VERSION=2.7.2

# Ubuntu has broken locale.
# We need to set these here, in order for them to be available
# both to the install script and to the final environment.
# Locale is generated in the install script.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Let's not delete the build scripts afterwards,
# they might come in handy for future inspection.
ADD scripts /build-scripts
RUN /build-scripts/install

ENV PATH="/root/.scripts:${PATH}"

RUN $BUILD_METADATA > /etc/docker-image-build-metadata.json

WORKDIR /root
CMD ["/usr/bin/zsh"]
