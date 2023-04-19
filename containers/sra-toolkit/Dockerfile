FROM app-bio/base


RUN apt-get update -y && \
    apt-get install -y sra-toolkit && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*