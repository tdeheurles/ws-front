#! /bin/bash
. ./build/release.cfg

k8s_api_version="v1beta3"
versiontag=$servicemajor.$serviceminor.$BUILD_NUMBER
manifestsPath="./deploy/kubernetes"

# RC
rcfile=$manifestsPath/$servicename\_$versiontag\_rc.json
rcname=$servicename

sed "s/__rcName__/$rcname/g" \
    $manifestsPath/$k8s_api_version/rc.template.json > $rcfile
sed -i "s/__major__/$servicemajor/g" $rcfile
sed -i "s/__minor__/$serviceminor/g" $rcfile
sed -i "s/__build__/$BUILD_NUMBER/g" $rcfile
sed -i "s|__image__|$1|g" $rcfile
sed -i "s/__privatePortName1__/$serviceportname1/g" $rcfile
sed -i "s/__privatePort1__/$serviceport1/g" $rcfile
sed -i "s/__privatePortName2__/$serviceportname2/g" $rcfile
sed -i "s/__privatePort2__/$serviceport2/g" $rcfile
sed -i "s/__replicas__/1/g" $rcfile


# SERVICE
servicefile=$manifestsPath/$servicename\_$versiontag\_service.json
sed "s/__serviceName__/$servicename/g" \
    $manifestsPath/$k8s_api_version/service.template.json > $servicefile
sed -i "s/__major__/$servicemajor/g" $servicefile
sed -i "s/__minor__/$serviceminor/g" $servicefile
sed -i "s/__build__/$BUILD_NUMBER/g" $servicefile
sed -i "s/__privatePortName1__/$serviceportname1/g" $servicefile
sed -i "s/__publicPortName1__/$serviceportname1/g" $servicefile
sed -i "s/__publicPort1__/$serviceport1/g" $servicefile
sed -i "s/__privatePortName2__/$serviceportname2/g" $servicefile
sed -i "s/__publicPortName2__/$serviceportname2/g" $servicefile
sed -i "s/__publicPort2__/$serviceport2/g" $servicefile
sed -i "s/__rcName__/$rcname/g" $servicefile

cp $rcfile $manifestsPath/rc_latest.json
cp $servicefile $manifestsPath/service_latest.json

echo "Manifests generated"
