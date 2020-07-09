FROM ubuntu as build

# Build htmlcoin


RUN apt-get -y update
RUN apt-get -y install apt-utils 
ADD tzscript.sh /tzscript.sh
RUN chmod 777 tzscript.sh
RUN /tzscript.sh


RUN apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev libgmp-dev
RUN apt-get -y install software-properties-common  

#RUN deb http://ppa.launchpad.net/bitcoin/ bionic main
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D46F45428842CE5E
RUN add-apt-repository 'deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu bionic main'



#RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get -y update
RUN apt-get -y install libdb4.8-dev libdb4.8++-dev

# set noninteractive installation
#ARG DEBIAN_FRONTEND="noninteractive"
#ENV TZ = "America/Sao_Paulo"
#install tzdata package


# enable zeromq
RUN apt-get -y install libzmq3-dev

RUN apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler

RUN git clone -b "v2.5.0" https://github.com/HTMLCOIN/HTMLCOIN --recursive
#RUN git clone -b "master-2.2" https://github.com/HTMLCOIN/HTMLCOIN --recursive
WORKDIR /HTMLCOIN
RUN git submodule update --init --recursive

# Note autogen will prompt to install some more dependencies if needed
RUN ./autogen.sh
RUN ./configure  --with-boost-libdir=/usr/lib/x86_64-linux-gnu/ --enable-bitcore-rpc --without-gui --enable-tests=no
RUN make -j2

RUN cp -rp src/htmlcoind /bin/htmlcoind
RUN cp -rp src/htmlcoin-tx /bin/htmlcoin-tx
RUN cp -rp src/htmlcoin-cli /bin/htmlcoin-cli

ENV HTML_DATA /data
RUN mkdir $HTML_DATA && ln -sfn $HTML_DATA /root/.htmlcoin 
VOLUME /data

COPY htmlcoin.conf /root/.htmlcoin/htmlcoin.conf

LABEL version="2.5"

EXPOSE 4889
EXPOSE 14889

ENTRYPOINT ["/bin/htmlcoind"]
CMD ["--logevents"]
#CMD ["-help"]