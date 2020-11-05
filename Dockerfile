FROM kihi1215/gcloud

LABEL maintainer="kihi"

RUN mv /root/.config/gcloud /root/.config/gcloud-old

CMD ["/bin/bash"]
