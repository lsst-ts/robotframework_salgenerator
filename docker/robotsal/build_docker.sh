tag=${1-latest}
docker build --tag ts-dockerhub.lsst.org/robotsal:$tag .
if [ $? ]; then
    echo -e "\n\nHere's the command to push to image: \n"
    echo -e "docker image push ts-dockerhub.lsst.org/robotsal:$tag"
else
    echo -e "Failed to build Docker image."
fi
