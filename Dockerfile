FROM microsoft/aspnet:1.0.0-beta4

RUN useradd -ms /bin/bash dev
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

ENV NODE_VERSION 0.10.38
ENV NPM_VERSION 2.9.1
ENV APT_PACKAGES git

RUN apt-get update -qq && \
  apt-get -yqq install $APT_PACKAGES && \
  apt-get -yqq clean

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
      && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
      && gpg --verify SHASUMS256.txt.asc \
      && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
      && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
      && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
      && npm install -g npm@"$NPM_VERSION" \
      && npm cache clear

apt-get -y install autoconf automake build-essential libtool

run curl -SLO http://libuv.org/dist/v1.0.0/libuv-v1.0.0.tar.gz  && \
      tar xvf libuv-v1.0.0.tar.gz  && \
      rm libuv-v1.0.0.tar.gz  && \
      cd libuv-v1.0.0  && \
      sh ./autogen.sh  && \
      ./configure&& \
      make  && \
      make install  && \
      cd ..  && \
      rm -rf libuv-v1.0.0  && \
      ldconfig  

RUN npm install -g bower grunt-cli

USER dev
WORKDIR /home/dev
