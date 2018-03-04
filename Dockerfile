FROM ubuntu:16.04

RUN apt-get update \
    &&  apt-get install -y build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python git zlib1g-dev wget bsdmainutils automake

RUN git  clone https://github.com/BTCPrivate/BitcoinPrivate.git btcp

RUN cd btcp \
    && ./btcputil/build.sh -j$(nproc) \
    && ./btcputil/fetch-params.sh

VOLUME ["$HOME/.btcprivate/btcprivate.conf"]

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
