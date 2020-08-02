FROM ubuntu as build

# Build htmlcoin

RUN apt-get -y update && apt-get -y install apt-utils 
ADD tzscript.sh /tzscript.sh
RUN chmod 777 tzscript.sh && /tzscript.sh

RUN apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev libgmp-dev
RUN apt-get -y install software-properties-common  

#RUN deb http://ppa.launchpad.net/bitcoin/ bionic main
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D46F45428842CE5E && add-apt-repository 'deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main'

#RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get -y update && apt-get -y install libdb4.8-dev libdb4.8++-dev libzmq3-dev libprotobuf-dev protobuf-compiler

RUN git clone https://github.com/HTMLCOIN/HTMLCOIN --recursive
#RUN git clone -b "master-2.2" https://github.com/HTMLCOIN/HTMLCOIN --recursive
WORKDIR /HTMLCOIN
RUN git submodule update --init --recursive

# Note autogen will prompt to install some more dependencies if needed
RUN ./autogen.sh && ./configure  --with-boost-libdir=/usr/lib/x86_64-linux-gnu/ --enable-bitcore-rpc --without-gui --enable-tests=no && make -j2
RUN cp -rp src/htmlcoind /bin/htmlcoind && cp -rp src/htmlcoin-tx /bin/htmlcoin-tx && cp -rp src/htmlcoin-cli /bin/htmlcoin-cli

ENV HTML_DATA /data
RUN mkdir $HTML_DATA && ln -sfn $HTML_DATA /root/.htmlcoin && rm -r /HTMLCOIN && apt autoremove --purge && rm -rf /var/lib/apt/lists/* 
VOLUME /data

COPY htmlcoin.conf /root/.htmlcoin/htmlcoin.conf

LABEL version="2.5"

EXPOSE 4889
EXPOSE 14889

ENTRYPOINT ["/bin/htmlcoind"]
CMD ["--logevents"]
#CMD ["-help"]
