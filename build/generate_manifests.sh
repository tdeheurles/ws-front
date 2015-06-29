#! /bin/bash
. ./build/release.cfg

k8s_api_version="v1beta3"
versiontag=$servicemajor.$serviceminor.$BUILD_NUMBER


# RC
rcfile=./deploy/kubernetes/$servicename\_$versiontag\_rc.json
rcname=$servicename

sed "s/__rcName__/$rcname/g" \
    ./deploy/kubernetes/$k8s_api_version/rc.template.json > $rcfile
sed -i "s/__major__/$servicemajor/g" $rcfile
sed -i "s/__minor__/$serviceminor/g" $rcfile
sed -i "s/__build__/$BUILD_NUMBER/g" $rcfile
sed -i "s|__image__|$1|g" $rcfile
sed -i "s/__privatePortName__/$servicename/g" $rcfile
sed -i "s/__privatePort__/$serviceport/g" $rcfile
sed -i "s/__replicas__/1/g" $rcfile


# SERVICE
servicefile=./deploy/kubernetes/$servicename\_$versiontag\_service.json

sed "s/__serviceName__/$servicename/g" \
    ./deploy/kubernetes/$k8s_api_version/service.template.json > $servicefile
sed -i "s/__major__/$servicemajor/g" $servicefile
sed -i "s/__minor__/$serviceminor/g" $servicefile
sed -i "s/__build__/$BUILD_NUMBER/g" $servicefile
sed -i "s/__privatePortName__/$servicename/g" $servicefile
sed -i "s/__publicPortName__/$servicename/g" $servicefile
sed -i "s/__publicPort__/$serviceport/g" $servicefile
sed -i "s/__rcName__/$rcname/g" $servicefile

echo "Manifests generated"
