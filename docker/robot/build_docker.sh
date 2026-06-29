tag=${1-latest}
docker build --platform linux/amd64 --tag lsstts/robot:$tag .
if [ $? -e 0 ]; then
    echo -e "\n\nHere's the command to push to image: \n"
    echo -e "docker image push lsstts/robot:$tag"
else
    echo -e "\n\nFailed to build Docker image."
fi
