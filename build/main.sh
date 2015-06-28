# Name it
. ./build/release.cfg
artifact_name="gcr.io/$projectid/$servicename"
artifact_tag="$artifact_name:$servicemajor.$serviceminor.$BUILD_NUMBER"


# Prepare container
mkdir -p ./build/container
sed "s/__SERVICEPORT__/$serviceport/g" ./build/template.Dockerfile > ./build/container/Dockerfile
cp ./src/index.html   ./build/container/
cp ./src/nginx.conf   ./build/container/
docker build -t $artifact_name ./build/container/
docker tag $artifact_name $artifact_tag


# Push to Google Cloud Engine
gcloud docker push $artifact_name
gcloud docker push $artifact_tag


# generate manifests
rm ./deploy/kubernetes/*.json
./build/generate_manifests.sh $artifact_tag
