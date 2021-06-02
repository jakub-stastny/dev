FROM ubuntu:21.04

ARG BUILD_METADATA

# Update the system.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Ubuntu has broken locale.
# We need to set these here, in order for them to be available
# both to the install script and to the final environment.
# Locale is generated in the install script.
#
# There's a Perl locale error when setting up locales. Ignore.
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
RUN apt-get install -y locales && locale-gen $LC_ALL

RUN apt-get install -y zsh

# Let's not delete the build scripts afterwards,
# they might come in handy for future inspection.
ADD scripts /build-scripts
RUN /build-scripts/install

ENV PATH="/root/.scripts:${PATH}"

RUN echo "$BUILD_METADATA" > /etc/docker-image-build-metadata.json

WORKDIR /root
CMD ["/usr/bin/zsh"]
