FROM centos:8

LABEL maintainer="kihi"

WORKDIR /root

RUN dnf -y update && \
    dnf -y install git

COPY google-cloud-sdk.repo /etc/yum.repos.d/

RUN dnf -y install google-cloud-sdk && \
    dnf clean all && \
    mv .config/gcloud .config/gcloud-old

CMD ["/bin/bash"]
