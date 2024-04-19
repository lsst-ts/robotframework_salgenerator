tag=${1-latest}
docker build --tag lsstts/robot:$tag .
if [ $? ]; then
    echo -e "\n\nHere's the command to push to image: \n"
    echo -e "docker image push lsstts/robot:$tag"
else
    echo -e "Failed to build Docker image."
fi
