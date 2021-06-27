#!/usr/bin/env zsh

export LOG_PATH=/root/.emacs.d/configure.log

test -d emacs || git clone --depth 1 https://git.savannah.gnu.org/git/emacs.git

# Dependencies from https://packages.ubuntu.com/impish/emacs-nox
#-y
apt-get install -y libacl1 libasound2 libc6 libdbus-1-3 libgmp10 libgnutls30 libgpm2 libjansson4 liblcms2-2 libselinux1 libsystemd0 libtinfo6 libxml2 zlib1g

# Needed for fast JSON
apt-get install -y libjansson4 libjansson-dev

# Dependencies for native compilation
apt-get install -y zlib1g-dev libgccjit0 libgccjit-10-dev gcc-10

cd emacs
export CC="gcc-10"
./autogen.sh && ./configure --with-native-compilation > $LOG_PATH && make -j$(nproc) && make install
