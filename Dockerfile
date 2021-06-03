FROM ubuntu:21.04

ARG BUILD_METADATA

# Update the system, so we can fix the locale.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Ubuntu has broken locale.
# We need to set these here, in order for them to be available
# both to the install script and to the final environment.
# Locale is generated in the install script.
#
# There's a Perl locale error when setting up locales. Ignore.
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
RUN apt-get install -y locales && locale-gen $LC_ALL

# Let's not delete the build scripts afterwards,
# they might come in handy for future inspection.
#
# Whatever runs inside the script don't get cached,
# not suited for compilations.
#
# With that said this should be environment agnostic,
# it should provide sources to install commonly used
# utilities, not necessary include them.
ADD scripts /build
RUN /build/install

# Even though we do this in dotfiles,
# having it exported means we can use these custom scripts
# when building a DPM image.
#
# For instance in the home image we use dotfiles from ~/.script/dotfiles.
ENV PATH="/root/.scripts:${PATH}"

RUN echo "$BUILD_METADATA" > /build/metadata.json

WORKDIR /root

RUN echo "root:$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32)" | chpasswd
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN apt-get install -y openssh-server mosh && mkdir /run/sshd
CMD ["/usr/sbin/sshd", "-p", "2222", "-D", "-e"]
