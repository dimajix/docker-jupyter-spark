FROM dimajix/spark:2.2.0
MAINTAINER k.kupferschmidt@dimajix.de

ARG ANACONDA_VERSION=4.2.0

ENV ANACONDA_HOME=/opt/anaconda3
ENV SPARK_MASTER=local[*]

USER root

RUN apt-get update \
    && apt-get install bzip2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh > /tmp/anaconda.sh \
    && chmod a+rx /tmp/anaconda.sh \
    && /tmp/anaconda.sh -f -b -p ${ANACONDA_HOME} \
    && rm -f /tmp/anaconda.sh

# copy configs and binaries
COPY bin/ /opt/docker/bin/
COPY libexec/ /opt/docker/libexec/
COPY conf/jupyter-kernels/ /opt/docker/conf/jupyter-kernels/

ENV PATH=$PATH:${ANACONDA_HOME}/bin

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["notebook"]
