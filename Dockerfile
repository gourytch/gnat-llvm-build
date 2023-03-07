FROM ubuntu:22.04

ARG Base=/opt
ARG GNAT_LLVM=${Base}/gnat-llvm
ENV GNAT_LLVM ${GNAT_LLVM}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&&  apt-get -y install \
        build-essential \
        git \
        cmake \
        llvm llvm-runtime \
        llvm-14 \
        gnat-11 \
        gprbuild

COPY build.sh /
RUN chmod a+x /build.sh

VOLUME [ "/io" ]

CMD [ "/build.sh", "automated" ]
