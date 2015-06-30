. ./config/release.cfg

docker run                                         \
  --rm                                             \
  -v /home/core/.kube/:/.kube/                     \
  -v /home/core/.config/gcloud/:/.config/gcloud/   \
  -v `pwd`:/workspace                              \
  -w /workspace                                    \
  -ti tdeheurles/gcloud-tools /bin/bash -c         \
  "gsutil -m cp -r gs://epsilon-deployment/$servicename/deploy/kubernetes/*.$template_extension ."

mv -f *.json ./deploy/kubernetes/
mv -f *.yml  ./deploy/kubernetes/
