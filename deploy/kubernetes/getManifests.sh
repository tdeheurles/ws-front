. ./build/release.cfg

docker run                                         \
  --rm                                             \
  -v /home/core/.kube/:/.kube/                     \
  -v /home/core/.config/gcloud/:/.config/gcloud/   \
  -v `pwd`:/workspace                              \
  -w /workspace                                    \
  -ti tdeheurles/gcloud-tools /bin/bash -c         \
  "gsutil cp -r gs://epsilon-deployment/$servicename/deploy/kubernetes/*.json ."

mv *.json ./deploy/kubernetes/
