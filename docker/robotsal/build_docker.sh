tag=${1-latest}
docker build --platform linux/amd64 --tag ts-dockerhub.lsst.org/robotsal:$tag .
if [ $? -eq 0 ]; then
    echo -e "\n\nHere's the command to push to image: \n"
    echo -e "docker image push ts-dockerhub.lsst.org/robotsal:$tag"
else
    echo -e "\n\nFailed to build Docker image."
fi
