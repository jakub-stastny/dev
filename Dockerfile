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

# Install Ruby.
# This has been extracted out in order to cache the build,
# so then if we change the install script, we don't have to recompile Ruby.
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential && wget -O ruby-install-0.7.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.0.tar.gz && tar -xzvf ruby-install-0.7.0.tar.gz && cd ruby-install-0.7.0 && make install && cd .. && rm -rf ruby-install-0.7.0* && ruby-install ruby -- --disable-install-doc

# Let's not delete the build scripts afterwards,
# they might come in handy for future inspection.
ADD scripts /build-scripts
RUN /build-scripts/install

ENV PATH="/root/.scripts:${PATH}"

RUN echo "'$BUILD_METADATA'" > /etc/docker-image-build-metadata.json

WORKDIR /root
CMD ["/usr/bin/zsh"]
