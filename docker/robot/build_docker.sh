tag=${1-latest}
docker build --platform linux/amd64 --tag lsstts/robot:$tag .
if [ $? ]; then
    echo "\n\nHere's the command to push to image: \n"
    echo "docker image push lsstts/robot:$tag"
else
    echo "Failed to build Docker image."
fi
