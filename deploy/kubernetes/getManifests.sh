. ./build/release.cfg
docker run \
  -w /root/ \
  -v `pwd`/deploy/kubernetes/:/root/ \
  gcloud-tools \
  /bin/bash -c \
  "gsutil cp -r gs://epsilon-deployment/$servicename/deploy/kubernetes/*.json ."
